/*6.
修正済み
tmp2のデータで、EMP3にEMPNOが一致する行があった場合は、
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
        exit ;

      ELSE --一致する行が無かった場合, EMP3にその行(tmp2.tel)を追加
        insert into   --EMP3にその行(tmp2.tel)を追加
          EMP3 (tel)
        values
        (rec1.mikutel) ;
      exit ;

      end if ;
    end loop;
  end loop;
END;
/



SQL> select * from emp3 order by empno;

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
                           5582547185
                           5579643187
                           5690178014
                            124871102
                           3458714157
                           3351448174
                           5114715971
                           1047781492
                           5389643271
                           4812248171






/* 添削 */

問題の意図が汲み取りにくいなぁと…

tmp2をloop処理し、
emp3に同じempnoがあればemp3.tel←tmp2.telを
emp3に同じempnoがなければemp3にinsertをしろという問題です。

データ操作する前、tmp2とemp3は以下のような関係

select a.*,b.* from emp3 b,tmp2 a where a.empno = b.empno(+) order by a.empno;

                                                                  TMP2 ←|→ EMP3
          EMPNO ENAME                            TEL COUNTRY             |           EMPNO ENAME                            TEL COUNTRY
--------------- -------------------- --------------- --------------------| --------------- -------------------- --------------- --------------------
           7499 ALLEN                     5389643271 Washington          |            7499 ALLEN                     5389643271 Washington					★emp3にあるのでupdate
           7500 Williams                  3351448174 Oklahoma            | @               @                    @               @							★emp3にないのでinsert
           7566 JONES                     5582547185 Arizona             |            7566 JONES                     5582547185 Arizona						★emp3にあるのでupdate(以下略
           7567 Johnson                   3458714157 @                   | @               @                    @               @
           7834 Garcia                     124871102 Louisiana           | @               @                    @               @
           7839 KING                      5579643187 New York            |            7839 KING                      5579643187 New York
           7844 TURNER                    5690178014 Washington          |            7844 TURNER                    5690178014 Washington
           7850 Brown                     5114715971 Nevada              | @               @                    @               @
           7854 Miller                    1047781492 Iowa                | @               @                    @               @
           7902 FORD                      4812248171 New York            |            7902 FORD                      4812248171 New York
           7922 Jones                     2471145810 Oregon              | @               @                    @               @

11行が選択されました。




/* 質問 */

5289642578のみが追加されるため、
以下の処理は間違っているのですが、
原因を特定できないです。
　⇒　rec2.rintelをinsertしているためです。
　　　rec1.rintelでは？
