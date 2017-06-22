/*********************************************************************/
/* nbdtx2tab.c : �X�M���                                            */
/*                                                                   */
/* Notes-.                                                           */
/*                                                                   */
/* History-.   2005/05/26   :  Created By SE281                      */
/*                                                                   */
/*********************************************************************/
/* All right reserved. Copyright(C) 2000, EMORI Co,Ltd.              */
/*********************************************************************/
#include  "af033k.h"
#include  "EILjdata.h"

extern SYS   sys;
extern char  gsSltext[];

char BUFF[LEN_EILFILE_RECORD + 1] ;

/*--------------------------------------------------------
Name   = EILCopyTable()
func   =
io     =
return =
date   = 2005/05/27  Created

--------------------------------------------------------*/
void  EILCopyTable( TAB_DATA *Data, OFEILS *sRec, OFEILD *dRec, char *Vend, char *custcd)
{
char     Wrk[64];
int      len;
char     txt1[LEN_EILD_D05 + 1] ;
char     txt2[LEN_EILD_D06 + 1] ;
char     txt3[LEN_EILD_D07 + 1] ;



    strcpy(  Data->rcvdst,  "EIL" );
    strcpy( Data->cencd, sRec->S03) ;
    StsnCpy( Data->custcd,  custcd,     LEN_EILS_S04 );
    /*
    StsnCpy( Data->ojan,    dRec->D05,  LEN_EILD_D05 - 4 );

    printf("custcd : %s\n", Data->custcd) ;
    printf("ojan : %s\n", Data->ojan) ;

    Data->pno  = Atoi( dRec->D06, LEN_EILD_D06 );
    Data->pno9 = Atoi( dRec->D07, LEN_EILD_D07 );

    printf("pno :  %d\n pno9 : %d\n", Data->pno, Data->pno9) ;

    */

    memset( txt1, 0, sizeof( txt1 ) );
    memset( txt2, 0, sizeof( txt2 ) );
    memset( txt3, 0, sizeof( txt3 ) );

    /* �w�b�_(S)�e�l���e�����ɑ��.������ = ������A�h���X */
    memcpy( txt1, ( BUFF + LEN_EILD_D01 + LEN_EILD_D02 + LEN_EILD_D03 + LEN_EILD_D04), LEN_EILD_D05 );
    memcpy( txt2, ( BUFF + LEN_EILD_D01 + LEN_EILD_D02 + LEN_EILD_D03 + LEN_EILD_D04 + LEN_EILD_D05 ), LEN_EILD_D06 );
    memcpy( txt3, ( BUFF + LEN_EILD_D01 + LEN_EILD_D02 + LEN_EILD_D03 + LEN_EILD_D04 + LEN_EILD_D05 + LEN_EILD_D06), LEN_EILD_D07 );


    /* -- dRec�̍\���̂Ƀf�[�^�i�[ -- */
    strcpy(dRec->D05, txt1) ;
    strcpy(dRec->D06, txt2) ;
    strcpy(dRec->D07, txt3) ;

    /* -- DATA�\���̂ւ̊i�[ -- */
    strcpy(Data->ojan, dRec->D05) ;

    Data->pno  = Atoi( dRec->D06, LEN_EILD_D06 );
    Data->pno9 = Atoi( dRec->D07, LEN_EILD_D07 );

    printf("jan : %s\npno :  %s\npno9 : %s\n", dRec->D05, dRec->D06, dRec->D07) ;
  }



CHECK_TABLE  EILTable[] = {
  {INIT_CHAR, "S"},
  {'S', "DE "},
  {'D', "DES "},
  {'E', "SE "},
  {'\0', NULL }
};


