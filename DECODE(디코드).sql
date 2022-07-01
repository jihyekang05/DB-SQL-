
--DECODE 예제
--출판사가 굿스포츠인 책에 출판사등급을 '우수', 그외 출판사는 '보통'으로 조회(컬럼명은
--'출판사등급'으로 지정)
SELECT bookname,publisher, '우수' "출판사등급"
FROm book
WHERE publisher = '굿스포츠'
UNION
SELECT bookname,publisher,'보통' "출판사등급"
FROM book
WHERE publisher <> '굿스포츠';

SELECT bookname, publisher,DECODE(publisher,'굿스포츠','우수','보통') 출판사등급
FROM book;

-- 고객테이블에서 고객등급 컬럼을 추가하여 박지성,김연아고객은 'VIP'로 출력,나머지는 null로 출력
SELECT name,DECODE(name,'박지성','VIP','김연아','VIP',null)"고객등급"
FROM customer;
