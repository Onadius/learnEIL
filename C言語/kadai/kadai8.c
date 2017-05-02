
/*
servicesを読み込み、以下の各項目を持つ構造体に
格納、表示せよ
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* 構造体宣言 */
struct services {
  char service_name[200] ;
  int port_no ;
  char protocol[10] ;
} ;



/* main関数 */
int main(void){

  struct services sagiri[276] ;
  struct services *miku ;

  char fname[] = "services.txt" ;
  FILE *fp ;
  int i = 0 ;

  /*ポインタmikuに構造体配列の先頭アドレスsagariを設定*/
  miku = sagiri ;


  /*ファイルオープン*/
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /*ファイル読み込みと格納*/
  /**/
  while( fscanf(fp, "%s", (miku + i)->service_name) != EOF){
    printf("%s\n", (miku + i)->service_name);
    i++ ;
  }
  fclose(fp) ;

  return 0 ;
}
