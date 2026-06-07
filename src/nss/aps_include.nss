#include "nwnx_sql"

const int SQL_SUCCESS = 1;
const int SQL_ERROR = 0;


void SQLInit()
{
// nothing
}

int SQLFetch()
{
    if (!NWNX_SQL_ReadyToReadNextRow())
        return SQL_ERROR;

    NWNX_SQL_ReadNextRow();
    return SQL_SUCCESS;
}

void SQLExecDirect(string sSQL)
{
    NWNX_SQL_ExecuteQuery(sSQL);
}

string SQLGetData(int iCol)
{
    if (iCol == 0) return "";
    return NWNX_SQL_ReadDataInActiveRow(iCol - 1);
}

// Return a string value when given a location
string APSLocationToString(location lLocation);

// Return a location value when given the string form of the location
location APSStringToLocation(string sLocation);

// Set oObject's persistent string variable sVarName to sValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration =
                         0, string sTable = "pwdata");

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration =
                      0, string sTable = "pwdata");

// Get oObject's persistent integer variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
int GetPersistentInt(object oObject, string sVarName, string sTable = "pwdata");

// Get oObject's persistent string variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: ""
string GetPersistentString(object oObject, string sVarName, string sTable = "pwdata");

// Delete persistent variable sVarName stored on oObject
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
void DeletePersistentVariable(object oObject, string sVarName, string sTable = "pwdata");


// Set oObject's persistent location variable sVarName to lLocation
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts location to a string for storage in the database.
void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = "pwdata");

// Get oObject's persistent location variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
location GetPersistentLocation(object oObject, string sVarname, string sTable = "pwdata");


// (private function) Replace special character ' with ~
string SQLEncodeSpecialChars(string sString);

// (private function)Replace special character ' with ~
string SQLDecodeSpecialChars(string sString);

void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration =
                      0, string sTable = "pwdata")
{
  SetPersistentString(oObject, sVarName, IntToString(iValue), iExpiration, sTable);
}

void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration =
                         0, string sTable = "pwdata")
{
  string sPlayer;
  string sTag;

  if (GetIsPC(oObject))
    {
      sPlayer = SQLEncodeSpecialChars(GetStringLowerCase(GetPCPlayerName(oObject)));
      sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
  else
    {
      sPlayer = "~";
      sTag = GetTag(oObject);
    }

  sVarName = SQLEncodeSpecialChars(sVarName);
  sValue = SQLEncodeSpecialChars(sValue);

  string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
    "' AND tag='" + sTag + "' AND name='" + sVarName + "'";

  int ret=NWNX_SQL_ExecuteQuery(sSQL);
  if (ret)
    {
      if(NWNX_SQL_ReadyToReadNextRow())
        {

          sSQL = "UPDATE " + sTable + " SET val='" + sValue +
            "',expire=" + IntToString(iExpiration) + ",last=now() WHERE player='" + sPlayer +
            "' AND tag='" + sTag + "' AND name='" + sVarName + "'";

      NWNX_SQL_ExecuteQuery(sSQL);
    }
      else
    {
      // row doesn't exist
          sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire,last) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
            sValue + "'," + IntToString(iExpiration) + ", now())";

      NWNX_SQL_ExecuteQuery(sSQL);
    }
    }
}

