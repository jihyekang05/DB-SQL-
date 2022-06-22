SELECT * FROM emp;

SELECT empno,ename, sal --사원번호,사원이름,급여 조회,4장
from emp; --해당되는 컬럼의 모든 튜플을 조회

SELECT * --모든 컬럼
from emp--emp 테이블로부터
WHERE empno = 7499; --사원번호가 7499인 튜플

SELECT empno,ename,sal,deptno --예제1
from emp;

SELECT job,ename,hiredate --예제2
FROM emp;

SELECT * --예제3
from emp
WHERE empno = 7566;

SELECT sal --예제4
FROM emp
WHERE empno = 7902;

SELECT *
FROM DEPT;

SELECT * --예제5
FROM DEPT
WHERE dname = 'SALES'; --문자열 내에서는 대소문자 구분해야한다.

SELECT deptno,dname --예제6
FROM DEPT
WHERE LOC = 'DALLAS';

SELECT * --예제7
FROM SALGRADE
WHERE GRADE >=3;

DESC emp;








