<?php

// This is a common library for standard SQL databases (mysql, mssql, etc)

$db_error = "";
$db_insertid = 0;
$db_lastquery = "";
$db_rowsaffected = 0;


// COMMON COMPLEX VARIABLE SHORTCUTS
function DB_Now() {
  return UnixToSqlTime(time());

  // Not using database's NOW() because it may be offset from PHP's clock!
  //return Array("type" => "timenow");
}

function DB_Null() {
  return ["type" => "null"];
}

function DB_IsNull() {
  return ["isnull" => true];
}

function DB_IsNotNull() {
  return ["isnotnull" => true];
}

function DB_IsActive() {
  return ["isactive" => true];
}


// VARIABLE HANDLING FUNCTIONS

function DB_WhereClause($field, $value) {
  $field = preg_replace('/\#\d+$/', "", $field);
  $field = preg_replace('/\W/', "", $field);
  if (is_array($value)) {
    if (isset($value["like"])) {
      return "$field LIKE ".DB_Enclose($value["like"]);
    } else if (isset($value["notlike"])) {
      return "NOT ($field LIKE ".DB_Enclose($value["notlike"]).")";
    } else if (isset($value["isnot"])) {
      return "$field != ".DB_Enclose($value["isnot"]);
    } else if (isset($value["isnull"])) {
      return DB_Test_Null($field);
    } else if (isset($value["isnotnull"])) {
      return "NOT (".DB_Test_Null($field).")";
    } else if (isset($value["match_ignore_case"])) {
      return "LOWER($field) = ".DB_Enclose(StrToLower($value["match_ignore_case"]));
    } else if ((isset($value["operator"])) && (isset($value["value"]))) {
      if (in_array($value["operator"], [">", "<", ">=", "<="])) {
	return "$field $value[operator] ".DB_Enclose($value["value"]);
      }
    } else if ((isset($value["notoperator"])) && (isset($value["value"]))) {
      if (in_array($value["notoperator"], [">", "<", ">=", "<="])) {
	return "NOT ($field $value[notoperator] ".DB_Enclose($value["value"]).")";
      }
    } else if (isset($value["in"])) {
      if (count($value["in"]) == 0) {
	// Empty set?  Return something that evaluates false
	return "0 = 1";
      }
      $ins = [];
      foreach ($value["in"] as $subval) {
	$ins[] = DB_Enclose($subval);
      }
      if (count($ins) == 1) {
	// One item?  Return a simple equals check
	$in = array_shift($ins);
	return "$field = $in";
      }
      $ins = implode(", ", $ins);
      return "$field IN ($ins)";
    } else if (isset($value["notin"])) {
      return "NOT (".DB_WhereClause($field, ["in" => $value["notin"]]).")";
    } else if ((isset($value["between"])) && (isset($value["and"]))) {
      return "$field BETWEEN ".DB_Enclose($value["between"])." AND ".DB_Enclose($value["and"]);
    } else if ((isset($value["notbetween"])) && (isset($value["and"]))) {
      return "NOT ($field BETWEEN ".DB_Enclose($value["notbetween"])." AND ".DB_Enclose($value["and"]).")";
    } else if (isset($value["hasbit"])) {
      $bit = pow(2, $value["hasbit"]);
      return "(($field & $bit) = $bit)";
    } else if (isset($value["nothasbit"])) {
      $bit = pow(2, $value["nothasbit"]);
      return "(($field & $bit) = 0)";
    } else if (isset($value["hasbitvalue"])) {
      $bit = $value["hasbitvalue"];
      return "(($field & $bit) = $bit)";
    } else if (isset($value["nothasbitvalue"])) {
      $bit = $value["nothasbitvalue"];
      return "(($field & $bit) = 0)";
    } else if (isset($value["isactive"])) {
      // Test for active admin objects, which can be 0 or NULL
      return "($field = 0 OR ".DB_Test_Null($field).")";
    } else if (isset($value["ors"])) {
      $ors = [];
      foreach ($value["ors"] as $subfield => $subvalue) {
	$ors[] = "(".DB_WhereClause($subfield, $subvalue).")";
      }
      return "(".implode(" OR ", $ors).")";
    } else if (isset($value["ands"])) {
      $ands = [];
      foreach ($value["ands"] as $subfield => $subvalue) {
	$ands[] = "(".DB_WhereClause($subfield, $subvalue).")";
      }
      return "(".implode(" AND ", $ands).")";
    } else if (isset($value["dbfield"])) {
      $field = $value["dbfield"];
      $field = preg_replace('/[^\w]/', "", $field);
      if ($field == "") {$field = "\"\"";}
      return $field;
    } else if (isset($value["true"])) {
      return "1 = 1";
    } else if (isset($value["false"])) {
      return "0 = 1";
    }
  }
  
  return "$field = ".DB_Enclose($value);
}

function DB_Enclose($value, $field = "") {
  // Sanitize a variable for DB command line

  if (is_array($value)) {
    if (isset($value["type"])) {
      // Preset types
      if ($value["type"] == "null") {
	return "NULL";
      } else if ($value["type"] == "timenow") {
	return '"'.UnixToSqlTime(time()).'"';
	//return "NOW()";
      }
    } else if (isset($value["dbfield"])) {
      // Point to a database field
      $field = $value["dbfield"];
      $field = preg_replace('/[^\w]/', "", $field);
      return $field;
    } else if (isset($value["crc32"])) {
      // CRC32 checksum of another value
      return "CRC32(".DB_Enclose($value["crc32"]).")";
    } else if ((isset($value["add"])) && ($field != "")) {
      return "$field + ".DB_Enclose($value["add"]);
    } else if ((isset($value["subtract"])) && ($field != "")) {
      return "$field - ".DB_Enclose($value["subtract"]);
    }
    // Unrecognized array type
    return "NULL";
  } else if ((is_float($value)) || (is_int($value))) {
    // Floats and integers can be presented literally
    return $value;
  } else if ((is_null($value)) || ($value === false)) {
    // Literal nulls and literal falses
    return "NULL";
  } else {
    // Quoted strings
    return '"'.DB_String($value).'"';
  }

  // Unrecognized variable type
    //Unreachable
  //return "NULL";
}

function DB_String($str) {
  // Escape a string for DB insertion
  $str = str_replace("\\", "\\\\", $str);
  $str = str_replace("\"", "\\\"", $str);
  $str = str_replace("\n", "\\n", $str);
  return $str;
}

function DB_DBTimeToEpoch($time) {
  if (preg_match('/^(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)$/', $time, $m)) {
    return mktime($m[4], $m[5], $m[6], $m[2], $m[3], $m[1]);
  }
  return false;
}

function UnixToSqlTime($utime) {
  return date("Y-m-d H:i:s", floor($utime));
}

function DateStringMinusSeconds($dateString, $seconds){
    $time = strtotime($dateString);
    $time = $time - $seconds;
    return UnixToSqlTime($time);
}

function DateStringPlusSeconds($dateString, $seconds){
    $time = strtotime($dateString);
    $time = $time + $seconds;
    return UnixToSqlTime($time);
}

// GENERIC TABLE FUNCTIONS

function DB_ExactMatches($table, $matches, $options = []) {
  // Search abitrary table in db for exact match, using name-value pairs in an array

  global $DatabasePrefix;
  global $db_error;
  global $db_lastquery;
  $db_error = "";

  // construct WHERE clause
  $clause = [];
  foreach ($matches as $field=>$value) {
    $clause[] = DB_WhereClause($field, $value);
  }
  $clause = implode(" AND ", $clause);
  if ($clause != "") {$clause = "WHERE $clause";}

  $selection = "*";
  if (isset($options["countmode"])) {
    $selection = "COUNT(*)";
  } else if (isset($options["sum"])) {
    $selection = "SUM($options[sum])";
  }

  $order = "";
  if (isset($options["OrderBy"])) {
    $order = "ORDER BY $options[OrderBy]";
  } else if (isset($options["DescOrderBy"])) {
    $order = "ORDER BY $options[DescOrderBy] DESC";
  }

  $limit = "";
  if (isset($options["Limit"])) {
    $limit = $options["Limit"];
    if (isset($options["Start"])) {
      $limit = $options["Start"].", $limit";
    }
    $limit = "LIMIT $limit";
  }

  $db_lastquery = "SELECT $selection FROM $DatabasePrefix$table $clause $order $limit";
  $results = DB_GetArray($db_lastquery);

  if (($table == "RepositoryFiles") && ($selection == "*") && (!(isset($options["DontLocalize"])))) {
    LocalizeRepoFiles($results);
  }

  return $results;
}

function DB_GetSum($sumof, $table, $matches, $countinstead = false) {
  // Search abitrary table in db for exact match, using name-value pairs in an array

  global $DatabasePrefix;
  global $db_error;
  global $db_lastquery;
  $db_error = "";

  // construct WHERE clause
  $clause = [];
  foreach ($matches as $field=>$value) {
    $clause[] = DB_WhereClause($field, $value);
  }
  $clause = implode(" AND ", $clause);
  if ($clause != "") {$clause = "WHERE $clause";}

  $function = $countinstead ? "count" : "sum";
  $sumof = preg_replace('/(^\w\.)/', "", $sumof);
  $db_lastquery = "SELECT $function($sumof) FROM $DatabasePrefix$table $clause";
  $r = DB_GetArray($db_lastquery);
  if ($r === false) {return false;}
  if (count($r) == 0) {
    $db_error = "No results returned.";
    return false;
  }

  $r = array_shift($r);
  $r = array_shift($r);
  return $r;
}

function DB_Update($table, $fields, $where) {
  // Update record fields
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  $set = [];
  foreach ($fields as $field=>$value) {
    $set[] = "$field = ".DB_enclose($value, $field);
  }
  $set = implode(", ", $set);

  $clause = [];
  foreach ($where as $field=>$value) {
    $clause[] = DB_WhereClause($field, $value);
  }
  $clause = implode(" AND ", $clause);
  if ($clause != "") {$clause = "WHERE $clause";}

  return DB_PlainQuery("UPDATE $DatabasePrefix$table SET $set $clause");
}

function DB_Delete($table, $where, $options = []) {
  // Delete records from a table
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  $clause = [];
  foreach ($where as $field=>$value) {
    $clause[] = DB_WhereClause($field, $value);
  }
  $clause = implode(" AND ", $clause);
  if ($clause != "") {$clause = "WHERE $clause";}

  $limit = "";
  if (isset($options["Limit"])) {
    $limit = "LIMIT ".$options["Limit"];
  }

  return DB_PlainQuery("DELETE FROM $DatabasePrefix$table $clause $limit");
}







// SETUP FUNCTIONS
// Used by setup and database structure modules

function DB_TestPrepopulation() {
  // Test database for existing data during setup
  global $DatabasePrefix;

  $users = DB_CountQuery("SELECT COUNT(*) FROM {$DatabasePrefix}Users");
  $configs = DB_CountQuery("SELECT COUNT(*) FROM {$DatabasePrefix}Configuration");
  return (($users > 0) && ($configs > 0));
}

function DB_CreateTable($table, $fields, $okifexists = 0) {
  // Check for a table in the DB.
  // If it doesn't exist, create it.
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;
  if (DB_CountQuery("SELECT COUNT(*) FROM $tablename") === false) {
    // Create new table
    $defs = [];
    foreach ($fields as $field=>$definition) {
      $definition = DB_LocalizeDefinition($definition);
      $defs[] = "$field $definition";
    }
    $defs = implode($defs, ", ");
    if (!(DB_PlainQuery("CREATE TABLE $tablename ($defs)"))) {
      // Error happened while creating table
      return false;
    }

    // Go back and create indexes as needed
    foreach ($fields as $field=>$definition) {
      $makeindex = (preg_match('/ INDEX$/', $definition));
      if ($makeindex) {
	if (!(DB_AddIndex($table, $field))) {
	  return false;
	}
      }
    }
    
    // Success!
    return true;
  } else {
    // Table exists.  Is this OK?
    if ($okifexists) {
      return true;
    } else {
      $db_error = "Table $table already exists";
      return false;
    }
  }
}

function DB_CreateOrVerifyTable($table, $fields) {
  // OBSOLETE?
  DB_CreateTable($table, $fields, 1);
}

function DB_RepairTable($table) {
  global $DatabasePrefix;
  global $db_error;

  $db_error = "";
  $tablename = $DatabasePrefix.$table;

  if (!(DB_PlainQuery("REPAIR TABLE $tablename"))) {
    return false;
  }

  return true;
}

function DB_AddFieldToTable($table, $field, $definition) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $makeindex = (preg_match('/ INDEX$/', $definition));
  $tablename = $DatabasePrefix.$table;
  $definition = DB_LocalizeDefinition($definition);

  if (!(DB_PlainQuery("ALTER TABLE $tablename ADD COLUMN $field $definition"))) {
    return false;
  }

  if ($makeindex) {
    return DB_AddIndex($table, $field);
  }

  return true;
}

function DB_UpdateFieldDefinition($table, $field, $definition) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;

  $makeindex = 0;
  if (preg_match('/ INDEX$/', $definition)) {
    $makeindex = 1;
    $definition = preg_replace('/ INDEX$/', "", $definition);
  }

  return DB_PlainQuery("ALTER TABLE $tablename MODIFY COLUMN $field $definition");
}

function DB_DropFieldFromTable($table, $field) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;

  return DB_PlainQuery("ALTER TABLE $tablename DROP COLUMN $field");
}

function DB_AddMultiIndexToTable($table, $index, $fields) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;
  $fields = implode(", ", $fields);

  return DB_PlainQuery("ALTER TABLE $tablename ADD INDEX $index ($fields)");
}

function DB_DropIndexFromTable($table, $index) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;

  return DB_PlainQuery("ALTER TABLE $tablename DROP INDEX $index");
}



// USER FUNCTIONS

function DB_Verify_Login($user, $pass) {
  // Verify a user and fetch his database record

  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  global $UserRecord;
  global $User;

  if (preg_match('/[^\w ]/', $user)) {
    $db_error = "Invalid user name";
    return false;
  }

  $Users = $DatabasePrefix."Users";
  $AdminLevels = $DatabasePrefix."AdminLevels";

  $record = DB_GetArray("SELECT $Users.*, AdminPermissions FROM $Users LEFT JOIN $AdminLevels ON $Users.AdminLevelID = $AdminLevels.ID WHERE LOWER(Username) = LOWER(\"$user\")");
  if ($record === false) {
    return false;
  }
  if (count($record) == 0) {
    $db_error = "No match";
    return false;
  }
  $TempRecord = array_shift($record);
  if ($TempRecord["Password"] != SaltedHash($pass, $TempRecord["Salt"])) {
    $db_error = "No match";
    return false;
  }
  if ($TempRecord["AccountStatus"] > 0) {
    $db_error = "This account has been set as inactive.";
    return false;
  }

  $UserRecord = $TempRecord;
  $User = $UserRecord["Username"];

  return true;
}


function DB_GetUserRoleBits($userid) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  $roles = $DatabasePrefix."Roles";
  $membership = $DatabasePrefix."Membership";

  $bits = DB_GetArray("SELECT BIT_OR(RolePermissions) FROM $membership LEFT JOIN $roles ON $membership.RoleID = $roles.ID WHERE $membership.UserID = $userid");
  if ($bits === false) {
    return false;
  }
  if (count($bits) == 0) {return 0;}
  $bits = array_shift($bits);
  $bits = array_shift($bits);
  return $bits;
}





// CONFIG FUNCTIONS

function GetLatestConfig() {
  // Load system config and status params into global vars

  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  $toprocess = [];

  // These variables may cause problems if not in DB, so define them early
  $upgradevars = ["GlobalMVAccess"];
  foreach ($upgradevars as $var) {
    global $$var;
    $var = "";
  }

  $config = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}Configuration ORDER BY ID Desc", 0, 1);
  if ($config === false) {
    return false;
  }
  if (count($config) == 0) {
    $db_error = "No config found.";
    return false;
  }
  $toprocess[] = array_shift($config);
  
  $status = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}Status ORDER BY ID Desc", 0, 1);
  if ($status === false) {
    return false;
  }
  if (count($status) > 0) {
    $toprocess[] = array_shift($status);
  }

  foreach ($toprocess as $result) {
    foreach ($result as $param=>$value) {
      if ($param != "ID") {
	global $$param;
	$$param = $value;
      }
    }
  }

  global $LicenseString;
  $LicenseString = "";
  $license = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}License ORDER BY ID Desc", 0, 1);
  if (($license !== false) && (count($license) > 0)) {
    $license = array_shift($license);
    $LicenseString = $license["LicenseString"];
  }

  // Apply some corrections for upgrades
  global $CommRetryLimit;
  global $ArchiveMediaMB;

  if ($CommRetryLimit < 2) {$CommRetryLimit = 10;}
  if ($ArchiveMediaMB == 700) {$ArchiveMediaMB = 660;} // Adjust for MB vs MiB
  if ($ArchiveMediaMB == 4490) {$ArchiveMediaMB = 4400;} // Adjust for MB vs MiB

  // Apply some configuration defaults if values are missing (upgrade or fresh install)
  $ConfigDefaults = ["XferDaemonPort" => 20911,
			  "PINMinDigits" => 4,
			  "AllowUserPinChange" => 1,
			  "CommFileBatch" => 300,
			  "DefaultExpirationAge" => "3m",
			  "DefaultInterviewExpAge" => "3m",
			  "DefaultAuxExpirationAge" => "1m",
			  "DefaultPR9ExpirationAge" => "1m",
			  "DefaultMVLogExpirationAge" => "1m",
			  "DefaultUnparsedExpAge" => "never",
			  "ExportReadyPath" => "export-ready",
			  "ArchiveReadyPath" => "archive-ready",
			  "HomeRect" => "24.7,-126.2,49.3,-66.7",
			  "ExpireAlertThreshold" => 0,
			  "ExpireAlertTimespan" => "1w",
			  "UseHubDaemon" => 1,
			  "HubDaemonPort" => 10911,
			  "MaxLogAge" => "1y",
			  "MaxEventAge" => "0",
			  "ExportMethodExclude" => "local",
			  "ExportMethodDefault" => "direct",
			  "ExportFormatDefault" => "webplay",
			  "TranscoderThreads" => 2,
			  "PTBurnLocalDrive" => "C:",
			  "iParkHost" => "127.0.0.1",
			  "iParkPort" => "3101",
			  "iParkFreq" => "30"];
  foreach ($ConfigDefaults as $ConfigField => $ConfigValue) {
    global $$ConfigField;
    if ((!(isset($$ConfigField))) || ($$ConfigField === "")) {
      $$ConfigField = $ConfigValue;
    }
  }

  // Translate old-style timespans
  $timespans = [7    => "1w",
		     14   => "2w",
		     30   => "1m",
		     45   => "45d",
		     60   => "2m",
		     91   => "3m",
		     121  => "4m",
		     183  => "6m",
		     365  => "1y",
		     730  => "2y",
		     1095 => "3y",
		     1826 => "5y",
		     3652 => "10y",
		     0    => "never",
		     -1   => "never"];
  global $DefaultExpirationAge;
  global $DefaultAuxExpirationAge;

  foreach (["DefaultExpirationAge", "DefaultAuxExpirationAge", "MaxLogAge"] as $exp) {
    if (isset($timespans[$$exp])) {
      // This is one of the old presets; convert
      $$exp = $timespans[$$exp];
    } else if (preg_match('/^(\d+)$/', $$exp)) {
      // This is some other number of days
      $$exp = $$exp."d"; 
    }
  }

  return true;
}

