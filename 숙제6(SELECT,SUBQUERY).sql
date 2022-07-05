--숙제 6
--EMP 테이블에서 사원이름이 S로 끝나는 사원 정보를 모두 출력하라.
SELECT *
FROM emp
WHERE ename LIKE '%S';

--EMP 테이블에서 30분 부서에서 근무하고 있는 사원 중에 직책이 SALESMAN인 
--사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력하라.
SELECT empno,ename,job,sal,deptno
FROM emp
WHERE deptno = 30
AND job = 'SALESMAN';

--EMP 테이블에서 부서번호가 10이면 총무부, 20이면 인사부, 30이면 재무부를 출력
SELECT ename,job,deptno,
CASE
    WHEN deptno = 10 THEN '총무부'
    WHEN deptno = 20 THEN '인사부'
    WHEN deptno = 30 THEN '재무부'
END "부서이름"
FROM emp;
--DECODE로 했을 때
--DECODE(deptno,10,'총무부',20,'인사부',30,'재무부')

--직무가 PRESIDENT는 경영자, MANAGER는 관리자, ANALYST는 분석가, 
--SALESMAN 영업,  CLERK 사무원으로 출력 (DECODE문으로도 가능하다)
SELECT ename, job,
CASE job
    WHEN 'PRESIDENT' THEN '경영자'
    WHEN  'MANAGER' THEN '관리자'
    WHEN  'ANALYST' THEN '분석가'
    WHEN 'SALESMAN' THEN '영업'
    WHEN  'CLERK' THEN '사무원'

END "직무"
FROM emp;

--EMP 테이블에서 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000 
--초과인 사원을 사원번호, 이름, 급여, 부서번호를 출력하라
SELECT empno, ename, sal, deptno
FROM emp
WHERE deptno IN (20,30)
AND sal > 2000;

--사원 이름에 e가 포함되어 있는 30번 부서의 사원 중 급여가 1000~2000 
--사이가 아닌 사원이름, 사원번호, 급여, 부서번호를 출력
SELECT ename,empno,sal,deptno
FROM emp
WHERE ename NOT IN ('%E%')
AND deptno = 30
AND sal NOT BETWEEN 1000 AND 2000;

--EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호,
--인원수, 급여의 합을 출력하라.
SELECT deptno,count(*),SUM(sal)
FROM emp
GROUP BY deptno
HAVING count(*) > 4;


--EMP 테이블에서 가장 많은 사원이 속해있는 부서의 부서번호와 사원수를 출력하라. 
--다시 해보자
SELECT e1.deptno,count(*)
FROM emp e1
GROUP BY e1.deptno
HAVING count(*) = (SELECT MAX(count(*))
                    FROM emp
                    GROUP BY deptno);


--COMM이 null 또는 0인 사원은 0으로 출력 나머지는 그대로 출력하라. (모든 정보 출력)
SELECT empno,ename,job,mgr,hiredate,sal,deptno,NVL(comm,0)
FROM emp;
--DECODE(comm,null,0,comm)

--EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력하라.
SELECT e2.mgr
FROM emp e2           
GROUP BY e2.mgr
HAVING count(*) IN (SELECT MAX(count(*))
                    FROM emp e1
                    GROUP BY e1.mgr);


--EMP 테이블에서 부서번호가 10인 부서의 사원수와 부서번호가 30인 부서의 
--사원수를 각각 출력하라.
SELECT deptno,count(*) "사원수"
FROM emp
GROUP BY deptno
HAVING deptno IN (10,30); 
--DECODE로 가능 
SELECT SUM(DECODE(deptno,10,1))"10번 부서", SUM(DECODE(deptno,30,1))"30번 부서"
FROM emp;

--EMP 테이블에서 사원번호가 7521인 사원의 직책과 같고 
--사원번호가 7934인 사원의 급여(SAL)보다 많은 사원의 사원번호, 이름, 직책, 급여를 출력하라.
SELECT empno, ename, job, sal
FROM emp e1
WHERE job = (SELECT job 
                FROM emp e2
                WHERE e2.empno = 7521)
AND sal > (SELECT sal
            FROM emp e3
            WHERE e3.empno =7934) ;
            
