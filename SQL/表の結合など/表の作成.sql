/*
�\(table)�̍쐬
CREATE TABLE �\�� (
  �� �f�[�^�^(��̕�) [DEFAULT�l] [����]
  �E�E�E
) ;


*/


CREATE TABLE PROJ (
  PROJNO NUMBER(3) NOT NULL,
  PNAME VARCHAR2(5),
  BUDGET NUMBER(7, 2)
);

DESCRIBE PROJ

CREATE TABLE PROJ (
  PROJNO NUMBER(3) NOT NULL,
  PNAME VARCHAR2(5),
  BUDGET NUMBER(7, 2) DEFAULT 2000
);


CREATE TABLE DEPT
(
  DEPTNO NUMBER CONSTRAINT SYU_DEPTNO PRIMARY KEY,
  DNAME VARCHAR2(9) CONSTRAINT ICII_DNAME UNIQUE,
  LOC VARCHAR2(10)
);


-- ����������
/*
�\�̊e��ɑ΂��ĔC�ӂɃ��[����ݒ�\�B
�ENOT NULL����
�EUNIQUE����
�EPRIMARY KEY����
�EFOREIGN KEY����
�ECHECK����
*/





/*
���₢���킹���܂ޕ\�̍쐬
CREATE TABLE �\�� (��, ....) AS �₢���킹��
��
�񖼂��w�肵�Ȃ��ꍇ�́A�₢���킹�őI�����ꂽ�񖼂����蓖�Ă���
*/

-- ����10�ɏ�������Ј��ō\�������\EMP2���쐬
CREATE TABLE EMP2 (
  NAME, SALARY, DEPARTMENT_NO
)
AS SELECT ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10 ;

-- MANAGER�E�A�������͋��^��25%���������̂ق��������Ј��ō\�������\BOUNUS�̍쐬
CREATE TABLE BOUNUS
AS SELECT ENAME, JOB, SAL, COMM FROM EMP
WHERE JOB = 'MANAGER' OR COMM > 0.25 * SAL ;



--�r���[�̍쐬
/*
�\�̏����Q�Ƃ�����B�ύX������ł���B
�f�[�^�x�[�X���ɂ͎��݂��Ȃ����A��������͕\�Ɠ��l�ŁA
�\�Ɠ��l�Ɉ�����B

*/

-- ����10�̎Ј��ō\�������r���[���A�\EMP����쐬
CREATE VIEW EMP10
AS SELECT EMPNO, ENAME, JOB FROM EMP
WHERE DEPTNO = 10 ;

EMPNO ENAME                JOB
---------- -------------------- ------------------
 7782 CLARK                MANAGER
 7839 KING                 PRESIDENT
 7934 MILLER               CLERK

-- �E�킪ANALYST�ō\�������r���[ANALYST��񖼂�ς��č쐬
CREATE VIEW ANALYST (ENO, NAME, JOB, DNO) AS
  SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP
  WHERE JOB = 'ANALYST'
WITH CHECK OPTION ;



-- ���`�̕ύX
--�\PROJ�Ɋe��f�[�^��ǉ�����
/*
ALTER TABLE �\�� MODIFY �� �f�[�^�^(��̕�) [NULL�l�̎�舵��];

*/
INSERT INTO PROJ VALUES (101, 'ALPHA', 105000);

�s1�ŃG���[���������܂����B:
ORA-01438: ���̗�ɋ��e�����w�萸�x���傫�Ȓl�ł�

ALTER TABLE PROJ MODIFY BUDGET NUMBER(8, 2);

�\���ύX����܂���

INSERT INTO PROJ VALUES (101, 'ALPHA', 105000);

SQL> SELECT * FROM PROJ ;

    PROJNO PNAME          BUDGET
---------- ---------- ----------
       101 ALPHA          105000


--��̒ǉ�
--�\DEPT��PROJNO���ǉ�
/*
ALTER TABLE �\�� ADD �� �f�[�^�^(��) [[NULL�l�̎�舵��];
�\��`�̍Ō�ɐV�������ǉ�����
���ɑ��݂��Ă����̉E���ɐV������̒ǉ��B��̏����l��NULL�l
*/
ALTER TABLE DEPT
ADD PROJNO NUMBER(3) ;
SQL> SELECT * FROM DEPT ;

    DEPTNO DNAME                LOC                      PROJNO
---------- -------------------- -------------------- ----------
        10 ACCOUNTING           NEW YORK
        20 RESEARCH             DALLAS
        30 SALES                CHICAGO
        40 OPERATIONS           BOSTON

-- �\�A�r���[�̉���
--DEPT��DEPARTMENT�ɉ���
/*
RENAME �\��/�r���[�� TO �V�������O
�����O�̕\�܂��̓r���[���Q�Ƃ���r���[�͖����ɂȂ�
���肠�邢�͍폜�̕K�v����
*/
RENAME DEPT TO DEPARTMENT ;


--�\�ƃr���[�̍폜
--�f�[�^�x�[�X����PROJ���폜
/*
�폜���ꂽ�\�Ɋ�Â��r���[�͖����ɂȂ�
����y�э폜�̕K�v����
*/
DROP TABLE PROJ ;

DROP VIEW EMP10 ;--���̕\�ɂ͉e���Ȃ�
