<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// 配置
$config = [
    'host' => '43.139.124.235',
    'username' => 'xingming',
    'password' => 'FY6KYSarpbEnYCFt',
    'database' => 'xingming'
];

// 获取请求路径
$requestUri = $_SERVER['REQUEST_URI'];
$path = parse_url($requestUri, PHP_URL_PATH);
$path = str_replace('/api/index.php', '', $path);
$path = trim($path, '/');

// 连接数据库
function getDB() {
    global $config;
    $conn = new mysqli($config['host'], $config['username'], $config['password'], $config['database']);
    if ($conn->connect_error) {
        die(json_encode(['error' => '数据库连接失败']));
    }
    $conn->set_charset('utf8mb4');
    return $conn;
}

// 登录
if (in_array($path, ['admin/login', 'login']) && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $username = $data['username'] ?? '';
    $password = $data['password'] ?? '';
    
    if (!$username || !$password) {
        echo json_encode(['error' => '请输入用户名和密码']);
        exit;
    }
    
    // 内置管理员
    $builtinAdmin = [
        'username' => 'admin',
        'password' => '$2b$10$x/mh8FfBDgFTXRjyewvjhegKvp9afwwBtv5sXD1SEzDajFe2zhce6'
    ];
    
    if ($username === $builtinAdmin['username'] && password_verify($password, $builtinAdmin['password'])) {
        $token = base64_encode(json_encode(['username' => $username, 'time' => time()]));
        echo json_encode(['token' => $token, 'username' => $username]);
        exit;
    }
    
    echo json_encode(['error' => '用户名或密码错误']);
    exit;
}

// 验证token
function verifyToken($token) {
    if (!$token) return false;
    $data = json_decode(base64_decode($token), true);
    return $data && isset($data['time']) && (time() - $data['time'] < 7 * 24 * 3600);
}

// 兑换接口
if ($path === 'redeem' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $code = strtoupper($data['code'] ?? '');
    
    if (!$code) {
        echo json_encode(['success' => false, 'message' => '请输入兑换码']);
        exit;
    }
    
    // 内置兑换码
    $builtinCodes = [
        'TESTVIP' => 10,
        'FREE666' => 5
    ];
    
    if (isset($builtinCodes[$code])) {
        echo json_encode(['success' => true, 'message' => '兑换成功', 'amount' => $builtinCodes[$code]]);
        exit;
    }
    
    // 数据库查询
    $conn = getDB();
    $stmt = $conn->prepare('SELECT * FROM redeem_codes WHERE code = ? AND status = 1');
    $stmt->bind_param('s', $code);
    $stmt->execute();
    $result = $stmt->get_result();
    
    if ($row = $result->fetch_assoc()) {
        if ($row['expired_at'] && strtotime($row['expired_at']) < time()) {
            echo json_encode(['success' => false, 'message' => '兑换码已过期']);
        } elseif ($row['max_use'] > 0 && $row['used_count'] >= $row['max_use']) {
            echo json_encode(['success' => false, 'message' => '兑换码已使用完']);
        } else {
            $update = $conn->prepare('UPDATE redeem_codes SET used_count = used_count + 1 WHERE id = ?');
            $update->bind_param('i', $row['id']);
            $update->execute();
            echo json_encode(['success' => true, 'message' => '兑换成功', 'amount' => $row['amount']]);
        }
    } else {
        echo json_encode(['success' => false, 'message' => '兑换码无效']);
    }
    $conn->close();
    exit;
}

// 管理后台接口需要验证
$token = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
$token = str_replace('Bearer ', '', $token);

if (strpos($path, 'admin/') === 0) {
    if (!verifyToken($token)) {
        echo json_encode(['error' => '未登录']);
        exit;
    }
}

// 获取用户列表
if ($path === 'admin/users' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $conn = getDB();
    $result = $conn->query('SELECT * FROM users ORDER BY created_at DESC LIMIT 100');
    $users = [];
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
    echo json_encode(['list' => $users, 'total' => count($users)]);
    $conn->close();
    exit;
}

// 获取兑换码列表
if ($path === 'admin/codes' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $conn = getDB();
    $result = $conn->query('SELECT rc.*, a.username as creator_name FROM redeem_codes rc LEFT JOIN admins a ON rc.created_by = a.id ORDER BY rc.created_at DESC LIMIT 100');
    $codes = [];
    while ($row = $result->fetch_assoc()) {
        $codes[] = $row;
    }
    echo json_encode(['list' => $codes, 'total' => count($codes)]);
    $conn->close();
    exit;
}

// 生成兑换码
if ($path === 'admin/codes' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);
    $amount = intval($data['amount'] ?? 10);
    $maxUse = intval($data['maxUse'] ?? 1);
    $count = intval($data['count'] ?? 1);
    
    $conn = getDB();
    $codes = [];
    
    for ($i = 0; $i < $count; $i++) {
        $code = generateCode();
        $stmt = $conn->prepare('INSERT INTO redeem_codes (code, amount, max_use, created_by) VALUES (?, ?, ?, 0)');
        $stmt->bind_param('sii', $code, $amount, $maxUse);
        $stmt->execute();
        $codes[] = ['code' => $code, 'amount' => $amount, 'max_use' => $maxUse];
    }
    
    echo json_encode(['success' => true, 'codes' => $codes]);
    $conn->close();
    exit;
}

// 获取统计数据
if ($path === 'admin/stats' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $conn = getDB();
    
    $users = $conn->query('SELECT COUNT(*) as total, SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) as active FROM users')->fetch_assoc();
    $codes = $conn->query('SELECT COUNT(*) as total, COALESCE(SUM(used_count), 0) as used FROM redeem_codes WHERE status = 1')->fetch_assoc();
    $records = $conn->query('SELECT COUNT(*) as total FROM name_records')->fetch_assoc();
    
    echo json_encode([
        'users' => ['total' => intval($users['total']), 'active' => intval($users['active']), 'disabled' => 0],
        'codes' => ['total' => intval($codes['total']), 'used' => intval($codes['used'])],
        'records' => ['total' => intval($records['total']), 'ai' => 0, 'local' => 0],
        'today' => ['records' => 0, 'users' => 0],
        'trend' => []
    ]);
    
    $conn->close();
    exit;
}

// 获取配置
if ($path === 'admin/configs' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $conn = getDB();
    $result = $conn->query('SELECT config_key, value FROM configs');
    $configs = [];
    while ($row = $result->fetch_assoc()) {
        $configs[$row['config_key']] = $row['value'];
    }
    echo json_encode($configs);
    $conn->close();
    exit;
}

// 生成随机码
function generateCode() {
    $chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    $code = '';
    for ($i = 0; $i < 8; $i++) {
        $code .= $chars[rand(0, strlen($chars) - 1)];
    }
    return $code;
}

// 默认
echo json_encode(['message' => '智能起名 API', 'path' => $path]);
