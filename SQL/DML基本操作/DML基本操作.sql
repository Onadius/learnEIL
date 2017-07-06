--�s�̒ǉ�
--�񖳎w����@
INSERT INTO EMP
VALUES (
  7954, 'CARTER', 'CLEARK', 7968, '88-4-1', 1000, NULL, 30
) ;

--��w����@(���ꂪ����)
INSERT INTO EMP (EMPNO, ENAME, HIREDATE, DEPTNO, SAL)
VALUES (
  7955, 'WILSON', SYSDATE, 30, 1500
);

--���₢���킹���܂ލs�̒ǉ�
/*
INSERT INTO �\�� (��, ...)
�₢���킹��
*/
INSERT INTO BONUS (ENAME, JOB, SAL, COMM)
SELECT ENAME, JOB, SAL, COMM FROM EMP
WHERE JOB = 'MANAGER' OR COMM > SAL * 0.25 ;


--�����l�̍X�V
/*
UPDATE �\��
SET �� = �ύX��̒l, ...
WHERE ���� <-�ꏊ�̎w�� ;
*/
UPDATE EMP
SET SAL = SAL*1.5
WHERE JOB = 'SALESMAN' ;


--BLAKE����̋��^��FORD����Ɠ������^�ɍX�V���A�m�F
UPDATE EMP
SET SAL = (
  SELECT SAL FROM EMP
  WHERE ENAME = 'FORD'
)
WHERE ENAME = 'BLAKE' ;

SELECT * FROM EMP
WHERE ENAME = 'BLAKE' ;



--�\EMP�ɐV������DEPT_NAME��ǉ����A�e�Ј��������镔���}���B
ALTER TABLE EMP ADD DEPT_NAME VARCHAR(15);

UPDATE EMP
SET DEPT_NAME = (
  SELECT DNAME FROM DEPT
  WHERE DEPT.DEPTNO = EMP.DEPTNO
);

--�s�̍폜
--NewYork�ɋΖ�����Ј��̍폜
/*
DELETE FROM �\��
WHERE �� = (�₢���킹��) ;

*/
DELETE FROM EMP
WHERE DEPTNO = (
  SELECT DEPTNO FROM DEPT
  WHERE LOC = 'NEW YORK'
);

SELECT ENAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO ;

ENAME                LOC
-------------------- --------------------
SMITH                DALLAS
SCOTT                DALLAS
FORD                 DALLAS
ADAMS                DALLAS
JONES                DALLAS
BLAKE                CHICAGO
WILSON               CHICAGO
TURNER               CHICAGO
CARTER               CHICAGO
MARTIN               CHICAGO
JAMES                CHICAGO
WARD                 CHICAGO
ALLEN                CHICAGO


--�r���[��p�����f�[�^�ύX�ɂ����鐧��
--EMP��DEPT�̌����r���[���쐬
CREATE VIEW EMPDEPT
AS SELECT ENAME, JOB, SAL, DNAME, LOC FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO ;

�r���[���쐬����܂����E

--�f�[�^�ύX�����̊m�F
INSERT INTO EMPDEPT
VALUES('DONALD', 'CLERK', 2000, 'TECHNICAL', 'SAN FRANCISCO') ;

�s1�ŃG���[���������܂����B:
ORA-01779: �L�[�ۑ�����Ă��Ȃ��\�Ƀ}�b�v�����͕ύX�ł��܂���

UPDATE EMPDEPT
SET JOB = 'ANALYST'
WHERE ENAME = 'SMITH' ;

�s2�ŃG���[���������܂����B:
ORA-01779: �L�[�ۑ�����Ă��Ȃ��\�Ƀ}�b�v�����͕ύX�ł��܂���
