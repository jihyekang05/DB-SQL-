SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO PL/SQL');
END;
/

DECLARE
    v_text varchar2(20) := 'pl/sql';
BEGIN
    dbms_output.put_line(v_text);
END;
/

-- := 대입, = 비교

/*
DECLARE 선언부 - 변수선언 및 초기화 가능
 1. 변수 (스칼라)
    - 변수명 데이터타입;
    - 변수명 데이터타입 := 값; - 선언 및 초기화
    - 변수명 데이터타입 NOT NULL;
    - 변수명 데이터타입 DEFAULT 값;
    
 2. 변수 (참조형)
    - 변수명 테이블명.컬럼명%TYPE;
    - 변수명 테이블명.컬럼명%TYPE := 값;
    - 변수명 테이블명%ROWTYPE; --테이블의 모든 컬럼을 데이터타입으로 지정
 
 3. 상수 - 변할 수 없는 저장공간
    - 변수명 CONSTANT 데이터타입 := 값;
    - 변수명 CONSTANT 테이블명.컬럼명%TYPE := 값;
 
*/
DECLARE
    v_bookname VARCHAR2(20); -- 선언만
    v_publisher VARCHAR2(50) := '키트리서적'; --선언 및 초기화
    v_price NUMBER NOT NULL := 15000;
    v_name VARCHAR2(20) DEFAULT '홍길동';
BEGIN
    v_bookname := '자바의 정석'; --값 대입
    v_publisher := '대한출판사';
    DBMS_OUTPUT.PUT_LINE(v_bookname);
    DBMS_OUTPUT.PUT_LINE(v_publisher);
    v_price := 10000;
    DBMS_OUTPUT.PUT_LINE('책이름:'||v_bookname || v_publisher || ' 출판사:' 
    || v_publisher || ' 가격:' || v_price);
    DBMS_OUTPUT.PUT_LINE(v_name);
END;
/

--테이블 참조
DECLARE
    v_book book%ROWTYPE;
BEGIN
    v_book.bookname := '자바의 정석';
    v_book.bookid := 1;
    v_book.publisher := '대한미디어';
    v_book.price := 15000;
    DBMS_OUTPUT.PUT_LINE( v_book.bookname);
    DBMS_OUTPUT.PUT_LINE( v_book.bookid);
    DBMS_OUTPUT.PUT_LINE( v_book.publisher);
    DBMS_OUTPUT.PUT_LINE( v_book.price);
END;
/

DECLARE
    v_name customer.name%TYPE;
    v_con CONSTANT customer.phone%TYPE := '010-123';
BEGIN
    v_name := '임꺽정';
    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_con);
END;
/

--짝수인지 홀수인지 확인하는 조건문
--MOD(v_num,2) 나머지 출력하는 함수
DECLARE
    v_num NUMBER;
BEGIN
    v_num := 6;
    IF MOD(v_num,2) = 0 THEN  
        DBMS_OUTPUT.PUT_LINE(v_num || '은 짝수');
    ELSE   
        DBMS_OUTPUT.PUT_LINE(v_num || '은 홀수');
    END IF;
END;
/

--반복문, 반복수행중단문
-- 1~100  짝수만 출력
--루프문 사용
DECLARE
    v_num NUMBER := 100;
    i NUMBER := 0;
BEGIN
    LOOP
        i := i+1;
        IF MOD(i,2) = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('i값: '|| i);
        END IF;
        EXIT WHEN i = v_num;
    
    END LOOP;
END;
/

--1~100까지의 합
DECLARE
    i NUMBER := 0;
    v_num NUMBER := 100;
    v_sum NUMBER := 0;
BEGIN
    WHILE i < v_num LOOP
        i := i+1;
        v_sum := v_sum + i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('합계: '||v_sum);
END;
/

--1부터 100까지 짝수의 합

DECLARE
    v_sum NUMBER := 0;
BEGIN
    FOR i IN 1..100 LOOP
    IF MOD(i,2) = 0 THEN
    v_sum := v_sum + i;
    ELSE
        CONTINUE;
    END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('짝수의 합계: '||v_sum);
END;
/
