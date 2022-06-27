--조인
--INNER JOIN(등가조인,이너조인)
-- 두개 이상의 테이블을 관계를 맺을 때 서로 겹치는 데이터만 조회하는 방법

--오라클 사용방식
--컬럼 호출할 때 겹치지 않는 경우는 컬럼명 바로 적기 가능
SELECT b.bookid, bookname, publisher,price, saleprice
FROM book b, orders o
WHERE b.bookid = o.bookid;

--ANSI 사용방식
SELECT *
FROM book INNER JOIN orders
ON book.bookid = orders.bookid;

SELECT *
FROM customer c, orders o
WHERE c.custid = o.custid
AND c.name = '박지성';



--OUTER JOIN(LEFT, RIGHT, FULL)
--LEFT
--Oracle 사용법
SELECT *
FROM book b, orders o
WHERE b.bookid = o.bookid(+);
--ANSI 사용법
SELECT *
FROM book b LEFT OUTER JOIN orders o
ON b.bookid = o.bookid;

--RIGHT
SELECT *
FROM book b, orders o
WHERE b.bookid(+) = o.bookid;

SELECT *
FROM book b RIGHT OUTER JOIN orders o
ON b.bookid = o.bookid;


--FULL OUTER
SELECT *
FROM book b FULL OUTER JOIN orders o
ON b.bookid = o.bookid;

--NATURAL JOIN
--같은 컬럼명을 대상으로 자동 이너조인
--같은 컬럼명은 한개의 컬럼으로 표현
SELECT *
FROM book b NATURAL JOIN orders o;


-------6장 조인 예제

--고객과 고객의 주문에 관한 데이터를 모두 보이시오
SELECT *
FROM customer c, orders o
WHERE c.custid = o.custid;

SELECT *
FROM customer c INNER JOIN orders o
ON c.custid = o.custid;

--Natural join
SELECT *
FROM customer c NATURAL JOIN orders o;


--고객의 이름과 고객이 주문한 도서의 판매가격 조회
SELECT c.name,o.saleprice
FROM customer c INNER JOIN orders o
ON c.custid = o.custid;

--고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객이름으로 정렬하시오.
SELECT c.name, SUM(o.saleprice)
FROM customer c, orders o
WHERE c.custid = o.custid
GROUP BY c.name
ORDER BY c.name;

--고객의 이름과 고객이 주문한 도서의 이름을 구하시오
SELECT c.name, b.bookname
FROM customer c, book b, orders o
WHERE c.custid = o.custid
AND b.bookid = o.bookid;

SELECT *
FROM customer c INNER JOIN orders o 
     ON c.custid = o.custid
INNER JOIN book b
    ON o.bookid = b.bookid;


--가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름 조회
SELECT c.name,b.bookname
FROM book b, orders o, customer c
WHERE b.bookid = o.bookid
AND o.custid = c.custid
AND b.price = 20000;

--도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을
--구하시오
SELECT c.name, o.saleprice
FROM customer c, orders o
WHERE c.custid = o.custid(+);

--도서를 구매하지 않은 고객의 이름 조회
SELECT c.name
FROM customer c LEFT OUTER JOIN orders o
ON c.custid = o.custid
WHERE o.saleprice is null;

----6장 예제

-- 주문한 사람의 이름, 책이름, 출판사, 가격, 판매가격, 주문일을 조회
SELECT c.name, b.bookname, b.publisher, b.price, o.saleprice, o.orderdate
FROM orders o, book b, customer c
WHERE o.custid = c.custid
AND b.bookid = o.bookid;

--야구 관련 책을 주문한 사람의 이름, 가격, 판매가격을 조회
SELECT c.name, b.price, o.saleprice
FROM customer c, book b, orders o
WHERE o.custid = c.custid
AND b.bookid = o.bookid
AND b.bookname LIKE ('%야구%');

--김연아 고객이 주문한 책이름, 판매가격, 주문일 조회
SELECT b.bookname, o.saleprice, o.orderdate
FROM customer c, book b, orders o
WHERE c.custid = o.custid
AND b.bookid = o.bookid
AND c.name = '김연아';

--할인을 받은 고객의 이름, 할인 받은 누적금액을 조회
SELECT c.name, SUM(b.price-o.saleprice)
FROM customer c, book b, orders o
WHERE c.custid = o.custid
AND o.bookid = b.bookid
AND (b.price - o.saleprice)>0
GROUP BY c.name;

--ANSI
SELECT c.name, SUM(price - saleprice)
FROM book b INNER JOIN orders o
ON b.bookid = o.bookid
INNER JOIN customer c
ON o.custid = c.custid
WHERE price - saleprice > 0
GROUP BY c.name;

-- 주문 일자 기준 그날 총 판매금액(saleprice), 주문횟수 조회
SELECT orderdate, SUM(saleprice), count(*) 주문횟수
FROM orders
GROUP BY orderdate;

--고객별 주문한 고객이름, 횟수, 총 금액(saleprice) 조회
SELECT c.name, count(*), SUM(saleprice)
FROM customer c, orders o
WHERE c.custid = o.custid
GROUP BY c.name;

