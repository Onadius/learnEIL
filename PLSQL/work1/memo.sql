/* --------------------------
・使用する既存テーブルのコピー【m04, m06】
  create table cpm04 as select * from m04 ;
  create table cpym06 as select * from m06 ;

sqlplus emori/emori

select
  cucd, cencd, cennm
from
  m04
where
  cucd = '700'
order by cucd,cencd ;


CUCD   CENCD  CENNM
------ ------ ------------------------------------------------------------
700    000    ＨＵＢ
700    001    管理本部　システム部
700    002    北陸物流センター
700    003    管理本部　物流部
700    004    神戸配送センター
700    005    松山配送センター
700    006    東北物流センター
700    010    中部物流センター
700    570    関西物流センター
700    590    九州物流センター
700    600    浜松配送センター
700    999    三鷹セコムSCセンター

(1)矩形選択によりtmpテーブル作成, CENCD(varchar2(3)), SN(not null, varchar2(20))

(2)m04のテーブル参考に、対応する拠点番号(CENCD)毎に
  tmpよりバルク処理にて格納したシリアルを、m06のテーブルにインサート処理




-------------------------- */


CREATE TABLE TESTTMP (
  CENCD VARCHAR2(3) ,
  SN VARCHAR2(20) NOT NULL
);

drop table cpm06 ;
