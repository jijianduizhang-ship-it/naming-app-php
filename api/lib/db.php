<?php
/**
 * 公共函数库
 */

$config = [
    'host'     => '127.0.0.1',
    'username' => 'name_imoons_cn',
    'password' => '1AXKX9RmJcDYGQ42',
    'database' => 'name_imoons_cn'
];

function getDB() {
    global $config;
    $conn = new mysqli($config['host'], $config['username'], $config['password'], $config['database']);
    if ($conn->connect_error) {
        http_response_code(500);
        echo json_encode(['error' => '数据库连接失败']);
        exit;
    }
    $conn->set_charset('utf8mb4');
    return $conn;
}

function verifyToken($token) {
    if (!$token) return false;
    $data = json_decode(base64_decode($token), true);
    return $data && isset($data['time']) && (time() - $data['time'] < 7 * 24 * 3600);
}

function generateCode($length = 8) {
    $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    $code = '';
    for ($i = 0; $i < $length; $i++) {
        $code .= $chars[rand(0, strlen($chars) - 1)];
    }
    return $code;
}

function requireAuth() {
    $token = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
    $token = str_replace('Bearer ', '', $token);
    if (!verifyToken($token)) {
        http_response_code(401);
        echo json_encode(['error' => '未登录']);
        exit;
    }
    return $token;
}

function getRequestBody() {
    return json_decode(file_get_contents('php://input'), true) ?? [];
}

function json($data, $code = 200) {
    http_response_code($code);
    echo json_encode($data);
    exit;
}
