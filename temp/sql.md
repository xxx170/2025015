### **ORDB 및 트리거 구현 **

기존 `MovieDB` 스키마를 확장하여 배우의 수상 경력을 관리하는 객체 관계형 테이블을 만들고, 데이터 무결성을 위한 트리거를 작성하시오.

**1-1. 객체 및 테이블 생성 (ORDB)**

* 다음 구조를 가진 `StarAwards` 테이블을 생성하시오.
* **배우이름 (Name):** PK, `MovieStar` 테이블의 `name` 참조.
* **수상목록 (Awards):** 중첩 테이블(Nested Table) 형태.
* 수상내역 객체(`award_ty`) 속성: `award_name`(상 이름), `year`(년도), `prize_money`(상금)




* *(힌트: `CREATE TYPE ... AS OBJECT`, `CREATE TYPE ... AS TABLE OF`, `NESTED TABLE ... STORE AS` 사용)*

**1-2. 지능형 트리거 작성 (`Star_Auto_Manage`)**

* `MovieStar` 테이블에 새로운 배우가 `INSERT` 될 때 동작하는 `BEFORE INSERT` 트리거를 작성하시오.
1. **주소 자동 생성:** `address`가 NULL이면, `5_get_random_addr` 함수(실습 때 만듦)를 사용하여 한국식 주소를 랜덤으로 생성해 넣으시오.
2. **성별 자동 결정:** `gender`가 NULL이면, `1990년` 이후 태어난 배우들 중 가장 많은 성별로 설정하시오. (동수면 랜덤)
3. **이력 기록:** 데이터 삽입 작업이 일어나면 `DML_History` 테이블(실습 때 만듦)에 `[시간, 테이블명('MovieStar'), 작업유형('INSERT')]`을 기록하시오.


* *(힌트: `DBMS_RANDOM`, `:NEW`, `PRAGMA AUTONOMOUS_TRANSACTION`)*



---



### 💡 문제 풀이 가이드 (시험 직전 체크리스트)

이 문제를 받자마자 머릿속에 다음 코드들이 떠올라야 합니다.

1. **문제 1-1 (ORDB):**
* `1_Create_StudioInfo.sql` (11/5 실습) 파일의 `CREATE TYPE` 순서를 그대로 복사해서 변수명만 바꿀 수 있는가?


2. **문제 1-2 (트리거):**
* `3.sql` (과제 8번)의 `:NEW.컬럼 IS NULL` 체크 로직과 `before_movie.sql` (11/12 실습)의 `DML_History` 기록 로직을 합칠 수 있는가?

### **1-1. 객체 및 테이블 생성 (ORDB)**

먼저 `StarAwards`라는 테이블을 만드는데, 이 안에 `Awards`라는 리스트(상 받은 목록)가 들어가야 합니다.

**[작성 순서]**

1.  **청소:** 기존에 있을지 모를 테이블과 타입을 지웁니다. (`FORCE` 필수)
2.  **알맹이(`award_ty`):** 상 이름, 연도, 상금 3가지를 담을 객체를 만듭니다.
3.  **통(`award_tab`):** 위 알맹이를 담을 리스트 타입을 만듭니다.
4.  **테이블(`StarAwards`):** 배우 이름(PK)과 리스트를 담을 테이블을 만듭니다.

** 코드**

