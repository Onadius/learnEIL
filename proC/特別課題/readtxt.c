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

/* TAB_CNVFUNC Funcs[] = �ɂ� */
int      EILTextToTable(char*, TAB_DATA*);

typedef struct {
  char  dftype[4];
  char  cunm[21];
  char  vend[6];
  char  cls;
  char  dtcls[2+1];
  int   (*ConvFunction)();
} TAB_CNVFUNC;

TAB_CNVFUNC   Funcs[] = {
{"EIL", "�C�[�A�C�G��", DEF_OHK_VEND, '0', "75", EILTextToTable}
};

/*--------------------------------------------------------
name    = SetLogBody033FormatError()
func    = ���Ӑ�l�K��÷�Ĵװ�Ή�SetLogBody
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
    "%02d��%02d��:���Ӑ�l�`��(��M�掯��=%5.5s)\n\
�݌ɕ��ް��`�����s���ł��Bں��ޔԍ�=%d(%c->%c)\n\
���ђS���҂ɘA�����ĉ������B",
    Time->tm_hour, Time->tm_min, Dftype, RecCount, *CorrectID, *IncorrectID);
  SetLogBody(1, 0, MessageText);
  ConsoleMessage( MessageText, 4 );
}

/*--------------------------------------------------------
name   = CheckRecord
func   = Online�t�H�[�}�b�g�`�F�b�N�֐�
io     = Table        : i-  ���R�[�hID Table
         PrevType     : i-  �O���R�[�hID
         Rec          : i-  ���񃌃R�[�hID
return = Rec          : OK
         0            : NG(�t�H�[�}�b�g�G���[)
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
func   = fgets��p�֐�[�p�r��online�Ɍ���]
         --- �����񒆂̕s�v�Ȑ��䕶���� space�ɒu��
io     = Buffer      : -o ������i�[��
         Length      : i- ������
         ifd         : i- file�޽�����
return = > 0         : normal(������)
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
name   = GetDataFromText
func   =
io     = FileName     : i- : �Ǎ����ް�̧�ٖ�
         Prim         : i- : �ް�ؽ�
return = 0            : normal
         -1           : error
date   = 2001/06/14   Written by T.Shirasaki(SE-No.229)
--------------------------------------------------------*/
int      GetDataFromText(char* FileName, TAB_DATA* Prim)
{
int      i,ret;


  /* �g���q�̊m�F */
  for ( i = 0; strlen(Funcs[i].dftype) > 0; i++ ) {
    if ( !strcmp(Funcs[i].dftype, sys.Dftype) ) {
      break;
    }
  }
  if ( Funcs[i].ConvFunction == NULL )  {
    return( -2 );
  }

  /**** �Ǎ��ݗp�f�[�^�쐬 ****/
  strcpy(sys.Cunm,  Funcs[i].cunm );
  strcpy(sys.Vend,  Funcs[i].vend );
  sys.Cls = Funcs[i].cls;
  strcpy(sys.Dtcls, Funcs[i].dtcls);



  /**** �Ǎ��� ****/
  if ( (ret = Funcs[i].ConvFunction(sys.FileName, Prim)) < 0 ) {
    SetLogHead(0);
    SetLogBody(1, 0, "�݌ɕ�[%s]", sys.FileName);
  }
  if( ret < 0 ){
    sys.Count = 0;
  }
  else{
    sys.Count = ret;
  }

  return( ret );
}
