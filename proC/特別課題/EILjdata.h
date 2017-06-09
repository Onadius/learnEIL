/**************************************************************************/
/* EILjdata.h : スギ薬局ﾃﾞｰﾀ                                              */
/*                                                                        */
/**************************************************************************/
/* All rights reserved. Copyright (C) 2000, EMORI Co,Ltd.                 */
/**************************************************************************/

#ifndef  _EILJDATAH_
#define  _EILJDATAH_

/*****************************************************************/
/* Constant definition.                                          */
/*****************************************************************/

#define LEN_EILFILE_RECORD   64

/***  Record ID  ***/
#define RECID_EILS           'S'
#define RECID_EILD           'D'
#define RECID_EILE           'E'

/***  Data Class  ***/

/* データ種別は個々でメンテナンスしてください */

#define READ_EILS            0x0001
#define READ_EILD            0x0010
#define READ_EILE            0x0080

/***  ファイルヘッダ  ***/
#define LEN_EILS_S01         1       /* レコード区分         */
#define LEN_EILS_S02         2       /* データ区分           */
#define LEN_EILS_S03         6       /* 送信元コード         */
#define LEN_EILS_S04         6       /* 送信先コード         */
#define LEN_EILS_S05         8       /* 送信データ作成日付   */
#define LEN_EILS_S06         6       /* 送信データ作成時刻   */
#define LEN_EILS_S07        35       /* 予備                 */

/***  在庫報告明細  ***/
#define LEN_EILD_D01         1       /* レコード区分         */
#define LEN_EILD_D02         2       /* データ区分           */
#define LEN_EILD_D03         6       /* DCコード             */
#define LEN_EILD_D04         8       /* 在庫確定日           */
#define LEN_EILD_D05        13       /* 商品コード           */
#define LEN_EILD_D06         7       /* 在庫数量             */
#define LEN_EILD_D07        27       /* 予備                 */

/***  トレーラ  ***/
#define LEN_EILE_E01         1       /* レコード区分         */
#define LEN_EILE_E02         2       /* データ区分           */
#define LEN_EILE_E03         6       /* レコード件数         */
#define LEN_EILE_E04        55       /* 予備                 */


/*****************************************************************/
/* Type definition.                                              */
/*****************************************************************/
typedef struct {
  char Record[LEN_EILFILE_RECORD];
} OFEIL;


/***  伝票明細  ***/
typedef struct {
  char  S01[LEN_EILD_D01];           /* レコード区分         */
  char  S02[LEN_EILD_D02];           /* データ区分           */
  char  S03[LEN_EILD_D03];           /* 送信元コード         */
  char  S04[LEN_EILD_D04];           /* 送信先コード         */
  char  S05[LEN_EILD_D05];           /* 送信データ作成日付    */
  char  S06[LEN_EILD_D06];           /* 送信データ作成時刻    */
  char  S07[LEN_EILD_D07];           /* 予備                 */
} OFEILS;

/***  伝票明細  ***/
typedef struct {
  char  D01[LEN_EILD_D01];           /* レコード区分         */
  char  D02[LEN_EILD_D02];           /* データ区分           */
  char  D03[LEN_EILD_D03];           /* DCコード             */
  char  D04[LEN_EILD_D04];           /* 在庫確定日           */
  char  D05[LEN_EILD_D05];           /* 商品コード           */
  char  D06[LEN_EILD_D06];           /* 在庫数量             */
  char  D07[LEN_EILD_D07];           /* 予備                 */
} OFEILD;



/*****************************************************************/
/* macro definition.                                             */
/*****************************************************************/

/* マクロは個々でメンテナンスしてください */

#endif
