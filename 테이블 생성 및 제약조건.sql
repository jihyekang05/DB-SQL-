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
