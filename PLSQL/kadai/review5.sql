/*
5.TMP��TEL1��EMP3��TEL�̏�4�����r���āA
��v�����s��EMP3��TEL�̏�4����TMP��TEL2�̒l�ɁA
��v���Ȃ������s�͏�4����9999�ɕύX���Ȃ����B

@C:\Users\Administrator\Documents\learnEIL\SQL\plSQL\kadai\review5.sql

�E�v���V�[�W���y�уt�@���N�V�����̎g�p
�E�o���N����
�E���ISQL
�E�o���N���I�o�C���h

��ʂɁA�v���V�[�W���̓A�N�V���������s���邽�߂Ɏg�p���A
�l�������邽�߂�������A��������Ɏg�p������A
�t�B���^�Ɏg�p������A���낢��ȖړI�Ɏg����B
fanction��return�ŕK���l��Ԃ��B

EXECUTE IMMEDIATE�Ƃ����L�[���[�h���g���΁A�������SQL�������s�ł���
--> ���ISQL



*/

-- console ���O�\��
SET SERVEROUTPUT ON

DECLARE
  tab_name1 VARCHAR2(10) := 'EMP3' ; --table���i�[�p
  tab_name2 VARCHAR2(10) := 'TMP' ; --table���i�[�p
  writeSQL1 VARCHAR2(100) ; --SQL�₢���킹���i�[�p
  writeSQL2 VARCHAR2(100) ; --SQL�₢���킹���i�[�p

  type emp3_type is table of emp3%rowtype ; -- �\�uemp3�v�̃R���N�V�����^�uemp3_type�v��`
  miku emp3_type ; ---- �R���N�V�����^�uemp3_type�v�̔z���`

  type tmp_type is table of tmp%rowtype ;
  rin tmp_type ;


BEGIN

  -- ���ISQL�₢���킹���̊i�[
  writeSQL1 := 'select * from ' || tab_name1 ;
  writeSQL2 := 'select * from ' || tab_name2 ;

  -- �o���N���ISQL����
  EXECUTE IMMEDIATE writeSQL1 bulk collect into miku ;
  EXECUTE IMMEDIATE writeSQL2 bulk collect into rin ;

  dbms_output.put_line(miku(1).tel) ;
  dbms_output.put_line(rin(1).tel1) ;

  /*
  --������i�[���ʏ���
  if miku(1).sal > 1000 then
    uduki := 'Get Smile!!' ;

  else
    uduki := 'Lost Smile...' ;

  END if ;

  -- ���蕶����Insert����
  INSERT into RESULT
    (CRESULT)
  values
    (uduki) ;
  */


END ;
/
