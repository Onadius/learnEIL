/*-----
配列
https://goo.gl/DecnxM
-----*/

/*
・配列は以下のように宣言します。
データ型 配列名[要素数];
int data[10];

長い配列の場合
要素数が多い場合には，初期値をソースコードに書くのは大変だから，
普通は for 文などを用いて初期値を設定する
  int a[1000];
  int i;

  for (i = 0; i < 1000; i++ ) {
      a[i] = 0;
  }

・2次元配列とは行(縦)と列(横)の2次元で考える配列です。
データ型 配列名[行の要素数][列の要素数];
data[0][0]	data[0][1]	data[0][2]
data[1][0]	data[1][1]	data[1][2]
data[2][0]	data[2][1]	data[2][2]
data[3][0]	data[3][1]	data[3][2]
data[4][0]	data[4][1]	data[4][2]

*/



/*
fprintfについて
http://hitorilife.com/fprintf.php
streamに標準出力(stdout)を指定すると、
printfと同じ結果を得ることができる。

#include <stdio.h>

main() {
  fprintf( stdout , "hello world\n" );
}
*/
