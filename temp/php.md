1.  **`search.php`**: 검색 조건에 따라 SQL이 늘어났다 줄었다 하는 **"고무줄 SQL(Dynamic SQL)"** 만들기.
2.  **`detail.php`**: 데이터를 가져와서 표를 예쁘게 합치는 **"테트리스(Rowspan)"** 하기.
-----

### ** 웹 기반 영화 정보 검색 시스템 **



3. **문제 2-1 (PHP 검색):**
* `oci_fetch_all.php` (11/19 실습)의 구조에 `search.php'의 `WHERE 1=1` 다이나믹 SQL 로직을 섞을 수 있는가?


4. **문제 2-2 (Rowspan):**
* `stars_array2.php` (12/3 실습)의 `count` -> `rowspan` -> `loop` 패턴을 그대로 적용할 수 있는가?


사용자가 영화 정보를 검색하고, 상세 정보를 조회할 수 있는 PHP 페이지 2개를 작성하시오.
**(제약조건: 데이터 조회 시 반드시 `oci_fetch_all` 함수를 사용할 것)**

**2-1. 검색 페이지 (`search.php`)**

* **입력 폼:**
* 영화 제목 (포함 검색, 와일드카드 `%` 지원)
* 제작 연도 범위 (시작 연도 ~ 종료 연도)
* 장르 (라디오 버튼: '컬러', '흑백', '상관없음')


* **기능:**
* Dynamic SQL을 사용하여 입력된 조건만 `WHERE` 절에 추가하시오. (입력 안 된 조건은 무시)
* 검색 결과는 표(Table) 형태로 출력하며 컬럼은 `제목`, `연도`, `영화사`, `제작자` 순으로 표시하시오.
* `제목`을 클릭하면 `detail.php?title=영화제목` 으로 이동하도록 링크를 거시오.



**2-2. 상세 및 통합 정보 페이지 (`detail.php`)**

* `GET` 방식으로 전달받은 영화 제목에 해당하는 상세 정보를 출력하시오.
* **제작자 정보 통합 출력 (Rowspan 활용):**
* 해당 영화의 제작자(`MovieExec`)가 만든 **다른 모든 영화 목록**을 아래 표와 같은 형식으로 출력하시오.
* 제작자 이름은 한 번만 출력되어야 하며, 영화 목록 칸과 합쳐져야 함 (`rowspan` 사용).


| 제작자 이름 | 제작한 영화 목록 (연도) |
| --- | --- |
| **Steven Spielberg** | E.T. (1982) |
| (위와 합쳐짐) | Jurassic Park (1993) |
| (위와 합쳐짐) | Schindler's List (1993) |



---

### 📂 2-1. 검색 페이지 (`search.php`) 만들기

이건 **[입력 폼(HTML)] + [고무줄 SQL(PHP)] + [결과 표(HTML)]** 샌드위치입니다.

#### **1단계: 입력 폼 만들기 (HTML)**

사용자가 값을 넣을 구멍을 뚫어줍니다. 여기서 중요한 건 `name` 속성입니다. 이 이름표가 PHP로 넘어갑니다.

```html
<form method="POST" action="search.php">
    제목: <input type="text" name="title"> <br>
    연도: <input type="number" name="year_start"> ~ <input type="number" name="year_end"> <br>
    <input type="submit" value="검색">
</form>
```

#### **2단계: 고무줄 SQL 만들기 (PHP 핵심)**

여기가 제일 중요합니다. 조건이 있냐 없냐에 따라 SQL을 조립합니다.

1.  **기본 문장:** `SELECT ... WHERE 1=1` (이걸 써야 뒤에 무조건 `AND`를 붙일 수 있어서 편함)
2.  **제목 조건:** 값이 있으면(`!empty`) -\> `AND title LIKE ...` 붙이기.
3.  **연도 조건:** 값이 있으면 -\> `AND year >= ...` 붙이기.

<!-- end list -->

```php
<?php
// DB 연결 (공식처럼 외우세요)
$conn = oci_connect("c##학번", "비번", "localhost/xe");

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // 1. 기본 뼈대 (WHERE 1=1 꼼수 사용)
    $sql = "SELECT title, year, name FROM Movie, MovieExec 
            WHERE producerno = certno AND 1=1"; 

    // 2. 제목이 입력되었으면? 문장 이어붙이기 (.=)
    if (!empty($_POST['title'])) {
        $sql .= " AND title LIKE :bv_title"; // 바인드 변수 자리 확보
    }

    // 3. 시작 연도가 입력되었으면?
    if (!empty($_POST['year_start'])) {
        $sql .= " AND year >= :bv_year_s";
    }
```

#### **3단계: 실행하고 택배 받기 (`oci_fetch_all`)**

과제 조건에 \*\*"반드시 `oci_fetch_all` 사용"\*\*이 있었죠? 이게 그 부분입니다.

1.  `oci_parse`: 준비.
2.  `oci_bind_by_name`: 아까 뚫어둔 구멍(`:bv_title`)에 진짜 값 채우기.
3.  `oci_fetch_all`: 데이터 한방에 다 가져오기.

<!-- end list -->

```php
    $stmt = oci_parse($conn, $sql);

    // 구멍 채우기 (Binding)
    if (!empty($_POST['title'])) {
        $val = '%' . $_POST['title'] . '%'; // 와일드카드 추가
        oci_bind_by_name($stmt, ":bv_title", $val);
    }
    if (!empty($_POST['year_start'])) {
        oci_bind_by_name($stmt, ":bv_year_s", $_POST['year_start']);
    }

    oci_execute($stmt);

    // [핵심] 한방에 배열로 가져오기 (이 옵션을 써야 편함)
    $nrows = oci_fetch_all($stmt, $res, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);
