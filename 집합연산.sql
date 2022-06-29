--집합연산
-- 집합연산 조건: 두개의 테이블의 구조가 같아야함(컬럼수, 데이터타입)
-- UNION (합집합) -두개의 테이블을 합쳐서 조회, 중복제거
SELECT *
FROM book
WHERE price <= 10000
UNION
SELECT *
FROM book
WHERE price >= 15000;

-- UNION ALL (합집합, 중복하여 표현)
SELECT *
FROM book
WHERE price <= 10000
UNION ALL
SELECT *
FROM book;

-- MINUS (차집합)
--순서 중요하다.
SELECT *
FROM customer
MINUS
SELECT *
FROM customer
WHERE custid = 5;

-- INTERSECT (교집합)
--박세리에 대한 고객정보만 추출
SELECT *
FROM customer
INTERSECT
SELECT *
FROM customer
WHERE custid = 5;

--EXISTS
--서브쿼리의 결과가 하나라도 존재하면 TRUE, 없으면 FALSE
--상관서브쿼리를 넣어야한다. 안그러면 의미 없다.
SELECT *
FROM customer c
WHERE EXISTS (SELECT *
                FROM orders o
                WHERE c.custid = o.custid);



--DML
--INSERT 삽입
/*INSERT INTO 테이블명 (컬럼1, 컬럼2..)
  VALUES (컬럼1에 대한 값 , 컬럼2에 대한 값..)*/

--'스포츠 의학', '한솔의학서적', 9000원 서적을 등록
INSERT INTO book(bookid, bookname, publisher, price)
VALUES (11, '스포츠 의학', '한솔의학서적', 9000);

--'스포츠 의학','한솔의학서적', 가격x 서적 등록
INSERT INTO book(bookid, bookname, publisher)
VALUES (12, '스포츠 의학', '한솔의학서적');

INSERT INTO book(bookid, bookname, publisher, price)
VALUES (13, '스포츠 통계학', null, 20000);

 --모든 컬럼 값을 INSERT 할 경우 컬럼리스트 생략 가능
 --조건: 모든 컬럼의 값을 입력, 컬럼순서 변경X
INSERT INTO book
VALUES (14, '수학의 정석', '키트리서적', 30000);

--SELECT를 이용한 2개이상의 데이터 INSERT
/*INSERT INTO 테이블명 (컬럼리스트)
 SELECT 문*/
INSERT INTO book (bookid, bookname, publisher, price)
SELECT *
FROM Imported_book;

--UPDATE
/* UPDATE 테이블명
   SET 수정할 컬럼 = 수정할 값
   WHERE 조건절
*/
--customer 테이블에 고객번호가 5인 고객의 주소를 대한민국 부산으로 변경
UPDATE customer
SET address = '대한민국 부산'
WHERE custid = 5;

SELECT *
FROM customer
WHERE custid = 5;

--customer 테이블에서 박세기 고객의 주소를 김연아 고객의 주소로 변경
UPDATE customer
SET address = (SELECT address
                FROM customer
                WHERE name = '김연아')
WHERE name = '박세리';

--DELETE 삭제
/*
DELETE FROM 테이블명
WHERE 조건절

*/
--모든 고객을 삭제하세요
DELETE FROM customer;

--customer 테이블에서 고객번호가 5인 고객을 삭제
DELETE FROM customer
WHERE custid = 5;

--book테이블에서 출판사가 키트리서적인 책 삭제
DELETE FROM book
WHERE publisher = '키트리서적';


SELECT *
FROM customer
WHERE custid = 2;

--ROLLBACK 전부취소
rollback;

--SAVEPOINT 예제
UPDATE customer
SET address = '대한민국 제주도'
WHERE custid = 1;

SAVEPOINT A1;

UPDATE customer
SET address = '대한민국 경기도'
WHERE custid = 2;

ROLLBACK TO A1;

SELECT *
FROM customer;


---7장 예제
--새로운 도서 (‘스포츠 세계’, ‘대한미디어’, 10000원)를 키트리서점에 입고
INSERT INTO book(bookid,bookname,publisher,price )
    VALUES (11,'스포츠 세계', '대한미디어', 1000);
--새로운 도서 (12, 오라클의 정석, 키트리미디어, 15000원) 입고
INSERT INTO book(bookid,bookname,publisher,price)
    VALUES(12,'오라클의 정석','키트리미디어',15000);
--새로운 도서 (자바의 정석, 20000원, 키트리미디어, 13) 컬럼 순서를 변경하여
--입고
INSERT INTO book(bookname,price,publisher,bookid)
    VALUES('자바의 정석',20000,'키트리미디어',13);
-- ‘삼성당’에서 출판한 도서를 삭제
DELETE FROM book
WHERE publisher = '삼성당';

-- ‘이상미디어’에서 출판한 도서를 삭제
DELETE FROM book--이유 생각해보기
WHERE publisher = '이상미디어';

-- 출판사 ‘대한미디어’를 ‘대한출판사’로 이름 수정
UPDATE book
SET publisher = '대한출판사'
WHERE publisher = '대한미디어';


SELECT AVG(saleprice)
FROM orders;

--키트리서점의 총 판매금액의 평균보다 낮은(<) 판매금액을 1000인상하여 수정
UPDATE book
SET price = price + 1000
WHERE price<(SELECT AVG(saleprice)
                FROM orders);
                
 -- 역도 관련된 책 가격 7000원 수정
UPDATE book
SET price = 7000
WHERE bookname LIKE '%역도%';

--출판사가 ‘키트리미디어’이고, 가격이 20000원 미만인 도서 삭제
DELETE FROM book
WHERE publisher = '키트리미디어'
AND price < 20000;

--고객 정보에 본인의 정보 입력
INSERT INTO customer(custid,name,address,phone)
    VALUES(6,'강지혜','대한민국 서울','010-5026-5666');
    
UPDATE customer
SET phone = '010-5026-5666'
WHERE custid = 6;

-- 본인이 ‘자바의 정석’ 책 18000원에 주문 (주문날짜는 현재 날짜로)
INSERT INTO orders(orderid,custid,bookid,saleprice,orderdate)
    VALUES(11,6,13,18000,'2022/06/29');

--위의 문제 다른 버전(실행안함)
INSERT INTO orders(orderid,custid,bookid,saleprice,orderdate)
    VALUES(11,(SELECT custid FROM customer WHERE name = '강지혜')
              ,(SELECT bookid FROM book WHERE bookname = '자바의 정석')
              ,18000,'2022/06/29');


COMMIT; /*커밋 완료*/

UPDATE book
SET price = price - 1000
WHERE price<(SELECT AVG(saleprice)
                FROM orders);
COMMIT;

UPDATE orders
SET saleprice = saleprice + 1000
WHERE saleprice <(SELECT AVG(saleprice)
                FROM orders);
COMMIT;     

--customer 테이블에서 본인 정보 중 주소를 대한민국,전화번호를 null로 수정
UPDATE customer
SET address = '대한민국',
    phone = null --비교 조건에서는 is null, 대입에는 = 사용
WHERE name = '강지혜';

commit;
