/*
7.EMP3を名前順に並べたとき、8番目以降の行の項目COUNTRYを、
TMP2中の同じEMPNOのCOUNTRYに更新しなさい。
*/

DECLARE
  /*emp3を名前順に並べたカーソル*/
  cursor name_c is
    select
      emp3.ename miku,
      emp3.empno mikunumber
    from
      emp3　　

    order by emp3.ename ;

  cnt number := 0 ; --8番目以降をカウントアップするための変数

BEGIN
  for rec1 in name_c loop
    cnt := cnt + 1 ;
    if cnt >= 8 THEN --8番目以降の人に対して
      dbms_output.put_line(rec1.mikunumber) ;

      /*
      項目COUNTRYを、
      TMP2中の同じEMPNOのCOUNTRYに更新
      */
      UPDATE
        EMP3
      SET emp3.country  = (
        SELECT
          tmp2.country
        FROM
          tmp2
        WHERE
          tmp2.empno = rec1.mikunumber
        AND
          emp3.empno = rec1.mikunumber
      )
      where /* 列中、rec1.mikunumberのところ*/
        emp3.empno = rec1.mikunumber ;

    end if ;
  end loop ;
END ;
/

--更新後
EMPNO ENAME                       TEL COUNTRY
---------- -------------------- ---------- --------------------
 7876 ADAMS                4814752574 Washington
 7499 ALLEN                5389643271 Washington
 7698 BLAKE                5989643287 Florida
 7782 CLARK                5189641708 Florida
 7902 FORD                 4812248171 New York
 7900 JAMES                4812248170 Washington
 7566 JONES                5582547185 Arizona
 7839 KING                 5579643187 New York
 7654 MARTIN               5182540148
 7934 MILLER               4812248172
 7788 SCOTT                5172541047
 7369 SMITH                5289642578
 7844 TURNER               5690178014 Washington
 7521 WARD                 5889649814



--元の表
EMPNO ENAME                       TEL COUNTRY
---------- -------------------- ---------- --------------------
 7876 ADAMS                4814752574 Washington
 7499 ALLEN                5389643271 Washington
 7698 BLAKE                5989643287 Florida
 7782 CLARK                5189641708 Florida
 7902 FORD                 4812248171 New York
 7900 JAMES                4812248170 Washington
 7566 JONES                5582547185 Arizona
 7839 KING                 5579643187 New York
 7654 MARTIN               5182540148 Washington
 7934 MILLER               4812248172 New York
 7788 SCOTT                5172541047 Florida
 7369 SMITH                5289642578 Arizona
 7844 TURNER               5690178014 Washington
 7521 WARD                 5889649814 Arizona
