SELECT * FROM emp;

SELECT empno,ename, sal --�����ȣ,����̸�,�޿� ��ȸ,4��
from emp; --�ش�Ǵ� �÷��� ��� Ʃ���� ��ȸ

SELECT * --��� �÷�
from emp--emp ���̺�κ���
WHERE empno = 7499; --�����ȣ�� 7499�� Ʃ��

SELECT empno,ename,sal,deptno --����1
from emp;

SELECT job,ename,hiredate --����2
FROM emp;

SELECT * --����3
from emp
WHERE empno = 7566;

SELECT sal --����4
FROM emp
WHERE empno = 7902;

SELECT *
FROM DEPT;

SELECT * --����5
FROM DEPT
WHERE dname = 'SALES'; --���ڿ� �������� ��ҹ��� �����ؾ��Ѵ�.

SELECT deptno,dname --����6
FROM DEPT
WHERE LOC = 'DALLAS';

SELECT * --����7
FROM SALGRADE
WHERE GRADE >=3;

DESC emp;








