<?php

// This is the MySQL Database module.
$db_link = new mysqli(); //stores the mysqli object
$db_set_keyword = "SET";
$db_group_concat_allowed = true;
$db_nested_select_allowed = true;
$db_in_transaction = false;

include "includes/sql.php";


// CONNECTION FUNCTIONS

/**
 * FC NOTE: Not sure why this is needed with mysqli
 * For some reasons $db_link resets to null (maybe on redirects)
 * so need to reconnect.
 * @return mysqli
 */
function DB_Link(){
  global $db_link;
  global $DatabaseLocation, $DatabaseUser, $DatabasePassword, $DatabaseName;
  if(!is_object($db_link)){
    DB_Connect($DatabaseLocation, $DatabaseUser, $DatabasePassword);
    DB_Select($DatabaseName);
  }
  return $db_link;
}

function DB_Connect($host, $user, $pass) {
  global $db_link;
  $db_link = mysqli_init();

  if($db_link) {
    return mysqli_real_connect($db_link, $host, $user, $pass);
  }
  return null;
}

function DB_Select($database, $try_create = 0)
{
  //Assumes $db_link is already connected to the database
  global $db_error;
  $db_link = DB_Link();

  if (!mysqli_select_db($db_link, $database)) {
    if ($try_create) {
      $result = mysqli_query($db_link, "CREATE DATABASE IF NOT EXISTS $database");
      if (mysqli_error($db_link)) {
        $db_error = mysqli_error($db_link);
        return false;
      }
      return mysqli_select_db($db_link, $database);
    } else {
      return false;
    }
  }
  return true;
}

// ACCESS FUNCTIONS

function DB_Insert($table, $fields) {
  // Insert a record into a table
  global $DatabasePrefix;
  global $db_error;
  global $db_insertid;
  $db_error = "";

  if (!(is_array($fields))) {
    $db_error = "Not given an array to insert.";
    return false;
  }

  $set = [];
  foreach ($fields as $field=>$value) {
    $set[] = "$field = ".DB_enclose($value);
  }
  $set = implode(", ", $set);
  
  return DB_InsertQuery("INSERT INTO $DatabasePrefix$table SET $set");
}

function DB_Transfer($fromtable, $totable, $fields, $wheres) {
  // Move records from one table to another
  global $DatabasePrefix;
  global $db_error;
  global $db_insertid;
  $db_error = "";

  // construct WHERE clause
  $clause = [];
  foreach ($wheres as $field=>$value) {
    $clause[] = DB_WhereClause($field, $value);
  }
  $clause = implode(" AND ", $clause);
  if ($clause != "") {$clause = "WHERE $clause";}

  $fields = implode(", ", $fields);

  return DB_InsertQuery("INSERT INTO $DatabasePrefix$fromtable SELECT $fields FROM $DatabasePrefix$totable $clause");
}

function DB_GetArray($sql, $identifier = "ID") {
  // For SQL that returns tabular data
  global $db_error;
  $db_link = DB_Link();
  $result = mysqli_query($db_link, $sql);
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link);
    return false;
  }

  // Make array based on results
  $matched = [];
  while ($row = mysqli_fetch_assoc($result)) {
    if (isset($row[$identifier])) {
      $matched[$row[$identifier]] = $row;
    } else {
      $matched[] = $row;
    }
  }
  return $matched;
}

function DB_GetLimitedArray($sql, $firstId, $idCount) {
  // For SQL that returns a portion of tabular data
  $sql .= " LIMIT $firstId, $idCount";
  return DB_GetArray($sql);
}

function DB_InsertQuery($sql) {
  // For SQL that inserts a new row into a table
  global $db_error;
  global $db_insertid;
  $db_link = DB_Link();

  mysqli_query($db_link,$sql);
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link);
    return false;
  }
  $db_insertid = mysqli_insert_id($db_link);
  return true;
}