function DB_UpdateConfiguration() {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  // Scan for fields and populate new list from global vars
  $config = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}Configuration ORDER BY ID Desc", 0, 1);
  if ($config === false) {
    return false;
  }
  if (count($config) == 0) {
    $db_error = "No config found.";
    return false;
  }
  $params = array_shift($config);
  $fields = [];
  foreach ($params as $param=>$value) {
    if ($param != "ID") {
      global $$param;
      if ((isset($$param)) && ($$param !== "")) {
	$fields[$param] = $$param;
      }
    }
  }
  
  return DB_Insert("Configuration", $fields);
}

function DB_UpdateStatus() {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  // Scan for fields and populate new list from global vars
  $status = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}Status ORDER BY ID Desc", 0, 1);
  if ($status === false) {
    return false;
  }
  if (count($status) == 0) {
    $params = ["DatabaseVersion"         => "INT UNSIGNED",
		    "SoftwareVersion"         => "VARCHAR(255)",
		    "CurrentArchiveID"        => "INT UNSIGNED",
		    "SiteID"                  => "VARCHAR(255)",
		    "HighBandwidthPort"       => "INT UNSIGNED",
		    "LastUserListUpdate"      => "DATETIME",
		    "LastSourceListUpdate"    => "DATETIME",
		    "LastGroupListUpdate"     => "DATETIME",
		    "LastClassListUpdate"     => "DATETIME",
                    "LastBodyCamListUpdate"   => "DATETIME",
		    "LastMaintenanceCycle"    => "DATETIME",
		    "MaintenanceRunning"      => "DATETIME",
		    "LastMaintenanceFailed"   => "TINYINT UNSIGNED"];
  } else {
    $params = array_shift($status);
  }

  $fields = [];
  foreach ($params as $param=>$value) {
    if ($param != "ID") {
      global $$param;
      if (isset($$param)) {
 	if ($$param === false) {
	  $fields[$param] = DB_Null();
	} else if ($$param !== "") {
	  $fields[$param] = $$param;
	}
      }
    }
  }
  
  return DB_Insert("Status", $fields);
}




// MEDIA/FILE FUNCTIONS

function DB_GetUnprocessedMediaFiles($sourceid) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  $sql = "SELECT * FROM {$DatabasePrefix}RepositoryFiles ";
  $sql .= "WHERE SourceID=$sourceid ";
  $sql .= "AND ".DB_Test_Null("ParseTime")." ";
  $sql .= "AND NOT ".DB_Test_Null("CompleteTime")." ";
  $sql .= "AND ErrorCode = 0 "; // Should this be <100?
  $sql .= "ORDER BY ID";

  return DB_GetArray($sql);
}

function DB_RunMediaQuery($prefix = "Search") {
  // Create an SQL search query based on input from the Search Media form
  // Uses $_SESSION["Search/..."] variables as input parameters

  // Globals
  global $DatabasePrefix;
  global $db_error;
  global $db_group_concat_allowed;
  global $db_nested_select_allowed;
  global $UserRecord;
  global $UserPermissions;
  global $BitValue;
  global $max_results;
  global $total_results;
  $db_error = "";

  // Table names
  $Media = $DatabasePrefix."Media";
  $Users = $DatabasePrefix."Users";
  $Sources = $DatabasePrefix."Sources";
  $RepositoryFiles = $DatabasePrefix."RepositoryFiles";
  $MediaChildFiles = $DatabasePrefix."MediaChildFiles";
  $MediaTags = $DatabasePrefix."MediaTags";
  $Roles = $DatabasePrefix."Roles";
  $Membership = $DatabasePrefix."Membership";
  $MediaAssociations = $DatabasePrefix."MediaAssociations";
  $Groups = $DatabasePrefix."Groups";
  $MediaTitleKeywords = $DatabasePrefix."MediaTitleKeywords";
  $TagNameKeywords = $DatabasePrefix."TagNameKeywords";
  $TagNotesKeywords = $DatabasePrefix."TagNotesKeywords";
  $TagFieldKeywords = $DatabasePrefix."TagFieldKeywords";
  $PlateReads = $DatabasePrefix."PlateReads";
  $PlateText = $DatabasePrefix."PlateText";
  $PlateTextSimplified = $DatabasePrefix."PlateTextSimplified";

  // Arrays for database query pieces
  $fields = [];      // Fields to return from query
  $tables = [];      // Tables to include in query
  $wheres = [];      // WHERE clauses to AND together
  $groupby = "";          // GROUP BY clause, if needed
  $index = "ID";
  $outerwheres = []; // If has elements, WHERE clauses to run on results from query above

  // Get form properties
  $basetype = "media";
  if (isset($_SESSION["$prefix/Quick"])) {
    $quick = $_SESSION["$prefix/Quick"];
    $group = "any";
  } else if (isset($_SESSION["$prefix/QuickLPR"])) {
    $quick = $_SESSION["$prefix/QuickLPR"];
    $basetype = "lpr";
  } else {
    $type = $_SESSION["$prefix/Type"];
    $title = $_SESSION["$prefix/Title"];
    $plate = $_SESSION["$prefix/Plate"];
    $hitplate = $_SESSION["$prefix/HitPlate"];
    $hitstate = $_SESSION["$prefix/HitState"];
    $group = $_SESSION["$prefix/Group"];
    $owner = $_SESSION["$prefix/Owner"];
    $eventtime = $_SESSION["$prefix/EventTime"];
    $uploadtime = $_SESSION["$prefix/UploadTime"];
    $source = $_SESSION["$prefix/Source"];
    $tags = $_SESSION["$prefix/Tags"];
    $class = $_SESSION["$prefix/Class"];
    $triggers = $_SESSION["$prefix/Triggers"];
    $gps = $_SESSION["$prefix/Gps"];
    $heading = $_SESSION["$prefix/Heading"];
    $expirationdate = $_SESSION["$prefix/ExpirationDate"];

    if ($type == "LPR") {
      $basetype = "lpr";
    }
  }

  if ($basetype == "lpr") {
    // Common LPR query elements
    $fields[] = "$PlateReads.*";
    $tables[] = "$PlateReads";

    // Source name from Source table
    $fields[] = "SourceName";
    $tables[] = "LEFT JOIN $Sources ON SourceID = $Sources.ID";

    // Username from user table, related to owner ID
    $fields[] = "Username";
    $tables[] = "LEFT JOIN $Users ON OwnerID = $Users.ID";

    // ParseTime and SourcePath from primary media file
    $fields[] = "$RepositoryFiles.SourcePath";
    $fields[] = "$RepositoryFiles.ParseTime";
    $tables[] = "LEFT JOIN $RepositoryFiles ON FromPR9 = $RepositoryFiles.ID";

    // Plate text from PlateText
    $fields[] = "ReadPlateText.Text AS ReadTextChars";
    $tables[] = "LEFT JOIN $PlateText AS ReadPlateText ON ReadText = ReadPlateText.ID";

    // Plate text from MatchText
    $fields[] = "MatchPlateText.Text AS MatchTextChars";
    $tables[] = "LEFT JOIN $PlateText AS MatchPlateText ON MatchText = MatchPlateText.ID";

  } else {
    // Common media query elements:

    // Media table
    $fields[] = "$Media.*";
    //$fields[] = "$Media.EventEndTime - $Media.EventStartTime AS Duration";
    $tables[] = $Media;

    // Source name from Source table
    $fields[] = "SourceName";
    $tables[] = "LEFT JOIN $Sources ON UploadSourceID = $Sources.ID";

    // Username from user table, related to owner ID
    $fields[] = "Username";
    $tables[] = "LEFT JOIN $Users ON OwnerID = $Users.ID";

    // ParseTime and SourcePath from primary media file
    $fields[] = "$RepositoryFiles.SourcePath";
    $fields[] = "$RepositoryFiles.ParseTime";
    $tables[] = "LEFT JOIN $RepositoryFiles ON PrimaryFileID = $RepositoryFiles.ID";

    // Group name and ID by association via MediaAssociations
    $tables[] = "LEFT JOIN $MediaAssociations ON $MediaAssociations.MediaID = $Media.ID";
    $tables[] = "LEFT JOIN $Groups ON $Groups.ID = $MediaAssociations.GroupID";
    $groupby = "GROUP BY $Media.ID";
    $fields[] = "GROUP_CONCAT(DISTINCT $Groups.ID) AS GroupIDs";
    $fields[] = "GROUP_CONCAT(DISTINCT $Groups.GroupName SEPARATOR ', ') AS GroupNames";

    // Trigger flags in binary
    $fields[] = "BIN(TriggerFlags) as BinTriggerFlags";

    // PERMISSION FILTERS
    // These filters apply to all searches and limit them to media the user has access to.
    if (($UserPermissions & $BitValue[16]) == 0) {
      // If user does not have global read access...
      $permfilter = [];
      
      // Create array of group IDs user has read access to through role permissions.
      $WithinGroups = [];
      $sql  = "SELECT $Groups.ID ";
      $sql .= "FROM $Groups ";
      $sql .= "  RIGHT JOIN $Membership ON $Membership.GroupID = $Groups.ID ";
      $sql .= "  RIGHT JOIN $Roles ON $Roles.ID = $Membership.RoleID ";
      $sql .= "WHERE ";
      $sql .= "  $Membership.UserID = $UserRecord[ID]";
      $sql .= "  AND (RolePermissions & $BitValue[16]) > 0";

      $found_groups = DB_GetArray($sql);
      if ($found_groups === false) {return false;}
      foreach ($found_groups as $id => $args) {
	$WithinGroups[$id] = $id;
      }

      // Also, query for groups with global media read access
      $sql  = "SELECT $Groups.ID ";
      $sql .= "FROM $Groups ";
      $sql .= "WHERE ";
      $sql .= "  (GroupPermissions & $BitValue[1]) > 0";

      $found_groups = DB_GetArray($sql);
      if ($found_groups === false) {return false;}
      foreach ($found_groups as $id => $args) {
	$WithinGroups[$id] = $id;
      }

      // Apply groups found above to permission filter
      if (count($WithinGroups) > 0) {
	$permfilter[] = "$MediaAssociations.GroupID IN (".implode(", ", $WithinGroups).")";
      }

      // If user has read access to own media, allow those in permission filter too
      if ($UserPermissions & $BitValue[24]) {
	$permfilter[] = "$Media.OwnerID = $UserRecord[ID]";
      }

      // Apply permission filter to WHERE array
      if (count($permfilter) > 1) {
	// multiple permission filter elements get ORed together and pushed on WHERE array
	$wheres[] = "(" . implode(" OR ", $permfilter) . ")";
      } else if (count($permfilter) == 1) {
	// A single permission filter can be pushed directly into WHERE array
	$wheres[] = array_shift($permfilter);
      } else {
	// This user doesn't have read access to anything!
	$wheres[] = "1 = 0";
      }
    }

    if (!($UserPermissions & $BitValue[4])) {
      // If user is not a media admin, he cannot see expired/deleted media
      $wheres[] = "DeleteStatus = 0";
    }
  }

  if (isset($_SESSION["$prefix/Quick"])) {
    // QUICK MEDIA SEARCH OPTIONS

    $qswheres = [];

    if ((preg_match('/\.\w+$/', $quick)) && (!(preg_match('/\s/', $quick)))) {
      // If a filename is entered, search repositoryfiles for that file
      $tables[] = "LEFT JOIN $MediaChildFiles ON $MediaChildFiles.MediaID = $Media.ID";
      $tables[] = "LEFT JOIN $RepositoryFiles AS AllRepoFiles ON $MediaChildFiles.RepositoryFileID = AllRepoFiles.ID";
      //$fields[] = "AllRepoFiles.SourcePath";
      $qswheres[] = "AllRepoFiles.SourcePath = ".DB_Enclose($quick);
      $quick = "";
    }

    $daterx = '/\b(\d+)\\/(\d+)\\/?(\d+)?\b/';
    if (preg_match($daterx, $quick, $m)) {
      // If a date is entered, show results whose event or parse time match that date
      $quick = preg_replace($daterx, "", $quick);
      $day = intval($m[2]);
      $month = intval($m[1]);
      if ((count($m) > 3) && ($m[3] > 0)) {
	$year = intval($m[3]);
	if ($year < 100) {$year += 2000;}
      } else {
	if (($month > date("n")) || ($day > date("j"))) {
	  $year = date("Y")-1;
	} else {
	  $year = date("Y");
	}
      }
      if ($day < 10) {$day = "0$day";}
      if ($month < 10) {$month = "0$month";}
      $startstamp = UnixToSqlTime(mktime(0, 0, 0, $month, $day, $year));
      $endstamp = UnixToSqlTime(mktime(23, 59, 59, $month, $day, $year));
      $qswheres[] = "($Media.EventStartTime BETWEEN \"$startstamp\" AND \"$endstamp\")";
      $qswheres[] = "($RepositoryFiles.ParseTime BETWEEN \"$startstamp\" AND \"$endstamp\")";
    }

    $rangerx = '/^(\d+)-(\d+)$/';
    if (preg_match($rangerx, $quick, $m)) {
      // If ID range is entered, show that range
      if ($m[1] <= $m[2]) {
	//$quick = preg_replace($rangerx, "", $quick);
	$qswheres[] = "($Media.ID BETWEEN $m[1] AND $m[2])";
      }
    }

    $rangerx = '/^(\d+)$/';
    if (preg_match($rangerx, $quick, $m)) {
      // If single number is entered, show that ID
      $qswheres[] = "$Media.ID = $m[1]";
    }

    if (preg_match('/[a-zA-Z0-9\-]/', $quick)) {
      // Find all matching keywords in media title, bookmarks
      $wids = DB_GetKeywordIDs($quick);
      if ($wids) {
	$fields[] = "COUNT($MediaTags.ID) AS TagCount";
	$tables[] = "LEFT JOIN $MediaTags ON $Media.ID = $MediaTags.MediaID";
	$tables[] = "LEFT JOIN $TagNameKeywords ON $MediaTags.ID = $TagNameKeywords.MediaTagID";
	$tables[] = "LEFT JOIN $TagNotesKeywords ON $MediaTags.ID = $TagNotesKeywords.MediaTagID";
	$tables[] = "LEFT JOIN $TagFieldKeywords ON $MediaTags.ID = $TagFieldKeywords.MediaTagID";
	$tables[] = "LEFT JOIN $MediaTitleKeywords ON $Media.ID = $MediaTitleKeywords.MediaID";

	$tests = [];
	$wids = implode(", ", $wids);
	$qswheres[] = "$TagNameKeywords.KeywordID IN ($wids)";
	$qswheres[] = "$TagNotesKeywords.KeywordID IN ($wids)";
	$qswheres[] = "$TagFieldKeywords.KeywordID IN ($wids)";
	$qswheres[] = "$MediaTitleKeywords.KeywordID IN ($wids)";
	$outerwheres[] = "TagCount > 0";
      }
    }

    if ($qswheres) {
      // OR the quick search patterns together
      $wheres[] = "(".implode(" OR ", $qswheres).")";
    } else {
      // No valid queries could be parsed out of the user's muddled ravings; return no results
      $wheres[] = "1 = 0";
    }

  } else if (isset($_SESSION["$prefix/QuickLPR"])) {

    // Do a partial plate match
    $term = SimplifyPlate($quick);

    if (0) {
      // This method is slow
      $wheres[] = "ReadPlateTextSimplified.Text LIKE \"%$term%\"";
    } else {
      // Finding matching IDs first is faster for some reason
      $matches = DB_ExactMatches("PlateTextSimplified", ["Text" => ["like" => "%$term%"]]);
      if ($matches === false) {return false;}
      if (count($matches) == 0) {return $matches;}
      $ids = implode(",", array_keys($matches));
      $wheres[] = "ReadPlateTextSimplified.ID IN ($ids)";
    }
    $tables[] = "LEFT JOIN $PlateTextSimplified AS ReadPlateTextSimplified ON ReadPlateText.SimplifiedID = ReadPlateTextSimplified.ID";
  } else {
    if ($type == "LPR") {
      // FULL LPR SEARCH OPTIONS

      // Plate read pulldown options
      if ($plate == "exact") {
	$wheres[] = "ReadPlateText.Text = ".DB_Enclose(FormatPlate($_SESSION["$prefix/PlateQuery"]));
      } else if ($plate == "fuzzy") {
	// Plate text from PlateText
	$wheres[] = "ReadPlateTextSimplified.Text = ".DB_Enclose(SimplifyPlate($_SESSION["$prefix/PlateQuery"]));
	$tables[] = "LEFT JOIN $PlateTextSimplified AS ReadPlateTextSimplified ON ReadPlateText.SimplifiedID = ReadPlateTextSimplified.ID";
      } else if ($plate == "partial") {
	$term = SimplifyPlate($_SESSION["$prefix/PlateQuery"]);
	$wheres[] = "ReadPlateTextSimplified.Text LIKE \"%$term%\"";
	$tables[] = "LEFT JOIN $PlateTextSimplified AS ReadPlateTextSimplified ON ReadPlateText.SimplifiedID = ReadPlateTextSimplified.ID";
      }

      // Hotlist hit plate options
      if ($hitplate == "unmatched") {
	$wheres[] = DB_Test_Null("MatchText");
      } else if ($hitplate == "matched") {
	$wheres[] = "NOT (".DB_Test_Null("MatchText").")";
      } else if ($hitplate == "exact") {
	$wheres[] = "MatchPlateText.Text = ".DB_Enclose(FormatPlate($_SESSION["$prefix/HitPlateQuery"]));
      } else if ($hitplate == "fuzzy") {
	// Plate text from PlateText
	$wheres[] = "MatchPlateTextSimplified.Text = ".DB_Enclose(SimplifyPlate($_SESSION["$prefix/HitPlateQuery"]));
	$tables[] = "LEFT JOIN $PlateTextSimplified AS MatchPlateTextSimplified ON MatchPlateText.SimplifiedID = MatchPlateTextSimplified.ID";
      } else if ($hitplate == "partial") {
	$term = SimplifyPlate($_SESSION["$prefix/HitPlateQuery"]);
	$wheres[] = "MatchPlateTextSimplified.Text LIKE \"%$term%\"";
	$tables[] = "LEFT JOIN $PlateTextSimplified AS MatchPlateTextSimplified ON MatchPlateText.SimplifiedID = MatchPlateTextSimplified.ID";
      }

      // Hotlist hit state options
      if ($hitstate == "exact") {
	$wheres[] = "MatchState = ".DB_Enclose(StrToUpper($_SESSION["$prefix/HitStateQuery"]));
      }

      // Expiration date pulldown options
      if ($expirationdate == "week") {
	// Expires within one week
	$end = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")+7));
	$wheres[] = "ExpirationDate < \"$end\"";
	$wheres[] = "NOT (".DB_Test_Null("ExpirationDate").")";
      } else if ($expirationdate == "month") {
	// Past month
	$end = UnixToSqlTime(mktime(0, 0, 0, date("n")+1));
	$wheres[] = "ExpirationDate < \"$end\"";
	$wheres[] = "NOT (".DB_Test_Null("ExpirationDate").")";
      } else if ($expirationdate == "lastweek") {
	$start = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")-7));
	$wheres[] = "ExpirationDate > \"$start\"";
	$wheres[] = "NOT (".DB_Test_Null("ExpirationDate").")";
      } else if ($expirationdate == "lastmonth") {
	// Past month
	$start = UnixToSqlTime(mktime(0, 0, 0, date("n")-1));
	$wheres[] = "ExpirationDate > \"$start\"";
	$wheres[] = "NOT (".DB_Test_Null("ExpirationDate").")";
      } else if ($expirationdate == "never") {
	$wheres[] = DB_Test_Null("ExpirationDate");
      } else if ($expirationdate == "custom") {
	// Custom time range
	$expirationfrom = ParseJSCalendar($_SESSION["$prefix/ExpirationFrom"], -1);
	$expirationto = ParseJSCalendar($_SESSION["$prefix/ExpirationTo"], 1);
	$wheres[] = "ExpirationDate BETWEEN \"$expirationfrom 00:00:00\" AND \"$expirationto 23:59:59\"";
	$wheres[] = "NOT (".DB_Test_Null("ExpirationDate").")";
      }

      // Heading pulldown options
      if ($heading == "n") {
	$wheres[] = "(ReadHeading >= 315 OR ReadHeading <= 45)";
	$wheres[] = "NOT (".DB_Test_Null("ReadHeading").")";
      } else if ($heading == "ne") {
	$wheres[] = "ReadHeading BETWEEN 0 AND 90";
	$wheres[] = "NOT (".DB_Test_Null("ReadHeading").")";
      } else if ($heading == "e") {
	$wheres[] = "ReadHeading BETWEEN 45 AND 135";
      } else if ($heading == "se") {
	$wheres[] = "ReadHeading BETWEEN 90 AND 180";
      } else if ($heading == "s") {
	$wheres[] = "ReadHeading BETWEEN 135 AND 225";
      } else if ($heading == "sw") {
	$wheres[] = "ReadHeading BETWEEN 180 AND 270";
      } else if ($heading == "w") {
	$wheres[] = "ReadHeading BETWEEN 225 AND 315";
      } else if ($heading == "nw") {
	$wheres[] = "ReadHeading BETWEEN 270 AND 360";
      }

    } else {
      // FULL MEDIA SEARCH FORM OPTIONS

      // Group options
      if ($group == "specific") {
	// Specific group filter for users with access to all groups
	$ids = $_SESSION["$prefix/GroupIDs"];
	$WithinGroups = [];
	foreach ($ids as $id) {
	  $id = intval($id);
	  if ($id > 0) {$WithinGroups[$id] = $id;}
	}
	if (count($WithinGroups) == 0) {
	  // No groups apply; no matches.
	  $wheres[] = "0 = 1";
	} else {
	  $wheres[] = "$MediaAssociations.GroupID IN (".implode(", ", $WithinGroups).")";
	}
      } else if ($group == "none") {
	// Filter for media not associated with any group
	// Will only work if user has global media read access (duh)
	$fields[] = "COUNT($MediaAssociations.ID) AS GroupCount";
	$outerwheres[] = "GroupCount = 0";
      }

      // Media type options
      if (preg_match('/^\d+$/', $type)) {
	$wheres[] = "MediaType = $type";
      } else {
	$wheres[] = "MediaType != 191";
      }

      // Trigger options
      if (($triggers == "and") || ($triggers == "or")) {
	$flags = "0";
	foreach ($_SESSION["$prefix/TriggerFlags"] as $bit) {
	  if (($bit > 0) && ($bit <= 64)) {
	    $flags = bcadd($flags, bcpow(2, $bit-1));
	  }
	}
	if ($triggers == "and") {
	  // requires all flags
	  $wheres[] = "(TriggerFlags & $flags) = $flags";
	} else {
	  // requires one or more flags
	  $wheres[] = "(TriggerFlags & $flags) > 0";
	}
      }

      $dotagcount = false;
      // Tag and Class pulldown options
      if (($tags == "none") || ($tags == "tagged") || ($tags == "query") ||
	  ($class == "specific")) {

	if (!($dotagcount)) {
	  $dotagcount = true;
	  $fields[] = "COUNT($MediaTags.ID) AS TagCount";
	  $tables[] = "LEFT JOIN $MediaTags ON $Media.ID = $MediaTags.MediaID";
	}
	
	if ($tags == "none") {
	  $outerwheres[] = "TagCount = 0";
	} else if ($tags == "tagged") {
	  $outerwheres[] = "TagCount > 0";
	} else if ($tags == "query") {
	  $wids = DB_GetKeywordIDs($_SESSION["$prefix/TagQuery"]);
	  if ($wids == false) {
	    $wheres[] = "0 = 1";
	  } else {
	    $tables[] = "LEFT JOIN $TagNameKeywords ON $MediaTags.ID = $TagNameKeywords.MediaTagID";
	    $tables[] = "LEFT JOIN $TagNotesKeywords ON $MediaTags.ID = $TagNotesKeywords.MediaTagID";
	    $tests = [];
	    $wids = implode(", ", $wids);
	    $tests[] = "$TagNotesKeywords.KeywordID IN ($wids)";
	    $tests[] = "$TagNameKeywords.KeywordID IN ($wids)";
	    if (count($tests) > 0) {
	      $wheres[] = "(".implode(" OR ", $tests).")";
	    }
	    $outerwheres[] = "TagCount > 0";
	  }
	}
	
	if ($class == "specific") {
	  $ids = $_SESSION["$prefix/ClassIDs"];
	  $goodids = [];
	  foreach ($ids as $id) {
	    $id = intval($id);
	    if ($id > 0) {$goodids[] = $id;}
	  }
	  if (count($goodids) == 0) {
	    $db_error = "No valid class IDs were selected";
	    return false;
	  }
	  $ids = implode(", ", $goodids);
	  $wheres[] = "ClassID IN ($ids)";
	}
      }

      // Title pulldown options
      if ($title == "titled") {
	$wheres[] = "NOT (".DB_Test_Null("Title").")";
	$wheres[] = "Title != ''";
      } else if ($title == "untitled") {
	$wheres[] = "(".DB_Test_Null("Title")." OR Title = '')";
      } else if ($title == "query") {
	$wids = DB_GetKeywordIDs($_SESSION["$prefix/TitleQuery"]);
	if ($wids == false) {
	  $wheres[] = "0 = 1";
	} else {
	  $tables[] = "LEFT JOIN $MediaTitleKeywords ON $Media.ID = $MediaTitleKeywords.MediaID";
	  $wids = implode(", ", $wids);
	  $wheres[] = "$MediaTitleKeywords.KeywordID IN ($wids)";
	}
      }

      // Custom fields
      for ($n=0; $n<16; $n++) {
	$ftype = $_SESSION["$prefix/Field".$n];
	$fquery = $_SESSION["$prefix/Field".$n."Query"];
	if ($ftype == "filled") {
	  if (!($dotagcount)) {
	    $dotagcount = true;
	    $fields[] = "COUNT($MediaTags.ID) AS TagCount";
	    $tables[] = "LEFT JOIN $MediaTags ON $Media.ID = $MediaTags.MediaID";
	  }
	  $wheres[] = "NOT (".DB_Test_Null("Field$n").")";
	  $wheres[] = "Field$n != ''";
	} else if ($ftype == "query") {
	  $wids = DB_GetKeywordIDs($fquery);
	  if ($wids == false) {
	    $wheres[] = "0 = 1";
	  } else {
	    if (!($dotagcount)) {
	      $dotagcount = true;
	      $fields[] = "COUNT($MediaTags.ID) AS TagCount";
	      $tables[] = "LEFT JOIN $MediaTags ON $Media.ID = $MediaTags.MediaID";
	    }
	    $tables[] = "LEFT JOIN $TagFieldKeywords ON $MediaTags.ID = $TagFieldKeywords.MediaTagID";
	    $wids = implode(", ", $wids);
	    $wheres[] = "(($TagFieldKeywords.KeywordID IN ($wids)) AND (FieldNum = $n))";
	    $outerwheres[] = "TagCount > 0";
	  }
	}
      }

      // Junk Flag
      $junk = $_SESSION["$prefix/Junk"];
      if ($junk == "only") {
	$wheres[] = "(MediaFlags & ".MEDIAFLAG_JUNK.") != 0";
      } else if ($junk == "any") {
	// no where clause needs to be added
      } else {
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_JUNK.") = 0";
      }

      // Media State
      if ($UserPermissions & $BitValue[4]) {
	$state = $_SESSION["$prefix/State"];
	if ($state == "any") {
	  // Excludes deleted and expunged media
	  $wheres[] = "DeleteStatus IN (0,1,2)";
	} else if ($state == "expired") {
	  // All expired media
	  $wheres[] = "DeleteStatus IN (1,2)";
	} else if ($state == "todelete") {
	  $wheres[] = "DeleteStatus = 1";
	  $wheres[] = DB_Test_Null("ArchivedTo");
	} else if ($state == "archived") {
	  $wheres[] = "DeleteStatus IN (1,2)";
	  $wheres[] = "ArchivedTo > 0";
	} else {
	  // Active media only
	  $wheres[] = "DeleteStatus = 0";
	}
      }

      // Expiration date pulldown options
      if ($expirationdate == "week") {
	// Expires within one week
	$end = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")+7));
	$wheres[] = "ExpirationDate < \"$end\"";
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") = 0";
	$wheres[] = "DeleteStatus = 0";
      } else if ($expirationdate == "month") {
	// Past month
	$end = UnixToSqlTime(mktime(0, 0, 0, date("n")+1));
	$wheres[] = "ExpirationDate < \"$end\"";
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") = 0";
	$wheres[] = "DeleteStatus = 0";
      } else if ($expirationdate == "lastweek") {
	$start = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")-7));
	$wheres[] = "ExpirationDate > \"$start\"";
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") = 0";
	$wheres[] = "DeleteStatus = 1";
      } else if ($expirationdate == "lastmonth") {
	// Past month
	$start = UnixToSqlTime(mktime(0, 0, 0, date("n")-1));
	$wheres[] = "ExpirationDate > \"$start\"";
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") = 0";
	$wheres[] = "DeleteStatus = 1";
      } else if ($expirationdate == "never") {
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") != 0";
	$wheres[] = "DeleteStatus = 0";
      } else if ($expirationdate == "custom") {
	// Custom time range
	$expirationfrom = ParseJSCalendar($_SESSION["$prefix/ExpirationFrom"], -1);
	$expirationto = ParseJSCalendar($_SESSION["$prefix/ExpirationTo"], 1);
	$wheres[] = "ExpirationDate BETWEEN \"$expirationfrom 00:00:00\" AND \"$expirationto 23:59:59\"";
        $wheres[] = "(MediaFlags & ".MEDIAFLAG_NEVEREXPIRE.") = 0";
      }

    }

    // THESE OPTIONS ARE COMMON TO BOTH LPR AND MEDIA SEARCHES

    // This can be added to Wheres to test if GPS is null
    if ($type == "LPR") {
      $gpsnulltest = DB_Test_Null("ReadLatitude");
      $gpsnulltest .= " AND " . DB_Test_Null("ReadLongitude");
    } else {
      $gpsnulltest = DB_Test_Null("GpsLatitudeMin");
      $gpsnulltest .= " OR " . DB_Test_Null("GpsLatitudeMax");
      $gpsnulltest .= " OR " . DB_Test_Null("GpsLongitudeMin");
      $gpsnulltest .= " OR " . DB_Test_Null("GpsLongitudeMax");
    }

    // GPS filtering options
    if ($gps == "yes") {
      // Only where location is known
      $wheres[] = "NOT ($gpsnulltest)";
    } else if ($gps == "no") {
      // Only where location is unknown
      $wheres[] = "($gpsnulltest)";

      /* OUTDATED!
    } else if ($gps == "specific") {
      // Only near specific location
      $gpslat = $_SESSION["$prefix/GpsLat"];
      $gpslon = $_SESSION["$prefix/GpsLon"];
      $wheres[] = "NOT ($gpsnulltest)";
      $wheres[] = "($gpslat BETWEEN GpsLatitudeMin AND GpsLatitudeMax)";
      $wheres[] = "($gpslon BETWEEN GpsLongitudeMin AND GpsLongitudeMax)";
      */

    } else if (($gps == "rect") || ($gps == "related")) {
      // GPS falls within a rectangle
      $minlat = DB_Enclose($_SESSION["$prefix/GpsLatMin"]);
      $minlon = DB_Enclose($_SESSION["$prefix/GpsLonMin"]);
      $maxlat = DB_Enclose($_SESSION["$prefix/GpsLatMax"]);
      $maxlon = DB_Enclose($_SESSION["$prefix/GpsLonMax"]);
      if ($type == "LPR") {
	$wheres[] = "ReadLatitude BETWEEN $minlat AND $maxlat";
	$wheres[] = "ReadLongitude BETWEEN $minlon AND $maxlon";
      } elseif ($gps == "related") {
	// Special parameters for Related Media search -- match GPS rect or Source IDs
	$w = "(( ";
	if (($maxlat > -360) && ($maxlon > -360)) {
	  $w .= "GpsLatitudeMin < $maxlat AND ";
	  $w .= "GpsLatitudeMax > $minlat AND ";
	  $w .= "GpsLongitudeMin < $maxlon AND ";
	  $w .= "GpsLongitudeMax > $minlon";
	} else {
	  // No GPS condition.
	  $w .= "0 = 1";
	}
	$w .= " ) OR ( ";
	$w .= DB_WhereClause("UploadSourceID", ["in" => $_SESSION["$prefix/SourceIDs"]]);
	$w .= " ) OR ( ";
	$w .= DB_WhereClause("UploadSourceID", DB_IsNull());
	$w .= " ))";

	$wheres[] = $w;
	
      } else {
	$wheres[] = "GpsLatitudeMin < $maxlat";
	$wheres[] = "GpsLatitudeMax > $minlat";
	$wheres[] = "GpsLongitudeMin < $maxlon";
	$wheres[] = "GpsLongitudeMax > $minlon";
      }
    }

    // Owner pulldown options
    if ($owner == "me") {
      // "My" media: media owned by user performing search
      $wheres[] = "OwnerID = $UserRecord[ID]";
    } else if ($owner == "none") {
      $wheres[] = DB_Test_Null("OwnerID");
    } else if ($owner == "specific") {
      // Media by specific users
      $ids = $_SESSION["$prefix/UserIDs"];
      $goodids = [];
      foreach ($ids as $id) {
	$id = intval($id);
	if ($id > 0) {$goodids[] = $id;}
      }
      if (count($goodids) == 0) {
	$db_error = "No valid user IDs were selected";
	return false;
      }
      $ids = implode(", ", $goodids);
      $wheres[] = "OwnerID IN ($ids)";
    }

    // Upload time pulldown options
    if ($uploadtime == "day") {
      // Past 24 hours
      $start = UnixToSqlTime(time()-60*60*24);
      $wheres[] = "ParseTime > \"$start\"";
    } else if ($uploadtime == "week") {
      // Past 7 days
      $start = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")-7));
      $wheres[] = "ParseTime > \"$start\"";
    } else if ($uploadtime == "month") {
      // Past month
      $start = UnixToSqlTime(mktime(0, 0, 0, date("n")-1));
      $wheres[] = "ParseTime > \"$start\"";
    } else if ($uploadtime == "year") {
      // Past year
      $start = UnixToSqlTime(mktime(null, null, null, date("n"), date("j"), date("Y")-1));
      $wheres[] = "ParseTime > \"$start\"";
    } else if ($uploadtime == "custom") {
      // Custom time range
      $uploadfrom = ParseJSCalendar($_SESSION["$prefix/UploadFrom"], -1);
      $uploadto = ParseJSCalendar($_SESSION["$prefix/UploadTo"], 1);
      $wheres[] = "ParseTime BETWEEN \"$uploadfrom\" AND \"$uploadto\"";
    }

    // Event time pulldown options
    $etfield = ($type == "LPR") ? "ReadTime" : "EventStartTime";

    if ($eventtime == "day") {
      $start = UnixToSqlTime(time()-60*60*24);
      $wheres[] = "$etfield > \"$start\"";
    } else if ($eventtime == "week") {
      $start = UnixToSqlTime(mktime(0, 0, 0, date("n"), date("j")-7));
      $wheres[] = "$etfield > \"$start\"";
    } else if ($eventtime == "month") {
      $start = UnixToSqlTime(mktime(0, 0, 0, date("n")-1));
      $wheres[] = "$etfield > \"$start\"";
    } else if ($eventtime == "year") {
      $start = UnixToSqlTime(mktime(null, null, null, date("n"), date("j"), date("Y")-1));
      $wheres[] = "$etfield > \"$start\"";
    } else if ($eventtime == "none") {
      $wheres[] = DB_Test_Null($etfield);
    } else if ($eventtime == "custom") {
      $eventfrom = ParseJSCalendar($_SESSION["$prefix/EventFrom"], -1);
      $eventto = ParseJSCalendar($_SESSION["$prefix/EventTo"], 1);
      $wheres[] = "$etfield BETWEEN \"$eventfrom\" AND \"$eventto\"";
    } else if ($eventtime == "related") {
      // Special timeframe search for related media
      $rfrom = UnixToSqlTime($_SESSION["$prefix/EventRFrom"]);
      $rto = UnixToSqlTime($_SESSION["$prefix/EventRTo"]);
      $wheres[] = "EventStartTime <= \"$rto\"";
      $wheres[] = "EventEndTime >= \"$rfrom\"";
    }

    $sourcefield = ($type == "LPR") ? "$PlateReads.SourceID" : "UploadSourceID";
    // Source pulldown options
    if ($source == "car") {
      $ids = $_SESSION["$prefix/SourceIDs"];
      $goodids = [];
      foreach ($ids as $id) {
	$id = intval($id);
	if ($id > 0) {$goodids[] = $id;}
      }
      if (count($goodids) == 0) {
	$db_error = "No valid source IDs were selected";
	return false;
      }
      $ids = implode(", ", $goodids);
      $wheres[] = "$sourcefield IN ($ids)";
    }
  }

  // CONSTRUCT SQL QUERY

  // Do we need to fake group_concat or count functions?
  // If so, define them in the rescan array for later
  $rescan = [];
  if (!($db_group_concat_allowed)) {
    $groupby = "";
    $newfields = [];
    foreach ($fields as $field) {
      if (preg_match('/^GROUP_CONCAT\(DISTINCT ([^\s]+\.\w+).*?\) AS (\w+)/', $field, $m)) {
	$newfields[] = "$m[1] as $m[2]";
	$delimiter = ",";
	if (preg_match('/SEPARATOR \'([^\']*)\'/', $field, $d)) {
	  $delimiter = $d[1];
	}
	$rescan[] = ["mode" => "group_concat",
			  "delimiter" => $delimiter,
			  "field" => $m[2]];
      } else if (preg_match('/^COUNT\(([^)]+)\) AS (\w+)/', $field, $m)) {
	$newfields[] = "$m[1] as $m[2]";
	$rescan[] = ["mode" => "count",
			  "field" => $m[2]];
      } else {
	$newfields[] = $field;
      }
    }
    $fields = $newfields;
  }
  if (count($rescan) > 0) {
    $index = "None";
  }

  // Construct SQL
  $fields = implode(", ", $fields);
  $tables = implode(" ", $tables);
  $wheres = implode(" AND ", $wheres);
  if ($wheres != "") {$wheres = "WHERE $wheres";}
  $query = "SELECT $fields FROM $tables $wheres $groupby";
  if ((count($outerwheres) > 0) && ($db_nested_select_allowed)) {
    // Outer WHERE clauses required and supported?  Return nested SELECT.
    $query = "SELECT * FROM ($query) AS FilteredMedia WHERE ".implode(" AND ", $outerwheres);
  }

  // SHOW QUERY FOR DEBUG
  //print $query;

  // Test query result size
  global $max_results;
  global $total_results;
  $total_query = "SELECT COUNT(*) FROM ($query) AS TotalResults";
  $total_results = DB_GetArray($total_query);
  if ($total_results === false) {return false;}
  $total_results = array_shift($total_results);
  $total_results = array_shift($total_results);
  if ($total_results > $max_results) {
    $first = $total_results - $max_results;
    $query .= " LIMIT $first, $max_results";
  }

  // Run query
  $results = DB_GetArray($query, $index);
  if ($results === false) {return false;}

  if (count($rescan) > 0) {
    // Rescan data for manual group concatenation and counting

    $newresults = [];
    foreach ($results as $num => $prop) {
      $id = $prop["ID"];
      if (!(isset($newresults[$id]))) {
	$newresults[$id] = $prop;
	foreach ($rescan as $arg) {
	  $field = $arg["field"];
	  $newresults[$id][$field] = [];
	  $newresults[$id][$field][$prop[$field]] = $prop[$field];
	}
      } else {
	foreach ($rescan as $arg) {
	  $newresults[$id][$field][$prop[$field]] = $prop[$field];
	}
      }
    }
    foreach ($newresults as $id => $prop) {
      foreach ($rescan as $arg) {
	$field = $arg["field"];
	$mode = $arg["mode"];
	if ($mode == "count") {
	  $newresults[$id][$field] = count($newresults[$id][$field]);
	} else if ($mode == "group_concat") {
	  $newresults[$id][$field] = implode($arg["delimiter"], $newresults[$id][$field]);
	}
      }
    }
    $results = $newresults;
  }

  if ((!($db_nested_select_allowed)) && (count($outerwheres) > 0)) {
    // Manually strain the data based on outer where clauses -- numerics only

    foreach ($outerwheres as $clause) {
      $newresults = [];
      if (preg_match('/^(\w+)\s*(=|<|>)\s*(\d+)$/', $clause, $m)) {

	$field = $m[1];
	$operator = $m[2];
	$value = floor($m[3]);

	foreach ($results as $id => $prop) {
	  if ( (($operator == "=") && ($prop[$field] == $value)) ||
	       (($operator == "<") && ($prop[$field] < $value)) || 
	       (($operator == ">") && ($prop[$field] > $value)) ) {
	    $newresults[$id] = $prop;
	  }
	}
      }
      $results = $newresults;
    }
  }

  uasort($results, "SearchResultSort");

  return $results;
}

function SearchResultSort($a, $b) {
  if (isset($a["ParseTime"])) {
    if ($a["ParseTime"] < $b["ParseTime"]) {return 1;}
    if ($a["ParseTime"] > $b["ParseTime"]) {return -1;}
  }
  return 0;
}

function ParseJSCalendar($cal, $bias = 0) {
  $year = date("Y");
  $month = date("n");
  $day = date("j");
  $hour = 12;
  $minute = 0;
  $second = 0;
  if ($bias == -1) {
    $hour = 0;
  } else if ($bias == 1) {
    $hour = 23;
    $minute = 59;
    $second = 59;
  }

  if (preg_match('/(\d+)-(\d+)-(\d+)/', $cal, $m)) {
    $year = $m[1];
    $month = $m[2];
    $day = $m[3];
  }
  if (preg_match('/(\d+):(\d+):(\d+)/', $cal, $m)) {
    $hour = $m[1];
    $minute = $m[2];
    $second = $m[3];
  }

  return UnixToSqlTime(mktime($hour, $minute, $second, $month, $day, $year));
}

function DB_GetKeywordIDs($words) {
  // Scan a string for keywords and return an array of existing IDs from the Keywords DB table
  // Returns false if no keywords can be found

  global $db_error;

  // Change to lower case and split into words
  $words = preg_replace('/[^a-z0-9\-\']+/', ",", strtolower($words));
  $words = preg_replace('/,+/', ",", $words);
  $words = preg_replace('/^,/', "", $words);
  $words = preg_replace('/,$/', "", $words);

  if ($words == "") {
    // No recognizable words offered
    return false;
  }

  $words = explode(",", $words);
  $wordrecs = DB_ExactMatches("Keywords", ["Word" => ["in" => $words]]);
  if ($wordrecs === false) {FatalError("Database error while fetching keyword list: $db_error");}

  if (count($wordrecs) == 0) {
    // No words were registered keywords
    return false;
  }

  return array_keys($wordrecs);
}


