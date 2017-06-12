/*********************************************************************/
/* nbdtx2tab.c : スギ薬局                                            */
/*                                                                   */
/* Notes-.                                                           */
/*                                                                   */
/* History-.   2005/05/26   :  Created By SE281                      */
/*                                                                   */
/*********************************************************************/
/* All right reserved. Copyright(C) 2000, EMORI Co,Ltd.              */
/*********************************************************************/
#include  "af033k.h"
#include  "nb0jdata.h"

extern SYS   sys;
extern char  gsSltext[];

/*--------------------------------------------------------
Name   = NB0CopyTable()
func   =
io     =
return =
date   = 2005/05/27  Created
--------------------------------------------------------*/
void  NB0CopyTable( TAB_DATA *Data, OFNB0D *dRec, char *Vend, char *custcd )
{
char     Wrk[64];
int      len;

  strcpy(  Data->rcvdst,  "NB0" );
  StsnCpy( Data->custcd,  custcd,     LEN_NB0S_S04 );
  StsnCpy( Data->ojan,    dRec->D05,  LEN_NB0D_D05 );
  Data->cno  = -1;
  Data->pno  = Atoi( dRec->D06, LEN_NB0D_D06 );
  Data->pno9 = -1;
  Data->jpno = -1;
  Data->zpno = -1;
  Data->npno = -1;
}


CHECK_TABLE  NB0Table[] = {
  {INIT_CHAR, "S"},
  {'S', "DE "},
  {'D', "DE "},
  {'E', "SE "},
  {'\0', NULL }
};

/*--------------------------------------------------------
Name   = NB0GetFileRecord()
func   =
io     =
return =
date   = 2005/05/27  Created by SE281
--------------------------------------------------------*/
static int  NB0GetFileRecord( char *FileName, OFNB0D *dRec, char *custcd, int *dFlg )
{
static int   fDes     = -1;
static char  PrevType = INIT_CHAR;
int          rSize;
char         Buf[LEN_NB0FILE_RECORD + 1];

  if ( fDes < 0 ) {
    if ( ( fDes = _c_open( FileName, O_RDONLY ) ) < 0 ) {
      if ( errno == ENOENT ) {
        return( -9 );
      }
      else {
        return( 0 );
      }
    }
  }

  memset(Buf, 0, sizeof(Buf));
  if( ( rSize = ReadConstant( fDes, Buf, LEN_NB0FILE_RECORD ) ) == LEN_NB0FILE_RECORD ){
    sys.CountRec++;
    switch( CheckRecord( NB0Table, PrevType, Buf[0] ) ) {
      case RECID_NB0S :
        memset( custcd, 0, sizeof( custcd ) );
        memcpy( custcd, ( Buf + LEN_NB0S_S01 + LEN_NB0S_S02 + LEN_NB0S_S03 ), LEN_NB0S_S04 );
        PrevType = Buf[0];
        break;
      case RECID_NB0D :
        memset( dRec, 0, sizeof( OFNB0D ) );
        memcpy( dRec, Buf, sizeof( OFNB0D ) );
        PrevType = Buf[0];
        *dFlg = 1;
        sys.Count++;
        break;
      case RECID_NB0E :
        PrevType = Buf[0];
        break;
      case ' ' :
        break;
      default :
        SetLogHead( 0 );
        SetLogBody(1, 0, "Record不正(%d行目)[%c-%c]", sys.CountRec, PrevType, Buf[0]);
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
Name   = NB0TextToTable()
func   =
io     =
return =
date   = 2002/06/19  Created
         2012/08/13  Updated by M.Nariyama (SE-No.325)
--------------------------------------------------------*/
int      NB0TextToTable(char *FileName, TAB_DATA *Prim)
{
OFNB0D       dRec;
TAB_DATA     Data;
int          Ret;
int          dFlg = 0;
char         custcd[LEN_NB0S_S04 + 1];

  /*** ※※※※※　通信制御上、Dftypeが替わってくるのでここで戻す　※※※※※ ***/
  /** Modified by M.Nariyama(SE-No.325)  (2012.08.13)スギ薬局(関東DC)対応 **/
  if ( !memcmp(sys.Dftype, "NB", 2) ) {
    StrnCpy( sys.Dftype, "NB0", 3 );
  }

  sys.Count = 0;
  sys.CountRec = 0;
  memset( custcd, 0, sizeof( custcd ) );
  while( ( Ret = NB0GetFileRecord( FileName, &dRec, custcd, &dFlg ) ) > 0 ) {
    if( ( dFlg == 1 ) && strlen( custcd ) ){
      memset( &Data, 0, sizeof( TAB_DATA ) );
      NB0CopyTable( &Data, &dRec, sys.Vend, custcd );
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
  SetLogBody( 1, 0, "%s様在庫報告TEXT入力(%d)", sys.Cunm, sys.CountRec );

  if( sys.Count == 0 ){
    SetLogHead( 0 );
    SetLogBody( 1, 0, "伝票明細0件" );
    return( 0 );
  }

  return( sys.Count );
}
