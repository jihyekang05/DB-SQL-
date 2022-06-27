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

--책이름에 ‘축구’의 단어를 농구로 변경하여 책이름 조회
SELECT REPLACE(bookname,'축구','농구')
FROM book;

--책 번호가 10번인 책의 이름과 출판사를 대문자로 변경하여 조회
SELECT UPPER(bookname) as "bookname",UPPER(publisher) as "publisher"
FROM book
WHERE bookid = '10';

--책이름의 글자수와 바이트 조회
SELECT LENGTH(bookname),LENGTHB(bookname)
FROM book;

--박지성의 총 구매액 조회(박지성의 고객번호는 1번으로 놓고 작성)
SELECT SUM(saleprice)
FROM orders
WHERE custid = 1;

--박지성이 구매한 도서의 수 조회(박지성의 고객번호는 1번으로 놓고 작성)
SELECT count(*) --count()는 주로 괄호 안에 *을 넣어주는 것이 좋다.
FROM orders
WHERE custid = 1;

--키트리서점 도서의 총 개수 조회
SELECT count(*) "도서의 총 개수"
FROM book;

--키트리서점에 도서를 출고하는 출판사 조회 (중복제거)
SELECT DISTINCT publisher
FROM book;

--대한미디어 출판사 책의 총 금액, 평균 금액 조회
SELECT sum(price),avg(price)
FROM book
WHERE publisher = '대한미디어';

--출판사별 책의 개수, 평균 금액 조회
SELECT publisher,count(*) "책의 개수",avg(price) "평균금액"
FROM book
GROUP BY publisher;

--김연아가 구매한 도서 총 금액 조회(김연아의 고객번호는 2번으로 놓고 작성)
SELECT sum(saleprice)
FROM orders
WHERE custid = 2;

--3권 구매한 고객의 총 구매 금액 조회
SELECT custid,sum(saleprice)
FROM orders
GROUP BY custid
HAVING count(*) = 3;

--주문일을 기준으로 총 판매금액 조회
SELECT orderdate,sum(saleprice)
FROM orders
GROUP BY orderdate;

--숙제 101

--대한민국에 사는 고객의 수를 조회
SELECT count(*) "고객 수"
FROM customer
WHERE ADDRESS LIKE ('대한민국%');

-- 출판사별 평균가격이 15000원 이하인 출판사 조회
SELECT publisher,avg(price)
FROM book
GROUP BY publisher
HAVING avg(price)<=15000;

--도서별 평균 판매금액, 최대 판매금액, 최소 판매금액 조회(문제 주의하기!!)
SELECT bookid,avg(saleprice),max(saleprice),min(saleprice)
FROM orders
GROUP BY bookid;

--고객별 주문한 수량 조회
SELECT custid,count(*) "주문한 수량"
FROM orders
GROUP BY custid;

--고객별 주문한 총 금액이 20000원 이상인 고객의 번호 앞에 (VIP) 단어 붙여 조회
SELECT custid ||'VIP'
FROM orders
GROUP BY custid
HAVING sum(saleprice) >= 20000;

--도서별 가장 많이 주문한 도서 순서로 정렬하여 조회 (도서번호만 나와도 됨)
SELECT bookid, count(*)
from orders
GROUP BY bookid
ORDER BY count(*) DESC, bookid ASC;
