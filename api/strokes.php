<?php
/**
 * GET /api/strokes?chars=王,李,思
 * 代理到 Node.js strokes 服务
 */
header('Content-Type: application/json; charset=utf-8');

$chars = isset($_GET['chars']) ? $_GET['chars'] : '';
if (empty($chars)) {
    echo json_encode(['error' => '缺少 chars 参数'], JSON_UNESCAPED_UNICODE);
    exit;
}

$charList = array_slice(array_map('trim', explode(',', $chars)), 0, 20);
$cleanChars = [];
foreach ($charList as $c) {
    $c = preg_replace('/[^\x{4e00}-\x{9fa5}]/u', '', $c);
    if ($c !== '') $cleanChars[] = $c;
}
if (empty($cleanChars)) {
    echo json_encode(['error' => '无可用汉字'], JSON_UNESCAPED_UNICODE);
    exit;
}

$encoded = rawurlencode(implode(',', $cleanChars));
$ctx = stream_context_create(['http' => ['timeout' => 5]]);
$result = @file_get_contents("http://127.0.0.1:8087/?chars=" . $encoded, false, $ctx);
if ($result === false) {
    echo json_encode(['error' => '笔画服务不可用'], JSON_UNESCAPED_UNICODE);
    exit;
}
echo $result;
