/*****************************************************************************/
/* readtxt.c :                                                               */
/*                                                                           */
/* Notes-.                                                                   */
/*                                                                           */
/* History-.              2001/06/14   :   created by T.Shirasaki(SE-No.229) */
/*                                                                           */
/*****************************************************************************/
#include "af033k.h"
#include "sltext.h"

extern SYS     sys;
static char    ReadBuffer[513];

#ifdef __UNIVEND__
#define  DEF_OHK_VEND           "90000"
#else
#define  DEF_OHK_VEND           ""
#endif

int      SNKTextToTable(char*, TAB_DATA*);
int      NB0TextToTable(char*, TAB_DATA*);
int      NY0TextToTable(char*, TAB_DATA*);
int      NYCTextToTable(char*, TAB_DATA*);
int      HA1TextToTable(char*, TAB_DATA*);
int      JR1TextToTable(char*, TAB_DATA*);
int      CO1TextToTable(char*, TAB_DATA*);
int      APCTextToTable(char*, TAB_DATA*);
int      WGWTextToTable(char*, TAB_DATA*);
int      KI0TextToTable(char*, TAB_DATA*);
int      KWCTextToTable(char*, TAB_DATA*);
int      TU1TextToTable(char*, TAB_DATA*);
int      BMSTextToTable(char*, TAB_DATA*);
int      KU0TextToTable(char*, TAB_DATA*);
int      UTKTextToTable(char*, TAB_DATA*);

typedef struct {
  char  dftype[4];
  char  cunm[21];
  char  vend[6];
  char  cls;
  char  dtcls[2+1];
  int   (*ConvFunction)();
} TAB_CNVFUNC;

TAB_CNVFUNC   Funcs[] = {
{"SNK", "センコー",            DEF_OHK_VEND, '0', "75", SNKTextToTable},
{"NB0", "スギ薬局(中部DC)",    DEF_OHK_VEND, '0', "75", NB0TextToTable},
{"NBE", "スギ薬局(関東DC)",    DEF_OHK_VEND, '0', "75", NB0TextToTable},
{"NY0", "西松屋(バラ)",        DEF_OHK_VEND, '1', "75", NY0TextToTable},
{"NYC", "西松屋(ケース)",      DEF_OHK_VEND, '0', "75", NYCTextToTable},
{"HA1", "ＣＦＳ",              DEF_OHK_VEND, '2', "75", HA1TextToTable},
{"JR1", "ＪＲ東日本",          DEF_OHK_VEND, '2', "75", JR1TextToTable},
{"CO1", "コスモス薬品(広川)",  DEF_OHK_VEND, '2', "75", CO1TextToTable},
{"APC", "スギ薬局(SLC大阪)",   DEF_OHK_VEND, '0', "75", APCTextToTable},
{"075", "ロジメディカル",      DEF_OHK_VEND, '0', "75", APCTextToTable},
{"WGW", "WMS連携",             DEF_OHK_VEND, '0', "75", WGWTextToTable},
{"KRD", "キリン堂",            DEF_OHK_VEND, '0', "75", KI0TextToTable},
{"KWC", "カワチ薬品",          DEF_OHK_VEND, '0', "75", KWCTextToTable},
{"TU1", "ツルハ北海道",        DEF_OHK_VEND, '0', "75", TU1TextToTable},
{"BMS", "流通BMS標準",         DEF_OHK_VEND, '0', "75", BMSTextToTable},
#ifdef __DEL_DEL_DEL__ /* cls = 3:在庫0作成対応 */
{"KU0", "杏林堂",              DEF_OHK_VEND, '0', "75", KU0TextToTable},
#else  /*__DEL_DEL_DEL__*/
{"KU0", "杏林堂",              DEF_OHK_VEND, '3', "75", KU0TextToTable},
#endif /*__DEL_DEL_DEL__*/
{"UTK", "ユタカファーマシーDC",DEF_OHK_VEND, '0', "75", UTKTextToTable},
{""   , "",                    "",           ' ', "75", NULL          }
};

