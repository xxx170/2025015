<?php
function p_error($id=null) {
    if($id == null) $e = oci_error();
    else $e = oci_error($id);
    print htmlentities($e['message']);
    exit();
}

$conn = oci_connect("db2020875015", "db59107669", "localhost/lecture");
if (!$conn) p_error();

$name = $_GET['name'];
$name_sql = str_replace("'", "''", $name);

$query = "SELECT m.title, m.year, m.length, me.name as prodName
          FROM movie m, movieexec me 
          WHERE m.producerno = me.certno AND m.studioname = '$name_sql'
          ORDER BY m.year";

$stmt = oci_parse($conn, $query);
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error($stmt);

echo "<h3>[$name] 제작 영화</h3>";
print "<TABLE border=1 cellspacing=2 bgcolor=#eeffdd>\n";
print "<TR bgcolor=#ccddaa align=center><TH>제목<TH>개봉년도<TH>상영시간<TH>제작자</TR>\n";

while ($row = oci_fetch_array($stmt, OCI_ASSOC)) {
    print "<TR> <TD> {$row['TITLE']} <TD> {$row['YEAR']}년 <TD> {$row['LENGTH']}분"
                . "<TD> {$row['PRODNAME']} </TR>\n";
}
print "</TABLE>\n";
echo "<br><a href='2.php'>목록으로</a>";

oci_free_statement($stmt);
oci_close($conn);
?>