function DB_GetUserListForMobile() {
  global $DatabasePrefix;
  global $db_error;
  global $db_group_concat_allowed;
  global $GlobalMVAccess;
  $db_error = "";

  $users = DB_ExactMatches("Users", []);
  if ($users === false) {return false;}
  $memberships = DB_ExactMatches("Membership", []);
  if ($memberships === false) {return false;}
  $groups = DB_ExactMatches("Groups", []);
  if ($groups === false) {return false;}
  $roles = DB_ExactMatches("Roles", []);
  if ($roles === false) {return false;}

  foreach ($users as $uid => $user) {
    $gids = [];
    foreach ($memberships as $mid => $member) {
      if (($member["UserID"] == $uid) && ($roles[$member["RoleID"]]["RolePermissions"] & 4)) {
	$gids[] = $member["GroupID"];
      }
    }
    $users[$uid]["GroupIDs"] = $gids;
    if ((count($gids) == 0) && (!($GlobalMVAccess))) {
      unset($users[$uid]);
    }
  }

  return $users;
}


function DB_GetMediaFiles($mediaid) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  // construct WHERE clause
  $MediaChildFiles = $DatabasePrefix."MediaChildFiles";
  $RepositoryFiles = $DatabasePrefix."RepositoryFiles";
  $Media = $DatabasePrefix."Media";
  $sql = "SELECT $RepositoryFiles.*, EventStartTime, StreamStartOffset, StreamEndOffset FROM ";
  $sql .= "$MediaChildFiles RIGHT JOIN $RepositoryFiles ON RepositoryFileID = $RepositoryFiles.ID ";
  $sql .= "RIGHT JOIN $Media ON MediaID = $Media.ID ";
  $sql .= "WHERE MediaID = $mediaid";

  $results = DB_GetArray($sql);
  LocalizeRepoFiles($results);
  return $results;
}

