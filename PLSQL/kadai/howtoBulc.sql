/*

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\howtoBulc.sql


・バルク処理の使い方
・%rowtype使用方法

*/

-- console ログ表示
SET SERVEROUTPUT ON


DECLARE

  /* 複数レコードをまとめて取得する（バルク処理：SELECT～INTO）*/
  type emp_type is table of emp%rowtype ; -- 表「emp」のコレクション型「emp_type」定義
  emp_rec emp_type ; ---- コレクション型「emp_type」の配列定義

BEGIN

  -- 表「emp」から取得した項目を、配列「emp_rec」に代入する
  select * bulk collect into emp_rec from emp;

  for i in 1..emp_rec.count loop
    dbms_output.put_line(emp_rec(i).ename) ;
  end loop ;

END ;
/
