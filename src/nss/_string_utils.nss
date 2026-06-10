////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - String Parsing Utilities
//
// Provides Between() and field-extraction helpers to replace the verbose
// nested GetStringLeft/GetStringRight/FindSubString chains used throughout
// the codebase.
//
// Usage:
//   #include "_string_utils"
//
//   string sName  = Between(sRecord, FIELD_A, FIELD_B);
//   string sPlace = EncodedField(sPlanetData, 2);  // value between &001& and &002&
//   string sHench = LetterField(sHenchData, 3);    // value between &B& and &C&
//
// All three functions mirror the PHP helpers in helpers.php on the web side.
////////////////////////////////////////////////////////////////////////////////
#include "_constants"

// ---------------------------------------------------------------------------
// Between(sData, sAfter, sBefore)
//
// Returns the substring of sData that lies after sAfter and before sBefore.
//   sAfter  = ""  ->  start from the beginning of sData
//   sBefore = ""  ->  read to the end of sData
// Returns "" if a non-empty delimiter is not found.
//
// Replaces patterns like:
//   GetStringRight(GetStringLeft(s,FindSubString(s,"&002&")),
//     GetStringLength(GetStringLeft(s,FindSubString(s,"&002&")))
//     -FindSubString(s,"&001&")-5)
// with:
//   Between(s, "&001&", "&002&")
// ---------------------------------------------------------------------------
string Between(string sData, string sAfter, string sBefore)
{
    int iStart;

    if (sBefore != "") {
        int iEnd = FindSubString(sData, sBefore);
        if (iEnd == -1) return "";
        sData = GetStringLeft(sData, iEnd);
    }

    if (sAfter == "") return sData;

    iStart = FindSubString(sData, sAfter);
    if (iStart == -1) return "";
    return GetStringRight(sData, GetStringLength(sData) - iStart - GetStringLength(sAfter));
}

// ---------------------------------------------------------------------------
// PadInt3(n)
// Returns n as a zero-padded 3-digit string: 7 -> "007", 12 -> "012".
// Used internally by EncodedField().
// ---------------------------------------------------------------------------
string PadInt3(int n)
{
    string s = IntToString(n);
    int iLen = GetStringLength(s);
    if (iLen == 1) return "00" + s;
    if (iLen == 2) return "0" + s;
    return s;
}

// ---------------------------------------------------------------------------
// EncodedField(sData, n)
//
// Extracts the nth field from a &001&-delimited string (1-indexed).
// Mirrors the PHP encoded_field() helper in helpers.php.
//
// Example:
//   EncodedField(sPlanet, 1)  ->  value before &001&
//   EncodedField(sPlanet, 2)  ->  value between &001& and &002&
//   EncodedField(sPlanet, 9)  ->  value between &008& and &009&
// ---------------------------------------------------------------------------
string EncodedField(string sData, int n)
{
    string sCurr = "&" + PadInt3(n) + "&";
    string sPrev = (n > 1) ? "&" + PadInt3(n - 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}

// ---------------------------------------------------------------------------
// LetterField(sData, n)
//
// Extracts the nth field from an &A&-delimited string (1-indexed, A=1, B=2…).
//
// Example:
//   LetterField(sHench, 1)  ->  value before &A&
//   LetterField(sHench, 2)  ->  value between &A& and &B&
//   LetterField(sHench, 3)  ->  value between &B& and &C&
// ---------------------------------------------------------------------------
string LetterField(string sData, int n)
{
    string sCurr = "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 1, 1) + "&";
    string sPrev = (n > 1) ? "&" + GetSubString("ABCDEFGHIJKLMNOPQRSTUVWXYZ", n - 2, 1) + "&" : "";
    return Between(sData, sPrev, sCurr);
}
