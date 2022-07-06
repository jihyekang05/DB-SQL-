
CREATE OR REPLACE PACKAGE CRYPTO
IS
    FUNCTION ENCRYPT (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') -- key
    RETURN RAW;
    FUNCTION DECRYPT (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') -- key
    RETURN VARCHAR2;
END CRYPTO;
/

CREATE OR REPLACE PACKAGE BODY CRYPTO
IS
    SQLERRMSG   VARCHAR2(255);
    SQLERRCDE   NUMBER;
     
    --암호화 함수
    FUNCTION encrypt (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') -- key
     RETURN RAW
    IS
        input_raw RAW(1024);
        --평문 암호화키 RAW 타입으로 변환
        key_raw RAW(16) := UTL_RAW.CAST_TO_RAW(key_data);
        v_out_raw RAW(1024);
        --AES 알고리즘, CBC 체인, PKCS5 패딩방식 사용
        AES_CBC_PKCS5 CONSTANT PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES128 
                                            + DBMS_CRYPTO.CHAIN_CBC 
                                            + DBMS_CRYPTO.PAD_PKCS5;
    BEGIN
        IF input_string IS NULL THEN
         RETURN NULL;
        end IF;
        
        --암호화 할 문자열 RAW 타입으로 변환
        input_raw := UTL_I18N.STRING_TO_RAW(input_string, 'AL32UTF8');
        v_out_raw := DBMS_CRYPTO.ENCRYPT(
                src => input_raw,       
                typ => AES_CBC_PKCS5,   
                key => key_raw);        
    --암호화된 RAW 타입 데이터 리턴
    RETURN v_out_raw;
    END encrypt;
    
    --복호화 함수
    FUNCTION decrypt (input_string IN VARCHAR2
                    , key_data IN VARCHAR2 := 'test1234test1234') -- key
     RETURN VARCHAR2
    IS
        --평문 암호화키 RAW 타입으로 변환
        key_raw RAW(16) := UTL_RAW.CAST_TO_RAW(key_data);
        output_raw RAW(1024);
        v_out_string VARCHAR2(1024);
        --AES 알고리즘, CBC 체인, PKCS5 패딩방식 사용
        AES_CBC_PKCS5 CONSTANT PLS_INTEGER := DBMS_CRYPTO.ENCRYPT_AES128 
  					    + DBMS_CRYPTO.CHAIN_CBC
  					    + DBMS_CRYPTO.PAD_PKCS5;

    BEGIN
        IF input_string IS NULL THEN
         RETURN NULL;
        end IF;
    
        output_raw := DBMS_CRYPTO.DECRYPT(
                src => input_string,
                typ => AES_CBC_PKCS5,
                key => key_raw);
        --복호화 한 RAW 데이터 UTF-8 형식의 문자열로 변환
        v_out_string := UTL_I18N.RAW_TO_CHAR(output_raw, 'AL32UTF8');
    --복호화된 문자열 타입 데이터 리턴
    RETURN v_out_string;
    END decrypt ;
END CRYPTO;
/
--암호화
SELECT crypto.encrypt('test')
FROM dual;

--복호화
SELECT crypto.decrypt('206C308A07DBB7F365A28408CC2A2CBD')
FROM dual;

SELECT crypto.encrypt(ename, 'testcrypto123456'),ename
FROM emp;

SELECT crypto.decrypt('FCE524D9A5DCFEA62AC0D70BE4DCD07D','testcrypto123456')
FROM dual;

--단방향 암호화
SELECT STANDARD_hash('test','SHA256')
FROM dual;

SELECT dbms_crypto.hash(to_clob('test'),4)
FROM dual;

