--함수
--퍼센트값만큼 값 증가시키는 함수
CREATE OR REPLACE FUNCTION func_tenup(

    v_num NUMBER
)
RETURN NUMBER
IS
    upnum NUMBER := 0.1;
    result NUMBER;
BEGIN
    result := v_num + (v_num*upnum);
    RETURN result;
END;
/

--퍼센트값과 입력값을 직접 조정할 수 있는 함수
CREATE OR REPLACE FUNCTION func_percent(
    
    v_num NUMBER,
    percent NUMBER
)
RETURN NUMBER
IS
    result NUMBER;
BEGIN
    result := v_num + (v_num * percent/100);
    RETURN result;
END;
/

--함수 실행
SELECT func_percent(10000,5)
FROM dual;
