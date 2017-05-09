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

      if( x > y ) {
        printf("   ");

      }
      else{
        printf("%3d", kuku[x][y]) ;
      }
    }
    printf("\n") ;
  }

  return 0;
}


/*

 |  1  2  3  4  5  6  7  8  9
---+---------------------------
1|  1  2  3  4  5  6  7  8  9
2|     4  6  8 10 12 14 16 18
3|        9 12 15 18 21 24 27
4|          16 20 24 28 32 36
5|             25 30 35 40 45
6|                36 42 48 54
7|                   49 56 63
8|                      64 72
9|                         81

*/