function DB_CalculateRepositorySpace($JustThisID = false) {
  global $db_error;
  global $DatabasePrefix;
  global $ExistantCodes;

  $Media = $DatabasePrefix."Media";
  $ChildFiles = $DatabasePrefix."MediaChildFiles";
  $RepositoryFiles = $DatabasePrefix."RepositoryFiles";

  // Get repository records
  $repos = DB_ExactMatches("MediaRepositories", []);
  if ($repos === false) {return false;}

  $codes = implode(", ", $ExistantCodes);

  foreach ($repos as $repoid => $repo) {
    if (($JustThisID > 0) && ($repoid != $JustThisID)) {
      continue;
    }

    if (!(is_dir($repo["LocalPath"]))) {
      // this repository is closed and its directory doesn't exist; ignore.
      continue;
    }
  
    // Query for space taken by files and reserved for known future uploads
    $sql  = "SELECT";
    $sql .= "  SUM(BytesReceived) as Received,";
    $sql .= "    SUM(BytesTotal) as Total";
    $sql .= "  FROM $RepositoryFiles";
    $sql .= "  WHERE ErrorCode IN ($codes)";
    $sql .= "    AND RepositoryId = $repoid";

    $space = DB_GetArray($sql);
    if ($space === false) {return false;}
    $space = array_shift($space);
    if ($space["Received"] == "") {$space["Received"] = 0;}
    if ($space["Total"] == "") {$space["Total"] = 0;}

    global $IsVidNode;
    if ($IsVidNode) {
      // Files don't expire on VidNode.
      $deletable = [];
      $deletable["Total"] = 0;
    } else {
      // Query for space available for deletion
      $sql  = "SELECT";
      $sql .= "  SUM(BytesTotal) as Total";
      $sql .= "  FROM $Media";
      $sql .= "    RIGHT JOIN $ChildFiles ON MediaID = $Media.ID";
      $sql .= "    RIGHT JOIN $RepositoryFiles ON $RepositoryFiles.ID = RepositoryFileID";
      $sql .= "  WHERE ErrorCode IN ($codes)";
      $sql .= "    AND DeleteStatus = 1";
      $sql .= "    AND RepositoryId = $repoid";

      $deletable = DB_GetArray($sql);
      if ($deletable === false) {return false;}
      $deletable = array_shift($deletable);  
      if ($deletable["Total"] == "") {$deletable["Total"] = 0;}
    }

    // Calculate sums
    $dat = [];
    $dat["BytesReceived"] = $space["Received"];
    $dat["BytesTotal"] = $space["Total"];
    if (is_dir($repo["LocalPath"])) {
      $dat["BytesFree"] = disk_free_space($repo["LocalPath"]);
    } else {
      $dat["BytesFree"] = 0;
    }
    $dat["BytesDeletable"] = $deletable["Total"];

    if (!(DB_Update("MediaRepositories", $dat, ["ID" => $repoid]))) {
      return false;
    }
  }

  return true;
}

