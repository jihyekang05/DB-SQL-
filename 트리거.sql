--트리거
CREATE TABLE hisorders(
    hisid NUMBER primary key,
    orderid NUMBER,
    orderstate CHAR(1),
    changedt DATE
);

CREATE SEQUENCE seq_hisorders_hisid
START WITH 1
INCREMENT BY 1
NOCACHE;


CREATE OR REPLACE TRIGGER trg_hisorders
AFTER
INSERT OR UPDATE OR DELETE ON orders
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO hisorders
        VALUES (seq_hisorders_hisid.nextval,1, 'I', SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO hisorders
        VALUES (seq_hisorders_hisid.nextval, 1, 'U', SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO hisorders
        VALUES (seq_hisorders_hisid.nextval, 1, 'D', SYSDATE);
    END IF;
END;
/

SELECT *
FROM hisorders;

INSERT INTO orders
VALUES(20,1,1,15000,SYSDATE);
UPDATE orders
SET saleprice = 10000;
rollback;