```

#### **4단계: 표 뿌리기 (Loop)**

가져온 박스(`$res`) 개수만큼 반복문을 돌립니다.
여기서 **상세 페이지로 가는 링크**를 걸어주는 게 포인트입니다.

```php
    echo "<table border='1'>";
    for ($i = 0; $i < $nrows; $i++) {
        $row = $res[$i]; // 한 줄 꺼내기
        
        echo "<tr>";
        // 제목을 누르면 detail.php로 이동! (제목을 달고 감)
        echo "<td><a href='detail.php?t=" . $row['TITLE'] . "'>" . $row['TITLE'] . "</a></td>";
        echo "<td>" . $row['YEAR'] . "</td>";
        echo "<td>" . $row['NAME'] . "</td>";
        echo "</tr>";
    }
    echo "</table>";
} // if 끝
?>
```

-----

### 📂 2-2. 상세 페이지 (`detail.php`) 만들기

여기는 \*\*"칸 합치기(Rowspan)"\*\*가 핵심입니다. 실습 때 했던 `stars_array2.php` 로직을 그대로 씁니다.

**[논리 순서]**

1.  영화 정보(제목, 연도) 보여주기.
2.  이 영화의 **제작자** 찾기.
3.  그 제작자가 만든 **영화 개수 세기** (Rowspan 용).
4.  그 개수만큼 칸 합쳐서 이름 출력하고, 옆에 영화 목록 나열하기.

#### **1단계: 데이터 받기**

`search.php`에서 보낸 제목(`?t=...`)을 받습니다.

```php
<?php
$conn = oci_connect("c##학번", "비번", "localhost/xe");
$title = $_GET['t']; // 제목 받기

// 따옴표(') 처리 (SQL 에러 방지용 필수 코스)
$safe_title = str_replace("'", "''", $title);
```

#### **2단계: 제작자 찾기 & 영화 목록 가져오기**

이건 쿼리 두 번 날리기 귀찮으니까, 제작자가 만든 영화 목록을 싹 가져옵니다.

```php
// "이 영화의 제작자가 만든 모든 영화"를 찾는 쿼리
// (복잡해 보이지만 그냥 제작자 이름으로 조인한 겁니다)
$sql = "SELECT me.name, m.title, m.year 
        FROM Movie m, MovieExec me
        WHERE m.producerno = me.certno
        AND me.certno = (SELECT producerno FROM Movie WHERE title = '$safe_title')";

$stmt = oci_parse($conn, $sql);
oci_execute($stmt);
// 전체 데이터 가져오기
$nrows = oci_fetch_all($stmt, $res, 0, -1, OCI_FETCHSTATEMENT_BY_ROW);
```

#### **3단계: 표 합치기 (Rowspan) - 여기가 시험 문제\!**

데이터가 5개 왔다면, 제작자 이름은 5칸을 차지해야 합니다.

```php
echo "<table border='1'>";

// 데이터가 1개라도 있으면
if ($nrows > 0) {
    $producer_name = $res[0]['NAME']; // 제작자 이름은 다 똑같으니까 첫 번째 거 씀

    echo "<tr>";
    // [핵심] 전체 개수($nrows) 만큼 칸을 합침!
    echo "<td rowspan='$nrows'>$producer_name</td>";

    // 첫 번째 영화 출력
    echo "<td>" . $res[0]['TITLE'] . " (" . $res[0]['YEAR'] . ")</td>";
    echo "</tr>";

    // 두 번째 영화부터는 반복문으로 출력
    for ($i = 1; $i < $nrows; $i++) {
        echo "<tr>";
        // 제작자 칸은 이미 합쳐졌으니 출력 안 함! 영화 칸만 만듦.
        echo "<td>" . $res[$i]['TITLE'] . " (" . $res[$i]['YEAR'] . ")</td>";
        echo "</tr>";
    }
} else {
    echo "<tr><td>정보 없음</td></tr>";
}
echo "</table>";
?>
```

-----

### ✨ 요약: 빈 종이에 쓸 때 순서

**`search.php`**

1.  `<form>` 태그 씀.
2.  `SELECT ... WHERE 1=1` 씀.
3.  `if (!empty)` 로 `AND` 조건 붙임.
4.  `oci_parse` -\> `oci_bind` -\> `oci_execute`.
5.  `oci_fetch_all`로 받고 `for`문 돌림.

**`detail.php`**

1.  `$_GET['t']` 받음.
2.  쿼리 날려서 목록 가져옴 (`oci_fetch_all`).
3.  `rowspan`에 전체 개수(`$nrows`) 넣어서 제작자 출력.
4.  나머지 영화들은 `for`문(`$i=1`부터 시작)으로 출력.

특히 **`search.php`의 "고무줄 SQL"** 부분과, **`detail.php`의 "Rowspan"** 부분은 반드시 손으로 써보세요. 이 패턴만 알면 숫자나 컬럼 이름이 바뀌어도 다 풀 수 있습니다\!
