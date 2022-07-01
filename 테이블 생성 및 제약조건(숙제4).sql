--숙제 4 scott계정

-- EMP테이블과 동일하게 TEST_EMP테이블 생성 (단, 제약조건 제외)
-- DEPT테이블과 동일하게 TEST_DEPT 테이블 생성 (단, 제약조건 제외)
-- SALGRADE테이블과 동일하게 TEST_SALGRADE 테이블 생성 (단, 제약조건 제외)
DESC emp;
CREATE TABLE test_emp(
    empno NUMBER(4),
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    COMM NUMBER(7,2),
    deptno NUMBER(2)
);

DESC dept;
CREATE TABLE test_dept(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR(13)

);

DESC salgrade;
CREATE TABLE test_salgrade(
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);

--EMP, DEPT, SALGRADE 데이터를 TEST_EMP, TEST_DEPT, TEST_SALGRADE 테이블로 삽입

INSERT INTO test_emp
    SELECT *
    FROM emp;
    
INSERT INTO test_dept
    SELECT *
    FROM dept;

INSERT INTO test_salgrade
    SELECT *
    FROM salgrade;


--TEST_EMP 테이블에 성별(GENDER)열 삽입 (데이터 타입은 CHAR(1))
ALTER TABLE test_emp ADD gender char(1);
commit;


-- GENDER 컬럼에 CHECK 'M'과 'F'만 받을수 있는 제약 조건추가
ALTER TABLE test_emp ADD CONSTRAINT test_emp_gender_ck check (gender IN('M','F'));


-- TEST_DEPT테이블의 DEPTNO에 PRIMARY키 제약추가
ALTER TABLE test_dept ADD CONSTRAINT test_dept_deptno_pk PRIMARY KEY (deptno);
--ALTER TABLE test_dept ADD primary key(deptno);
--제약조건 이름없이 추가 가능하다.
commit;

-- TEST_emp테이블의 empno에 PRIMARY키 제약추가
ALTER TABLE test_emp ADD CONSTRAINT  test_emp_empno_ck primary key(empno);
commit;


-- TEST_EMP테이블과 TEST_DEPT 테이블의 DEPTNO컬럼에 FOREIGN키 제약추가
--(ON DELETE CASCADE 추가)
ALTER TABLE test_emp ADD CONSTRAINT test_emp_deptno_fo FOREIGN KEY(deptno) REFERENCES test_dept(deptno)
ON DELETE CASCADE;
commit;

--TEST_EMP테이블의 ENAME컬럼에 NOT NULL 제약 추가 
--null조건은 MODIFY로 제약을 걸어야한다.
ALTER TABLE test_emp MODIFY ename VARCHAR2(10) not null;
commit;


-- TEST_EMP테이블의 INSERT시 상여금을 0으로 입력되게 수정 
ALTER TABLE test_emp MODIFY comm NUMBER(7,2) default 0;
commit;

-- TEST_EMP테이블에 INSERT시 입사일을 현재날짜로 입력되게 수정
ALTER TABLE test_emp MODIFY hiredate DATE  default sysdate;
commit;


-- TEST_EMP테이블의 JOB컬럼을 VARCHAR2(30)으로 수정
ALTER TABLE test_emp MODIFY job VARCHAR2(30);
commit;

-- TEST_DEPT테이블의 DNAME에 UNIQUE 제약 추가
ALTER TABLE test_dept ADD CONSTRAINT test_dept_dname_uk unique(dname);
--ALTER TABLE test_dept MODIFY dname VARCHAR2(14) UNIQUE;
commit;

-- TEST_DEPT테이블의 LOC 컬럼명 ADDR로 변경
ALTER TABLE test_dept rename column loc to addr;
commit;

-- TEST_EMP테이블의 이름을 T_EMP로 변경
ALTER TABLE test_emp rename to t_emp;
commit;

-- TEST_DEPT테이블의 이름을 T_DEPT로 변경
ALTER TABLE test_dept rename to t_dept;
commit;

-- TEST_SALGRADE테이블의 이름을 T_SALGRADE로 변경
ALTER TABLE test_salgrade rename to t_salgrade;
commit;

-- T_DEPT 테이블 삭제 값 확인 (T_EMP, T_DEPT)
DELETE FROM t_emp;
DELETE FROM t_dept;
commit;

--T_EMP테이블의 GENDER 컬럼 삭제
ALTER TABLE t_emp DROP COLUMN gender;
commit;

