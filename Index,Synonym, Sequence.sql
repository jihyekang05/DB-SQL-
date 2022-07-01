--인덱스(INDEX) : 테이블 컬럼에 색인을 걸어 검색 속도를 높이는 역할
/*
 1. 생성
    - CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
    
 2. 재생성: 인덱스가 깨질 때 재생성하여 속도를 향상
    - ALTER INDEX 인덱스명 REBUILD;
 3. 삭제
    - DROP INDEX 인덱스명;
*/

--테이블 복사해서 새로운 테이블 생성
INSERT INTO copy_book
SELECT * FROM copy_book;
commit;

SELECT COUNt(*)
FROM copy_book;

SELECT count(*)
FROM copy_book
WHERE publisher = '대한출판사';

--인덱스 생성
CREATE INDEX ix_publisher ON copy_book(publisher);

--인덱스 삭제
DROP  INDEX ix_publisher;

DROP TABLE copy_book;

--시노님 (동의어) : 테이블에 별칭 지정

/*
 1. 생성, 수정
  - CREATE OR REPLACE SYNONYM 별칭
    FOR 계정.테이블명;
 2. 삭제
  - DROP SYNONYM 별칭;
*/

--시노님 지정
CREATE OR REPLACE SYNONYM s_emp
FOR scott.emp;

SELECT *
FROM stu;

CREATE OR REPLACE SYNONYM stu
FOR kitri_bs.student;


--시퀀스 (sequence) : 자동으로 숫자를 증감해서 반환하는 객체
/*
 1. 생성
  CREATE SEQUENCE 시퀀스명(seq_명칭)
  INCREMENT BY 증감숫자 -- 기본값 1, 시퀀스가 실행될때마다 증감되는 숫자 설정
  
  START WITH 시작숫자 -- 기본값1, 처음 시작되는 숫자 설정
  NOMINVALUE/MINVALUE 최소값 -- 기본값 NOMINVALUE, 최소값
  NOMAXVALUE/MAXVALUE 최대값 -- 기본값 NOMAXVALUE, 최대값
  NOCYCLE/CYCLE -- 기본값 NOCYCLE, 최대값이 끝나면 최소값부터 반복할지 설정
  NOCACHE/CACHE -- 기본값 CACHE 20, 캐시값 사용
  
 2. 사용방법
  - 시퀀스명.currval: 현재값 반환
  - 시퀀스명.nextval: 그다음 증감값 반환
  예) select 시퀀스명.nextval from 테이블
      INSERT INTO .... values (시퀀스명.nextval ...)
      
*/

--시퀀스 생성
CREATE SEQUENCE seq_test;
--시퀀스 생성 후 처음에 호출할 때 nextval가 우선적으로 실행
SELECT seq_test.nextval
FROM dual;

SELECT seq_test.currval
FROM dual;

INSERT INTO book VALUES( seq_test.nextval ,'오라클 기초','길벗',10000);

---시퀀스 생성
CREATE SEQUENCE seq_orders_orderid
START WITH 12
INCREMENT BY 5
MINVALUE 12
MAXVALUE 20
CYCLE
NOCACHE;

SELECT seq_orders_orderid.nextval
FROM dual;

DROP SEQUENCE seq_orders_orderid;
