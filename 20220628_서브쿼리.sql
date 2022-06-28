--숙제 2 풀이

--사원테이블과 부서테이블을 동등조인(EQUI)
SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--사원테이블과 부서테이블을 FULL OUTER JOIN 조회
SELECT *
FROM emp FULL OUTER JOIN dept
ON emp.deptno = dept.deptno;

--사원테이블과 부서테이블의 Natural join 조회(내추럴 조인은 컬럼 명이 동일해야 한다.)
SELECT *
FROM emp e NATURAL JOIN dept d;

--RESEARCH부서의 사원번호, 사원이름, 부서번호, 부서이름을 조회
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.dname = 'RESEARCH';

--NEW YORK에서 일하는 사원들의 사원이름을 조회
SELECT e.ename
FROM emp e
WHERE e.deptno = (SELECT d.deptno
                        FROM dept d
                        WHERE d.loc = 'NEW YORK');
SELECT e.ename
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc = 'NEW YORK';
                       

--BLAKE가 일하는 부서이름, 지역 조회
SELECT d.dname, d.loc
FROM dept d, emp e
WHERE d.deptno = e.deptno
AND e.ename = 'BLAKE';

SELECT dname,loc
FROM dept 
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'BLAKE');


--BLAKE 사원보다 늦게 입사한 사원의 이름과 입사일 조회
SELECT e1.ename, e1.hiredate
FROM emp e1
WHERE e1.hiredate > (SELECT e2.hiredate
                        FROM emp e2
                        WHERE e2.ename = 'BLAKE');
                        
                        
--SALES 부서에서 급여가 가장 높은 사원의 정보 조회
SELECT *
FROM emp e2, dept d2
WHERE e2.deptno = d2.deptno
AND e2.sal =  (SELECT MAX(e1.sal)
                        FROM emp e1
                        WHERE e1.deptno = (SELECT d.deptno
                                            FROM dept d
                                            WHERE d.dname = 'SALES'))
AND d2.dname = 'SALES';

--직책이 MANAGER와 SALESMAN이고 CHICAGO에서 일하는 사원의 정보 조회                                           

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.job IN ('MANAGER','SALESMAN')
AND d.loc = 'CHICAGO';


--급여가 2000이상인 사원들의 사원이름, 부서이름, 위치를 조회
SELECT e1.ename, d.dname,d.loc
FROM emp e1, dept d
WHERE e1.deptno = d.deptno
AND e1.sal >= 2000;

--급여가 1000이상, 2000이하인 사원들의 사원번호, 사원이름, 부서이름을 사원번호순(오름차순)
--으로 정렬하여 조회

SELECT e2.empno, e2.ename, d.dname 
FROM emp e2, dept d
WHERE e2.deptno = d.deptno
AND e2.sal BETWEEN 1000 AND 2000
ORDER BY e2.empno;


--NEW YORK, DALLAS 지역에서 일하는 사원들의 사원번호, 사원이름, 급여를 조회
SELECT e.empno, e.ename, e.sal
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND d.loc IN ('NEW YORK', 'DALLAS');


--사원번호, 사원이름, 상급자 사원번호, 상급자 사원이름을 조회 (SELF JOIN)
SELECT e1.empno, e1.ename, e2.empno 상급자, e2.ename
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno;


--조인할 때 비트윈 사용해보기)사원들의 사원번호, 사원이름, 급여, 급여등급을 조회
--(급여등급테이블 사용, losal과 hisal 사이의 값으로 급여등급 결정)
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.HISAL;

--급여등급이 3인 사원들의 사원번호, 사원이름, 사원직무를 조회

SELECT e.empno, e.ename, e.job
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal
AND s.grade = 3;

--- 급여등급별 사원의 수, 급여 합계 조회
SELECT s.grade,count(*) "사원의 수", SUM(e.sal) "급여합계"
FROM salgrade s,emp e
WHERE e.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;

--BLAKE 사원보다 많은 급여를 받는 사원이름, 급여를 조회
SELECT e2.ename, e2.sal
FROM emp e2
WHERE e2.sal > (SELECT e.sal
                    FROM emp e
                    WHERE e.ename = 'BLAKE');

                
