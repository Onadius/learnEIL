/*
自己参照構造体として定義しなおし、
線形リストにて格納、表示を行え
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOZINUM 256
#define FILEROW 275

/* 構造体宣言 */
struct services {
  char service_name[20] ;
  char port_number[10] ;
  char protocol[20] ;
  struct services *next ;
} ;


/* 関数プロトタイプ宣言 */
void extructStr(char *str, int i, struct services *miku) ;
void setNext(struct services *miku) ;
void outPut(struct services *miku) ;


/* main関数 */
int main(void){

  struct services sagiri[FILEROW] ;
  struct services *miku ; /* 作業用 */

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[MOZINUM] ;
  int  i = 0 ;
  char *cpy ;

  /*ポインタmikuに構造体配列の先頭アドレスsagiriを設定(初期化)*/
  miku = sagiri ;

  /*ファイルオープン*/
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /* ファイル読み込みと格納 */
  while( fgets(str, MOZINUM, fp) != NULL ){

    /* 先頭10行を除く処理 */
    if( strncmp(str, "#", 1) == 0 || strcmp(str, "\n") == 0 ) {
      continue ;
    }

    /* 文字列抽出関数呼び出し */
    cpy = str ;
    extructStr(cpy, i, miku) ;

    i++ ;
  }
  fclose(fp) ;

  /* 自己参照構造体定義関数呼び出し */
  setNext(miku) ;

  /* 出力関数呼び出し */
  outPut(miku) ;

  return 0 ;
}



/* 文字列抽出及び構造体配列への格納関数 */
void extructStr(char *str, int i, struct services *miku) {

  char *s1, *s2, *s3 ;

  s1 = strtok(str, " /") ;
  strcpy((miku + i)->service_name, s1) ;

  /* (miku + i)->port_numberには、i行目の数字から/までを抽出 */
  str = strtok(NULL, " /") ;
  s2 = str ;
  strcpy((miku + i)->port_number, s2);

  /* (miku + i)->protocolには、i行目の/から空白までを抽出 */
  str = strtok(NULL, " /") ;
  s3 = str ;
  strcpy((miku + i)->protocol, s3);
}


/* 自己参照構造体定義関数  */
void setNext(struct services *miku) {

  struct services dmy ;
  struct services *start = &dmy ;
  int i ;

  start->next = miku ; /* 初期化 */
  miku->next = (miku + 1) ; /*初期化*/

  for( i = 1 ; i <= FILEROW ; i ++) {

    if( i == FILEROW ) {
      (miku + i)->next = NULL ;
    }

    (miku + i)->next = (miku + (i + 1)) ;
  }
}


/* 出力関数 */
void outPut(struct services *miku) {
  int j ;
  /* 出力 */
  for( j = 0 ; j < FILEROW ; j++ ) {
    printf("<service name>:%s  <port number>:%s  <protocol>:%s\n",
      (miku + j)->service_name,
      (miku + j)->port_number,
      (miku + j)->protocol) ;
  }
}