--주문금액이 2만원 이하인 고객의 이름, 총 금액 조회
SELECT c.name, o.saleprice
FROM customer c, orders o
WHERE c.custid = o.custid
AND o.saleprice <= 20000;

--고객별 주문금액이 2만원 이하인 고객의 이름, 총 금액 조회
SELECT c.name, SUM(o.saleprice)
FROM customer c, orders o
WHERE c.custid = o.custid
GROUP BY c.name
HAVING SUM(o.saleprice) <= 20000;

--대한미디어와 이상미디어에서 책을 구매한 고객의 이름, 주소 조회
SELECT c.name, c.address
FROM customer c, book b, orders o
WHERE c.custid = o.custid
AND b.bookid = o.bookid
AND b.publisher IN ('대한미디어','이상미디어');

--키트리서점 책 중 주문이 한번도 없었던 책 이름, 출판사, 가격을 조회
SELECT b.bookname, b.publisher, b.price
FROM book b, orders o
WHERE b.bookid = o.bookid(+)
AND o.orderid is null;

--대한민국에 사는 사람이 가장 많이 구매한 책의 이름, 출판사 조회 (많이 구매한 순으로 정렬)
SELECT b.bookname,b.publisher,COUNT(*)
FROM book b, customer c, orders o
WHERE b.bookid = o.bookid
AND c.custid = o.custid
AND c.address LIKE '대한민국%'
GROUP BY b.bookname, b.publisher
ORDER BY COUNT(*) DESC;

-- 장미란 고객이 주문한 도서 중 출판사가 이상미디어인 책의 책이름, 판매금액, 주문일자 조회
SELECT b.bookname, o.saleprice, o.orderdate
FROM book b, orders o,customer c
WHERE b.bookid = o.bookid
AND o.custid = c.custid
AND c.name = '장미란'
AND b.publisher = '이상미디어';

--박지성, 김연아가 구매한 판매금액순(내림차순) 고객이름, 책이름, 가격, 판매가
--격 조회
SELECT c.name, b.bookname, b.price, o.saleprice
FROM customer c , orders o, book b
WHERE b.bookid = o.bookid
AND c.custid = o.custid
AND c.name IN ('박지성','김연아')
ORDER BY o.saleprice DESC;

-- 서브쿼리
--메인쿼리 안에 들어가는 또 다른 쿼리
--서브쿼리 종류 (SELECT절에 들어가는 스칼라
--              FROM절에 들어가는 인라인
--              WHERE절에 들어가는 중첩질의)

-- SELECT 동작순서
/*
SELECT 컬럼 --7 (SELECT ...) 7-1
FROM 테이블 -- 1
WHERE 조건 --2 (SELECT 컬럼 2-3
                FROM 테이블 2-1
                WHERE 조건2-2)
AND        --3
GROUP BY 컬럼--4
HAVING 조건--5
AND       -6
ORDER BY --8
*/

--6장 예제

--가장 비싼 도서의 이름을 조회
SELECT bookname, price
FROM book
WHERE price = (SELECT MAX(price)
                FROM book);

--도서를 구매한 적이 있는 고객의 이름을 검색하시오
SELECT *
FROM orders o, customer c
WHERE o.custid(+) = c.custid
AND o.bookid is not null;

SELECT name
FROM customer
WHERE custid IN(SELECT custid
                FROM orders);
                
--대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                FROM orders
                WHERE bookid IN (SELECT bookid
                                FROM book
                                WHERE publisher ='대한미디어'));
                                
--대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice)
FROM orders
WHERE custid IN (SELECT custid
                FROM customer
                WHERE address LIKE '%대한민국%');

-- 전체평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice)
                    FROM orders);
  
--상관 서브쿼리(WHERE)

--각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액조회
SELECT orderid, custid, saleprice
FROM orders md
WHERE saleprice > (SELECT AVG(saleprice)
                    FROM orders so
                    WHERE md.custid = so.custid);
                    
--스칼라 서브쿼리 (SELECT 절에서 사용) 다시 보기
SELECT bookname,(SELECT AVG(price)
        FROM book)
FROM book;


--인라인 뷰(FROM 절에서 사용)
--고객번호가 2이하인 고객의 판매액 ,고객이름 조회

--JOin으로 풀이
SELECT o.saleprice, c.name
FROM orders o, customer c
WHERE o.custid = c.custid
AND o.custid <= 2;

--서브쿼리 풀이
SELECT o.saleprice,c.name
FROM (SELECT *
        FROM customer
        WHERE custid <=2) c, orders o
WHERE c.custid = o.custid;

--SELF JOIN (셀프조인)
--자기 자신의 테이블에서 겹치는 데이터를 찾기 위한 방법

--오라클 사용법
SELECT *
FROM emp a, emp b --약칭 필수
WHERE a.mgr = b.empno;

--ANSI 사용법
SELECT b.empno, b.ename, a.empno, a.ename
FROM emp a JOIN emp b
ON a.mgr = b.empno;
