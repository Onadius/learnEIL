
CREATE TABLE TMP_032_170525_1 (
  IDAT DATE,
  CUCD VARCHAR2(7),
  CUSCD VARCHAR2(3),
  CUSPCD VARCHAR2(8),
  SPNM VARCHAR2(42),
  SPAD1 VARCHAR2(42),
  SPAD2 VARCHAR2(42),
  SPTEL VARCHAR2(14),
  EXP VARCHAR2(3)
);

describe TMP_032_170525_1 ;

delete from TMP_032_170525_1 ;
commit ;

 select * from TMP_032_170525_1 ;