/*--------------------------------------------------------
Name   = EILGetFileRecord()
func   =
io     =
return =
date   = 2005/05/27  Created by SE281
--------------------------------------------------------*/
static int  EILGetFileRecord( char *FileName, OFEILS *sRec, OFEILD *dRec, char *custcd, char *cencd, char *sdate, char *stime, int *dFlg )
{
static int   fDes     = -1;
static char  PrevType = INIT_CHAR;
int          rSize;
char         Buf[LEN_EILFILE_RECORD + 1]; /* ���R�[�h�i�[ */


  if ( fDes < 0 ) {
    /* file open */
    if ( ( fDes = _c_open( FileName, O_RDONLY ) ) < 0 ) {
      if ( errno == ENOENT ) {
        return( -9 );
      }
      else {
        return( 0 );
      }
    }
  }

  memset(Buf, 0, sizeof(Buf)) ;

  printf("ReadConstant()�O��Buf : %s\n", Buf); /* -- 6/19�ǋL --> S���R�[�h���̂݊m�F -- */

  /* ��s���̏���. Buf��1�s�̕����񂷂ׂĊi�[ */
  if( ( rSize = ReadConstant( fDes, Buf, LEN_EILFILE_RECORD ) ) == LEN_EILFILE_RECORD ){
    sys.CountRec++;

    printf("ReadConstant()���Buf : %s\n", Buf); /* -- 6/19�ǋL --> S���R�[�h���̂݊m�F -- */

    /* �t�@�C���ǂݍ��ݎ��̓�����(S, D, E)��I�� */
    switch( CheckRecord( EILTable, PrevType, Buf[0] ) ) {

      case RECID_EILS : /* "S"�w�b�_�[�̏ꍇ */

        memset( sRec, 0, sizeof( OFEILS ) );
        memcpy( sRec, Buf, sizeof( OFEILS ) );

        /* ������ */
        memset( custcd, 0, sizeof( custcd ) );
        memset( cencd, 0, sizeof( cencd ) );
        memset( sdate, 0, sizeof( sdate ) );
        memset( stime, 0, sizeof( stime ) );

        /* �w�b�_(S)�e�l���e�����ɑ��.������ = ������A�h���X */
        memcpy( cencd, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 ), LEN_EILS_S03 );
        memcpy( custcd, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 ), LEN_EILS_S04 );
        memcpy( sdate, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 + LEN_EILS_S04 ), LEN_EILS_S05 );
        memcpy( stime, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 + LEN_EILS_S04 + LEN_EILS_S05), LEN_EILS_S06 );

        /* -- sRec�̍\���̂Ƀf�[�^�i�[ -- */
        strcpy(sRec->S03, cencd) ;
        strcpy(sRec->S04, custcd) ;
        strcpy(sRec->S05, sdate) ;
        strcpy(sRec->S06, stime) ;

        /* �O�s�̃��R�[�h�^�C�v�Ɍ��݂̂���(S)���� */
        PrevType = Buf[0];


        break;

      case RECID_EILD :

        memset( dRec, 0, sizeof( OFEILD ) );
        memcpy( dRec, Buf, sizeof( OFEILD ) );

        strcpy(BUFF, Buf) ;
        printf("DREC : %s\n", Buf);

        PrevType = Buf[0];
        *dFlg = 1;
        sys.Count++;
        break;

      case RECID_EILE :
        PrevType = Buf[0];
        break;


      case ' ' :
        break;
      default :
        SetLogHead( 0 );
        SetLogBody(1, 0, "Record�s��(%d�s��)[%c-%c]", sys.CountRec, PrevType, Buf[0]);
        _c_close( fDes );
        return( -1 );
    }

    return( 1 );
  }
  else{
    if ( _c_close(fDes) < 0 ) {
      return( -2 );
    }
    return( 0 );
  }
}

/*--------------------------------------------------------
Name   = EILTextToTable()
func   =
io     =
return =
date   = 2002/06/19  Created
         2012/08/13  Updated by M.Nariyama (SE-No.325)
--------------------------------------------------------*/
int      EILTextToTable(char *FileName, TAB_DATA *Prim)
{
OFEILD       dRec;
OFEILS       sRec;
TAB_DATA     Data;
int          Ret;
int          dFlg = 0;
int          copyFlag = 0 ;

char         cencd[LEN_EILS_S03 + 1]; /* �t�@�C���w�b�_(s):���M���R�[�h */
char         custcd[LEN_EILS_S04 + 1]; /* �t�@�C���w�b�_(S):���M��R�[�h */
char         sdate[LEN_EILS_S05 + 1] ; /* �t�@�C���w�b�_(S):���M�f�[�^�쐬���t */
char         stime[LEN_EILS_S06 + 1] ; /* �t�@�C���w�b�_(S):���M�f�[�^�쐬������ */


  /*** ���������� �ʐM�����ADftype���ւ���Ă���̂ł����Ŗ߂� ���������� ***/
  /** Modified by M.Nariyama(SE-No.325)  (2012.08.13)�X�M���(�֓�DC)�Ή� **/

  /*�ǂݍ��݃t�@�C���g���q�̊i�[*/
  if ( !memcmp(sys.Dftype, "EIL", 3) ) {
    StrnCpy( sys.Dftype, "EIL", 3 );
  }

  /* sys.Count --> �ǂݍ��݃f�[�^0���̂Ƃ��`�[����0���\������(����if���Q��) */
  sys.Count = 0;
  sys.CountRec = 0;


  /* ������(�t�@�C���w�b�_S�p) */
  memset( custcd, 0, sizeof( custcd ) );
  memset( cencd, 0, sizeof( cencd ) );
  memset( sdate, 0, sizeof( sdate ) );
  memset( stime, 0, sizeof( stime ) );


  /* -- �ȍ~�֐����d�v -- */
  while( ( Ret = EILGetFileRecord( FileName, &sRec, &dRec, custcd, cencd, sdate, stime, &dFlg ) ) > 0 ) {
    /* printf("�Ԃ�lret : %d\n", Ret); --> EILGetFileRecord()���Ԃ�l --> 1 */
    if( ( dFlg == 1 ) && strlen( custcd ) ){
      memset( &Data, 0, sizeof( TAB_DATA ) );
      EILCopyTable( &Data, &sRec, &dRec, sys.Vend, custcd);
      if ( AddDataQue(Prim, &Data) ) {
        return( -1 );
      }
    }
    dFlg = 0;
  }

  if ( Ret < 0 ) {
    return( Ret );
  }

  SetLogHead( 0 );
  SetLogBody( 1, 0, "%s�l�݌ɕ�TEXT����(%d)", sys.Cunm, sys.CountRec );

  if( sys.Count == 0 ){
    SetLogHead( 0 );
    SetLogBody( 1, 0, "�`�[����0��" );
    return( 0 );
  }

  return( sys.Count );
}
