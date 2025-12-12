<?php
function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2020875015", "db59107669", "localhost/lecture");
if (!$conn) p_error();

// 입력값 받기
$title_in = isset($_POST['title']) ? $_POST['title'] : '';
$is_like = isset($_POST['is_like']);
$is_case = isset($_POST['is_case']);
$len_min = isset($_POST['len_min']) ? $_POST['len_min'] : '';
$len_max = isset($_POST['len_max']) ? $_POST['len_max'] : '';
$actor_birth = isset($_POST['actor_birth']) ? $_POST['actor_birth'] : '';
$gender = isset($_POST['gender']) ? $_POST['gender'] : '';

// WHERE절 만들기
$where_clauses = [];

if (!empty($title_in)) {
    $clean_title = str_replace("'", "''", $title_in);
    if ($is_like) {
        if ($is_case) $where_clauses[] = "m.title LIKE '%$clean_title%'";
        else $where_clauses[] = "LOWER(m.title) LIKE LOWER('%$clean_title%')";
    } else {
        if ($is_case) $where_clauses[] = "m.title = '$clean_title'";
        else $where_clauses[] = "LOWER(m.title) = LOWER('$clean_title')";
    }
}

if (!empty($len_min)) $where_clauses[] = "m.length >= $len_min";
if (!empty($len_max)) $where_clauses[] = "m.length <= $len_max";

if (!empty($actor_birth)) {
    $gender_cond = "";
    if ($gender == 'male') $gender_cond = "AND ms.gender = 'male'";
    if ($gender == 'female') $gender_cond = "AND ms.gender = 'female'";
    
    $sub_query = "EXISTS (
        SELECT 1 FROM starsin si, moviestar ms 
        WHERE si.movietitle = m.title 
        AND si.movieyear = m.year 
        AND si.starname = ms.name 
        AND to_char(ms.birthdate, 'YYYY') >= '$actor_birth'
        $gender_cond
    )";
    $where_clauses[] = $sub_query;
}

$where_sql = "";
if (count($where_clauses) > 0) {
    $where_sql = "WHERE " . implode(" AND ", $where_clauses) . " AND ";
} else {
    $where_sql = "WHERE ";
}

// 쿼리 실행 제목 가나다순, 연도 오름차순
$query = "SELECT m.title, m.year, me.name as producer, s.name as studio, s.address 
          FROM movie m, movieexec me, studio s 
          $where_sql 
          m.producerno = me.certno AND m.studioname = s.name
          ORDER BY m.title ASC, m.year ASC";

$stmt = oci_parse($conn, $query);
oci_execute($stmt);

$nrows = oci_fetch_all($stmt, $res, null, null, OCI_FETCHSTATEMENT_BY_ROW);

if ($nrows == 0) {
    print "<p align=center>검색 결과가 없습니다.</p>";
    exit;
}

// 스타일
print "<TABLE bgcolor=#abbcbabc border=1 cellspacing=2 width=100%>\n";
print "<TR bgcolor=#1ebcbabf align=center>
        <TH>영화제목</TH> <TH>개봉년도</TH> <TH>제작자</TH> <TH>영화사</TH> <TH>영화사 주소</TH>
       </TR>\n";

for ($i = 0; $i < $nrows; $i++) {
    $row = $res[$i];
    $d_title = $row['TITLE'];
    
    // LIKE 검색 시 하이라이트 
    if ($is_like && !empty($title_in)) {
        $d_title = preg_replace("/(".preg_quote($title_in, '/').")/i", "<span style='background-color:yellow;color:red'>$1</span>", $d_title);
    }

    print "<TR> 
            <TD> $d_title </TD> 
            <TD align=center> {$row['YEAR']}년 </TD> 
            <TD align=center> {$row['PRODUCER']} </TD> 
            <TD align=center> {$row['STUDIO']} </TD> 
            <TD> {$row['ADDRESS']} </TD> 
           </TR>\n";
}
print "</TABLE>\n";

oci_free_statement($stmt);
oci_close($conn);
?>