function DB_PlainQuery($sql) {
  // For SQL with no expected output
  global $db_error;
  global $db_lastquery;
  global $db_rowsaffected;
  $db_link = DB_Link();

  $db_lastquery = $sql;
  mysqli_query($db_link ,$sql);
  $db_rowsaffected = mysqli_affected_rows($db_link);
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link)." ($sql)";
    return false;
  }
  return true;
}

function DB_CountQuery($sql) {
  // For SQL that return a single count value in a single row
  global $db_error;
  $db_link = DB_Link();

  $result = mysqli_query($db_link, $sql);
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link);
    return false;
  }

  return mysqli_result($result, 0, 0);
}

function DB_Test_Null($field) {
  return "ISNULL($field)";
}






// DEFINITION FUNCTIONS

function DB_AddIndex($table, $field) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;
  
  return DB_PlainQuery("ALTER TABLE $tablename ADD INDEX ($field)");
}

function DB_AddTextIndex($table, $field) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  
  $tablename = $DatabasePrefix.$table;
  
  return DB_PlainQuery("ALTER TABLE $tablename ADD FULLTEXT ($field)");
}

function DB_Get_Table_Definition($table) {
  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  $db_link = DB_Link();

  $def = mysqli_query($db_link,"DESCRIBE {$DatabasePrefix}$table");
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link);
    return false;
  }

  $fields = [];

  while ($row = mysqli_fetch_assoc($def)) {
    $fields[$row["Field"]] = "$row[Type]";
    if ($row["Extra"] != "") {
      $fields[$row["Field"]] .= "; $row[Extra]";
    }
    if ($row["Key"] != "") {
      $fields[$row["Field"]] .= "; $row[Key]";
    }
  }
  
  return $fields;
}

function DB_Get_Table_Indexes($table) {
  // Return an array of: key_name => [array of indexed columns]

  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  $db_link = DB_Link();

  $def = mysqli_query($db_link, "SHOW INDEXES IN {$DatabasePrefix}$table");
  if (mysqli_error($db_link)) {
    $db_error = mysqli_error($db_link);
    return false;
  }

  $indexes = [];
  while ($row = mysqli_fetch_assoc($def)) {
    $name = $row["Key_name"];
    $column = $row["Column_name"];
    if (!(isset($indexes[$name]))) {
      $indexes[$name] = [];
    }
    $indexes[$name][] = $column;
  }
  
  return $indexes;
}

function DB_Get_Table_Status($table) {
  // Check table status.  Returns true if OK, false if DB error, status string if table is irregular.

  global $DatabasePrefix;
  global $db_error;
  $db_error = "";
  $db_link = DB_Link();

  $engine = DB_Get_Engine($table);
  if ($engine === false) {return false;}
  if (preg_match('/myisam/i', $engine)) {

    $def = mysqli_query($db_link, "CHECK TABLE {$DatabasePrefix}$table FAST QUICK");
    if (mysqli_error($db_link)) {
      $db_error = mysqli_error($db_link);
      return false;
    }

    while ($row = mysqli_fetch_assoc($def)) {
      $status = $row["Msg_text"];
      if (($status == "OK") || ($status == "Table is already up to date")) {
	// This used to be the OK status!
	return "Outdated database engine: $engine";
      }
      return $status;
    }

    $db_error = "No results from table check.";
    return false;
    
  } else if (!(preg_match('/innodb/i', $engine))) {
    return "Unsupported database engine: $engine";
  }

  return true;
}

function DB_Get_Engine($table) {
  global $db_error;
  global $DatabasePrefix;
  $r = DB_GetArray("SHOW CREATE TABLE {$DatabasePrefix}$table");
  if ($r === false) {return false;}
  if (count($r) == 0) {$db_error = "No results from query"; return false;}
  $r = array_shift($r);
  if (!(isset($r["Create Table"]))) {$db_error = "No data found in query results"; return false;}
  if (!(preg_match('/ENGINE\=(\w+)/', $r["Create Table"], $m))) {$db_error = "No engine found"; return false;}
  return $m[1];
}

