
--시퀀스 생성
CREATE SEQUENCE seq_test;
--시퀀스 생성 후 처음에 호출할 때 nextval가 우선적으로 실행
SELECT seq_test.nextval
FROM dual;

SELECT seq_test.currval
FROM dual;

INSERT INTO book VALUES( seq_test.nextval ,'오라클 기초','길벗',10000);

---시퀀스 생성
CREATE SEQUENCE seq_orders_orderid
START WITH 12
INCREMENT BY 5
MINVALUE 12
MAXVALUE 20
CYCLE
NOCACHE;

SELECT seq_orders_orderid.nextval
FROM dual;

DROP SEQUENCE seq_orders_orderid;
