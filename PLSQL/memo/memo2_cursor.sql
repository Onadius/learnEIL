--3.一番多いJOBの名前をRESULTテーブルのJNRESULTにinsertするPLSQLを書きなさい。
--@C:\Users\Administrator\Desktop\text\SQL\plSQL\kadai.sql

--カーソルについて　https://goo.gl/Cs6NOu
/*
カーソルを使用する場合は、宣言部にてカーソルを宣言します。
実行するSQL文にカーソル名を付けます。
※ カーソル宣言に記述するSELECT文にINTO句は必要ありません。(FETCH命令に記述します)

カーソルを１行読む変数としてカーソル変数があります。
宣言部にてカーソル変数は、<カーソル変数名>　<カーソル名>%ROWTYPE; と記述します。
※ カーソル変数は、カーソル宣言の後に宣言します。

カーソル変数の値を参照する場合は、<カーソル変数名>.<列名> と記述します。

カーソルは、OPEN命令にて実行されます

FETCH命令は、OPEN命令にて実行された実行集合の中から、
カーソルが指す一行をレコード変数に読み込みます。

FETCH命令にて、カーソルは次の行に移ります。


明示カーソルを１行ずつ読み込む処理を簡単に記述する命令がカーソルＦＯＲループです。
OPEN, FETCH, CLOSE, ループの脱出条件などを自動的に行います｡
※ レコード型変数を宣言する必要はありません｡
※ レコード型変数は、カーソルＦＯＲループの中のみにて参照できます｡
※ レコード型変数に代入することはできません｡

*/


SET SERVEROUTPUT ON
DECLARE
  cursor jobnames is
    select
      e.job
    from
      emp e
    group by e.job
    having
      COUNT(e.ename) = (
        select max(count(a.ename))
        from emp a
        group by a.job
    );

  r1 jobnames%rowtype ;

BEGIN
  open jobnames ;
  loop
    dbms_output.put_line(r1.job);
    insert into RESULT (
      JNRESULT
    )
    values (
      r1.job
    ) ;
    FETCH jobnames into r1 ;
    exit when jobnames%notfound ;
  END loop ;
  close jobnames;
END;
/


JNRESULT
------------------------------


CLERK


SALESMAN

-- forループ
DECLARE
  cursor tel1_4 is
    select
      substr(tmp.tel1, 1, 4) miku
    from
      tmp;
  /*
  カーソル名:tel1_4 : tmp.tel1の上4桁(miku)
  */

  cursor tel2_4 is
    select
      substr(emp3.tel, 1, 4) rin
    from
      emp3;
  /*
  カーソル名:tel2_4 : emp3.telの上4桁(rin)
  */

BEGIN
  for rec1 in tel1_4 loop

    dbms_output.put_line('c1  '||rec1.miku);

    for rec2 in tel2_4 loop
      dbms_output.put_line('c2  '||rec2.rin);
    end loop;

  end loop;
END;
/
