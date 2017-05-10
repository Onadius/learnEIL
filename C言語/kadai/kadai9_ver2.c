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

  /* -- 自己参照構造体定義 -- */
  struct services dmy ;
  struct services *start = &dmy ; //最初の構造体
  struct services *wkdata ; // 最新データ格納用
  struct services *wp ; // 現作業用


  start->next = NULL;
  wp = start; //初期化している (1)


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


    /* 以下、自己参照構造体への格納処理 */

    wkdata = (struct services *)malloc(sizeof(struct services)); /* 領域確保 */
    if (wkdata == NULL){
      printf("sonnna namae no hito siranai !\n") ; /* 領域確保不可 */
      break ;
    }

    /* wkdata構造体に各値代入 */
    strcpy(wkdata->service_name, (miku + i)->service_name) ;
    strcpy(wkdata->port_number, (miku + i)->port_number) ;
    strcpy(wkdata->protocol, (miku + i)->protocol) ;

    if( wp->next == NULL ) {

      /* wkdata->next をNULLにする。NULLは最後のデータの印 */
      wkdata->next = NULL ;

      /* wpはwkdataよりひとつ前のpersonal構造体変数。
      ひとつ前のnextにwkdataを設定し、チェーンを作る */
      wp->next = wkdata ;

      /* wpを最新のpersonal構造体を指し示すようにする (1) */
      wp = wkdata ;
    }
    i++ ;
  }
  fclose(fp) ;

  /* 出力 */
  for( wp = start->next ; wp != NULL ; wp = wp->next ){
    printf("[serviceName] : %s  [portNumber] : %s  [Protocol] : %s\n",
    wp->service_name, wp->port_number, wp->protocol);
  }

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






/* -- 結果

[serviceName] : echo  [portNumber] : 7  [Protocol] : tcp
[serviceName] : echo  [portNumber] : 7  [Protocol] : udp
[serviceName] : discard  [portNumber] : 9  [Protocol] : tcp
[serviceName] : discard  [portNumber] : 9  [Protocol] : udp
...
[serviceName] : directplaysrvr  [portNumber] : 47624  [Protocol] : tcp
[serviceName] : directplaysrvr  [portNumber] : 47624  [Protocol] : udp

*/
