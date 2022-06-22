SELECT bookname,price
FROM book;

SELECT bookid, bookname, publisher, price
FROM book;


--WHERE ���� ����-5��
--1.�� [=, <>(not), <(�̸�), >(�ʰ�), >=(�̻�), <=(����)]

SELECT *
FROM book
WHERE price >= 7000;

--2.���� BETWEEN a AND b (a�̻� b������ �� ��ȸ)

SELECT bookname, publisher, price
FROM Book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 10000 
AND price <= 15000;

--3. ���� => IN, NOT IN (�ش�Ǵ� �����͵鸸 ��ȸ (2���̻�))

--���ǻ簡 ���ѹ̵��, �̻�̵�� ��� �����͸� ��ȸ
SELECT *
FROM book
WHERE publisher IN ('���ѹ̵��', '�̻�̵��');

SELECT *
FROM book
WHERE publisher IN '���ѹ̵��'; -- =�� ���� �ǹ�

-- ���ѹ̵�� ���� ��� ���ǻ� å ��ȸ
SELECT *
FROM book
WHERE publisher NOT IN '���ѹ̵��';

SELECT *
FROM book
WHERE NOT publisher = '���ѹ̵��'; --���� �ڵ�� ������ ��°�

SELECT *
FROM book
WHERE publisher <> '���ѹ̵��'; --����

--4.���� => LIKE (����� ���� ã�� ��)
-- LIKE '%����%' => ���� �յ��� ������ �ƹ��ų� ���͵� �˻�
-- �౸�� ���õ� ������ �˻�
SELECT *
FROM book
WHERE bookname LIKE '%�౸%';
-- ���ǻ簡 �̵�� �ܾ ���Ե� å�� �̸�, ���� ��ȸ
SELECT bookname,publisher, price
FROM book
WHERE publisher LIKE '%�̵��%';

--5. NULL
--
SELECT *
FROM customer
WHERE phone is null; -- = null ���� �ȵȴ�.

-- 6. ��������(AND, OR, NOT)
-- ���ǻ簡 �½����� �̰�, ������ 7000�� �̻��� å ��ȸ
SELECT *
FROM book
WHERE publisher = '�½�����'
AND price >= 7000 --AND������ �ΰ��̻��� ������ �� ��� ����
AND bookname LIKE '%�౸%';

--7. ���
SELECT bookname, publisher, price+1000
FROM book;

SELECT 10+5
FROM dual; --�ӽ����̺�

--8. ��������
SELECT 'hello'||' nice'
FROM dual;

SELECT bookid || '/' || bookname || '/' || publisher
FROM book;

--9. ��Ī(alias)

SELECT '�ȳ��ϼ���' as �λ縻
FROM dual;

SELECT bookid, bookname as bn, publisher, price
FROM book;


--����

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
AND publisher  = '�½�����';

SELECT bookname
FROM book
WHERE publisher LIKE '%�̵��%';

SELECT bookname, publisher, price
FROM book
WHERE bookname LIKE '%�౸%';

SELECT bookid, bookname, publisher, price+1000 as ��������
FROM book
WHERE price < 10000;

SELECT price*0.9 as "10%����" --�ٽ� Ȯ���ϱ�
FROM book
WHERE price >= 20000;

SELECT *
FROM book
WHERE bookname LIKE '%�౸%'
AND publisher IN '������';

SELECT *
FROM book
WHERE publisher IN ('�½�����','�̻�̵��');


SELECT * --�ߺ�����??
FROM book;

SELECT *
FROM book
WHERE publisher IN ('���ѹ̵��', '�̻�̵��')
order by price DESC;

SELECT *
FROM book
order by bookname;

SELECT *
FROM customer
WHERE phone = '000-6000-0001';


SELECT *
FROM customer
WHERE address LIKE '%���ѹα�%';

SELECT *
FROM ORDERS
WHERE orderdate = '21/07/03';

SELECT *
FROM ORDERS;
WHERE orderdate = 


