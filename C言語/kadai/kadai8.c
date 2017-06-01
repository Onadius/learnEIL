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
  char service_name[10] ;
  int  port_no ;
  char protocol[10] ;
} ;

/* 関数プロトタイプ宣言 */
/* char strcheck1(char str[N]) ; */

/* main関数 */
int main(void){

  struct services sagiri[276] ;
  struct services *miku ;

  char fname[] = "services.txt" ;
  FILE *fp ;
  char str[N] ;
  int i = 0 ;
  char *s1, *s2, *s3 ;
  char *cpy ;


  /*ポインタmikuに構造体配列の先頭アドレスsagiriを設定*/
  miku = sagiri ;


  /*ファイルオープン*/
  if((fp = fopen(fname, "r")) == NULL){
    printf("can't open file\n") ;
  }

  /*
  ファイル読み込みと格納

  fgets() --> 戻り値はポインタstrか、エラー、ファイル終了時はNULL
  10行目からスタート
  (miku + i)->service_nameには、i行目の1文字目から空白までを抽出
  (miku + i)->port_noには、i行目の数字から/までを抽出
  (miku + i)->protocolには、i行目の/から空白までを抽出

  */
  while( fgets(str, N, fp) != NULL ){

    /* 先頭10行を除く処理 */
    if( strncmp(str, "#", 1) == 0 || strcmp(str, "\n") == 0 ) {
      continue ;
    }

    /* i行目の1文字目から空白までを抽出 */
    //strcheck1(str) ;
    //printf("service_name : %s", (miku + i)->service_name) ;
    cpy = str ;

    /* スペースをNULL(\0)に置換する */
    s1 = strtok(cpy, " /") ;

    /* /をNULLに置換する */
    cpy = strtok(NULL, " /") ;
    s2 = cpy ;

    cpy = strtok(NULL, " /") ;
    s3 = cpy ;


    /* 抽出した行の文字列すべてstrは出力済 */
    //strcpy((miku + i)->protocol, str) ;
    printf("%s %s %s\n", s1, s2, s3);
    //printf("%s\n", (miku + i)->protocol);
    ++i ;
  }

  fclose(fp) ;

  return 0 ;
}



/*
char strcheck1(char str[]){
  int j ;
  char ary[10] ;

  for ( j = 0 ; j < strlen(str) ; j++ ){

    if(strcmp(str, " ") == 0){
      break ;
    }

    ary[j] = str[j] ;
  }
  return ary ;
}
*/
