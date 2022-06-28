--6장 예제
SELECT c.name
FROM orders o2,book b2,customer c
WHERE o2.bookid = b2.bookid
AND c.custid = o2.custid
AND b2.price - o2.saleprice = (SELECT MAX(b.price - o.saleprice)
                                FROM orders o, book b
                                WHERE o.bookid = b.bookid);
--1번 조인으로
SELECT c.name
FROM book b, orders o, customer c
WHERE b.bookid = o.bookid
AND o.custid = c.custid
AND b.price - o.saleprice = (SELECT MAX(b.price - o.saleprice)
                                        FROM book b, orders o
                                        WHERE b.bookid = o.bookid);



--총 주문금액(saleprice) 평균 이하인 도서의 책이름, 출판사 조회
SELECT b.bookname, b.publisher
FROM book b, orders o
WHERE b.bookid = o.bookid
AND o.saleprice<= (SELECT AVG(saleprice)
                    FROM orders);


--책이름이 가장 긴 책의 책번호, 책이름, 출판사 조회
SELECT b.bookid, b.bookname, b.publisher
FROM book b
WHERE LENGTH(bookname) = (SELECT MAX(LENGTH(bookname))
                            FROM book);

--주문날짜별로 주문금액의 평균보다 큰 책번호, 책이름, 출판사, 책가격 조회
SELECT b.bookid, b.bookname, b.price, o1.saleprice
FROM book b, orders o1
WHERE b.bookid = o1.bookid
AND o1.saleprice > (SELECT AVG(o2.saleprice)
                            FROM orders o2
                            WHERE o2.orderdate = o1.orderdate);

--키트리서점 책 중 가장 인기있는 책이름 출력 (주문이 많은 책)
SELECT b.bookid, b.bookname
FROM book b, orders o
WHERE b.bookid = o.bookid
GROUP BY b.bookid, b.bookname
HAVING COUNT(*) = (SELECT MAX(count(*))
                            FROM orders
                            GROUP BY bookid);





