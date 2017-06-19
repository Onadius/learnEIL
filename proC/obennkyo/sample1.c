
/* -- ホスト変数の参照

ホスト変数は、SQL DML 文で使用します。
ホスト変数は SQL 文の中では先頭にコロン（:）
を付ける必要がありますが、
Cの文の中ではコロンを先頭に付けないでください。

ホスト変数名は C 識別子なので、宣言および参照する際は、
大文字 / 小文字の使用を一致させる必要があります。

ホスト変数は、プログラムのアドレスへ設定してください。
このため、関数コールおよび数式をホスト変数に指定することはできません。

-- */

char buf[15] ;
int emp_number ;
float salary ;

gets(buf) ;
emp_number = atoi(buf) ;

EXEC SQL
  select
    sal
  into
    :salary
  from
    emp
  where empno = :emp_number ;



/* --- VARCHAR変数
VARCHAR は、C の拡張型または宣言済の構造体

VARCHAR 変数の利点は、SELECT または FETCH の後に VARCHAR 構造体の長さメン
バーを明示的に参照できること

Oracle は、選択された文字列の長さを長さメンバーに
配置します。それからこのメンバーを、NULL（つまり '\0'）終了記号を加えることなどに
使用できます。

VARCHAR の長さ指定子としては、#define による定義済マクロか、プリコンパイル時に整
数で解決できる任意の複合式を使用できます。



--- */

VARCHAR username[20] ;

//プリコンパイラはこれを配列メンバーおよび長さメンバーを持つ次の構造体に展開する
struct {
  unsigned short len ;
  unsigend char arr[20] ;
} username ;


username.arr[username.len] = '\0'; //終端文字を加える



/*
SQL 文では、次の例が示すように、コロンを接頭辞として付けた構造体名を使用して、
VARCHAR 変数を参照します。


*/

//~~
int part_number ;
VARCHAR part_desc[40] ;
//~~
main () {
  //~~
  EXEC SQL
    select
      part_desc
    into
      :part_desc
    from
      parts
    where pnum = :part_number ;
}


/* VARCHAR 変数を関数に渡す
Pro*C/C++ では参照によって VARCHAR を関数に渡す必要があります。次の例で、
VARCHAR 変数を関数に渡す正しい方法を示します。
*/

VARCHAR emp_name[20] ;
//~~
EXEC SQL
SELECT
  ename
INTO
  :emp_name
FROM
  emp
WHERE empno = 7499 ;
//~~

print_employee_name(&emp_name); /* VARCHAR変数はアドレス渡せ */


print_employee_name(name)
VARCHAR *name;
{
 ...
 printf("name is %.*s\n", name->len, name->arr);
 ...
}