-- 직책(JOB)별로 최소 급여를 받는 사원의 정보를 
--사원번호, 이름, 업무, 부서명을 출력하라. (직책별로 내림차순 정렬)      
SELECT d.deptno,e2.ename,e2.job
FROM emp e2,dept d
WHERE e2.deptno = d.deptno
AND (e2.job,e2.sal) IN (SELECT job,MIN(sal)
                    FROM emp e1
                    GROUP BY job)
ORDER BY job DESC;

-- 각 사원 별 커미션이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를 사원번호, 
--사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하라. ( 보너스가 NULL이면 0으로 출력)
SELECT e.empno,e.ename,NVL(comm,0),e.deptno,d.dname,d.loc
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND (e.comm = 0 OR e.comm is null)
AND d.loc LIKE '%GO';

-- 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라.
SELECT deptno,AVG(sal),
CASE
    WHEN AVG(sal) >= 2000 THEN '초과'
    ELSE '미만'
END "초과여부"
FROM emp
GROUP BY deptno;

-- 각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해 사원번호, 
--사원명, 부서번호, 입사일을 출력하라. ****
SELECT ename,deptno,hiredate
FROM emp
WHERE(deptno,hiredate) IN (SELECT deptno,MIN(hiredate)
                            FROM emp
                            GROUP BY deptno);



-- 각 부서 별 사원수를 입사 년도별 출력하라. (컬럼 : 입사1980, 입사1981, 입사1982)
SELECT deptno,
SUM(DECODE(TO_CHAR(hiredate,'YYYY'),1980,1,0)) "1980",
SUM(DECODE(TO_CHAR(hiredate,'YYYY'),1981,1,0)) "1981",
SUM(DECODE(TO_CHAR(hiredate,'YYYY'),1982,1,0)) "1982"
FROM emp
GROUP BY deptno;


-- 1981년 6월 1일 ~ 1981년 12월 31일 입사자 중 부서명이 SALES인 사원의 부서번호, 
--사원명, 직책, 입사일을 출력하라. (입사일 오름차순 정렬)
SELECT e.deptno, e.ename, e.job, e.hiredate
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND hiredate BETWEEN '1981/06/01' AND '1981/12/31'
AND d.dname = 'SALES'
ORDER BY e.hiredate;

-- 사원 테이블에서 각 사원의 사원번호, 사원명, 상급자 사원번호, 상급자 사원명을 출력하라. 
--(각 사원의 급여(SAL)는 상급자 급여보다 많거나 같다.) *****
SELECT e1.empno,e1.ename,e2.empno,e2.ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
AND e1.sal >= e2.sal;


-- 사원명의 첫 글자가 ‘A’이고, 처음과 끝 사이에 ‘LL’이 들어가는 사원의 커미션이 
--COMM2일때, 모든 사원의 커미션에 COMM2를 더한 결과를 사원명, COMM, COMM2, COMM+COMM2로 출력하라.
--(COMM null 값 0으로 변경해서 풀이) **

SELECT (CASE
        WHEN e2.comm is null THEN 0
        ELSE e2.comm
        END), e2.ename,(SELECT e2.comm
                    FROM emp e2
                    WHERE ename LIKE 'A%'
                    AND ename LIKE '%LL%'),(SELECT e2.comm
                                            FROM emp e2
                                            WHERE ename LIKE 'A%'
                                            AND ename LIKE '%LL%')+e2.comm

FROM emp e2;

SELECT NVL(comm,0),
(SELECT NVL(comm,0)
FROM emp
WHERE ename LIKE 'A%LL%')"COMM2",NVL(comm,0)+(SELECT NVL(comm,0)
                                    FROM emp
                                    WHERE ename LIKE 'A%LL%')"COMM+COMM2"
FROM emp;

-- 1981년 5월 31일 이후 입사자의 부서번호, 부서명, 사원번호, 사원명, 입사일을 출력하시오.
   --(부서별 사원정보가 없더라도 부서번호, 부서명은 출력)
   --(부서번호 오름차순 정렬)
   --(입사일 오름차순 정렬)
