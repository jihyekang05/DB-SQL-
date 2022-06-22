SELECT bookname,price
FROM book;

SELECT bookid, bookname, publisher, price
FROM book;


--WHERE 조건 연습-5장
--1.비교 [=, <>(not), <(미만), >(초과), >=(이상), <=(이하)]

SELECT *
FROM book
WHERE price >= 7000;

--2.범위 BETWEEN a AND b (a이상 b이하의 값 조회)

SELECT bookname, publisher, price
FROM Book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 10000 
AND price <= 15000;

--3. 집합 => IN, NOT IN (해당되는 데이터들만 조회 (2개이상))

--출판사가 대한미디어, 이상미디어 모든 데이터를 조회
SELECT *
FROM book
WHERE publisher IN ('대한미디어', '이상미디어');

SELECT *
FROM book
WHERE publisher IN '대한미디어'; -- =과 같은 의미

-- 대한미디어 외의 모든 출판사 책 조회
SELECT *
FROM book
WHERE publisher NOT IN '대한미디어';

SELECT *
FROM book
WHERE NOT publisher = '대한미디어'; --위의 코드와 동일한 출력값

SELECT *
FROM book
WHERE publisher <> '대한미디어'; --동일

--4.패턴 => LIKE (비슷한 값을 찾는 것)
-- LIKE '%문자%' => 문자 앞뒤의 내용이 아무거나 들어와도 검색
-- 축구와 관련된 도서를 검색
SELECT *
FROM book
WHERE bookname LIKE '%축구%';
-- 출판사가 미디어 단어가 포함된 책의 이름, 가격 조회
SELECT bookname,publisher, price
FROM book
WHERE publisher LIKE '%미디어%';

--5. NULL
--
SELECT *
FROM customer
WHERE phone is null; -- = null 성립 안된다.

-- 6. 복합조건(AND, OR, NOT)
-- 출판사가 굿스포츠 이고, 가격이 7000원 이상인 책 조회
SELECT *
FROM book
WHERE publisher = '굿스포츠'
AND price >= 7000 --AND조건은 두개이상의 조건일 때 사용 가능
AND bookname LIKE '%축구%';

--7. 계산
SELECT bookname, publisher, price+1000
FROM book;

SELECT 10+5
FROM dual; --임시테이블

--8. 문자조합
SELECT 'hello'||' nice'
FROM dual;

SELECT bookid || '/' || bookname || '/' || publisher
FROM book;

--9. 별칭(alias)

SELECT '안녕하세요' as 인사말
FROM dual;

SELECT bookid, bookname as bn, publisher, price
FROM book;


--예제

SELECT bookid, bookname,price
FROM book;

SELECT bookname, price
FROM book
WHERE price >= 10000;

SELECT bookid, bookname, publisher
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT bookname, publisher, price
FROM book
WHERE price <= 6000 
AND publisher  = '굿스포츠';

SELECT bookname
FROM book
WHERE publisher LIKE '%미디어%';

SELECT bookname, publisher, price
FROM book
WHERE bookname LIKE '%축구%';

SELECT bookid, bookname, publisher, price+1000 as 가격증가
FROM book
WHERE price < 10000;

SELECT price*0.9 as "10%할인" --다시 확인하기
FROM book
WHERE price >= 20000;

SELECT *
FROM book
WHERE bookname LIKE '%축구%'
AND publisher IN '나무수';

SELECT *
FROM book
WHERE publisher IN ('굿스포츠','이상미디어');


SELECT * --중복제거??
FROM book;

SELECT *
FROM book
WHERE publisher IN ('대한미디어', '이상미디어')
order by price DESC;

SELECT *
FROM book
order by bookname;

SELECT *
FROM customer
WHERE phone = '000-6000-0001';


SELECT *
FROM customer
WHERE address LIKE '%대한민국%';

SELECT *
FROM ORDERS
WHERE orderdate = '21/07/03';

SELECT *
FROM ORDERS;
WHERE orderdate = 


