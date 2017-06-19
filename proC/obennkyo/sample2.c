/*
カーソル変数には
範囲があり、C の有効範囲規則に従っています。
カーソル変数は、他の関数にパラメータと
して渡すことができ、カーソル変数を宣言しているソース・ファイルの外部にある関数にも
渡すことができます。また、カーソル変数を戻す関数のみでなくカーソル変数へのポインタ
を戻す関数も定義できます。
*/

//~~

EXEC SQL BEGIN DECLARE SECTION ;
  sql_cursor emp_cursor ;
  sql_cursor dept_cursor ;
  sql_cursor *ecp ;

//~~
EXEC SQL
  ecp = &emp_cursor ;


/*
Pro*C/C++ プログラム内で無名 PL/SQL ブロックの 1 つを使用してカーソルをオープンす
るには、無名ブロック内にカーソルを定義します。たとえば、次のとおりです。
*/
sql_cursor emp_cursor; //カーソル宣言
int dept_num = 10;
...
EXEC SQL EXECUTE
  BEGIN
    OPEN :emp_cursor
      FOR
        select
          ename
        from
          emp
        where deptno = :dept_num ;

  END ;
END-EXEC ;



/*
構造体がホスト変数として使用されると、構造体の名前のみが SQL 文で 使用されます。し
かし、構造体の各メンバーは Oracle にデータを送信したり、問合せで Oracle からデータを
受信します。次の例では、EMP 表に従業員を 1 人追加する際に使用されるホスト構造体を示
します。

メンバーが構造体の中で宣言される順序は、SQL 文中の対応する列の順序と一致する必要が
あります。また、INSERT 文で列のリストが省略されている場合は、データベース表の列の
順序と一致している必要があります。

*/
typedef struct {
 char emp_name[11]; /* one greater than column length */
 int emp_number;
 int dept_number;
 float salary;
} emp_record ;
...
/* define a new structure of type "emp_record" */
emp_record new_employee ;

strcpy(new_employee.emp_name, "CHEN");
new_employee.emp_number = 9876;
new_employee.dept_number = 20;
new_employee.salary = 4250.00;

EXEC SQL INSERT INTO emp (ename, empno, deptno, sal)
 VALUES (:new_employee);
