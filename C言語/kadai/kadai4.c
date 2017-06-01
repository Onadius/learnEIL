#include <stdio.h>

#define NUM 9
#define LOOP 8

/* 九九計算関数 */
int calculate(int a, int b){
  int seki ;

  seki = a * b;
  return seki;
}


int main(void){

  int kuku[NUM][NUM] = {}; /*[行 y][列 x]*/
  int x, y ;
  int j ;

  /* 格納処理 */
  for ( x = 0 ; x <= LOOP ; x++) {

    for( y = 0 ; y <= LOOP ; y++ ) {

      kuku[x][y] = calculate(x + 1, y + 1) ;
    }
  }

  /* 出力処理 */
  printf("   |");
  for ( j = 1 ; j <= NUM ; j++) {
    printf("%3d", j) ;
  }
  printf("\n");
  printf("---+---------------------------\n") ;

  for ( x = 0 ; x <= LOOP ; x++) {
    printf("%3d|", x + 1) ;

    for( y = 0 ; y <= LOOP ; y++ ) {

      if(x < y) break ;

      printf("%3d", kuku[x][y]) ;
    }
    printf("\n") ;
  }

  return 0;
}
