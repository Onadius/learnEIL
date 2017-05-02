#include <stdio.h>

int calculate(int a, int b){
  int seki ;

  seki = a * b;
  return seki;
}


int main(void){

  int kuku[9][9] = {}; /*[行 y][列 x]*/
  int x, y ;
  int i, j, result ;

  printf("   |");
  for ( j = 1 ; j <= 9 ; j++) {
    printf("%3d", j) ;
  }
  printf("\n");
  printf("---+---------------------------\n") ;

  for ( x = 0; x <= 8; x++) {
    printf("%3d|", x + 1) ;

    for( y = 0; y <= 8; y++ ) {

      if(x < y) break ;

      result = calculate(x + 1, y + 1) ;
      kuku[x][y] = result ;
      printf("%3d", kuku[x][y]);
    }
    printf("\n") ;
  }
  return 0;
}


/*

 |  1  2  3  4  5  6  7  8  9
---+---------------------------
1|  1
2|  2  4
3|  3  6  9
4|  4  8 12 16
5|  5 10 15 20 25
6|  6 12 18 24 30 36
7|  7 14 21 28 35 42 49
8|  8 16 24 32 40 48 56 64
9|  9 18 27 36 45 54 63 72 81

*/
