/*
servicesを読み込み、以下の各項目を持つ構造体に
格納、表示せよ
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 256

/* 構造体宣言 */
struct services {
  char service_name[20] ;
  char port_no[10] ;
  char protocol[20] ;

  struct services *next ;
} ;


/* main関数 */
int main(void){

  struct services sagiri[275] ;
  struct services *miku ;

  /* 自己参照構造体
  struct services dmy ; //dmyは初期化用
  struct services *start = &dmy ; //startは最初のpersonal構造体
  struct services *wp ; //wpは作業用
  struct services *wkdata ; //最新のデータ用
  */

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[N] ;
  int  i = 0 ;
  int  j ;
  char *s1, *s2, *s3, *cpy ;

  /*ポインタmikuに構造体配列の先頭アドレスsagiriを設定*/
  miku = sagiri ;

  miku->next = NULL ; //初期化

  /*ファイルオープン*/
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /* ファイル読み込みと格納 */
  while( fgets(str, N, fp) != NULL ){

    /* 先頭10行を除く処理 */
    if( strncmp(str, "#", 1) == 0 || strcmp(str, "\n") == 0 ) {
      continue ;
    }

    /* strok()より、i行目の1文字目から空白までを抽出 */
    cpy = str ;
    s1 = strtok(cpy, " /") ;
    strcpy((miku + i)->service_name, s1) ; //機能してない？

    /* (miku + i)->port_noには、i行目の数字から/までを抽出 */
    cpy = strtok(NULL, " /") ;
    s2 = cpy ;
    strcpy((miku + i)->port_no, s2);

    /* (miku + i)->protocolには、i行目の/から空白までを抽出 */
    cpy = strtok(NULL, " /") ;
    s3 = cpy ;
    strcpy((miku + i)->protocol, s3);

    i++ ;
  }
  fclose(fp) ;

  /*

  /* 出力 */
  for( j = 0 ; j <= 274 ; j++ ) {
    printf("<service name>:%s  <port number>:%s  <protocol>:%s\n",
      (miku + j)->service_name, (miku + j)->port_no, (miku + j)->protocol) ;
  }

  return 0 ;
}


/*
結果

<service name>:echo  <port number>:7  <protocol>:tcp

<service name>:echo  <port number>:7  <protocol>:udp

<service name>:discard  <port number>:9  <protocol>:tcp
<service name>:discard  <port number>:9  <protocol>:udp
<service name>:systat  <port number>:11  <protocol>:tcp
<service name>:systat  <port number>:11  <protocol>:udp
<service name>:daytime  <port number>:13  <protocol>:tcp
・・・
<service name>:directplaysrvr  <port number>:47624  <protocol>:udp

*/
