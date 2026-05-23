<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { exit(0); }
$requestUri = $_SERVER['REQUEST_URI'];
$path = parse_url($requestUri, PHP_URL_PATH);
$path = preg_replace('#^/api#', '', $path);
$path = trim($path, '/');
if (strpos($path, 'article') === 0) { require __DIR__ . '/article.php'; exit; }
if ($path === 'save-record') { $_GET['action'] = 'record'; }
if (preg_match('#^admin/(\w+)(?:/(\d+))?(?:/(\w+))?$#', $path, $m)) {
    $adminFile = __DIR__ . '/admin/' . $m[1] . '.php';
    if (isset($m[2])) { $_GET['id'] = intval($m[2]); }
    if (isset($m[3])) { $_GET[$m[3]] = true; }
    if (file_exists($adminFile)) { require $adminFile; exit; }
}
$routes = [
    'login'=>'login.php','redeem'=>'redeem.php','ai-generate-names'=>'naming.php',
    'naming'=>'naming.php','save-record'=>'naming.php','admin/login'=>'admin/login.php',
    'admin/users'=>'admin/users.php','admin/codes'=>'admin/codes.php',
    'admin/records'=>'admin/records.php','admin/stats'=>'admin/stats.php',
    'admin/configs'=>'admin/configs.php',
];
if (isset($routes[$path])) { require __DIR__ . '/' . $routes[$path]; exit; }
http_response_code(404);
echo json_encode(['error'=>'接口不存在','path'=>$path]);