--T_EMP, T_DEPT, T_SALGRADE 테이블 삭제
DROP TABLE t_emp;
DROP TABLE t_dept;
DROP TABLE t_salgrade;


-- 제약 조건 추가하여 NEW_TEST_EMP, NEW_TEST_DEPT, NEW_TEST_SALGRADE 
--테이블 동일하게 생성

CREATE TABLE new_test_dept(
    deptno NUMBER(2) primary key,
    dname VARCHAR2(14),
    loc VARCHAR(13)

);


CREATE TABLE new_test_salgrade(
    grade NUMBER,
    losal NUMBER,
    hisal NUMBER
);

CREATE TABLE new_test_emp(
    empno NUMBER(4) primary key,
    ename VARCHAR2(10),
    job VARCHAR2(9),
    mgr NUMBER(4),
    hiredate DATE,
    sal NUMBER(7,2),
    COMM NUMBER(7,2),
    deptno NUMBER(2),
    CONSTRAINT new_test_emp_fk FOREIGN KEY (deptno) REFERENCES new_test_dept(deptno)
);



-----kitri_bs계정 숙제4
--제약조건
/*
종류
- PRIMARY KEY(기본키) : not null + unique
- NOT NULL : null 허용하지 않음
- UNIQUE : 해당하는 컬럼에 유일한 값만 입력가능
- FOREIGN KEY(외래키) : 참조되는 테이블과 관계를 맺는 키
- CHECK : 해당하는 컬럼에 조건을 넣어서 제약
- DEFAULT(기본값) : 값을 안넣을 경우 기본적으로 들어가는 값

제약조건 작성법
 1. 이름없이 작성
    1-1. 컬럼명 옆에 작성
     - 컬럼 데이터타입 제약조건
     
    1-2. 아래에 작성
     - 컬럼 데이터타입,
       제약조건(컬럼명)
       
 2. 제약조건 이름 넣어서 작성
    2-1. 컬럼명 옆에 작성
     - 컬럼 데이터타입 CONSTRAINT 제약조건이름 제약조건
     
    2-2. 아래에 작성
     - 컬럼 데이터타입,
       CONSTRAINT 제약조건이름 제약조건(컬럼명)
*/


DESC customer;



CREATE TABLE new_customer(
    custid NUMBER(2) primary key,
    name   VARCHAR2(40) not null,
    address VARCHAR2(50) default '-',
    phone VARCHAR2(50) unique,
    gender char(1) check(gender IN ('M','F'))
);

DROP TABLE new_orders;

CREATE TABLE new_book(
    bookid NUMBER(2),
    bookname VARCHAR2(40) not null,
    publisher VARCHAR2(40),
    price NUMBER(8),
    publishDate date default SYSDATE,
    
    primary key(bookid),
    unique(bookname),
    check(price BETWEEN 0 AND 100000)
    
);

SELECT *
FROM new_customer;

--제약조건이름 넣은 테이블
--foreign key(레퍼런스)는 프라이머리키여야 한다.
DESC orders;
CREATE TABLE new_orders(
    orderid NUMBER(2) CONSTRAINT new_orders_orderid_pk primary key,
    custid NUMBER(2) REFERENCES new_customer(custid),
    bookid NUMBER(2),
    SALEPRICE NUMBER(8),
    ORDERDATE DATE default SYSDATE,
    CONSTRAINT new_orders_saleprice_ck check (saleprice>0),
    CONSTRAINT new_orders_bookid_fk FOREIGN KEY(bookid) REFERENCES new_book(bookid) on delete set null

);

DELETE FROM new_book
WHERE bookid = 1;

--8장 테이블 생성 예제
--학생 테이블
CREATE TABLE student(
    STU_NO char(9) CONSTRAINT student_stu_no primary key,
    STU_NAME VARCHAR2(12) not null,
    STU_DEPT VARCHAR2(20),
    STU_GRADE NUMBER(1),
    STU_CLASS CHAR(1),
    STU_GENDER CHAR(1) check (STU_GENDER IN ('M','F'))
    
   
    
);

--과목 테이블
CREATE TABLE subject(
    SUB_NO CHAR(3) CONSTRAINT subject_sub_no primary key,
    SUB_NAME VARCHAR2(30) not null,
    SUB_PROF VARCHAR2(12),
    SUB_GRADE NUMBER(1),
    SUB_DEPT VARCHAR2(20)

);