/*--------------------------------------------------------
name    = SetLogBody033FormatError()
func    = 得意先様規定ﾃｷｽﾄｴﾗｰ対応SetLogBody
io      =
return  =
date    = 2001/05/22  Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
void       SetLogBodyEx033FormatError(char* Dftype,
                                      char* CorrectID,
                                      char* IncorrectID,
                                      int   RecCount)
{
char       MessageText[256];
struct tm* Time;
time_t     Now;

  time( &Now );
  Time = localtime( &Now );
  sprintf(MessageText,
    "%02d時%02d分:得意先様形式(受信先識別=%5.5s)\n\
在庫報告ﾃﾞｰﾀ形式が不正です。ﾚｺｰﾄﾞ番号=%d(%c->%c)\n\
ｼｽﾃﾑ担当者に連絡して下さい。",
    Time->tm_hour, Time->tm_min, Dftype, RecCount, *CorrectID, *IncorrectID);
  SetLogBody(1, 0, MessageText);
  ConsoleMessage( MessageText, 4 );
}

/*--------------------------------------------------------
name   = CheckRecord
func   = Onlineフォーマットチェック関数
io     = Table        : i-  レコードID Table
         PrevType     : i-  前レコードID
         Rec          : i-  今回レコードID
return = Rec          : OK
         0            : NG(フォーマットエラー)
date   = 2003/09/05   Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
char     CheckRecord(CHECK_TABLE Table[], char PrevType, char Rec)
{
int      i;
char    *Type;

  for ( i = 0; (Table[i].PrevType != '\0') &&
               (Table[i].PrevType != PrevType); i++ ) {
    ;
  }
  if ( Table[i].PrevType == '\0' ) {
    return( 0 );
  }

  for ( Type = Table[i].AllowTypes; *Type != '\0'; Type++ ) {
    if ( *Type == Rec ) {
      break;
    }
  }
  if ( *Type == '\0' ) {
    return( 0 );
  }

  return( Rec );
}

/*--------------------------------------------------------
name   = _c_fgets()
func   = fgets代用関数[用途はonlineに限定]
         --- 文字列中の不要な制御文字は spaceに置換
io     = Buffer      : -o 文字列格納先
         Length      : i- 文字列長
         ifd         : i- fileﾃﾞｽｸﾘﾌﾟﾀ
return = > 0         : normal(文字列長)
         -1          : error
date   = 2005/02/18  Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
int      _c_fgets(char* Buffer, int Length, int ifd)
{
int      i, ret, kflg = 0;
char     buf;

  for ( i = 0; (i < (Length - 1)) && ((ret = _c_read(ifd, &buf, 1)) > 0); i++ ) {
    if ( kflg ) {
      kflg = 0;
    }
    else if ( IsKanji(buf) ) {
      kflg = 1;
    }
    else if ( buf == '\r' ) {
      i--;
      continue;
    }
    else if ( buf == '\n' ) {
      if ( i == 0 ) {
        i--;
        continue;
      }
      break;
    }
    Buffer[i] = buf;
  }
  if ( ret < 0 ) {
    return( -1 );
  }
  else if ( (i == 0) && (ret == 0) ) {
    return( 0 );
  }

  Buffer[i] = '\0';

  return( strlen(Buffer) );
}

/*--------------------------------------------------------
name    = ReadConstant()
func    =
io      =
return  =
date    = 11/01/95      Written by K.Sasaki(SE No.151)
--------------------------------------------------------*/
int        ReadConstant(int fDes, char *Buffer, int BufferLength)
{
int        rSize;

  memset(ReadBuffer, 0, sizeof(ReadBuffer));
#ifdef __USE_READ__
  if ( (rSize = _c_read(fDes, ReadBuffer, (BufferLength + 1))) < 0 ) {
#else
  if ( (rSize = _c_fgets(ReadBuffer, (BufferLength + 1), fDes)) < 0 ) {
#endif
    return( -1 );
  }
#ifdef __USE_READ__
  if ( (rSize != (BufferLength + 1)) && (rSize) ) {
    return( -1 );
#else
  if ( (rSize != BufferLength) && (rSize) ) {
#endif
#ifdef __PADDING_SPACE__
    memset(ReadBuffer + rSize, ' ', BufferLength - rSize);
    ReadBuffer[BufferLength] = '\0';
    rSize = BufferLength;
#endif
  }
  if ( rSize == (BufferLength + 1) ) {
    rSize = BufferLength;
  }

  memcpy(Buffer, ReadBuffer, BufferLength);
  return( rSize );
}


/*--------------------------------------------------------
name   = InitCSV()
func   = CSV形式の文字列を tokenに区切り
         ""で囲まれている場合は ""を除く
         解析後文字列は '\0'区切りとなる
io     = s           : io 解析文字列
         len         : i- 文字列長
return = 解析後全文字列長
date   = 2003/01/29  Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
int      InitCSV(char *s, int len)
{
int      i;
char    *p;
char    *SaveArea;
int      NewLength, State;

  if ( (SaveArea = (char *)malloc(len)) == NULL ) {
    return( -1 );
  }
  memcpy(SaveArea, s, len);

  NewLength = 0;
  for ( i = 0, State = -1; i < len; i++ ) {
    p = (SaveArea + i);
    /** tokenの最初 **/
    if ( State == -1 ) {
      /** '"'なら囲まれてるはず **/
      if ( *p == '"' ) {
        State = 1;
        continue;
      }
      /** 以外は区切り文字までそのままコピー **/
      State = 2;
    }

    /** ""の間以外で 区切り文字 (,/タブ/改行)ならtokenの終わり **/
    if ( (State != 1) &&
         ((*p == ',') || (*p == '\t') || (*p == '\r') || (*p == '\n')) ) {
      *(s + NewLength) = '\0';
      NewLength++;
      State = -1;
      continue;
    }

    /** ""の間 終わりの"判断 **/
    if ( (State == 1) && (*p == '"') ) {
      /* """ */
      if ( (i < (len - 2)) && (*(p + 1) == '"') && (*(p + 2) == '"') ) {
        *(s + NewLength) = '"';
        NewLength++;
        i += 2;
      }
      else {
        State = 0;
      }
      continue;
    }

    /** ""の間 もしくは まんまの場合 コピー **/
    if ( (State == 1) || (State == 2) ) {
      if ( IsKanji(*p) ) {
        *(s + NewLength)     = *p;
        *(s + NewLength + 1) = *(p + 1);
        NewLength += 2;
        i++;
      }
      else {
        *(s + NewLength)     = *p;
        NewLength++;
      }
    }
  }

  *(s + NewLength) = '\0';
  NewLength++;

  free(SaveArea);

  return( NewLength );
}

