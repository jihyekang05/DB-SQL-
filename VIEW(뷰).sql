--뷰(View) : 하나 이상의 테이블을 조합하여 만든 가상의 테이블(미러링 테이블)
/*
    특징
    - 편리성
    - 보안성
    - 원본데이터(원본 테이블)에 따라 값이 변경
    - 객체 생성이 어려움 (인덱스, 시노님)
    - 데이터 INSERT, UPDATE, DELETE에 제약이 따른다.
    
    작성법
    1.생성
     CREATE VIEW 뷰이름
     AS SELECT...
    
    2.수정 (생성도 가능)
     CREATE OR REPLACE VIEW 뷰이름
     AS SELECT...
     
    3.삭제 
     DROP VIEW 뷰이름;
*/

-- 고객번호, 고객이름, 책번호, 책이름, 판매가격, 주문일이 나오는 뷰 생성

CREATE VIEW vw_orders
AS
SELECT o.custid,c.name,b.bookid,b.bookname,o.saleprice,o.orderdate
FROM orders o, customer c, book b
WHERE o.custid = c.custid
AND b.bookid = o.bookid;

SELECT *
FROM vw_orders
WHERE bookname LIKE '%축구%';


-- 판매금액이 10000원 이상인 vw_orders 데이터를 볼 수 있게 뷰 수정
CREATE OR REPLACE VIEW vw_orders
AS
SELECT o.custid,c.name,b.bookid,b.bookname,o.saleprice,o.orderdate
FROM orders o, customer c, book b
WHERE o.custid = c.custid
AND b.bookid = o.bookid
AND o.saleprice>= 10000;

SELECT *
FROM vw_orders;

--vw_orders 뷰 삭제
DROP VIEW vw_orders;

--원본 데이터(원본 테이블)값에 따라 같이 변한다.
UPDATE orders
SET saleprice = 23000
WHERE orderid = 2;
commit;

SELECT *
FROM vw_orders;

INSERT INTO vw_orders 
VALUES (1, '박지성', 2, '축구아는 여자', 13000, sysdate);

CREATE OR REPLACE VIEW vw_book
AS
SELECT *
FROM book
WHERE bookname LIKE '%축구%';

SELECT *
FROM vw_book;

INSERT INTO vw_book
VALUES (14,'축구 플레이', '굿스포츠', 13000);

--vw_book테이블은 축구관련된 서적만 들어가기 때문에 insert해도 데이터 볼 수 없다.
INSERT INTO vw_book
VALUES (15, '야구 플레이', '키트리서적', 20000);

--뷰 옵션
/*
 WITH CHECK OPTION : WHERE조건에 부합하는 데이터만 INSERT, UPDATE, DELETE 가능하게 해주는 옵션
 WITH READ ONLY : SELECT 가능하게 해주는 옵션
*/

CREATE OR REPLACE VIEW vw_customer
AS
SELECT custid "cid", name, address "addr"
FROM customer;
--WITH READ ONLY;

SELECT *
FROM vw_customer;

INSERT INTO vw_customer
VALUES(7,'아아','아아아아');

CREATE OR REPLACE VIEW vw_book_price
AS
SELECT *
FROM book
WHERE price >= (SELECT AVG(price)
                    FROM book)
WITH CHECK OPTION;

INSERT INTO vw_book_price
VALUES (16,'테니스 역사', '키트리서점',16000);

DELETE FROM vw_book_price
WHERE bookid = 16;
                