--FORD 사원과 같은 부서에 근무하는 사원이름을 조회
SELECT e2.ename
FROM  emp e2
WHERE e2.deptno = (SELECT e.deptno
                    FROM emp e
                    WHERE e.ename = 'FORD')
AND e2.ename <> 'FORD';


--부서별 부서이름, 인원수를 인원이 많은 순으로 정렬하여 조회
SELECT count(*)"인원수",d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname
ORDER BY count(*) DESC;


--FORD와 업무와 월급이 같은 사원의 모든 정보 추출
SELECT *
FROM emp e2
WHERE e2.job = (SELECT e.job
                    FROM emp e
                    WHERE e.ename = 'FORD')
AND e2.sal =(SELECT e.sal
                    FROM emp e
                    WHERE e.ename = 'FORD');

SELECT *
FROM emp e2
WHERE (e2.job,e2.sal) = (SELECT e.job,e.sal
                            FROM emp e
                            WHERE e.ename = 'FORD');

-- 부하직원 인원수가 많은 순으로 상사 사원번호, 상사 사원이름, 부하직원수를 조회

SELECT e1.mgr,e2.ename,count(*) "부하직원수"
FROM emp e1, emp e2
WHERE e1.mgr = e2.empno
GROUP BY e1.mgr,e2.ename
ORDER BY count(*) DESC;


--20번 부서 사원의 사원직무와 같은 사원직무인 다른 부서의 사원의 모든 정보를 조회
SELECT *
FROM emp e2
WHERE e2.job IN (SELECT e1.job
                    FROM emp e1
                    WHERE e1.deptno = 20)
AND e2.deptno <> 20;

--업무별 최대 급여를 받는 사원의 사원번호, 이름, 업무, 입사일, 급여, 부서번호 추출
--<같은 값이 있을 경우 결과값이 여러개가 나올 수 있다.>
SELECT e2.empno, e2.ename, e2.hiredate, e2.sal, e2.deptno
FROM emp e2
WHERE e2.sal IN (SELECT MAX(sal)
                    FROM emp e
                    GROUP BY e.job);
--오류 없는 쿼리(상관서브쿼리 사용)
SELECT e1.empno, e1.ename, e1.hiredate, e1.sal, e1.deptno
FROM emp e1
WHERE e1.sal = (SELECT MAX(e2.sal)
                    FROM emp e2
                    WHERE e1.job = e2.job);


--전체 사원의 평균 급여보다 급여가 많은 사원 정보 조회
SELECT *
FROM emp e2
WHERE e2.sal > (SELECT AVG(sal)
                    FROM emp e1);

--모든 부서별 평균 급여보다 급여가 많은 사원 정보 조회(상관서브쿼리)

SELECT *
FROM emp e1
WHERE e1.sal > (SELECT AVG(e2.sal)
                    FROM emp e2
                    WHERE e2.deptno = e1.deptno);


--RESEARCH 부서의 최대 급여보다 급여가 높은 사원의 모든 정보 조회
SELECT *
FROM emp e2
WHERE e2.sal > (SELECT MAX(e1.sal)
                    FROM emp e1
                    WHERE e1.deptno = (SELECT d.deptno
                                        FROM dept d
                                        WHERE d.dname = 'RESEARCH'));
SELECT *  
FROM emp e2
WHERE e2.sal > (SELECT MAX(e.sal)
                FROM emp e, dept d
                WHERE e.deptno = d.deptno
                AND d.dname = 'RESEARCH');


--COMM을 받은 부서 직원들의 상급자의 사원이름, 부서이름을 조회
SELECT e2.ename, d.dname
FROM emp e2, dept d
WHERE e2.deptno = d.deptno
AND e2.empno IN (SELECT e1.mgr
                        FROM emp e1
                        WHERE e1.comm is not null
                        AND e1.comm >0);
                        
SELECT DISTINCT e2.ename, d.dname
FROM emp e1,emp e2,dept d
WHERE e1.mgr = e2.empno
AND d.deptno = e2.deptno
AND e1.comm is not null
AND e1.comm <> 0;


--사원번호,사원명,부서명,소속부서 인원수,업무,소속 업무 급여평균,급여를 추출(SELECT절 )

