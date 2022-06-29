--계정 생성, 수정, 삭제
/*system, sys와 같은 오라클 관리자 계정에서 다른계정 생성, 수정, 삭제 가능

1. 생성(CREATE)
    CREATE USER 계정 IDENTIFIED BY 비밀번호;
    [DEFAULT TABLESPACE]
    
2. 수정(ALTER)
    ALTER USER 계정 IDENTIFIED BY 비밀번호(수정);
    
3. 삭제 (DROP)
    DROP USER 계정 CASCADE;
    * CASCADE : 계정 안에 객체(테이블, 인덱스, 뷰)가 존재할 경우 삭제가 되지 않음
                CASCADE 입력하여 삭제시 객체까지 전체 삭제된다.
    
*/

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER hr IDENTIFIED BY hr;

ALTER USER hr IDENTIFIED BY 1234;

DROP USER hr CASCADE;

-- GRANT (권한)
-- GRANT 부여할 권한 TO 계정
GRANT CREATE SESSION TO hr;

--아래 라인은 scott계정에서 실행해야한다.
GRANT SELECT ON emp TO kitri_bs;

-- REVOKE (권한 회수)
-- REVOKE 회수할 권한 FROM 계정
REVOKE CREATE SESSION FROM hr;

-- ROLL (권한의 집합)
-- GRANT 롤 TO 계정
GRANT CONNECT, RESOURCE, UNLIMITED TABLESPACE TO hr;
