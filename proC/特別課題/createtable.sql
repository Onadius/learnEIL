
CREATE TABLE tmp_56z_170605_1 (
  IDAT DATE,
  OBAT NUMBER(10),
  CLS  VARCHAR2(1),
  RCVDST VARCHAR2(3),
  CUSTCD                    VARCHAR2(12),
  CENCD                     VARCHAR2(6),
  JAN                       VARCHAR2(13),
  PNO                       NUMBER(8) ,
  PNO9                      NUMBER(8)
);

describe tmp_56z_170605_1 ;

delete from tmp_56z_170605_1 ;
commit ;

 select * from tmp_56z_170605_1 ;
