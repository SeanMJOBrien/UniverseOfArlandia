////////////////////////////////////////////////////////////////////////////////
// Universe of Arlandia - String Delimiter Constants
// Centralises all delimiter strings used in pwdata record parsing.
// Include this file wherever string field extraction is needed.
// Do NOT change these values — they must match what the game server writes.
////////////////////////////////////////////////////////////////////////////////

// ---------------------------------------------------------------------------
// Numeric field delimiters — &001& format (5 chars)
// Used in: planet, area, creature, ambiance, enigma, mission records
// ---------------------------------------------------------------------------
const string FIELD_1  = "&001&";
const string FIELD_2  = "&002&";
const string FIELD_3  = "&003&";
const string FIELD_4  = "&004&";
const string FIELD_5  = "&005&";
const string FIELD_6  = "&006&";
const string FIELD_7  = "&007&";
const string FIELD_8  = "&008&";
const string FIELD_9  = "&009&";
const string FIELD_10 = "&010&";
const string FIELD_11 = "&011&";
const string FIELD_12 = "&012&";
const string FIELD_13 = "&013&";
const string FIELD_14 = "&014&";
const string FIELD_15 = "&015&";
const string FIELD_16 = "&016&";
const string FIELD_17 = "&017&";
const string FIELD_18 = "&018&";
const string FIELD_19 = "&019&";
const string FIELD_20 = "&020&";
const string FIELD_21 = "&021&";
const string FIELD_22 = "&022&";
const string FIELD_23 = "&023&";
const string FIELD_24 = "&024&";
const string FIELD_25 = "&025&";
const string FIELD_26 = "&026&";
const string FIELD_27 = "&027&";
const string FIELD_28 = "&028&";
const string FIELD_29 = "&029&";
const string FIELD_30 = "&030&";

// ---------------------------------------------------------------------------
// Letter field delimiters — &A& format (3 chars)
// Used in: hench, player, item records
// ---------------------------------------------------------------------------
const string FIELD_A = "&A&";
const string FIELD_B = "&B&";
const string FIELD_C = "&C&";
const string FIELD_D = "&D&";
const string FIELD_E = "&E&";
const string FIELD_F = "&F&";
const string FIELD_G = "&G&";
const string FIELD_H = "&H&";
const string FIELD_I = "&I&";
const string FIELD_J = "&J&";
const string FIELD_K = "&K&";
const string FIELD_L = "&L&";

// ---------------------------------------------------------------------------
// Object serialisation delimiters — _A_ format (3 chars)
// Used in: area_recall, area_save — serialised creature/item records
// Fields: _A_=blueprint _B_=tag _C_=name _D_=type _E_=X _F_=Y _G_=Z
//         _H_=facing _I_=stop _J_=master _K_=HP _L_=stack size
// ---------------------------------------------------------------------------
const string OBJ_A = "_A_";
const string OBJ_B = "_B_";
const string OBJ_C = "_C_";
const string OBJ_D = "_D_";
const string OBJ_E = "_E_";
const string OBJ_F = "_F_";
const string OBJ_G = "_G_";
const string OBJ_H = "_H_";
const string OBJ_I = "_I_";
const string OBJ_J = "_J_";
const string OBJ_K = "_K_";
const string OBJ_L = "_L_";
const string OBJ_M = "_M_";
const string OBJ_N = "_N_";
const string OBJ_O = "_O_";
const string OBJ_P = "_P_";
const string OBJ_Q = "_Q_";
const string OBJ_R = "_R_";
const string OBJ_S = "_S_";
const string OBJ_T = "_T_";
const string OBJ_U = "_U_";
const string OBJ_V = "_V_";
const string OBJ_W = "_W_";
const string OBJ_X = "_X_";
const string OBJ_Y = "_Y_";
const string OBJ_Z = "_Z_";

// ---------------------------------------------------------------------------
// Index delimiters — _01_ format (4 chars)
// Used in: interests, domain records
// ---------------------------------------------------------------------------
const string IDX_01 = "_01_";
const string IDX_02 = "_02_";
const string IDX_03 = "_03_";
const string IDX_04 = "_04_";
const string IDX_05 = "_05_";
const string IDX_06 = "_06_";
const string IDX_07 = "_07_";
const string IDX_08 = "_08_";
const string IDX_09 = "_09_";
const string IDX_10 = "_10_";
const string IDX_11 = "_11_";

// ---------------------------------------------------------------------------
// Special-purpose delimiters
// ---------------------------------------------------------------------------
const string DELIM_ON  = "_ON_";   // boolean on state
const string DELIM_OFF = "_OF_";   // boolean off state
const string DELIM_TO  = "_TO_";   // target reference
const string DELIM_IS  = "_IS_";   // state check
const string DELIM_DM  = "_DM_";   // DM flag
const string DELIM_SEP = "##";     // section separator used in galaxy data
