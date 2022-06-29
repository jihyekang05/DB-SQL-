--테이블 생성 (CREATE TABLE)
/*
        CREATE TABLE 테이블명 (
            컬럼1 데이터타입 [제약조건],
            컬럼2 데이터타입 [제약조건],
            ...
            컬럼n 데이터타입 [제약조건],

                );
*/

-- book 테이블과 동일한 new_book 테이블 생성
CREATE TABLE new_book(
    bookid NUMBER(2),
    bookname VARCHAR2(40),
    publisher VARCHAR2(40),
    price NUMBER(8)
);