SELECT e.deptno,d.dname,e.ename,e.hiredate
FROM emp e,dept d
WHERE  e.deptno = d.deptno(+)
AND hiredate > '1981/05/31'
ORDER BY deptno,hiredate;

-- 사원의 직책이 MANAGER 인 사원은 급여를 10%인상, SALSEMAN인 사원은 5% 인상, 
--ANALYST는 기존급여 그대로, 나머지는 3프로 인상하여 사원의 정보를 출력
SELECT
CASE job
    WHEN  'MANAGER' THEN sal*1.1
    WHEN  'SALESMAN' THEN sal*1.05
    WHEN 'ANALYST' THEN sal
    ELSE sal*1.03
END"변경된 연봉",e.*
FROM emp e;

-- 사원의 사원번호, 사원명, 입사일, 근무년수를 출력하라.  
   --(근무년수는 월을 기준으로 버림 (예:40.4년 = 40년, 40.7년=40년))
SELECT empno, ename,hiredate,TRUNC((sysdate - hiredate)/365)"근무년수"
FROM emp;


-- 1981년 5월 31일 이후 입사자 중 커미션이 NULL이거나 0인 사원의 커미션은 
--500으로 그렇지 않으면 기존 커미션을 출력하라.
SELECT empno,
CASE 
    WHEN comm = 0 THEN 500
    WHEN comm is null THEN 500
    ELSE comm
END
FROM emp
WHERE hiredate >= '1981/05/31';

-- 현재 시간과 현재 시간으로부터 한 시간 후의 시간을 출력하라. 
   --(포맷은 ‘YYYY년-MM월-DD일 HH시:MI분:SS초’로 출력)
SELECT TO_CHAR(SYSDATE,'YYYY"년"-MM"월"-DD"일" HH:MI:SS')
FROM dual;

SELECT TO_CHAR(SYSDATE + (INTERVAL '1' HOUR),'YYYY-MM-DD HH:MI:SS')
FROM dual;

---- 각 부서별 사원수를 출력하라. *************
   --(부서별 사원수가 없더라도 부서번호, 부서명은 출력)
   --(부서별 사원수가 0인 경우 ‘없음’ 출력)
   --(부서번호 오름차순 정렬)
SELECT d.deptno,d.dname,SUM(DECODE(e.deptno,null,0,1))
FROM emp e,dept d
WHERE e.deptno(+) = d.deptno
GROUP BY d.deptno,d.dname;

?-- 사원이름, 부서번호를 출력하고, 부서번호가 10번이면 '부서번호10번', 
--아니면 '10번아님'이라고 출력하라
SELECT ename,deptno,
CASE
    WHEN deptno = 10 THEN '부서번호10번'
    ELSE '10번아님'
END"10번여부"
FROM emp;

-- 사원이름, 직책(job), 입사일, 수당(comm) 컬럼을 출력하고, 수당(comm)이 null이면 'X',
--null이 아니면 'O'라고 표기하는 '수당존재여부'라는 컬럼도 만들어 함께 출력하라
SELECT ename,job,hiredate,comm,
CASE
    WHEN comm is null THEN 'X'
    WHEN comm = 0 THEN 'X'
    WHEN comm is not null THEN 'O'
END "수당존재여부"
FROM emp;

---- 부서번호가 20이고, 직원 이름이 'SMITH'이면 '금주당직', 부서번호가 20이고 
--SMITH가 아닌 나머지는 '다음주 당직', 
--그 외에는 null로 표시하는 '비고' 컬럼을 만들어 사원이름, 부서번호, 비고를 출력하라
SELECT ename,deptno,
CASE
    WHEN deptno = 20 AND ename = 'SMITH' THEN '금주당직'
    WHEN deptno = 20 AND ename != 'SMITH' THEN '다음주 당직'
    ELSE null
END"비고"
FROM emp;


-- 부서별 급여등급의 수 (컬럼을 부서가 나오게하고, 해당하는 급여등급이 없으면 0으로 표시)

SELECT s.grade,SUM(DECODE(deptno,10,1,0))"10번 부서",SUM(DECODE(deptno,20,1,0))"20",
SUM(DECODE(deptno,30,1,0))"30",SUM(DECODE(deptno,40,1,0))"40"
FROM salgrade s,emp e
WHERE e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;

