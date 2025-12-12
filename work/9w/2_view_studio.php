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

$query = "SELECT s.name, s.address, me.name as boss, me.address as boss_addr, me.networth 
          FROM studio s, movieexec me 
          WHERE s.presno = me.certno AND s.name = '$name_sql'";

$stmt = oci_parse($conn, $query);
if (!$stmt) p_error($conn);

$r = oci_execute($stmt);
if (!$r) p_error($stmt);

$row = oci_fetch_array($stmt, OCI_ASSOC);

echo "<h3>[$name] 영화사 정보</h3>";
if ($row) {
    echo "<ul>";
    echo "<li><b>영화사:</b> {$row['NAME']}</li>";
    echo "<li><b>주소:</b> {$row['ADDRESS']}</li>";
    echo "<li><b>사장:</b> <font color=blue>{$row['BOSS']}</font></li>";
    echo "<li><b>사장 주소:</b> {$row['BOSS_ADDR']}</li>";
    echo "<li><b>재산:</b> $" . number_format($row['NETWORTH']) . "</li>";
    echo "</ul>";
} else {
    echo "<p>정보를 찾을 수 없습니다.</p>";
}
echo "<br><a href='2.php'>목록으로</a>";

oci_free_statement($stmt);
oci_close($conn);
?>