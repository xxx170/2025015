## SQL 관련 (PL/SQL, Trigger, Exception)

### Dynamic SQL (주소 키워드 검색)
**설명:**  
MovieExec 테이블에서 주소에 특정 키워드가 포함된 임원을 찾고, 평균 재산액과 상세 정보를 출력하는 예시입니다. Dynamic SQL은 `EXECUTE IMMEDIATE`로 문자열 SQL을 실행합니다.  

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

### Trigger (MovieStar 삽입 시 자동 값 채우기)
**설명:**  
MovieStar 테이블에 새로운 배우가 삽입될 때, `address`, `birthdate`, `gender`가 NULL이면 자동으로 기본값을 채워주는 트리거입니다.  

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

### Exception Handling (중복 오류 처리)
**설명:**  
중복된 값 삽입 시 발생하는 ORA-00001 오류를 `PRAGMA EXCEPTION_INIT`으로 처리하는 예시입니다.  

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
