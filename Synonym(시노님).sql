--시노님 (동의어) : 테이블에 별칭 지정

/*
 1. 생성, 수정
  - CREATE OR REPLACE SYNONYM 별칭
    FOR 계정.테이블명;
 2. 삭제
  - DROP SYNONYM 별칭;
*/

--시노님 지정
CREATE OR REPLACE SYNONYM s_emp
FOR scott.emp;

SELECT *
FROM stu;

CREATE OR REPLACE SYNONYM stu
FOR kitri_bs.student;


--시퀀스 (sequence) : 자동으로 숫자를 증감해서 반환하는 객체
/*
 1. 생성
  CREATE SEQUENCE 시퀀스명(seq_명칭)
  INCREMENT BY 증감숫자 -- 기본값 1, 시퀀스가 실행될때마다 증감되는 숫자 설정
  
  START WITH 시작숫자 -- 기본값1, 처음 시작되는 숫자 설정
  NOMINVALUE/MINVALUE 최소값 -- 기본값 NOMINVALUE, 최소값
  NOMAXVALUE/MAXVALUE 최대값 -- 기본값 NOMAXVALUE, 최대값
  NOCYCLE/CYCLE -- 기본값 NOCYCLE, 최대값이 끝나면 최소값부터 반복할지 설정
  NOCACHE/CACHE -- 기본값 CACHE 20, 캐시값 사용
  
 2. 사용방법
  - 시퀀스명.currval: 현재값 반환
  - 시퀀스명.nextval: 그다음 증감값 반환
  예) select 시퀀스명.nextval from 테이블
      INSERT INTO .... values (시퀀스명.nextval ...)
      
*/