int GetPersistentInt(object oObject, string sVarName, string sTable = "pwdata")
{
  string sPlayer;
  string sTag;
  object oModule;

  if(GetLocalInt(GetModule(), "MOD_NO_NWNX")) return 0;

  if (GetIsPC(oObject))
    {
      sPlayer = SQLEncodeSpecialChars(GetStringLowerCase(GetPCPlayerName(oObject)));
      sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
  else
    {
      sPlayer = "~";
      sTag = GetTag(oObject);
    }

  sVarName = SQLEncodeSpecialChars(sVarName);

  string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
    "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
  int ret=NWNX_SQL_ExecuteQuery(sSQL);
  if (ret)
    {
      if(NWNX_SQL_ReadyToReadNextRow())
    {
      NWNX_SQL_ReadNextRow();
      // Note NWNX_SQL_ReadDataInActiveRow is zero based..
      //    0 is the first column, 1 is the second, etc.
      // Also, it returns a string representation by default.  Use StringToInt/Float as necessary.
      return StringToInt(NWNX_SQL_ReadDataInActiveRow(0));
    }
    }
  return 0;
}

string GetPersistentString(object oObject, string sVarName, string sTable = "pwdata")
{
  string sPlayer;
  string sTag;

  if(GetLocalInt(GetModule(), "MOD_NO_NWNX")) return "";

  if (GetIsPC(oObject))
    {
      sPlayer = SQLEncodeSpecialChars(GetStringLowerCase(GetPCPlayerName(oObject)));
      sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
  else
    {
      sPlayer = "~";
      sTag = GetTag(oObject);
    }

  sVarName = SQLEncodeSpecialChars(sVarName);

  string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
    "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
  int ret=NWNX_SQL_ExecuteQuery(sSQL);
  if (ret)
    {
      if(NWNX_SQL_ReadyToReadNextRow())
    {
      NWNX_SQL_ReadNextRow();
      // Note NWNX_SQL_ReadDataInActiveRow is zero based..
      //    0 is the first column, 1 is the second, etc.
      // Also, it returns a string representation by default.  Use StringToInt/Float as necessary.
      return SQLDecodeSpecialChars(NWNX_SQL_ReadDataInActiveRow(0));
    }
    }

  return "";
}

void DeletePersistentVariable(object oObject, string sVarName, string sTable = "pwdata")
{
  string sPlayer;
  string sTag;

  if (GetIsPC(oObject))
    {
      sPlayer = SQLEncodeSpecialChars(GetStringLowerCase(GetPCPlayerName(oObject)));
      sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
  else
    {
      sPlayer = "~";
      sTag = GetTag(oObject);
    }

  sVarName = SQLEncodeSpecialChars(sVarName);
  string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer +
    "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
  NWNX_SQL_ExecuteQuery(sSQL);
}

void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = "pwdata")
{
  SetPersistentString(oObject, sVarName, APSLocationToString(lLocation), iExpiration, sTable);
}

location GetPersistentLocation(object oObject, string sVarName, string sTable = "pwdata")
{
  return APSStringToLocation(GetPersistentString(oObject, sVarName, sTable));
}

// Problems can arise with SQL commands if variables or values have single quotes
// in their names. These functions are a replace these quote with the tilde character

string SQLEncodeSpecialChars(string sString)
{
  if (FindSubString(sString, "'") == -1)      // not found
    return sString;

  int i;
  string sReturn = "";
  string sChar;

  // Loop over every character and replace special characters
  for (i = 0; i < GetStringLength(sString); i++)
    {
      sChar = GetSubString(sString, i, 1);
      if (sChar == "'")
    sReturn += "~";
      else
    sReturn += sChar;
    }
  return sReturn;
}

string SQLDecodeSpecialChars(string sString)
{
  if (FindSubString(sString, "~") == -1)      // not found
    return sString;

  int i;
  string sReturn = "";
  string sChar;

  // Loop over every character and replace special characters
  for (i = 0; i < GetStringLength(sString); i++)
    {
      sChar = GetSubString(sString, i, 1);
      if (sChar == "~")
    sReturn += "'";
      else
    sReturn += sChar;
    }
  return sReturn;
}

string APSLocationToString(location lLocation)
{
  object oArea = GetAreaFromLocation(lLocation);
  vector vPosition = GetPositionFromLocation(lLocation);
  float fOrientation = GetFacingFromLocation(lLocation);
  string sReturnValue;

  if (GetIsObjectValid(oArea))
    sReturnValue =
      "#AREA#" + GetTag(oArea) + "#POSITION_X#" + FloatToString(vPosition.x) +
      "#POSITION_Y#" + FloatToString(vPosition.y) + "#POSITION_Z#" +
      FloatToString(vPosition.z) + "#ORIENTATION#" + FloatToString(fOrientation) + "#END#";

  return sReturnValue;
}

location APSStringToLocation(string sLocation)
{
  location lReturnValue;
  object oArea;
  vector vPosition;
  float fOrientation, fX, fY, fZ;

  int iPos, iCount;
  int iLen = GetStringLength(sLocation);

  if (iLen > 0)
    {
      iPos = FindSubString(sLocation, "#AREA#") + 6;
      iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
      oArea = GetObjectByTag(GetSubString(sLocation, iPos, iCount));

      iPos = FindSubString(sLocation, "#POSITION_X#") + 12;
      iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
      fX = StringToFloat(GetSubString(sLocation, iPos, iCount));

      iPos = FindSubString(sLocation, "#POSITION_Y#") + 12;
      iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
      fY = StringToFloat(GetSubString(sLocation, iPos, iCount));

      iPos = FindSubString(sLocation, "#POSITION_Z#") + 12;
      iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
      fZ = StringToFloat(GetSubString(sLocation, iPos, iCount));

      vPosition = Vector(fX, fY, fZ);

      iPos = FindSubString(sLocation, "#ORIENTATION#") + 13;
      iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
      fOrientation = StringToFloat(GetSubString(sLocation, iPos, iCount));

      lReturnValue = Location(oArea, vPosition, fOrientation);
    }

  return lReturnValue;
}

