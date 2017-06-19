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
#include  "EILjdata.h"

extern SYS   sys;
extern char  gsSltext[];

/*--------------------------------------------------------
Name   = EILCopyTable()
func   =
io     =
return =
date   = 2005/05/27  Created

--------------------------------------------------------*/
void  EILCopyTable( TAB_DATA *Data, OFEILD *sRec, OFEILD *dRec, char *Vend, char *custcd )
{
char     Wrk[64];
int      len;

  strcpy(  Data->rcvdst,  "EIL" );
  StsnCpy( Data->custcd,  custcd,     LEN_EILS_S04 );
  StsnCpy( Data->ojan,    dRec->D05,  LEN_EILD_D05 );

  printf("hello\n") ;

  Data->cno  = -1;
  Data->pno  = Atoi( dRec->D06, LEN_EILD_D06 );
  Data->pno9 = -1;
  Data->jpno = -1;
  Data->zpno = -1;
  Data->npno = -1;
}


CHECK_TABLE  EILTable[] = {
  {INIT_CHAR, "S"},
  {'S', "DE "},
  {'D', "DE "},
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
char         Buf[LEN_EILFILE_RECORD + 1]; /* レコード格納 */


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

  printf("ReadConstant()前のBuf : %s\n", Buf); /* -- 6/19追記 --> Sレコード分のみ確認 -- */

  /* 一行ずつの処理. Bufに1行の文字列すべて格納 */
  if( ( rSize = ReadConstant( fDes, Buf, LEN_EILFILE_RECORD ) ) == LEN_EILFILE_RECORD ){
    sys.CountRec++;

    printf("ReadConstant()後のBuf : %s\n", Buf); /* -- 6/19追記 --> Sレコード分のみ確認 -- */

    /* ファイル読み込み時の頭文字(S, D, E)を選別 */
    switch( CheckRecord( EILTable, PrevType, Buf[0] ) ) {

      case RECID_EILS : /* "S"ヘッダーの場合 */

        memset( sRec, 0, sizeof( OFEILS ) );
        memcpy( sRec, Buf, sizeof( OFEILS ) );

        /* 初期化 */
        memset( custcd, 0, sizeof( custcd ) );
        memset( cencd, 0, sizeof( cencd ) );
        memset( sdate, 0, sizeof( sdate ) );
        memset( stime, 0, sizeof( stime ) );


        /* ヘッダ(S)各値を各引数に代入.第二引数 = 文字列アドレス */
        memcpy( cencd, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 ), LEN_EILS_S03 );
        memcpy( custcd, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 ), LEN_EILS_S04 );
        memcpy( sdate, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 + LEN_EILS_S04 ), LEN_EILS_S05 );
        memcpy( stime, ( Buf + LEN_EILS_S01 + LEN_EILS_S02 + LEN_EILS_S03 + LEN_EILS_S04 + LEN_EILS_S05), LEN_EILS_S06 );


        /* -- sRecの構造体にデータ格納 -- */
        strcpy(sRec->S03, cencd) ;
        strcpy(sRec->S04, custcd) ;
        strcpy(sRec->S05, sdate) ;
        strcpy(sRec->S06, stime) ;


        /* 出力確認 */
        printf("Buf : %s\n", Buf) ;
        printf("cencd : %s\n", sRec->S03);
        printf("custcd : %s\n", sRec->S04);
        printf("sdate : %s\n", sRec->S05);
        printf("stime : %s\n", sRec->S06);

        /* 前行のレコードタイプに現在のもの(S)を代入 */
        PrevType = Buf[0];
        /* *dFlg = 1;  EILCopyTable()の処理条件 --> 関数内見直しの必要あり 6/19 */
        /* sys.Count++; 追記 6/19 --> 伝票処理表示の処理条件 */

        break;

      case RECID_EILD :

        memset( dRec, 0, sizeof( OFEILD ) );
        memcpy( dRec, Buf, sizeof( OFEILD ) );

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

char         cencd[LEN_EILS_S03 + 1]; /* ファイルヘッダ(s):送信元コード */
char         custcd[LEN_EILS_S04 + 1]; /* ファイルヘッダ(S):送信先コード */
char         sdate[LEN_EILS_S05 + 1] ; /* ファイルヘッダ(S):送信データ作成日付 */
char         stime[LEN_EILS_S06 + 1] ; /* ファイルヘッダ(S):送信データ作成日時刻 */


  /*** ※※※※※ 通信制御上、Dftypeが替わってくるのでここで戻す ※※※※※ ***/
  /** Modified by M.Nariyama(SE-No.325)  (2012.08.13)スギ薬局(関東DC)対応 **/

  /*読み込みファイル拡張子の格納*/
  if ( !memcmp(sys.Dftype, "EIL", 3) ) {
    StrnCpy( sys.Dftype, "EIL", 3 );
  }

  /* sys.Count --> 読み込みデータ0件のとき伝票明細0件表示する(下のif文参照) */
  sys.Count = 0;
  sys.CountRec = 0;


  /* 初期化(ファイルヘッダS用) */
  memset( custcd, 0, sizeof( custcd ) );
  memset( cencd, 0, sizeof( cencd ) );
  memset( sdate, 0, sizeof( sdate ) );
  memset( stime, 0, sizeof( stime ) );


  /* -- 以降関数超重要 -- */
  while( ( Ret = EILGetFileRecord( FileName, &sRec, &dRec, custcd, cencd, sdate, stime, &dFlg ) ) > 0 ) {
    /* printf("返り値ret : %d\n", Ret); --> EILGetFileRecord()より返り値 --> 1 */
    if( ( dFlg == 1 ) && strlen( custcd ) ){
      memset( &Data, 0, sizeof( TAB_DATA ) );
      EILCopyTable( &Data, &sRec, &dRec, sys.Vend, custcd );
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
