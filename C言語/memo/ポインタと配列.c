/*
ポインタ = アドレス変数


int a; // int型のオブジェクト宣言
int *pa; // 「intへのポインター」型のオブジェクト宣言
(int* pa ;)
変数aを参照するための値は、アドレス演算子（単項&演算子）&演算子）を
使って&aとすると得られます。
aの型がintであるとすると、&aの型はint *になります。

オブジェクトaを参照するための値（アドレス）がpaに入ります。
int a;
int *pa;
pa = &a; // aを参照するための値がpaに入る

ポインターが参照するオブジェクトの値を取り出すには、
間接演算子（*演算子）*演算子）を使います。

int a = 1;
int *pa = &a;
printf("a = %d\n", *pa); // a = 1


メリット１：相対位置による操作ができる
ポインターによりオブジェクトの位置を渡すと、その位置を基準として離れた位置のデータを
簡単に参照することができます。つまり、基準からどれくらい離れた位置にほしいデータがあるか
さえ知っていれば、すぐにその位置のデータを読み書きできます。

メリット２：大きなオブジェクトを簡単に扱える
ポインターを渡すことでデータのある場所を渡すことができますので、
データそのものをコピーすることなく、複数の場所から同じデータを
参照することができるようになります。

メリット３：操作を指定することができる
ポインターは関数を参照することができます。
ある操作に対して関数をポインターで渡すことにより、
その操作を指定することができます。


配列とポインター
配列では先頭のオブジェクトから各要素が相対的にどの位置にあるか簡単にわかるからです。
配列をポインターで扱うときは、配列の要素をポインターで表して使います。


int ary[] = { 1, 2, 3 };
// 上は次のように書いた場合と同じです。
int ary[3];
ary[0] = 1;
ary[1] = 2;
ary[2] = 3;

配列の先頭要素へのポインターの書き方として、
配列名である ary が式の中に出てきたときには
配列の先頭要素を参照するポインターとして扱われるというルールにより
int *p = ary;

ary は先頭要素へのポインターですから、
先頭要素を参照するには *ary と書くことができます。

次の要素へのポインターは ary + 1、
その参照先の要素は *(ary + 1) と書けます。

つまり、
ary[x] = *(p + x)


・二次元配列とポインタについて
https://goo.gl/luu4bC

二次元配列は、配列の配列。
a[i][j]は、*( a[i] + j )と同じ。

int a[4][5];
では、各要素は
それぞれ要素数５（列の数）の配列 a[0], a[1]. a[2],a[3]となります。

要素a[i][j]は、その行の先頭アドレスa[i]からｊだけ後ろの位置にあります。
そしてア ドレス (a[i] + j)の内容は間接参照演算、*(a[i]+j)で参照できるからです。
さらに配 列a[i]は、*( a + i )と書けるので、
次のような等号（同一性）が成り立ちます。 

a[i][j] == *( a[i] + j ) == *( *(a+i) + j ),
























*/
