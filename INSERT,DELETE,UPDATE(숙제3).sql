GRANT SELECT ON dept TO kitri_bs WITH GRANT OPTION;
/*
CREATE TABLE new_book(
    bookid NUMBER(2),
    bookname VARCHAR2(40),
    publisher VARCHAR2(40),
    price NUMBER(8)
);*/



--숙제3

--EMP, DEPT, SALGRADE 테이블과 동일한 NEW_EMP, NEW_DEPT, NEW_SALGRADE 테이블 생성
--table create는 commit할 필요 없다.
desc emp;
DROP TABLE new_emp;
CREATE TABLE new_emp(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job  VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7,2),
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2)
);


   

SELECT *
FROM emp;

--emp테이블에 있는 것 그대로 옮길 때 사용한다.
INSERT INTO new_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
    SELECT *
    FROM emp;



desc dept;

SELECT *
FROM dept;

CREATE TABLE new_dept(
        deptno NUMBER(2),
        dname VARCHAR2(14),
        loc VARCHAR2(13)

);

INSERT INTO new_dept(deptno,dname,loc)
    SELECT deptno,dname,loc
    FROM dept;




SELECT *
FROM salgrade;
desc salgrade;
    
CREATE TABLE new_salgrade(
        grade NUMBER,
        losal NUMBER,
        hisal NUMBER
);

INSERT INTO new_salgrade(grade,losal,hisal)
    SELECT grade,losal,hisal
    FROM salgrade;
    

--NEW_EMP 테이블에 EMP테이블에서 부서 번호가 10, 20인 사원정보 등록하고 조회**

INSERT INTO new_emp
    SELECT *
    FROM emp
    WHERE deptno IN (10,20);
commit;


--부서테이블에 부서번호 50번, 부서명 IT,  지역 SEOUL 입력하고 조회,값을 넣을 땐 values,
--테이블을 넣을 때는 SELECT
INSERT INTO new_dept(deptno,dname,loc)
    VALUES(50,'IT','SEOUL');
commit;

--사원번호 7567, 사원이름 KIM, 사원직무 PM, 상급자 사원번호 7839, 
--급여 3600, 커미션 100, 부서번호 50 등록 후 조회(21/01/12 날짜로 등록)
INSERT INTO new_emp(empno,ename,job,mgr,sal,comm,deptno,hiredate)
    VALUES(7567,'KIM','PM',7839,3600,100,50,'21/01/12');
commit;    

--사원번호 7703, 사원이름 TOM, 사원직무 SALESMAN, 
--상급자 사원번호 7566, 급여 1400, 커미션 0, 부서번호 20 입사 후 조회(현재날짜로 등록)
INSERT INTO new_emp(empno,ename,job,mgr,sal,comm,deptno,hiredate)
    VALUES(7703,'TOM','SALESMAN',7566,1400,0,20,sysdate);
commit;

--사원번호 7935, 사원이름 PARK, 사원직무 DEVELOPER 상급자 사원번호 7839, 급여 3000, 
--커미션 500, 부서번호 50 입사 후 조회(현재날짜로 등록)
INSERT INTO new_emp(empno,ename,job,mgr,sal,comm,deptno,hiredate)
    VALUES(7935,'PARK','DEVELOPER',7839,3000,500,50,sysdate);
commit;   

--사원번호 7936, 임의로 본인의 영어이름, 직무, 상급자 사원번호, 
--급여, 커미션, 부서번호 현재날짜로 등록 후 조회
INSERT INTO new_emp(empno,ename,job,mgr,sal,comm,deptno,hiredate)
    VALUES(7936,'ji','manager',3500,2000,20,20,sysdate);
commit;

--사원번호 7369의 사원직무를 ANALYST로 수정 후 조회
UPDATE new_emp
SET job = 'ANALYST'
WHERE empno = 7369;
commit;

--부서번호 20번 직원의 급여 10프로 인상 후 조회
UPDATE new_emp
SET sal = sal*1.1
WHERE deptno = 20;
commit;

--모든사원의 급여를 100 증가 후 조회
UPDATE new_emp
SET sal = sal+100;
commit;

--EMP 테이블에서 30번 부서중 급여가 2000 이상인 직원만 NEW_EMP테이블에 등록 후 조회
INSERT INTO new_emp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
SELECT *
FROM emp 
WHERE deptno = 30
AND sal >= 2000;
commit;

--상급자 사원번호가 7839인 사원의 상급자 사원번호를 7782로 변경 후 조회
UPDATE new_emp
SET mgr = 7782
WHERE mgr = 7839;
commit;

--dept테이블에서 10,20,30번 부서의 데이터를 new_dept 테이블로 등록하고 조회
INSERT INTO new_dept
SELECT *
FROM dept
WHERE deptno IN (10,20,30);
commit;

--지역이 DALLAS인 사원들의 급여를 10 감액하여 수정 후 조회
UPDATE new_emp
SET sal = sal-10
WHERE deptno = (SELECT deptno
                FROM new_dept
                WHERE loc = 'DALLAS');
commit;               
                
--30번 부서의 지역을 LOS ANGELES로 수정 후 조회
UPDATE new_dept
SET loc = 'LOS ANGELES'
WHERE deptno = 30;
commit;

--사원번호 7566 퇴사 후 조회
DELETE FROM new_emp
WHERE empno = 7566;
commit;

--상급자의 번호가 사원 번호에 없는 사원의 MGR값을 NULL로 변경 후 조회
UPDATE new_emp
SET mgr = null
WHERE empno IN (SELECT e1.empno
                    FROM new_emp e1,new_emp e2
                    WHERE e1.mgr = e2.empno(+)
                    AND e1.mgr is not null
                    AND e2.empno is null);
commit;
          
--50번 부서 삭제 후 조회  (에러 발생시 원인 파악하여 삭제), 제약조건 없어서 삭제 가능
DELETE FROM new_dept
WHERE deptno = 50;
commit;

--사원이름이 ALLEN, WARD, BLAKE 사원의 부서번호를 10으로 변경 후 조회
UPDATE new_emp
SET deptno = 10
WHERE ename IN ('ALLEN','WARD','BLAKE');
commit;

--COMM이 NULL인 데이터를 0으로 수정 후 조회
UPDATE new_emp
SET comm  = 0
WHERE comm is null;
commit;

--NEW_EMP 테이블 삭제 후 조회


--NEW_DEPT 테이블 데이터 전체 삭제 후 조회
DELETE FROM new_dept;
commit;

