<?php
/**
 * 兑换码兑换接口
 */
require_once __DIR__ . '/lib/db.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// GET: 返回兑换码列表（需要认证）
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    requireAuth();
    $conn = getDB();
    $codes = $conn->query("SELECT id, code, amount, max_use, used_count, status, expired_at, created_at FROM redeem_codes ORDER BY id ASC")->fetch_all(MYSQLI_ASSOC);
    $conn->close();
    json(['success' => true, 'list' => $codes]);
}

// POST: 兑换
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    json(['error' => '不支持的请求方法'], 405);
}

$data = getRequestBody();
$code = strtoupper($data['code'] ?? '');

if (!$code) {
    json(['success' => false, 'message' => '请输入兑换码'], 400);
}

// 内置兑换码
$builtinCodes = [
    'TESTVIP' => 10,
    'FREE666' => 5
];

if (isset($builtinCodes[$code])) {
    json(['success' => true, 'message' => '兑换成功', 'amount' => $builtinCodes[$code]]);
}

// 数据库查询
$conn = getDB();
$stmt = $conn->prepare('SELECT * FROM redeem_codes WHERE code = ? AND status = 1');
$stmt->bind_param('s', $code);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {
    if ($row['expired_at'] && strtotime($row['expired_at']) < time()) {
        json(['success' => false, 'message' => '兑换码已过期']);
    } elseif ($row['max_use'] > 0 && $row['used_count'] >= $row['max_use']) {
        json(['success' => false, 'message' => '兑换码已使用完']);
    } else {
        $update = $conn->prepare('UPDATE redeem_codes SET used_count = used_count + 1 WHERE id = ?');
        $update->bind_param('i', $row['id']);
        $update->execute();
        json(['success' => true, 'message' => '兑换成功', 'amount' => intval($row['amount'])]);
    }
}

json(['success' => false, 'message' => '兑换码无效']);