--수강 테이블
CREATE TABLE enrol(
    SUB_NO CHAR(3),
    STU_NO CHAR(9),
    ENR_GRADE NUMBER(3) default 0,
    CONSTRAINT enrol_sub_no FOREIGN KEY(SUB_NO) REFERENCES subject(SUB_NO),
    CONSTRAINT enrol_stu_no FOREIGN KEY(STU_NO) REFERENCES student(STU_NO)
    
);



--ALTER TABLE(테이블 수정)
-- 컬럼 추가, 수정, 삭제
-- 컬럼 이름변경
-- 제약조건 추가, 수정, 삭제

--New_Book 테이블에 VARCHAR2(13)의 데이터타입을 가진 isbn 속성을 추가하시오
ALTER TABLE new_book ADD isbn varchar2(13);
DESC new_book;

--NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오
ALTER TABLE new_book MODIFY isbn number;

--NewBook 테이블의 isbn 속성을 삭제하시오
ALTER TABLE new_book DROP COLUMN isbn;

--NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오
ALTER TABLE new_book MODIFY bookid number(2) NOT NULL;

--NewBook 테이블의 bookname컬럼에 unique 제약조건 삭제
ALTER TABLE new_book DROP CONSTRAINT SYS_C008328;

--new_book 테이블의 bookname 컬럼에 unique 제약조건 추가
ALTER TABLE new_book ADD CONSTRAINT new_book_bookname_uk unique(bookname);

--new_book 테이블의 publisher 컬럼 삭제
ALTER TABLE new_book DROP COLUMN publisher;

--new_book테이블의 price컬럼 제약조건 삭제
ALTER TABLE new_book DROP CONSTRAINT SYS_C008327;
--new_book 테이블의 price 컬럼을 varchar2(40)로 변경
ALTER TABLE new_book MODIFY price number(10);

--new_book테이블 price컬럼 varchar로 변경
ALTER TABLE new_book MODIFY price varchar2(50);--에러남, 타입변경은 불가능하다.


--컬럼명 변경
--ALTER TABLE 테이블명 rename column 현재컬럼명 to 변경컬럼명
ALTER TABLE new_book RENAME COLUMN publishdate to pdate;

--테이블명 변경
--ALTER TABLE 테이블명 rename to 변경테이블명;
ALTER TABLE new_book RENAME TO newbook;

--TRUNCATE로 테이블 삭제
TRUNCATE TABLE new_orders;

--new_book, new_customer, new_orders
DROP TABLE new_orders;
DROP TABLE new_customer;
DROP TABLE newbook;





---숙제 4

-- STUDENT 테이블에 STU_BIRTHDAY(생년월일) 컬럼 DATE 타입으로 추가
ALTER TABLE student ADD stu_birthday DATE;

-- STUDENT 테이블의 학과 컬럼 데이터 타입 VARCHAR2(30) 수정
ALTER TABLE student MODIFY stu_dept VARCHAR2(30);
commit;

-- STUDENT 테이블의 학과 컬럼 NOT NULL 제약 추가**
ALTER TABLE student MODIFY stu_dept varchar2(30) not null;

-- STUDENT 테이블의 반 컬럼 삭제
ALTER TABLE student DROP COLUMN stu_class;

-- SUBJECT 테이블의 학년 컬럼 삭제
ALTER TABLE subject DROP COLUMN sub_grade;

-- SUBJECT 테이블에 SUB_GUBUN(과목 구분) 컬럼 추가
ALTER TABLE subject ADD sub_gubun char(1) ;

-- SUBJECT 테이블의 학과 컬럼 데이터 타입 VARCHAR2(30) 수정
ALTER TABLE student MODIFY stu_dept VARCHAR2(30);
commit;

-- SUBJECT 테이블의 학과 컬럼을 STUDENT 테이블의 학과 컬럼에 외래키 제약 추가 
--외래키 주려면 primary key여야 한다. 그래서 오류가 난다.
ALTER TABLE student ADD CONSTRAINT student_sub_fo FOREIGN KEY(stu_dept) REFERENCES subject(sub_dept);


-- ENROL 테이블의 ENROL_GRADE 컬럼을 점수가 아닌 학점이 들어갈 수 있게 수정 
--(예: ENROL_GRADE에 들어갈 수 있는 데이터 : A, B, C, D, F ) 
ALTER TABLE ENROL MODIFY enr_grade char(1);
