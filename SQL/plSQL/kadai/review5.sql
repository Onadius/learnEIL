/*
5.TMPのTEL1とEMP3のTELの上4桁を比較して、
一致した行はEMP3のTELの上4桁をTMPのTEL2の値に、
一致しなかった行は上4桁を9999に変更しなさい。

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review5.sql

・プロシージャ及びファンクションの使用
・バルク処理
・動的SQL
・バルク動的バインド

一般に、プロシージャはアクションを実行するために使用し、
値を代入するためだったり、条件判定に使用したり、
フィルタに使用したり、いろいろな目的に使える。
fanctionはreturnで必ず値を返す。

EXECUTE IMMEDIATEというキーワードを使えば、文字列のSQL文を実行できる
--> 動的SQL



*/

-- console ログ表示
SET SERVEROUTPUT ON

DECLARE
  tab_name1 VARCHAR2(10) := 'EMP3' ; --table名格納用
  tab_name2 VARCHAR2(10) := 'TMP' ; --table名格納用
  writeSQL1 VARCHAR2(100) ; --SQL問い合わせ文格納用
  writeSQL2 VARCHAR2(100) ; --SQL問い合わせ文格納用

  type emp3_type is table of emp3%rowtype ; -- 表「emp3」のコレクション型「emp3_type」定義
  miku emp3_type ; ---- コレクション型「emp3_type」の配列定義

  type tmp_type is table of tmp%rowtype ;
  rin tmp_type ;


BEGIN

  -- 動的SQL問い合わせ文の格納
  writeSQL1 := 'select * from ' || tab_name1 ;
  writeSQL2 := 'select * from ' || tab_name2 ;

  -- バルク動的SQL処理
  EXECUTE IMMEDIATE writeSQL1 bulk collect into miku ;
  EXECUTE IMMEDIATE writeSQL2 bulk collect into rin ;

  dbms_output.put_line(miku(1).tel) ;
  dbms_output.put_line(rin(1).tel1) ;

  /*
  --文字列格納判別処理
  if miku(1).sal > 1000 then
    uduki := 'Get Smile!!' ;

  else
    uduki := 'Lost Smile...' ;

  END if ;

  -- 判定文字列Insert処理
  INSERT into RESULT
    (CRESULT)
  values
    (uduki) ;
  */


END ;
/
