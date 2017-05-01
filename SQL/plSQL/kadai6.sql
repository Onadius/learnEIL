/*6.tmp2のデータで、EMP3にEMPNOが一致する行があった場合は、
EMP3のTELをTMP2のTELに変更し、一致する行が無かった場合は
EMP3にその行を追加しなさい。
*/

DECLARE
  cursor mikumiku is
    select
      tmp2.empno miku,
      tmp2.tel mikutel
    from
      tmp2;
  /*
  カーソル名:mikumiku : tmp2のempno(miku)とtel(mikutel)
  */

  cursor rinrin is
    select
      emp3.empno rin,
      emp3.tel rintel
    from
      emp3;
  /*
  カーソル名:rinrin : emp3のempno(rin)とtel(rintel)
  */

BEGIN
  for rec1 in mikumiku loop --tmp2.empnoに関して、
    for rec2 in rinrin loop --emp3.empnoに関して、
      if rec1.miku = rec2.rin THEN -- tmp2のデータで、EMP3にEMPNOが一致する行があった場合
        dbms_output.put_line(rec2.rin) ;

        UPDATE --EMP3のTELをTMP2のTELに変更
          emp3
        SET
          emp3.tel = rec2.rintel
        WHERE
          emp3.empno = rec2.rin ;
        exit ; --更新作業を一回行ったら、その時点でループ(rec2.rinでの)終了

      ELSE --一致する行が無かった場合, EMP3にその行(tmp2.tel)を追加

        /*
        5289642578のみが追加されるため、
        以下の処理は間違っているのですが、
        原因を特定できないです。
        */
        insert into   --EMP3にその行(tmp2.tel)を追加
          EMP3 (tel)
        values(
          rec2.rintel
        );
        exit ;

      end if ;
    end loop;
  end loop;
END;
/



SQL> select * from emp3 ;

     EMPNO ENAME                       TEL COUNTRY
---------- -------------------- ---------- --------------------
      7369 SMITH                5289642578 Arizona
      7499 ALLEN                5389643271 Washington
      7521 WARD                 5889649814 Arizona
      7566 JONES                5582547185 Arizona
      7654 MARTIN               5182540148 Washington
      7698 BLAKE                5989643287 Florida
      7782 CLARK                5189641708 Florida
      7788 SCOTT                5172541047 Florida
      7839 KING                 5579643187 New York
      7844 TURNER               5690178014 Washington
      7876 ADAMS                4814752574 Washington
      7900 JAMES                4812248170 Washington
      7902 FORD                 4812248171 New York
      7934 MILLER               4812248172 New York
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
                                5289642578
