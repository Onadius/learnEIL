/*****************************************************************************/
/* af033k.h  :                                                               */
/*                                                                           */
/* History-.              2001/06/14   :   Created by T.Shirasaki(SE-No.229) */
/*****************************************************************************/
#ifndef  __AF033KH__
#define  __AF033KH__

#define  LEN_SCM      26

#include "dolstd.h"
#include "dbcom.h"
#include "setlog.h"

/*****************************************************************/
/* Constant definition.                                          */
/*****************************************************************/
/* retrun value */
#define  NORMAL               0
#define  FATALERROR          -1
#define  DBERROR             -2

#define  TYPE_START          0x01
#define  INIT_CHAR           0x01     /* 互換性  */

/* dftype */
#define  DFTYPE_SNK          "SNK"
#define  DFTYPE_NB0          "NB0"
#define  DFTYPE_JR1          "JR1"     /* Added by M.Nariyama(SE No.325)  (2007.01.04) */
#define  DFTYPE_CO1          "CO1"     /* Added by M.Nariyama(SE No.325)  (2007.12.04) */
#define  DFTYPE_SGM          "SGM"     /* Added by H.Michibayashi(SE-No.388)  (2014.05.12) */
#define  DFTYPE_EIL          "EIL"

/* system mode */
#define  MODE_RDTXT          0x0001
#define  MODE_RDWRK          0x0002
#define  MODE_EMRG           0x0008

/* system status */
#define  STS_ERR             -1
#define  STS_WAIT             0
#define  STS_LOGIN            1
#define  STS_EXCL             2
#define  STS_READ            10
#define  STS_CHECK           20
#define  STS_INSERT          30
#define  STS_DEXCL           98
#define  STS_END             99

/* exit code */
#define  EXT_NORM             0
#define  EXT_FERR             1
#define  EXT_DBERR            2
#define  EXT_NODAT            9
#define  EXT_USAGE           10

/* update/insert flag */
#define  FLG_NON              0
#define  FLG_INS              1
#define  FLG_UPD              2
#define  FLG_DEL              3

#define  LOG_DSP              1
#define  APP_NAME            "AF033K"
#define  APP_JNAME           "在庫報告取込"
#define  DEF_LOG_SIZE        (1024 * 1024 * 1)
#define  LOG_NAME            "/ryutu/spool/af033k.log"

#define  LEN_DATA_ERR         2       /* ｴﾗｰｺｰﾄﾞ         */


#define  LEN_DATA_RCVDST      3       /* CENCD          */
#define  LEN_DATA_CUSTCD     12       /* CUSTCD         */
#define  LEN_DATA_CENCD       6       /* CENCD          */
#define  LEN_S_DATE           8       /* 送信データ作成日付   */
#define  LEN_S_TIME           6       /* 送信データ作成時刻   */
#define  LEN_DATA_OJAN       13       /* OJAN           */
#define  LEN_DATA_VJAN       13       /* VJAN           */
#define  LEN_DATA_CUGDCD     15       /* CUGDCD         */
#define  LEN_DATA_DFTYPE      3       /* 受信識別子      */


/*****************************************************************/
/* Type definition.                                              */
/*****************************************************************/
/* core */
typedef struct _TAB_DATA TAB_DATA;
struct _TAB_DATA{
  char      rcvdst[LEN_DATA_RCVDST + 1];     /* RCVDST          */
  char      custcd[LEN_DATA_CUSTCD + 1];     /* CUSTCD          */
  char      cencd[LEN_DATA_CENCD + 1];       /* CENCD           */
  char      sdate[LEN_S_DATE + 1] ;
  char      stime[LEN_S_TIME + 1] ;
  char      ojan[LEN_DATA_OJAN + 1];         /* OJAN            */
  char      vjan[LEN_DATA_VJAN + 1];         /* VJAN            */
  char      cugdcd[LEN_DATA_CUGDCD + 1];     /* CUGDCD          */
  int       cno;                             /* CNO             */
  int       pno;                             /* PNO             */
  int       pno9;                            /* PNO9            */
  int       jpno;                            /* JPNO            */
  int       zpno;                            /* ZPNO            */
  int       npno;                            /* NPNO            */

  TAB_DATA *Prev;
  TAB_DATA *Next;
};


#define INIT_CHAR    0x01
typedef struct {
  char  PrevType;
  char* AllowTypes;
} CHECK_TABLE;

/* System */
typedef struct {
   char      LockHandle[129];
   char      UserPass[64];
   char      FileName[128];
   int       Mode;
   int       Status;
   int       Login;
   int       Lock;
   int       Interval;
   int       ExitCode;
   int       Count;
   int       Count_C;
   int       CountRec;       /* Added by SE281 2005.05.27 */
   int       CountSum;       /* 集計用                 *//* Added by M.Nariyama(SE No.325)  (2007.12.04) */
   char      Dtcls[2+1];
   char      Dftype[4];      /* ﾃﾞｰﾀﾌｧｲﾙﾌｫｰﾏｯﾄ         */
   char      Cls;
   char      Vend[6];
   char      Cucd[8];
   char      Cunm[21];
   char      Sdday[9];
   double    OBat;
   char      Dats[15];

/* 環状ﾘｽﾄ ﾙｰﾄﾘｽﾄ */
   TAB_DATA  Data;
}SYS;

/*****************************************************************/
/* macro definition.                                             */
/*****************************************************************/
#define   ClearSys()             (memset(&sys, 0, sizeof(SYS)))
#define   GetSysUserPass()       (sys.UserPass)
#define   SetSysUserPass(a)      (strcpy(sys.UserPass, a))
#define   GetSysFileName()       (sys.FileName)
#define   SetSysFileName(a, l)   memcpy(sys.FileName, a, l);sys.FileName[l]='\0'
#define   GetSysStatus()         (sys.Status)
#define   SetSysStatus(a)        (sys.Status = a)
#define   GetSysLogin()          (sys.Login)
#define   SetSysLogin(a)         (sys.Login = a)
#define   GetSysLock()           (sys.Lock)
#define   SetSysLock(a)          (sys.Lock = a)
#define   GetSysInterval()       (sys.Interval)
#define   SetSysInterval(a)      (sys.Interval = a)
#define   GetSysExitCode()       (sys.ExitCode)
#define   SetSysExitCode(a)      (sys.ExitCode = a)

/*****************************************************************/
/* function definition.                                          */
/*****************************************************************/
int      AddDataQue(TAB_DATA*, TAB_DATA*);
int      SetAFS73(char*, char*, char*);

/* chkdata.pc */
int      CountData(TAB_DATA*);
int      CheckData(TAB_DATA*);
int      PutDB(double, TAB_DATA*);

/* readtxt.c */
int      GetDataFromText(char*, TAB_DATA*);


FILE*    InitCsv(char*, char**, int);
int      ReadCsvRecord(FILE*, char*, int);
int      TermCsv(FILE*, char*);
int      Pad0(char*, char*, int);
int      MakeCD(char*, int);

#endif /*__AF033KH__*/
