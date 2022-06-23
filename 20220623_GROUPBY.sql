SELECT sum(saleprice)
FROM ORDERS;

SELECT bookid, REPLACE(bookname,'야구','농구')bookname, publisher, price
FROM book;

SELECT bookname "제목", Length(bookname) "글자수", LENGTHB(bookname)"바이트수"
FROM book
WHERE publisher = '굿스포츠';

--TO_DATE(문자, format형태) -> 문자를 날짜로 변환(20220623)
SELECT TO_DATE('20220623')
FROM dual;

--NVL(expr1,expr2) 
-- -> expr1 값이 null이면 expr2값으로 대체
-- expr1값이 null이 아니면 expr1값이 조회

SELECT phone, NVL(phone,  '-')
FROM customer;

--NVL2(expr1,expr2,expr3)
-- -> expr1 값이 null이면 expr3값이 조회
-- -> expr1 값이 null이 아니면 expr2값이 조회
SELECT phone, NVL2(phone,'O','X') as flag
FROM customer;

--집계함수
--count(*) -> 튜플의 총 건수
SELECT count(*)
FROM book
WHERE publisher = '대한미디어';

--sum(expr) -> 관련된 컬럼의 총 합계
SELECT sum(price)
FROM book;

--avg(expr) -> 관련된 컬럼의 평균값
SELECT avg(price)
FROM book;

--min(expr) -> 관련된 컬럼의 최소값
SELECT min(price)
FROM book;

--max(expr) -> 관련된 컬럼의 최대값
SELECT max(price)
FROM book;

----Group by
-- 특정 컬럼을 기준으로 집계를 하는 명령어
SELECT publisher, sum(price),avg(price),max(price),min(price),count(*)
FROM book
GROUP BY publisher;
--1. group by 옆에 들어간 컬럼명을 SELECT옆에 먼저 적는다.
--2. SELECT 컬럼 적는 부분에 직계함수만 가능

-- HAVING
-- group by의 조건 절
SELECT publisher, sum(price),avg(price),max(price),min(price),count(*)
FROM book
GROUP BY publisher
HAVING sum(price)>=20000
AND count(*) = 3;
--1. 집계함수만 가능하다.(단, group by에 적힌 컬럼은 가능하다.)
--2. 복합조건일 때는 AND, OR 가능 (단, 집계함수만 가능)

--GROUP BY 예시문제
--가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 수량을 구하시
--오. 단, 두 권 이상 구매한 고객만 구한다.
SELECT custid,count(*)
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >= 2;

--5장 예제

SELECT REPLACE(bookname,'축구','농구')
FROM book;

SELECT UPPER(bookname),UPPER(publisher)
FROM book
WHERE bookid = '10';

SELECT LENGTH(bookname),LENGTHB(bookname)
FROM book;

SELECT SUM(saleprice)
FROM orders
WHERE custid = '1';

SELECT count(custid)
FROM orders
WHERE custid = '1';

SELECT count(bookname)
FROM book;

SELECT DISTINCT publisher
FROM book;

SELECT sum(price),avg(price)
FROM book;

SELECT publisher,count(*),avg(price)
FROM book
GROUP BY publisher;

SELECT sum(saleprice)
FROM orders
WHERE custid = '2';

SELECT custid,sum(saleprice)
FROM orders
GROUP BY custid
HAVING count(*) = 3;

SELECT orderdate,sum(saleprice)
FROM orders
GROUP BY orderdate;

--숙제 101
SELECT count(address)
FROM customer
WHERE ADDRESS LIKE ('대한민국%');

SELECT publisher,avg(price)
FROM book
GROUP BY publisher
HAVING avg(price)<=15000;

SELECT bookname,avg(price),max(price),min(price)
FROM book
GROUP BY bookname;

SELECT custid,count(bookid)
FROM orders
GROUP BY custid;

SELECT custid ||'VIP'
FROM orders
GROUP BY custid
HAVING sum(saleprice) >= 20000;

SELECT bookid
from orders
GROUP BY bookid
ORDER BY count(bookid) DESC;









