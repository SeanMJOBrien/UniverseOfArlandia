/*
 * colors_inc.nss
 *
 * Access to the color tokens provided by The Krit.
 ************************************************************
 * Please use these judiciously to enhance the gaming
 * experience. (Overuse of colors detracts from it.)
 ************************************************************
 * Color tokens in a string will change the color from that
 * point on when the string is displayed on the screen.
 * Every color change should be ended by an end token,
 * supplied by ColorTokenEnd().
 *
 * Joined other color include. 09.05.2016, dunahan@schwerterkueste.de
 ************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Includements
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Constants
///////////////////////////////////////////////////////////////////////////////

const string COLORTOKEN = "                  ##################$%&'()*+,-./0123456789:;;==?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[[]^_`abcdefghijklmnopqrstuvwxyz{|}~~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü°°¢£§•¶ß®©™´¨¨ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛˛";
//const string sColors = "                                            !!#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ÄÇÉÑÖÜáàâäãåéëíìîïñóòôöõúûü°¢£§•ß©©™´¨≠ÆØ∞±≤≥¥µ∂∑∏∏∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛˛˛";
const string ColorArray = "     !##$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]]^_`abcdefghijklmnopqrstuvwxyz{|}~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛˛";

const string TEXT_COLOR_RED    =  "˛  ";
const string TEXT_COLOR_ORANGE =  "˛ú ";
const string TEXT_COLOR_YELLOW =  "˛˛ ";
const string TEXT_COLOR_GREEN  =  " ˛ ";
const string TEXT_COLOR_BLUE   =  "  ˛";
const string TEXT_COLOR_CYAN   =  " ˛˛";
const string TEXT_COLOR_PURPLE =  "˛ ˛";
const string TEXT_COLOR_WHITE  =  "˛˛˛";
const string TEXT_COLOR_GREY   =  "~~~";
const string TEXT_COLOR_CRIMSON = "ë  ";
const string TEXT_COLOR_EMERALD = " ~ ";
const string TEXT_COLOR_BROWN   = "«~6";
const string TEXT_COLOR_AZURE   = "~~˛";

///////////////////////////////////////////////////////////////////////////////
// Prototypes
///////////////////////////////////////////////////////////////////////////////


// Supplies a string that changes the text to the given RGB values.
// Valid parameter values are 0-255.
string ColorToken(int nRed, int nGreen, int nBlue);

// Supplies a string that ends an earlier color change.
string ColorTokenEnd();

///////////////////////////////////////////////////////////////////////////////

// Supplies a string that changes the text to black.
string ColorTokenBlack();

// Supplies a string that changes the text to blue.
string ColorTokenBlue();

// Supplies a string that changes the text to gray.
string ColorTokenGray();

// Supplies a string that changes the text to green.
string ColorTokenGreen();

// Supplies a string that changes the text to light purple.
string ColorTokenLightPurple();

// Supplies a string that changes the text to orange.
string ColorTokenOrange();

// Supplies a string that changes the text to pink.
string ColorTokenPink();

// Supplies a string that changes the text to purple.
string ColorTokenPurple();

// Supplies a string that changes the text to red.
string ColorTokenRed();

// Supplies a string that changes the text to white.
string ColorTokenWhite();

// Supplies a string that changes the text to yellow.
string ColorTokenYellow();

///////////////////////////////////////////////////////////////////////////////

// Supplies a string that changes the text to the color of
// combat messages.
string ColorTokenCombat();

// Supplies a string that changes the text to the color of
// dialog.
string ColorTokenDialog();

// Supplies a string that changes the text to the color of
// dialog actions.
string ColorTokenDialogAction();

// Supplies a string that changes the text to the color of
// dialog checks.
string ColorTokenDialogCheck();

// Supplies a string that changes the text to the color of
// dialog highlighting.
string ColorTokenDialogHighlight();

// Supplies a string that changes the text to the color of
// replies in the dialog window.
string ColorTokenDialogReply();

// Supplies a string that changes the text to the color of
// the DM channel.
string ColorTokenDM();

// Supplies a string that changes the text to the color of
// many game engine messages.
string ColorTokenGameEngine();

// Supplies a string that changes the text to the color of
// saving throw messages.
string ColorTokenSavingThrow();

// Supplies a string that changes the text to the color of
// messages sent from scripts.
string ColorTokenScript();

// Supplies a string that changes the text to the color of
// server messages.
string ColorTokenServer();

// Supplies a string that changes the text to the color of
// shouts.
string ColorTokenShout();

// Supplies a string that changes the text to the color of
// skill check messages.
string ColorTokenSkillCheck();

// Supplies a string that changes the text to the color of
// the talk and party talk channels.
string ColorTokenTalk();

// Supplies a string that changes the text to the color of
// tells.
string ColorTokenTell();

// Supplies a string that changes the text to the color of
// whispers.
string ColorTokenWhisper();

///////////////////////////////////////////////////////////////////////////////

// Returns the name of oPC, surrounded by color tokens, so the color of
// the name is the lighter blue often used in NWN game engine messages.
string GetNamePCColor(object oPC);

// Returns the name of oNPC, surrounded by color tokens, so the color of
// the name is the shade of purple often used in NWN game engine messages.
string GetNameNPCColor(object oNPC);


string UndoColoring(string sSaid)
{
  if (FindSubString(sSaid, "<c") == -1)   // not found!
    return sSaid;

  else
    sSaid = GetSubString(sSaid, 6, GetStringLength(sSaid) - 3);

  return sSaid;
}


///////////////////////////////////////////////////////////////////////////////
// Basic Functions
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// ColorToken()
//
// Supplies a string that changes the text to the given RGB values.
// Valid parameter values are 0-255.
//
string ColorToken(int nRed, int nGreen, int nBlue)
{
    return "<c" + GetSubString(ColorArray, nRed, 1) +
            GetSubString(ColorArray, nGreen, 1) +
            GetSubString(ColorArray, nBlue, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenEnd()
//
// Supplies a string that ends an earlier color change.
//
string ColorTokenEnd()
{
 return "</c>";
}



///////////////////////////////////////////////////////////////////////////////
// Functions by Color
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// ColorTokenBlack()
//
// Supplies a string that changes the text to black.
//
string ColorTokenBlack()
{
    return "<c" + GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray, 0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenBlue()
//
// Supplies a string that changes the text to blue.
//
string ColorTokenBlue()
{
    return "<c" + GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray,   0, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenGray()
//
// Supplies a string that changes the text to gray.
//
string ColorTokenGray()
{
    return "<c" + GetSubString(ColorArray, 127, 1) +
            GetSubString(ColorArray, 127, 1) +
            GetSubString(ColorArray, 127, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenGreen()
//
// Supplies a string that changes the text to green.
//
string ColorTokenGreen()
{
    return "<c" + GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray,   0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenLightPurple()
//
// Supplies a string that changes the text to light purple.
//
string ColorTokenLightPurple()
{
    return "<c" + GetSubString(ColorArray, 175, 1) +
            GetSubString(ColorArray,  48, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenOrange()
//
// Supplies a string that changes the text to orange.
//
string ColorTokenOrange()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 127, 1) +
            GetSubString(ColorArray, 0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenPink()
//
// Supplies a string that changes the text to pink.
//
string ColorTokenPink()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray,   0, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenPurple()
//
// Supplies a string that changes the text to purple.
//
string ColorTokenPurple()
{
    return "<c" + GetSubString(ColorArray, 127, 1) +
            GetSubString(ColorArray,   0, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenRed()
//
// Supplies a string that changes the text to red.
//
string ColorTokenRed()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray, 0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenWhite()
//
// Supplies a string that changes the text to white.
//
string ColorTokenWhite()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenYellow()
//
// Supplies a string that changes the text to yellow.
//
string ColorTokenYellow()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray,   0, 1) + ">";
}



///////////////////////////////////////////////////////////////////////////////
// Functions by Purpose
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// ColorTokenCombat()
//
// Supplies a string that changes the text to the color of
// combat messages.
//
string ColorTokenCombat()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 102, 1) +
            GetSubString(ColorArray,   0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDialog()
//
// Supplies a string that changes the text to the color of
// dialog.
//
string ColorTokenDialog()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDialogAction()
//
// Supplies a string that changes the text to the color of
// dialog actions.
//
string ColorTokenDialogAction()
{
    return "<c" + GetSubString(ColorArray, 1, 1) +
            GetSubString(ColorArray, 254, 1) +
            GetSubString(ColorArray,   1, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDialogCheck()
//
// Supplies a string that changes the text to the color of
// dialog checks.
//
string ColorTokenDialogCheck()
{
    return "<c" + GetSubString(ColorArray, 254, 1) +
            GetSubString(ColorArray, 1, 1) +
            GetSubString(ColorArray, 1, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDialogHighlight()
//
// Supplies a string that changes the text to the color of
// dialog highlighting.
//
string ColorTokenDialogHighlight()
{
    return "<c" + GetSubString(ColorArray, 1, 1) +
            GetSubString(ColorArray,   1, 1) +
            GetSubString(ColorArray, 254, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDialogReply()
//
// Supplies a string that changes the text to the color of
// replies in the dialog window.
//
string ColorTokenDialogReply()
{
    return "<c" + GetSubString(ColorArray, 102, 1) +
            GetSubString(ColorArray, 178, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenDM()
//
// Supplies a string that changes the text to the color of
// the DM channel.
//
string ColorTokenDM()
{
    return "<c" + GetSubString(ColorArray, 16, 1) +
            GetSubString(ColorArray, 223, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenGameEngine()
//
// Supplies a string that changes the text to the color of
// many game engine messages.
//
string ColorTokenGameEngine()
{
    return "<c" + GetSubString(ColorArray, 204, 1) +
            GetSubString(ColorArray, 119, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenSavingThrow()
//
// Supplies a string that changes the text to the color of
// saving throw messages.
//
string ColorTokenSavingThrow()
{
    return "<c" + GetSubString(ColorArray, 102, 1) +
            GetSubString(ColorArray, 204, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenScript()
//
// Supplies a string that changes the text to the color of
// messages sent from scripts.
//
string ColorTokenScript()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 0, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenServer()
//
// Supplies a string that changes the text to the color of
// server messages.
//
string ColorTokenServer()
{
    return "<c" + GetSubString(ColorArray, 176, 1) +
            GetSubString(ColorArray, 176, 1) +
            GetSubString(ColorArray, 176, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenShout()
//
// Supplies a string that changes the text to the color of
// shouts.
//
string ColorTokenShout()
{
    return "<c" + GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 239, 1) +
            GetSubString(ColorArray,  80, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenSkillCheck()
//
// Supplies a string that changes the text to the color of
// skill check messages.
//
string ColorTokenSkillCheck()
{
    return "<c" + GetSubString(ColorArray, 0, 1) +
            GetSubString(ColorArray, 102, 1) +
            GetSubString(ColorArray, 255, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenTalk()
//
// Supplies a string that changes the text to the color of
// the talk and party talk channels.
//
string ColorTokenTalk()
{
    return "<c" + GetSubString(ColorArray, 240, 1) +
            GetSubString(ColorArray, 240, 1) +
            GetSubString(ColorArray, 240, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenTell()
//
// Supplies a string that changes the text to the color of
// tells.
//
string ColorTokenTell()
{
    return "<c" + GetSubString(ColorArray,  32, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray,  32, 1) + ">";
}

///////////////////////////////////////////////////////////////////////////////
// ColorTokenWhisper()
//
// Supplies a string that changes the text to the color of
// whispers.
//
string ColorTokenWhisper()
{
    return "<c" + GetSubString(ColorArray, 128, 1) +
            GetSubString(ColorArray, 128, 1) +
            GetSubString(ColorArray, 128, 1) + ">";
}



///////////////////////////////////////////////////////////////////////////////
// Colored Name Functions
///////////////////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////////////////////////
// GetNamePCColor()
//
// Returns the name of oPC, surrounded by color tokens, so the color of
// the name is the lighter blue often used in NWN game engine messages.
//
//
string GetNamePCColor(object oPC)
{
    return "<c" + GetSubString(ColorArray, 153, 1) +
            GetSubString(ColorArray, 255, 1) +
            GetSubString(ColorArray, 255, 1) + ">" +
            GetName(oPC) + "</c>";
}

///////////////////////////////////////////////////////////////////////////////
// GetNameNPCColor()
//
// Returns the name of oNPC, surrounded by color tokens, so the color of
// the name is the shade of purple often used in NWN game engine messages.
//
string GetNameNPCColor(object oNPC)
{
    return "<c" + GetSubString(ColorArray, 204, 1) +
            GetSubString(ColorArray, 153, 1) +
            GetSubString(ColorArray, 204, 1) + ">" +
            GetName(oNPC) + "</c>";
}


////////////////////////////////////////////////////////////////////////////////
// Zeigt einen, nach RGB Code vorgegebenen, farblichen Text an
// Standard ist Weiss (R 255, G 255 und B 255).
//
string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255);
string ColorString(string sText, int nRed=255, int nGreen=255, int nBlue=255)
{
  return "<c" + GetSubString(COLORTOKEN, nRed,   1) +
                GetSubString(COLORTOKEN, nGreen, 1) +
                GetSubString(COLORTOKEN, nBlue,  1) +
         ">"   +
         sText +
         "</c>";
}


// Returns Pseudo-Ascii Character (for color use only, not accurate Ascii)
string ASCII(int iAsciiCode) // 0 - 255
{
  int ASCIIReturn = iAsciiCode;
  if (ASCIIReturn < 0)
    ASCIIReturn = 0;

  else if (ASCIIReturn > 255)
    ASCIIReturn = 255;

  return GetSubString(COLORTOKEN, iAsciiCode + 1, 1);
}

// Returns Pseudo-Ascii Integer Value (for color use only, not accurate Ascii)
int ASCIIToInt(string sLookup)
{
    return FindSubString(COLORTOKEN, sLookup) - 1;
}

// Returns a Color Code Based on Pseudo-Ascii
string RGB(int iR, int iG, int iB) // 0-255
{
    return "<c"+ASCII(iR)+ASCII(iG)+ASCII(iB)+">";
}

// Colors the text
string RGBColorText(string RGBCode, string sText)
{
  return "<c"+ RGBCode +">"+ sText +"</c>";
}

//ColorText Function, uses either a color token or a 3-Digit Color Code
//Codes can be copied and pasted to item and placable names, descriptions, etc :)
string ColorText(string ColorCode, string sText)
{
  ColorCode = GetStringLowerCase(ColorCode);

       if (ColorCode == "purpur")       ColorCode = "<cë  >";
  else if (ColorCode == "rot")          ColorCode = "<c˛  >";
  else if (ColorCode == "pflaume")      ColorCode = "<c˛ww>";
  else if (ColorCode == "mandarine")    ColorCode = "<c«Z >";
  else if (ColorCode == "orange")       ColorCode = "<c˛ú >";
  else if (ColorCode == "pfirsich")     ColorCode = "<c˛« >";
  else if (ColorCode == "bernstein")    ColorCode = "<cúú >";
  else if (ColorCode == "gelb")         ColorCode = "<c˛˛ >";
  else if (ColorCode == "zitrone")      ColorCode = "<c˛˛w>";
  else if (ColorCode == "smaragd")      ColorCode = "<c ~ >";
  else if (ColorCode == "gr¸n")         ColorCode = "<c ˛ >";
  else if (ColorCode == "limette")      ColorCode = "<cw˛w>";
  else if (ColorCode == "mitternacht")  ColorCode = "<c  t>";
  else if (ColorCode == "marine")       ColorCode = "<c  ë>";
  else if (ColorCode == "blau")         ColorCode = "<c  ˛>";
  else if (ColorCode == "azur")         ColorCode = "<c~~˛>";
  else if (ColorCode == "himmelblau")   ColorCode = "<c««˛>";
  else if (ColorCode == "violett")      ColorCode = "<c• •>";
  else if (ColorCode == "lila")         ColorCode = "<c˛ ˛>";
  else if (ColorCode == "lavendel")     ColorCode = "<c˛~˛>";
  else if (ColorCode == "schwarz")      ColorCode = "<c   >";
  else if (ColorCode == "schiefer")     ColorCode = "<c666>";
  else if (ColorCode == "dunkelgrau")   ColorCode = "<cZZZ>";
  else if (ColorCode == "grau")         ColorCode = "<c~~~>";
  else if (ColorCode == "hellgrau")     ColorCode = "<cØØØ>";
  else if (ColorCode == "weiﬂ")         ColorCode = "<c˛˛˛>";
  else if (ColorCode == "t¸rkis")       ColorCode = "<c ••>";
  else if (ColorCode == "jade")         ColorCode = "<c tt>";
  else if (ColorCode == "cyan")         ColorCode = "<c ˛˛>";
  else if (ColorCode == "graublau")     ColorCode = "<cú˛˛>";
  else if (ColorCode == "wasser")       ColorCode = "<cZ«Ø>";
  else if (ColorCode == "silber")       ColorCode = "<cøØ«>";
  else if (ColorCode == "rose")         ColorCode = "<cŒFF>";
  else if (ColorCode == "pink")         ColorCode = "<c˛Vø>";
  else if (ColorCode == "holz")         ColorCode = "<cëZ(>";
  else if (ColorCode == "braun")        ColorCode = "<c«~6>";
  else if (ColorCode == "br‰une")       ColorCode = "<cﬂëF>";
  else if (ColorCode == "fleisch")      ColorCode = "<c˚•Z>";
  else if (ColorCode == "elfenbein")    ColorCode = "<c˛Œ•>";
  else if (ColorCode == "gold")         ColorCode = "<c˛ø6>";
  else if (ColorCode == "zufall")
    {
        switch (d3())
        {
            case 1: ColorCode = RGB(Random(128)+128,Random(192)+64,Random(192)+64); break;
            case 2: ColorCode = RGB(Random(192)+64,Random(128)+128,Random(192)+64); break;
            case 3: ColorCode = RGB(Random(192)+64,Random(192)+64,Random(128)+128); break;
        }
    }

    return ColorCode + sText + "</c>";
}


int LowInteger(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt2:iInt1;}


int HighInteger(int iInt1, int iInt2) {return (iInt1>iInt2)?iInt1:iInt2;}


string JumbleCode(string JColor1, string JColor2)
{
    string sR1=(GetSubString(JColor1,0,1));
    string sG1=(GetSubString(JColor1,1,1));
    string sB1=(GetSubString(JColor1,2,1));

    string sR2=(GetSubString(JColor2,0,1));
    string sG2=(GetSubString(JColor2,1,1));
    string sB2=(GetSubString(JColor2,2,1));

    int RHi=HighInteger(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int RLo=LowInteger(ASCIIToInt(sR1),ASCIIToInt(sR2));
    int GHi=HighInteger(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int GLo=LowInteger(ASCIIToInt(sG1),ASCIIToInt(sG2));
    int BHi=HighInteger(ASCIIToInt(sB1),ASCIIToInt(sB2));
    int BLo=LowInteger(ASCIIToInt(sB1),ASCIIToInt(sB2));

    return ASCII(Random(RHi-RLo)+RLo+1)+ASCII(Random(GHi-GLo)+GLo+1)+ASCII(Random(BHi-BLo)+BLo+1);
}


//Jumble Text randomly selects a color between Color1 and Color2
string JumbledText(string Color1, string Color2, string JumbleString)
{
    int j;
    string ReturnString;
    while (j<(GetStringLength(JumbleString)))
    {
        ReturnString = ReturnString+"<c"+JumbleCode(Color1,Color2)+">"+GetSubString(JumbleString,j,1)+"</c>";
        j++;
    }
    return ReturnString;
}

string ChaoticText(string RandomString)
{
    int i=1;
    string ReturnString;

    while (i<(GetStringLength(RandomString)+1))
    {
        ReturnString = ReturnString + ColorText("random",GetSubString(RandomString,i-1,1));
        i++;
    }
    return ReturnString;
}


