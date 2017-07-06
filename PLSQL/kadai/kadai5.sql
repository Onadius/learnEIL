/*
5.TMPのTEL1とEMP3のTELの上4桁を比較して、
一致した行はEMP3のTELの上4桁をTMPのTEL2の値に、
一致しなかった行は上4桁を9999に変更しなさい。
*/
DECLARE
  cursor mikumiku is
    select
      substr(tmp.tel1, 2, 4) miku
    from
      tmp;
  /*
  カーソル名:mikumiku : tmp.tel1の上4桁(miku)
  */

  cursor rinrin is
    select
      substr(emp3.tel, 1, 4) rin
    from
      emp3;
  /*
  カーソル名:rinrin : emp3.telの上4桁(rin)
  */

BEGIN
  for rec1 in mikumiku loop --tmp.tel1の上4桁に関して、
    for rec2 in rinrin loop --emp3.telの上4桁に関して、
      if rec1.miku = rec2.rin THEN
        dbms_output.put_line(rec2.rin) ;

        UPDATE
          tmp
        SET
          tmp.tel2 = rec2.rin
        WHERE
          substr(tmp.tel1, 2, 4) = rec1.miku ;
        exit ; --更新作業を一回行ったら、その時点でループ(rec2.rinでの)終了
        /*
        tmp.te1がreac1.mkikuのtel2列に対して、
        reac2.rin(emp3.tel上4桁)を挿入
        */

      ELSE
        UPDATE
          tmp
        SET
          tel2 = 9999
        WHERE
          substr(tmp.tel1, 2, 4) = rec1.miku ;
      end if ;
    end loop;
  end loop;
END;
/

PL/SQLプロシージャが正常に完了しました。


SQL> select * from tmp ;

TEL1                     TEL2
------------------------ --------------------
05389643271              5389
05582547185              5582
05182540148              5182
05989643287              5989
05690178014              5690
04814752574              4814
04812248172              4812
06841784137              9999
06841178014              9999
07817147027              9999

10行が選択されました。
