-- ROWNUM, 10만 잘라서 보고싶다.
SELECT *
FROM (SELECT ROWNUM AS "RNUM", b.*
        FROM (SELECT * 
                FROM book
                ORDER BY bookid) b)
WHERE RNUM BETWEEN 11 AND 20;
