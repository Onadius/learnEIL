#include <stdio.h>

/*構造体型枠宣言*/
struct seiseki {
  int no ;
  char name[20] ;
  double average ;
} ;


int main(void) {

  int i ;

  /* 構造体の初期化と宣言 */
  struct seiseki miku = { 5, "MIKU", 39.3 };

  /* 構造体の参照 */
  printf("No : %d\nName : %s\nAve : %.1f", miku.no, miku.name, miku.average) ;
}
