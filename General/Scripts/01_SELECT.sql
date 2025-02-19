/* SELECT
 * 
 * - 지정된 테이블에서 원하는 데이터가 존재하는 
 *   행, 열을 선택해서 조회하는 SQL(구조적 질의 언어)
 * 
 * - 선택된 데이터 == 조회 결과 묶음 == RESULT SET
 * 
 * - 조회 결과는 0행 이상
 *   (조건에 맞는 행이 없을 수 있다!) *
 * */

/* [SELECT 작성법 - 1]
 * 
 * 2) SELECT * || 컬럼명, ....
 * 1) FROM 테이블명;
 * 
 * - 지정된 테이블의 모든 행에서
 *   특정 열(컬럼)만 조회하기
 * */

-- EMPLOYEE 테이블에서
-- 모든 행의 이름(EMP_NAME), 급여(SAYLARY) 컬럼 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 행(== 모든 사원)의 사번, 이름, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE;

-- EMPLOYEE 테이블의
-- 모든 행, 모든 열(컬럼) 조회
--> *(asterisk) : "모든", "포함"을 나타내는 기호
SELECT *
FROM EMPLOYEE;


-- DEPARTMENT 테이블에서
-- 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;


-- EMPLOYEE 테이블에서
-- 이름, 이메일, 전화번호 조회
SELECT EMP_NAME, EMAIL, PHONE 
FROM EMPLOYEE;

----------------------------

/* 컬럼 값 산술 연산 */

/* 컬럼 값 : 행과 열이 교차되는 한 칸에 작성된 값
 * 
 * - SELECT문 작성 시
 *   SELECT절 컬럼명에 산술 연산을 작성하면
 *   조회 결과(RESULT SET)에서
 *   모든 행에 산술 연산이 적용된 컬럼 값이 조회된다!!
 */

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 급여 + 100만 조회
SELECT EMP_NAME, SALARY, SALARY + 1000000 
FROM EMPLOYEE; 

-- 모든 사원의 이름, 급여(1개월), 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY, SALARY * 12 
FROM EMPLOYEE; 

---------------------------------------

/* - SYSDATE / CURRENT_DATE 
 * - SYSTIMESTAMP / CURRENT_TIMESTAMP
 
/* * DB는 날짜 / 시간 관련 데이터를 다룰 수 있도록하는 자료형 제공  
 * 
 * - DATE 타입 : 년,월,일,시,분,초,요일 저장
 * 
 * - TIMESTAMP 타입 : 년,월,일,시,분,초,요일, ms, 지역 저장
 * 
 * - SYS (시스템) : 시스템에 설정된 시간
 * - CURRENT : 현재 접속한 세션(사용자)의 시간 기반
 * 
 * - SYSDATE : 현재 시스템 기반 시간 얻어오기
 * - CURRENT_DATE : 현재 사용자 계정 기반 시간 얻어오기
 * 
 * * DATA -> TIMESTAMP 바꾸면 ms단위 + 지역 정보를 추가로 얻어옴
 * */
SELECT SYSDATE, CURRENT_DATE 
FROM DUAL;

SELECT SYSTIMESTAMP, CURRENT_TIMESTAMP 
FROM DUAL;

/* DUAL(DUmmy tAbLe) 테이블
 * - 가짜 테이블(임시 테이블)
 * - 조회하려는 데이터가 
 *   실제 테이블에 저장된 데이터가 아닌 경우
 *   사용하는 임시 테이블
 */

/* 날짜 데이터 연산하기 (+, -만 가능!!) */

-- 날짜 + 정수 : 정수 만큼 "일" 수 증가
-- 날짜 - 정수 : 정수 만큼 "일" 수 감소

-- 어제, 오늘, 내일, 모레 조회
SELECT
 CURRENT_DATE - 1,
 CURRENT_DATE, 
 CURRENT_DATE + 1,
 CURRENT_DATE + 2
FROM
 DUAL;


/* 시간 연산 응용 (알아두면 도움 많이됨!!) */
SELECT 
 CURRENT_DATE, 
 CURRENT_DATE + 1/24, -- + 1시간 
 CURRENT_DATE + 1/24/60, -- + 1분 
 CURRENT_DATE + 1/24/60/60, -- + 1초 
 CURRENT_DATE + 1/24/60/60 * 30 -- + 30초 
FROM DUAL;


/* 날짜끼리 - 연산 = 
 * 날짜 - 날짜 = 두 날짜 사이의 차이나는 일 수
 *
 * * TO_DATE('날짜모양문자열', '인식패턴')
 *  -> '날짜모양문자열'을 '인식패턴'을 이용해 해석하여
 *      DATE 타입으로 변환
 * * */

SELECT 
 TO_DATE('2025-02-19', 'YYYY-MM-DD'), 
 '2025-02-19' 
FROM 
 DUAL;

-- 오늘(2/19) 부터 2/28 까지 남은 일 수
SELECT 
 TO_DATE('2025-02-28', 'YYYY-MM-DD') 
 - TO_DATE('2025-02-19', 'YYYY-MM-DD') 
FROM
 DUAL;

-- 종강일(7/17) 까지 남은 일수
SELECT 
 TO_DATE('2025-07-17', 'YYYY-MM-DD') 
 - TO_DATE('2025-02-19', 'YYYY-MM-DD') 
FROM
 DUAL;


-- 퇴근 시간 까지 남은 시간
SELECT 
 (TO_DATE('2025-02-19   17:50:00', 
 				 'YYYY-MM-DD HH24:MI:SS') 
  - CURRENT_DATE) * 24 * 60
FROM DUAL;


-- EMPLOYEE 테이블에서
-- 모든 사원의
-- 사번, 이름, 입사일, 현재까지 근무 일수, 연차 조회

SELECT 
	EMP_ID, 
	EMP_NAME,
  HIRE_DATE,
  FLOOR( CURRENT_DATE - HIRE_DATE ), -- 내림 처리
  CEIL((CURRENT_DATE - HIRE_DATE) / 365) -- 올림 처리
FROM EMPLOYEE;


-----------------------------------------

/* 컬럼명 별칭(Alias) 지정하기 
 * 
 * [지정 방법]
 * 1) 컬럼명 AS 별칭   : 문자 O, 띄어쓰기 X, 특수문자 X
 * 
 * 2) 컬럼명 AS "별칭" : 문자 O, 띄어쓰기 O, 특수문자 O
 * 
 *  * AS 구문은 생략 가능!!
 * 
 *  * ORACLE에서 ""의 의미 
 *  - "" 내부에 작성된 글자 모양 그대로를 인식해라!!
 * 
 * ex) 문자열    오라클 인식
 * 			abc  -> ABC, abc (대소문자 구분 X)
 * 		 "abc" ->    abc (""내부 작성된 모양 으로만 인식)
 * 
 * 
 * */

















