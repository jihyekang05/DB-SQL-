--저장 프로시저
CREATE OR REPLACE PROCEDURE pro_book_cnt
(
    v_keyword VARCHAR2,
    v_out OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    IF v_keyword = '축구' THEN
        SELECT COUNT(*) INTO v_cnt
        FROM book
        WHERE bookname LIKE '%축구%';
        DBMS_OUTPUT.PUT_LINE('축구관련책 :' || v_cnt || '권');
        v_out := v_cnt;
    ELSE
        DBMS_OUTPUT.PUT_LINE('그 외 여러권');
    END IF;
END;
/
DECLARE
vv NUMBER;
BEGIN
    pro_book_cnt('축구',vv);
    DBMS_OUTPUT.PUT_LINE(vv);
END;
