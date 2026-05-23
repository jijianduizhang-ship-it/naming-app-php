# 瑞名阁智能起名系统 - 部署文档

> **name.imoons.cn** — 基于八字五行分析的智能起名平台
> 前端：HTML + JS（移动端优先）| 后端：PHP + MySQL | AI：DeepSeek

---

## 环境要求

| 软件 | 版本 | 说明 |
|------|------|------|
| Nginx | ≥ 1.18 | Web 服务器，反代 PHP-FPM |
| PHP | ≥ 8.0 | FastCGI 进程管理器 |
| MySQL | ≥ 5.7 | 数据库 |
| Node.js | ≥ 16 | 笔画计算微服务（可选） |
| Composer | ≥ 2 | PHP 依赖管理 |

---

## 目录结构

```
name.imoons.cn/
├── .env.example              # 环境变量示例
├── .gitignore                # Git 忽略配置
├── README.md                  # 本文档
├── index.html               # 单页应用入口（移动端）
├── admin.html               # 后台管理系统
├── info.php                 # PHP 环境信息页
├── strokes_server.js        # Node.js 笔画计算服务
├── api/                     # API 路由目录
│   ├── index.php            # 自路由入口（Nginx URL 重写）
│   ├── lib/db.php          # 数据库连接
│   ├── login.php           # 登录认证
│   ├── naming.php          # 起名核心逻辑（八字+AI）
│   ├── redeem.php          # 兑换码
│   ├── strokes.php         # 笔画查询代理（调用内网微服务）
│   ├── article.php         # 知识文章 CRUD
│   ├── composer.json       # PHP 依赖声明
│   ├── vendor/             # Composer 依赖（6tail/lunar-php）
│   └── admin/              # 后台管理 API（需认证）
│       ├── codes.php       # 兑换码管理
│       ├── configs.php     # 系统配置（AI Key 等）
│       ├── records.php     # 起名记录管理
│       ├── stats.php       # 统计数据
│       └── users.php       # 用户管理
├── pages/                  # 页面路由
│   ├── home.html           # 首页
│   ├── naming.html         # 起名表单
│   ├── result.html         # 结果展示
│   ├── name-detail.html    # 名字详情（三才五格）
│   ├── history.html        # 历史记录
│   ├── profile.html        # 个人中心
│   ├── redeem.html         # 兑换码
│   ├── knowledge.html      # 知识文章列表
│   └── about.html          # 关于我们
└── deployment/             # 部署相关文件
    └── init.sql            # 数据库初始化脚本
```

---

## 一、数据库初始化

### 1.1 创建数据库和用户

```sql
CREATE DATABASE `name_imoons_cn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'name_imoons_cn'@'localhost' IDENTIFIED BY 'your_password';
CREATE USER 'name_imoons_cn'@'127.0.0.1' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON `name_imoons_cn`.* TO 'name_imoons_cn'@'localhost';
GRANT ALL PRIVILEGES ON `name_imoons_cn`.* TO 'name_imoons_cn'@'127.0.0.1';
FLUSH PRIVILEGES;
```

### 1.2 导入初始化脚本

```bash
mysql -uname_imoons_cn -p name_imoons_cn < deployment/init.sql
```

### 1.3 表结构说明

| 表名 | 说明 |
|------|------|
| `name_records` | 起名记录（含八字、名字、五行、喜忌） |
| `redeem_codes` | 兑换码 |
| `ai_configs` | AI 配置（API URL / Key / 模型） |
| `users` | 用户表（预留，当前为空） |
| `knowledge_articles` | 知识文章 |

---

## 二、PHP 依赖安装

```bash
cd /www/wwwroot/name.imoons.cn/api
composer install
```

> 注意：`composer.json` 已声明依赖 `6tail/lunar-php`，用于精确八字计算。

---

## 三、nginx 配置

### 虚拟主机配置（`/etc/nginx/conf.d/name.imoons.cn.conf`）

```nginx
server {
    listen 80;
    server_name name.imoons.cn;
    root /www/wwwroot/name.imoons.cn;
    index index.html index.php;

    # 字符编码
    charset utf-8;

    # API 请求转发至 PHP-FPM
    location /api/ {
        try_files $uri $uri/ /api/index.php?$query_string;
    }

    # HTML 页面路由（全部指向 index.html 单页应用）
    location / {
        try_files $uri $uri/ /index.html;
    }

    # PHP-FPM 配置（TCP 模式）
    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
        fastcgi_read_timeout 300;
    }

    # 禁止访问敏感文件
    location ~ /\.env {
        deny all;
    }
    location ~ /\.git {
        deny all;
    }
}
```

> **重要**：PHP-FPM 必须监听 `127.0.0.1:9000`（TCP），不要用 Unix socket。

### PHP-FPM 配置（`/www/server/php/80/etc/php-fpm.conf`）

```ini
[www]
listen = 127.0.0.1:9000
```

### 验证并重载

```bash
nginx -t && nginx -s reload
```

---

## 四、笔画计算服务（可选）

系统支持两种笔画数据来源：

### 方案 A：Node.js 微服务（推荐，已实现）

```bash
# 安装依赖
cd /www/wwwroot/name.imoons.cn
npm install hanzi --save