function DB_Field_Def_Match($SoftDef, $DBDef) {
  // For DB administration: Does definition in DB reflect software definition?

  global $db_error;
  $db_error = "";

  // Do definitions match?
  $match = 0;
  $ldef = strtolower($SoftDef);
  $sdef = strtolower($DBDef);
  $sdef = preg_replace('/\;.*$/', "", $sdef);
  $sdef = preg_replace('/\b(tinyint|smallint|int|bigint)\(\d+\)/', '$1', $sdef);
  $ldef = preg_replace('/ ?\bprimary key\b/', "", $ldef);
  $ldef = preg_replace('/ ?\bindex\b/', "", $ldef);
  $ldef = preg_replace('/ ?\bfulltext\b/', "", $ldef);
  $ldef = preg_replace('/ ?\bauto_increment\b/', "", $ldef);
  $ldef = preg_replace('/ references \w+\(\w+\)/', "", $ldef);
  $ldef = preg_replace('/ references \w+\.\w+/', "", $ldef);

  // Older versions of MYSQL needed this
  // $ldef = preg_replace('/varchar\(1\)/', "char(1)", $ldef);

  if ($ldef != $sdef) {
    //print "$ldef != $sdef<br>";
    return false;
  }

  if (preg_match('/\bAUTO_INCREMEMNT\b/', $SoftDef))  {
    // Check for auto_increment in extras
    if (!(preg_match('/\bauto_increment\b/', $DBDef))) {
      $db_error = "no autoinc";
      return false;
    }
  }

  if (preg_match('/\bPRIMARY KEY\b/', $SoftDef)) {
    // Check for PRI in key
    if (!(preg_match('/\bPRI\b/', $DBDef))) {
      $db_error = "no prikey";
      return false;
    }

  } else if (preg_match('/\bINDEX\b/', $SoftDef)) {
    // Check for indexed key
    if (!(preg_match('/\bMUL\b/', $DBDef))) {
      $db_error = "no index";
      return false;
    }

  } else if (preg_match('/\bFULLTEXT\b/', $SoftDef)) {
    // Check for fulltext indexedx key
    if (!(preg_match('/\bMUL\b/', $DBDef))) {
      $db_error = "no textindex";
      return false;
    }
  }

  return true;
}

function DB_LocalizeDefinition($definition) {
  $definition = preg_replace('/ INDEX$/', "", $definition);
  $definition = preg_replace('/ FULLTEXT$/', "", $definition);
  return $definition;
}


// TRANSACTION FUNCTIONS

function DBT_Begin() {
  // Begin a transaction; Any further Insert or Update queries will not go into effect until committed.
  global $db_error, $db_in_transaction;

  if ($db_in_transaction) {
    $db_error = "Begin transaction called when already in transaction.";
    return false;
  }

  $pass = DB_PlainQuery("START TRANSACTION;");
  if ($pass) {$db_in_transaction = true;}
  return $pass;
}

function DBT_Commit() {
  // Commit the transaction to the DB
  global $db_error, $db_in_transaction;

  if (!($db_in_transaction)) {
    $db_error = "Commit transaction called when not currently in transaction.";
    return false;
  }
  return DB_PlainQuery("COMMIT;");
}

function DBT_Rollback() {
  // Abort the transaction and any Inserts/Updates performed in it
  global $db_error, $db_in_transaction;

  if (!($db_in_transaction)) {
    $db_error = "Rollback transaction called when not currently in transaction.";
    return false;
  }
  return DB_PlainQuery("ROLLBACK;");
}


/**
 * Duplicate the mysql_result() function using mysqli
 * Adapted from: http://mariolurig.com/coding/mysqli_result-function-to-match-mysql_result/
 * @return bool
 */
function mysqli_result($result,$row=0,$field=0){
  $num_rows = mysqli_num_rows($result);
  if ($num_rows && $row <= ($num_rows-1) && $row >=0){
    mysqli_data_seek($result,$row);
    $result_row = (is_numeric($field)) ? mysqli_fetch_row($result) : mysqli_fetch_assoc($result);
    if (isset($result_row[$field])){
      return $result_row[$field];
    }
  }
  return false;
}