```sql
-- 1. 청소하기 (기존 것 삭제)
DROP TABLE StarAwards CASCADE CONSTRAINTS;
DROP TYPE award_tab FORCE;
DROP TYPE award_ty FORCE;

-- 2. 알맹이 만들기 (수상 내역 객체)
CREATE OR REPLACE TYPE award_ty AS OBJECT (
    award_name  VARCHAR2(100),
    year        NUMBER(4),
    prize_money NUMBER(20)
);
/

-- 3. 통 만들기 (수상 목록 리스트)
CREATE OR REPLACE TYPE award_tab AS TABLE OF award_ty;
/

-- 4. 최종 테이블 만들기 (도시락통)
CREATE TABLE StarAwards (
    name    VARCHAR2(30) PRIMARY KEY, -- 배우 이름 (PK)
    
    -- [핵심] 수상 목록 리스트 (중첩 테이블)
    Awards  award_tab,
    
    -- 외래키(FK) 설정: MovieStar 테이블의 name을 참조
    FOREIGN KEY (name) REFERENCES MovieStar(name)
)
-- [필수] 리스트 저장소 지정
NESTED TABLE Awards STORE AS awards_store_table;
/
```

> **체크 포인트:** `NESTED TABLE ... STORE AS ...` 구문을 빼먹지 않았는지 꼭 확인하세요\!

-----


### **1-2. 지능형 트리거 작성 (`Star_Auto_Manage`)**

이제 `MovieStar` 테이블에 데이터가 들어올 때(`INSERT`) 자동으로 빈칸을 채우고 기록을 남기는 트리거입니다.

**[작성 순서]**

1.  **껍데기:** `BEFORE INSERT ON MovieStar`
2.  **선언부:** `PRAGMA AUTONOMOUS_TRANSACTION` (트리거 안에서 COMMIT 하려면 필수)
3.  **주소 로직:** `get_addr` 함수 사용 (실습 파일 `5_get_random_addr.sql` 참고)
4.  **성별 로직:** 1990년 이후 출생자 중 많은 성별 찾기
5.  **기록 로직:** `DML_History`에 INSERT 하고 `COMMIT`

** 코드**

```sql
CREATE OR REPLACE TRIGGER Star_Auto_Manage
BEFORE INSERT ON MovieStar
FOR EACH ROW
DECLARE
    -- [중요] 트리거 내에서 DML_History에 쓰고 COMMIT 하려면 이 줄이 필수!
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_gender CHAR(6);
BEGIN
    -- 1. 주소 자동 생성 (NULL인 경우)
    -- 실습 때 만든 get_addr 함수에 없는 타입('x')을 넣으면 풀 주소를 반환하도록 되어 있음
    IF :NEW.address IS NULL THEN
        :NEW.address := get_addr('x'); 
    END IF;

    -- 2. 성별 자동 결정 (NULL인 경우)
    IF :NEW.gender IS NULL THEN
        BEGIN
            SELECT gender INTO v_gender
            FROM (
                SELECT gender, COUNT(*) 
                FROM MovieStar
                WHERE birthdate >= TO_DATE('1990-01-01', 'YYYY-MM-DD')
                GROUP BY gender
                ORDER BY COUNT(*) DESC, DBMS_RANDOM.VALUE -- 동수면 랜덤
            )
            WHERE ROWNUM = 1; -- 1등만 선택
            
            :NEW.gender := v_gender;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                :NEW.gender := 'female'; -- 데이터가 없으면 기본값
        END;
    END IF;

    -- 3. 이력 기록 (DML_History)
    INSERT INTO DML_History (time, t_name, operation)
    VALUES (SYSTIMESTAMP, 'MovieStar', 'INSERT');
    
    -- [중요] 자율 트랜잭션이므로 여기서 꼭 COMMIT 해야 함
    COMMIT;
END;
/
```

**질문 포인트:**

  * `get_addr('x')`는 왜 쓰나요? -\> 실습 코드(`5_get_random_addr.sql`)를 보면 `CASE` 문에 없는 값(예외)이 들어오면 전체 주소를 리턴하게 되어 있어서 꼼수를 쓴 겁니다.
  * `PRAGMA AUTONOMOUS_TRANSACTION`은 왜 쓰나요? -\> 트리거는 원래 실행 중에 `COMMIT`을 못 하는데, 로그 기록은 남겨야 하니까 "이 부분만 별도 트랜잭션으로 처리해줘\!"라고 선언하는 겁니다.

