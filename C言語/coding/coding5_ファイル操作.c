//ファイル入力
/*
#include <stdio.h>

int main(void) {

  FILE *fp ;
  char s[10000] ;
  char c ;

  if((fp = fopen("message.txt", "r")) == NULL) {
    printf("error!\n") ;
    return 1 ;
  }

  // fscanf()で取得
  printf("----------------------------------\n") ;
  while(fscanf(fp, "%s", s) != EOF) {
    printf("%s\n", s) ;
  }

  printf("----------------------------------\n") ;

  fclose(fp) ;

  return 0 ;
}
*/

#include <stdio.h>
int main(void) {
    FILE *fp;  /* ファイルポインタの宣言 */
    char s[256];
    char c;
    if ((fp = fopen("message2.txt", "w")) == NULL) {  /* ファイルのオープン */
        printf("file open error!!\n");
        return 1;
    }

    char sagiri[] = "さぎりちゃん可愛すぎ" ;

    /* fprintf()による出力 */
    fprintf(fp, "%s\n", sagiri);

    fclose(fp);  /* ファイルのクローズ */

    return 0;
}