SELECT e1.empno, e1.ename,
(SELECT count(*)
FROM emp e2
WHERE e1.deptno = e2.deptno)"소속부서 인원수",
(SELECT AVG(e3.sal)
FROM emp e3
WHERE e1.job = e3.job)"소속 업무 급여평균",
d.dname,
e1.job,
e1.sal
FROM emp e1, dept d                     
WHERE e1.deptno = d.deptno;


    
--급여등급별 최고 급여와, 평균 급여를 조회

SELECT s.grade,MAX(e1.sal),AVG(e1.sal)
FROM emp e1, salgrade s
WHERE e1.sal BETWEEN s.losal AND s.hisal
GROUP BY s.grade;

--급여등급별 평균 급여보다 적게 받는 사원의 정보 조회

SELECT *
FROM emp e1, salgrade s1
WHERE e1.sal BETWEEN s1.losal AND s1.hisal
AND e1.sal < (SELECT AVG(e2.sal)
                    FROM emp e2, salgrade s2
                    WHERE e2.sal BETWEEN s2.losal AND s2.hisal
                    AND s1.grade = s2.grade);
   
   
      
--COMM을 가장 잘받은 사원의 모든 정보 조회

SELECT *
FROM emp e2
WHERE e2.comm = (SELECT MAX(COMM)
                    FROM emp e1);


--30번 부서의 사원 중 최저 급여를 받는 사원의 사원번호, 사원이름, 급여를 조회

SELECT *
FROM emp e2
WHERE e2.sal IN (SELECT MIN(e1.sal)
                    FROM emp e1
                    WHERE e1.deptno = 30);


--각 부서의 최대 급여를 받는 사원의 부서코드, 사원이름, 급여를 조회 
--(부서번호 오름차순 정렬)
SELECT e1.deptno, e1.ename, e1.sal
FROM emp e1
WHERE e1.sal = (SELECT MAX(e2.sal)
                FROM emp e2
                WHERE e2.deptno = e1.deptno)
ORDER BY e1.deptno;


--각 부서의 평균 급여보다 급여를 적게 받는 사원의 부서번호, 사원명, 급여 조회

SELECT e1.deptno, e1.ename, e1.sal
FROM emp e1
WHERE e1.sal < (SELECT AVG(e2.sal)
                FROM emp e2
                WHERE e1.deptno = e2.deptno);






--WARD와 급여가 같은 사원의 이름,업무,급여를 추출
SELECT e2.ename, e2.job,e2.sal
FROM emp e2
WHERE e2.sal = (SELECT e1.sal
                FROM emp e1
                WHERE e1.ename = 'WARD');



--사원이름이 ALLEN인 사원과 같은 업무를 하는 사람의 사원번호, 이름, 업무, 급여 추출
SELECT e2.empno,e2.ename,e2.job,e2.sal
FROM emp e2
WHERE e2.job = (SELECT e1.job
                    FROM emp e1
                    WHERE e1.ename = 'ALLEN');


--EMP 테이블의 사원번호가 7521인 사원과 업무가 같고 급여가 7934인 사원보다 많은 사원의 
--사원번호, 이름, 담당업무, 입사일, 급여 추출
SELECT e2.empno,e2.ename,e2.job,e2.hiredate,e2.sal
FROM emp e2
WHERE e2.job =(SELECT e1.job
                FROM emp e1
                WHERE e1.empno = 7521)
AND e2.sal > (SELECT e3.sal
                FROM emp e3
                WHERE e3.empno = 7934);



--부서별 최소급여가 20번 부서의 최소급여보다 큰 부서의 부서번호, 최소 급여 추출
SELECT e2.deptno,MIN(e2.sal)
FROM emp e2
GROUP BY e2.deptno
HAVING MIN(e2.sal)>(SELECT MIN(e1.sal)
                    FROM emp e1
                    WHERE e1.deptno = 20);


--급여가 높은 사원 5명 조회( 높은 순으로 정렬)
SELECT *
FROM emp e1
WHERE 5 > (SELECT COUNT(*)
                FROM emp e2
                WHERE e1.sal < e2.sal)
ORDER BY e1.sal DESC;
