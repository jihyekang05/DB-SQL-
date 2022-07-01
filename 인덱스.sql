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