function GetRelatedMedia($media) {
  if (!(is_array($media))) {
    $m = DB_ExactMatches("Media", ["ID" => $media]);
    if ($m === false) {return false;}
    if (count($m) == 0) {
      $db_error = "Media ID not found";
      return false;
    }
    $media = array_shift($m);
  }

  $DateTolerance = 60;
  $GpsTolerance = 0.2 * 360 / 24901; // approx 0.2 miles
  $DateStart = SqlToUnixTime($media["EventStartTime"]) - $DateTolerance;
  $DateEnd = SqlToUnixTime($media["EventEndTime"]) + $DateTolerance;

  $wheres = [];
  $wheres["EventStartTime"] = ["operator" => "<", "value" => UnixToSqlTime($DateEnd)];
  $wheres["EventEndTime"] = ["operator" => ">", "value" => UnixToSqlTime($DateStart)];
  $ors = [];
  if ($media["UploadSourceID"] > 0) {
    $ors["UploadSourceID"] = $media["UploadSourceID"];
  } else {
    $ors["UploadSourceID"] = ["false" => 1];
  }
  if ($media["GpsLatitudeMax"] != "") {
    $ors["GpsLatitudeMin"] = DB_IsNull();
    $ors["GpsTest"] = ["ands" => ["GpsLatitudeMin" => ["operator" => "<", "value" => $media["GpsLatitudeMax"] + $GpsTolerance],
					    "GpsLatitudeMax" => ["operator" => ">", "value" => $media["GpsLatitudeMin"] - $GpsTolerance],
					    "GpsLongitudeMin" => ["operator" => "<", "value" => $media["GpsLongitudeMax"] + $GpsTolerance],
					    "GpsLongitudeMax" => ["operator" => ">", "value" => $media["GpsLongitudeMin"] - $GpsTolerance]]];
  } else {
    $ors["GpsTest"] = ["false" => 1];
  }
  $wheres[] = ["ors" => $ors];
  $wheres["ID"] =  ["isnot" => $media["ID"]];

  // TO DO: Check for access rights
  return DB_ExactMatches("Media", $wheres);
}



// BOOKMARK FIELDS

function DB_GetBookmarkFields() {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";

  $fields = DB_GetLimitedArray("SELECT * FROM {$DatabasePrefix}BookmarkFields ORDER BY ID Desc", 0, 1);
  if ($fields === false) {
    return false;
  }
  if (count($fields) == 0) {
    $fields = ["Field0Label" => "Case #",
		    "Field0Desc" => "ID number of the case.",
		    "Field0Max" => "12",
		    "Field1Label" => "Citation #",
		    "Field1Desc" => "Number of the citation.",
		    "Field1Max" => "12",
		    "Field2Label" => "Veh Plate",
		    "Field2Desc" => "Vehicle license plate",
		    "Field2Max" => "12",
		    "Field3Label" => "Veh Reg",
		    "Field3Desc" => "Vehicle registration number",
		    "Field3Max" => "12",
		    "Field4Label" => "First Name",
		    "Field4Desc" => "Subject's first name.",
		    "Field4Max" => "64",
		    "Field5Label" => "Mid Name",
		    "Field5Desc" => "Subject's middle name.",
		    "Field5Max" => "64",
		    "Field6Label" => "Last Name",
		    "Field6Desc" => "Subject's last name.",
		    "Field6Max" => "64",
		    "Field7Label" => "Drv Lic #",
		    "Field7Desc" => "Subject's drivers license number or state ID",
		    "Field7Max" => "12",
		    "Field8Label" => "DOB",
		    "Field8Desc" => "Subject's date of birth",
		    "Field8Max" => "255"];
  } else {
    $fields = array_shift($fields);
  }

  $f = [];
  for ($n=0; $n<16; $n++) {
    $f[$n] = [];
    $f[$n]["Label"] = (isset($fields["Field".$n."Label"])) ? $fields["Field".$n."Label"] : "";
    $f[$n]["Desc"] = (isset($fields["Field".$n."Desc"])) ? $fields["Field".$n."Desc"] : "";
    $f[$n]["Max"] = (isset($fields["Field".$n."Max"])) ? $fields["Field".$n."Max"] : "255";
  }
  return $f;
}

function DB_SetBookmarkFields($f) {
  global $DatabasePrefix;
  global $db_error;
  global $UserRecord;
  $db_error = "";

  $fields = [];
  $fields["SetBy"] = $UserRecord["ID"];
  $fields["SetTime"] = DB_Now();

  for ($n=0; $n<16; $n++) {
    $fields["Field".$n."Label"] = (isset($f[$n]["Label"])) ? $f[$n]["Label"] : "";
    $fields["Field".$n."Desc"] = (isset($f[$n]["Desc"])) ? $f[$n]["Desc"] : "";
    $fields["Field".$n."Max"] = (isset($f[$n]["Max"])) ? $f[$n]["Max"] : "255";
  }

  return DB_Insert("BookmarkFields", $fields);
}

function GetCount($count) {
  if (!is_array($count)) {return false;}
  $count = array_shift($count);
  if (!is_array($count)) {return false;}
  $count = array_shift($count);
  return $count;
}