/*--------------------------------------------------------
name   = GetDataFromText
func   =
io     = FileName     : i- : 読込みﾃﾞｰﾀﾌｧｲﾙ名
         Prim         : i- : ﾃﾞｰﾀﾘｽﾄ
return = 0            : normal
         -1           : error
date   = 2001/06/14   Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
int      GetDataFromText(char* FileName, TAB_DATA* Prim)
{
int      i,ret;

  for ( i = 0; strlen(Funcs[i].dftype) > 0; i++ ) {
    if ( !strcmp(Funcs[i].dftype, sys.Dftype) ) {
      break;
    }
  }
  if ( Funcs[i].ConvFunction == NULL )  {
    return( -2 );
  }

  /**** 読込み用データ作成 ****/
  strcpy(sys.Cunm,  Funcs[i].cunm );
  strcpy(sys.Vend,  Funcs[i].vend );
  sys.Cls = Funcs[i].cls;
  strcpy(sys.Dtcls, Funcs[i].dtcls);

  /**** 読込み ****/
  if ( (ret = Funcs[i].ConvFunction(sys.FileName, Prim)) < 0 ) {
    SetLogHead(0);
    SetLogBody(1, 0, "在庫報告????[%s]", sys.FileName);
  }
  if( ret < 0 ){
    sys.Count = 0;
  }
  else{
    sys.Count = ret;
  }

  return( ret );
}
