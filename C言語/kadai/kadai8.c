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
  int  port_no ;
  char protocol[10] ;
} ;


/* main関数 */
int main(void){

  struct services sagiri[276] ;
  struct services *miku ;

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[N] ;
  int i = 0 ;

  /*ポインタmikuに構造体配列の先頭アドレスsagariを設定*/
  miku = sagiri ;


  /*ファイルオープン*/
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /*
  ファイル読み込みと格納

  10行目からスタート
  (miku + i)->service_nameには、i行目の1文字目から空白までを抽出
  (miku + i)->port_noには、i行目の数字から/までを抽出
  (miku + i)->protocolには、i行目の/から空白までを抽出

  */
  while(fgets((miku + i)->service_name, N, fp) != EOF){

    printf("%s\n", (miku + i)->service_name);
    ++i ;
  }

  fclose(fp) ;

  return 0 ;
}
