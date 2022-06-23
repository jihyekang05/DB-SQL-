-----숙제1------------------
SELECT *
FROM emp;

SELECT sal+NVL(comm,0) "급여와 커미션의 합"
FROM emp;

SELECT DISTINCT job
FROM emp;

SELECT ename,sal*12 "연봉"
FROM emp;

SELECT empno,ename 
FROM emp
WHERE mgr is null;

SELECT HIREDATE ||'에 입사한 '|| ename||' 입니다' 
FROM emp
WHERE empno = '7369';

SELECT CONCAT(CONCAT(CONCAT(hiredate,'에 입사한 '),ename),' 입니다')
FROM emp
WHERE empno = '7369';

SELECT deptno,loc
FROM dept
WHERE deptno <> 30;
--NOT deptno = 30, deptno NOT IN 30, deptno != 30

SELECT ename
FROM emp
WHERE deptno = 10
AND job = 'MANAGER';

SELECT empno,ename
FROM emp 
WHERE sal >= 2000
AND deptno = 30;

SELECT empno,ename 
FROM emp
WHERE job = 'CLERK'
AND hiredate > '80/12/31';

SELECT empno,ename,sal
FROM emp
WHERE sal BETWEEN 1000 AND 2500;

SELECT empno,ename,deptno
FROM emp
WHERE TO_CHAR(empno) LIKE '75%'; --자동변환되었다. empno는 숫자타입이라서 변환필요하다.

SELECT empno,ename,sal
FROM emp
WHERE deptno IN(10,30);

SELECT empno,ename,deptno
FROM emp
--WHERE hiredate BETWEEN '81/02/01' AND '81/02/28';
WHERE TO_CHAR(hiredate) LIKE '81/02/%'; --TO_CHAR없어도 되긴 한다.

SELECT ename
FROM emp
WHERE empno IN(7902,7782);

SELECT ename
FROM emp
WHERE empno NOT IN(7698,7839);

SELECT empno,ename
FROM emp
--WHERE SUBSTR(ename,2,1)='A';
WHERE ename LIKE '_A%';--_는 자릿수를 나타낸다._두개면 두번째 자리

SELECT empno,ename
FROM emp
WHERE mgr is null;

SELECT empno,ename,deptno
FROM emp
WHERE JOB IN('MANAGER','SALESMAN');

SELECT empno
FROM emp
ORDER By empno;

SELECT *
FROM emp
ORDER By sal DESC;

SELECT lower(job),lower(ename)
FROM emp;

SELECT ename,SUBSTR(ename,1,2)
FROM emp;

SELECT ename,length(ename)
FROm emp;

SELECT empno,ename,comm+sal
FROm emp
ORDER BY (sal+comm) DESC;

-- 추가문제
SELECT REPLACE(job,'SALESMAN','SALES')
FROM emp;

SELECT NVL(comm,0)
FROM emp;

SELECT *
FROM emp
WHERE comm is not null
OR comm <> 0;

SELECT TO_CHAR(hiredate,'yyyy-MM-DD')
FROM emp;

SELECT TO_CHAR(SYSDATE,'YYYY"년"MM"월"DD"일"')
FROM dual;



