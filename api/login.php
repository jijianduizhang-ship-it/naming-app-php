<?php
/**
 * 管理员登录
 */
require_once __DIR__ . '/lib/db.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    json(['error' => '不支持的请求方法'], 405);
}

$data = getRequestBody();
$username = $data['username'] ?? '';
$password = $data['password'] ?? '';

if (!$username || !$password) {
    json(['error' => '请输入用户名和密码'], 400);
}

$builtinAdmin = [
    'username' => 'admin',
    'password' => '$2b$10$x/mh8FfBDgFTXRjyewvjhegKvp9afwwBtv5sXD1SEzDajFe2zhce6'
];

if ($username === $builtinAdmin['username'] && password_verify($password, $builtinAdmin['password'])) {
    $token = base64_encode(json_encode(['username' => $username, 'time' => time()]));
    json(['token' => $token, 'username' => $username]);
}

json(['error' => '用户名或密码错误'], 401);
