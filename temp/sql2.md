## SQL 관련 (PL/SQL, Trigger, Exception)

### Dynamic SQL (주소 키워드 검색)
**설명:**  
MovieExec 테이블에서 주소에 특정 키워드(`uk`, `_`, `california`, `new york`, `texas`, `chicago`)가 포함된 임원을 찾고 평균 재산액과 상세 정보를 출력합니다. Dynamic SQL은 `EXECUTE IMMEDIATE`로 문자열 SQL을 실행합니다.  

```sql
DECLARE
    v_sql   VARCHAR2(1000);
    v_avg   NUMBER;
BEGIN
    v_sql := 'SELECT AVG(networth) FROM MovieExec WHERE LOWER(address) LIKE ''%uk%''';
    EXECUTE IMMEDIATE v_sql INTO v_avg;
    DBMS_OUTPUT.PUT_LINE('평균 재산액: ' || TO_CHAR(v_avg, '999,999,999.00'));
END;
/
```

---

###  StudioInfo 테이블 생성 및 랜덤 삽입
**설명:**  
StudioInfo 테이블을 생성하고 budget, salary, cont_period를 랜덤 값으로 삽입합니다.  

```sql
CREATE TABLE StudioInfo (
    name VARCHAR2(50),
    budget NUMBER,
    salary NUMBER,
    cont_period NUMBER
);

DECLARE
    v_budget NUMBER;
    v_salary NUMBER;
    v_period NUMBER;
BEGIN
    FOR i IN 1..5 LOOP
        v_budget := TRUNC(DBMS_RANDOM.VALUE(1000000, 100000000));
        v_salary := TRUNC(DBMS_RANDOM.VALUE(50000, 500000));
        v_period := TRUNC(DBMS_RANDOM.VALUE(1, 10));

        INSERT INTO StudioInfo VALUES ('Studio_'||i, v_budget, v_salary, v_period);
    END LOOP;
END;
/
```

---

### Trigger (Star_Insert)
**설명:**  
MovieStar 삽입 시 address, birthdate, gender가 NULL이면 자동으로 채워주는 트리거입니다.  

```sql
CREATE OR REPLACE TRIGGER Star_Insert
BEFORE INSERT ON MovieStar
FOR EACH ROW
BEGIN
    IF :NEW.address IS NULL THEN
        :NEW.address := '부산광역시 랜덤주소';
    END IF;

    IF :NEW.birthdate IS NULL THEN
        :NEW.birthdate := TO_DATE('1990-01-01','YYYY-MM-DD');
    END IF;

    IF :NEW.gender IS NULL THEN
        :NEW.gender := 'M';
    END IF;
END;
/
```

---

### Exception Handling
**설명:**  
중복 오류(ORA-00001)를 처리하는 PL/SQL 예시입니다.  

```sql
DECLARE
    e_dup EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_dup, -00001);
BEGIN
    INSERT INTO MovieExec VALUES (...);
EXCEPTION
    WHEN e_dup THEN
        DBMS_OUTPUT.PUT_LINE('중복 오류 발생!');
END;
/
```

---


---