# 启动服务（后台运行）
node strokes_server.js &

# 设置开机自启（systemd）
# 见 deployment/strokes.service
systemctl daemon-reload
systemctl enable strokes
systemctl start strokes
```

> 笔画服务监听 `127.0.0.1:8087`，由 `api/strokes.php` 通过 `file_get_contents` 代理调用。

### 方案 B：纯前端（需修改 `name-detail.html`）

移除笔画 API 调用，直接在前端引入 `hanzi` npm 包。

---

## 五、系统配置

### 5.1 AI 配置（后台管理）

后台访问：`https://name.imoons.cn/admin.html`
默认账号：`admin` / `admin123`

在 **系统配置** 页面填入：
- API 地址：`https://api.deepseek.com/v1/chat/completions`
- API Key：你的 DeepSeek API Key
- 模型：`deepseek-chat`

### 5.2 环境变量（可选）

如使用 `.env` 文件，复制 `.env.example` 为 `.env` 并填入真实值。

---

## 六、API 接口一览

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| `POST` | `/api/naming` | AI 生成名字 | ✗ |
| `POST` | `/api/naming?action=record` | 保存起名记录 | ✗ |
| `POST` | `/api/login` | 管理员登录 | ✗ |
| `POST` | `/api/redeem` | 兑换码兑换 | ✗ |
| `GET` | `/api/redeem` | 兑换码列表 | ✓ |
| `GET` | `/api/article` | 文章列表 | ✗ |
| `POST` | `/api/article` | 创建文章 | ✓ |
| `PUT` | `/api/article` | 更新文章 | ✓ |
| `DELETE` | `/api/article` | 删除文章 | ✓ |
| `GET` | `/api/admin/stats` | 统计数据 | ✓ |
| `GET` | `/api/admin/records` | 起名记录 | ✓ |
| `GET` | `/api/admin/codes` | 兑换码管理 | ✓ |
| `GET` | `/api/admin/configs` | 系统配置 | ✓ |
| `PUT` | `/api/admin/configs` | 更新配置 | ✓ |
| `GET` | `/api/admin/users` | 用户列表 | ✓ |
| `GET` | `/api/strokes` | 查询汉字笔画 | ✗ |

---

## 七、日常维护

### 查看服务状态

```bash
# Nginx
nginx -v

# PHP-FPM
systemctl status php-fpm-80

# 笔画微服务
systemctl status strokes

# MySQL
systemctl status mysqld
```

### 日志位置

| 服务 | 路径 |
|------|------|
| Nginx 错误日志 | `/www/server/nginx/logs/error.log` |
| PHP-FPM 日志 | `/www/server/php/80/logs/` |
| MySQL 日志 | `/www/server/mysql/log/` |

### 备份数据库

```bash
mysqldump -uname_imoons_cn -p name_imoons_cn > backup_$(date +%Y%m%d).sql
```

---

## 八、已知限制

1. **喜用神算法为简化版** — 仅用天干地支计数+日主强弱评分（阈值≥2.0），不含月令权重和特殊格局判断，与专业万年历结果可能存在差异。
2. **前端农历计算不精确** — 前端 `lunar@2.0.0` 库计算农历日期有误差（±13天），八字由后端精确计算，前端仅用于生肖展示。
3. **收藏功能本地存储** — `toggleFav()` 存 `localStorage`，换设备/清缓存会丢失。
4. **users 表为空** — 系统未实现用户注册，积分体系依赖 localStorage。

---

## 九、快速验证

```bash
# 1. 验证 API 可用
curl -X POST http://name.imoons.cn/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'

# 2. 验证起名生成
curl -X POST http://name.imoons.cn/api/naming \
  -H "Content-Type: application/json" \
  -d '{"surname":"王","birthday":"2025-01-17","birthday_time":"21:25","sex":"男","nameLength":2}'

# 3. 验证笔画服务
curl "http://name.imoons.cn/api/strokes.php?chars=王,李"
```
