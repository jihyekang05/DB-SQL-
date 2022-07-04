--DECODE 예제

--book 테이블에서 해당하는 출판사가 책을 3권이 입고되어 있으면 '매우우수', 2권이면 '우수', 
--1권이면 '보통'을 출판사등급 컬럼으로 조회

SELECT publisher,DECODE(count(publisher),3,'매우우수',2,'우수','보통') "출판사등급"
FROM book
GROUP BY publisher;

-- orders 테이블에서 3권 구매한 고객은 'VIP', 2권 구매한 고객은 '우수', 1권은 '일반'
--다시 보기
SELECT c.custid,c.name,DECODE(count(c.custid), 3,'VIP',2,'우수','일반') "회원등급"
FROM orders o, customer c
WHERE o.custid = c.custid
GROUP BY c.custid, c.name;

-- orders 테이블에서 고객별 구매한 권수 조회(0권이면 '없음')
--다시 확인
SELECT co.custid, decode(SUM(co.cnt), 0, '없음', SUM(co.cnt))
FROM (SELECT c.custid,
        DECODE(c.custid, o.custid, 1, 0) as "CNT"
        FROM orders o, customer c
        WHERE o.custid(+) = c.custid) co
GROUP BY co.custid;

SELECT c.custid, c.name, count(c.custid),
DECODE(count(o.custid), 0, '없음', count(o.custid)) as "CNT"
FROM orders o, customer c
WHERE o.custid (+)= c.custid
GROUP BY c.custid, c.name;


-- orders 테이블에서 출판사별 날짜마다 판매 권수 표시 (없으면 0)
-- 대한출판사, 굿스포츠, 나무수 출판사별 판매 권수
SELECT distinct publisher
FROM book;

SELECT o.orderdate,
       COUNT(DECODE(b.publisher, '대한출판사', 1)) "대한출판사",
        COUNT(DECODE(b.publisher, '굿스포츠', 1))"굿스포츠",
        COUNT(DECODE(b.publisher, '나무수', 1))"나무수"
FROM orders o, book b
WHERE o.bookid = b.bookid
GROUP BY o.orderdate;


-- CASE 예제
--책의 가격이 15000이상 '고가, 미만은 '저가' 출력
--컬럼명은 '가격범위'
SELECT bookname,price,
CASE
    WHEN (price >= 15000) THEN '고가'
    ELSE '저가'
END "가격범위"
FROM book;

--customer 테이블에 '배송비' 컬럼 추가, 대한민국 거주자는 '무료, 미국거주 '10000',
--영국거주 '15000'
SELECT address,
CASE
    WHEN (address LIKE '%대한민국%') THEN '무료'
    WHEN (address LIKE '%미국%') THEN '10000'
    WHEN (address LIKE '%영국%') THEN '15000'
END "배송비"
FROM customer;

-- book 테이블에 10000원 이하인 책은 가격을 10프로 인상, 20000원 이상인 책은 10프로 인하,
--컬럼명 가격조정
SELECT bookname,price,
CASE
    WHEN (price <= 10000) THEN price*1.1
    WHEN (price >= 20000) THEN price*0.9
    ELSE price
    END "가격조정"
FROM book;

-- 도서별 판매금액이 30000원 이상인 책은 목표달성, 아닌책은 남은 금액 출력
--컬럼명: 목표금액
SELECT o.bookid, b.bookname,SUM(o.saleprice),
    CASE
        WHEN SUM(saleprice) >= 20000 THEN '목표달성'
        WHEN SUM(saleprice) < 20000 THEN TO_CHAR(20000 - SUM(saleprice))
    END "목표금액"
FROM orders o, book b
WHERE o.bookid = b.bookid
GROUP by o.bookid, b.bookname;

-- 전체 책의 금액보다 평균이상인 책은 '평균이상', 평균미만은 '평균미만'으로 출력
SELECT bookname,price,
CASE
    WHEN price >= (SELECT AVG(price) FROM book) THEN '평균이상'
    ELSE '평균미만'
END "평균",
(SELECT AVG(price) FROM book)"평균값"
FROM book;

-- 축구관련책, 야구관련책 권수 조회
SELECT b.keyword, COUNT(*)
FROM (SELECT bookname,
        CASE
            WHEN bookname like '%축구%' THEN '축구'
            WHEN bookname like '%야구%' THEN '야구'
        END "KEYWORD"
        FROM book) b
WHERE b.keyword is not null
GROUP BY b.keyword;

-- 판매금액대별 0~999원, 10000원~19999원, 20000원 이상 책들의 주문건수 조회
SELECT o.price, count(*)
FROM (SELECT saleprice,
        CASE
            WHEN saleprice BETWEEN 0 AND 9999 THEN '1000원대'
            WHEN saleprice BETWEEN 10000 AND 19999 THEN '10000원대'
            ELSE '20000원 이상'
        END"PRICE"
        FROM orders) o
GROUP BY o.price;


--DECODE 예제

--책이름이 ‘축구’,‘야구’,’농구’,’골프’ 관련책은 ‘구기종목’, 피겨 관련 책은 
--‘스케이팅’, 역도 관련 책은 ‘체조’ 그 외 모든 책은 ‘스포츠’로 출력하는 
--‘종목’컬럼을 만들어 책번호, 책이름, 출판사, 종목을 출력
SELECT bookid, bookname, publisher,
CASE
    WHEN bookname LIKE ('%축구%') THEN '구기종목'
    WHEN bookname LIKE ('%야구%') THEN '구기종목'
    WHEN bookname LIKE ('%농구%') THEN '구기종목'
    WHEN bookname LIKE ('%골프%') THEN '구기종목'
    WHEN bookname LIKE ('%피겨%') THEN '스케이팅'
    WHEN bookname LIKE ('%역도%') THEN '체조'
    ELSE '스포츠'
END "종목"
FROM book;

--모든 책의 평균 가격 이상의 책은 ‘평균가이상’, 미만은 null로 출력하는 ‘평균
--가’ 컬럼을 만들어 책이름, 가격, 평균가를 출력

SELECT bookname, price,
CASE
    WHEN (SELECT AVG(price) FROM book) <= price THEN '평균가이상'
   
END"평균가"
FROM book;

--책의 가격이 10000원 이하인 책들은 1000원 인상하고, 초과인 책은 가격은 변
--동없이 책이름, 가격, 변동가격으로 출력
SELECT bookname, price, 
CASE 
    WHEN price <= 10000 THEN price + 1000
    ELSE price
END "변동가격"
FROM book;

--전화번호가 있는 고객은 ‘비공개’ 없는 고객은 ‘입력필요’로 고객의 모든 정보
--를 출력
SELECT c.*,DECODE(phone,null,'입력필요','비공개')"전화번호"
FROM customer c;

--주문 내역 중 할인이 들어간 책은 ‘할인’, 가격에 변동이 없는 책은 ‘변동없음’
--으로 출력하는 컬럼을 추가하여 책이름, 출판사, 가격, 판매가격, 할인내역을
--출력
SELECT b.bookname,price,saleprice,
CASE
    WHEN (b.price - o.saleprice) > 0 THEN '할인'
    WHEN (b.price - o.saleprice) = 0 THEN '변동없음'
    ELSE '가격증가'
END
FROM book b, orders o
WHERE b.bookid = o.bookid;

--책을 구매한 내역이 있는 고객에게 쿠폰을 제공하고 구매 내역이 없는 고객은
--제공하지 않는 ‘쿠폰’ 컬럼을 만들어 ‘제공’, ‘미제공’으로 고객이름, 쿠폰 컬럼
--출력
--다시 보기
SELECT CO.c_custid, co.name,
DECODE( o.custid,null,'미제공','제공')
FROM(SELECT distinct c.custid as "c_custid",c.name as "o_custname"
        FROM customer c, orders o
        WHERE c.custid = o.custid(+)) "CO";




--주문을 3번 이상한 고객은 ‘최우수회원’, 2번은 ‘우수회원’, 1번은 ‘일반회원’, 
--0번은 ‘잠재고객’ 으로 '멤버십’ 컬럼을 만들어 이름과 함께 출력

SELECT co.custid,co.name,
CASE
            WHEN SUM(co.cnt) >= 3 THEN '최우수회원'
            WHEN SUM(co.cnt) = 2 THEN '우수회원'
            WHEN SUM(co.cnt) = 1 THEN '일반회원'
            WHEN SUM(co.cnt) = 0 THEN '잠재고객'
END "멤버십"
FROM (SELECT c.name, c.custid,
        DECODE(o.orderid, null, 0,1) "CNT"
        FROM customer c, orders o
        WHERE c.custid = o.custid(+))"CO"
GROUP BY co.custid,co.name;







SELECT c.custid,
        CASE
            WHEN count(custid) >= 3 THEN '최우수회원'
            WHEN count(custid) = 2 THEN '우수회원'
            WHEN count(custid) = 1 THEN '일반회원'
            WHEN count(custid) = 0 THEN '잠재고객'
        END "멤버십"
FROM orders o, customer c
WHERE o.custid(+) = c.custid
GROUP BY c.custid;
