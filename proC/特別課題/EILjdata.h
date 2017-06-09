/**************************************************************************/
/* EILjdata.h : �X�M����ް�                                              */
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

/* �f�[�^��ʂ͌X�Ń����e�i���X���Ă������� */

#define READ_EILS            0x0001
#define READ_EILD            0x0010
#define READ_EILE            0x0080

/***  �t�@�C���w�b�_  ***/
#define LEN_EILS_S01         1       /* ���R�[�h�敪         */
#define LEN_EILS_S02         2       /* �f�[�^�敪           */
#define LEN_EILS_S03         6       /* ���M���R�[�h         */
#define LEN_EILS_S04         6       /* ���M��R�[�h         */
#define LEN_EILS_S05         8       /* ���M�f�[�^�쐬���t   */
#define LEN_EILS_S06         6       /* ���M�f�[�^�쐬����   */
#define LEN_EILS_S07        35       /* �\��                 */

/***  �݌ɕ񍐖���  ***/
#define LEN_EILD_D01         1       /* ���R�[�h�敪         */
#define LEN_EILD_D02         2       /* �f�[�^�敪           */
#define LEN_EILD_D03         6       /* DC�R�[�h             */
#define LEN_EILD_D04         8       /* �݌Ɋm���           */
#define LEN_EILD_D05        13       /* ���i�R�[�h           */
#define LEN_EILD_D06         7       /* �݌ɐ���             */
#define LEN_EILD_D07        27       /* �\��                 */

/***  �g���[��  ***/
#define LEN_EILE_E01         1       /* ���R�[�h�敪         */
#define LEN_EILE_E02         2       /* �f�[�^�敪           */
#define LEN_EILE_E03         6       /* ���R�[�h����         */
#define LEN_EILE_E04        55       /* �\��                 */


/*****************************************************************/
/* Type definition.                                              */
/*****************************************************************/
typedef struct {
  char Record[LEN_EILFILE_RECORD];
} OFEIL;


/***  �`�[����  ***/
typedef struct {
  char  S01[LEN_EILD_D01];           /* ���R�[�h�敪         */
  char  S02[LEN_EILD_D02];           /* �f�[�^�敪           */
  char  S03[LEN_EILD_D03];           /* ���M���R�[�h         */
  char  S04[LEN_EILD_D04];           /* ���M��R�[�h         */
  char  S05[LEN_EILD_D05];           /* ���M�f�[�^�쐬���t    */
  char  S06[LEN_EILD_D06];           /* ���M�f�[�^�쐬����    */
  char  S07[LEN_EILD_D07];           /* �\��                 */
} OFEILS;

/***  �`�[����  ***/
typedef struct {
  char  D01[LEN_EILD_D01];           /* ���R�[�h�敪         */
  char  D02[LEN_EILD_D02];           /* �f�[�^�敪           */
  char  D03[LEN_EILD_D03];           /* DC�R�[�h             */
  char  D04[LEN_EILD_D04];           /* �݌Ɋm���           */
  char  D05[LEN_EILD_D05];           /* ���i�R�[�h           */
  char  D06[LEN_EILD_D06];           /* �݌ɐ���             */
  char  D07[LEN_EILD_D07];           /* �\��                 */
} OFEILD;



/*****************************************************************/
/* macro definition.                                             */
/*****************************************************************/

/* �}�N���͌X�Ń����e�i���X���Ă������� */

#endif
