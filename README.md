# 智能起名小程序 (PHP 版)

## 项目结构

```
naming-app-php/
├── api/
│   └── index.php    # PHP 后端 API
├── index.html       # 前端页面
├── admin.html       # 管理后台
└── README.md
```

## 部署说明

### 1. 环境要求
- PHP 7.4+
- MySQL 5.7+

### 2. 数据库
导入 `database.sql` 到 MySQL

### 3. 配置
修改 `api/index.php` 中的数据库配置：
```php
$config = [
    'host' => 'localhost',
    'username' => 'your_username',
    'password' => 'your_password',
    'database' => 'your_database'
];
```

### 4. 部署
将项目上传到服务器即可，前端静态文件可部署到任何静态托管服务。

## 功能
- 用户端：起名、兑换
- 管理后台：用户管理、兑换码管理、统计数据
