# 瑞名阁 - 智能起名系统

在线体验：https://name.imoons.cn

## 项目结构

```
name.imoons.cn/
├── index.html              # 首页
├── admin.html              # 管理后台
├── pages/                  # 业务页面
│   ├── home.html           # 首页（与根 index.html 共用）
│   ├── naming.html         # 起名页
│   ├── result.html         # 结果页
│   ├── name-detail.html    # 名字详情页
│   ├── history.html        # 起名记录
│   ├── profile.html        # 个人中心
│   ├── redeem.html         # 兑换码
│   ├── about.html          # 关于我们
│   └── knowledge.html       # 起名知识（文章列表/详情）
├── api/                    # 后端 API
│   ├── index.php           # 路由入口
│   ├── lib/db.php           # 数据库公共函数
│   ├── login.php           # 登录
│   ├── redeem.php          # 兑换码兑换
│   ├── naming.php          # AI 起名（含保存记录）
│   ├── article.php          # 文章
│   ├── admin/
│   │   ├── login.php       # 后台登录
│   │   ├── stats.php       # 数据统计
│   │   ├── users.php       # 用户管理
│   │   ├── codes.php       # 兑换码管理
│   │   ├── records.php     # 起名记录
│   │   └── configs.php     # 系统配置
│   └── knowledge.php        # 起名知识
├── info.php                # 探针页
└── README.md
```

## 功能

### 用户端
- **首页**：展示起名知识文章
- **智能起名**：输入姓氏、性别、出生日期时辰，AI 分析八字五行、喜用神，生成符合命理的好名字
  - 支持 2 字名（单名）和 3 字名（双名）自由切换
  - 基于 DeepSeek AI 生成
  - 扣减兑换次数
- **兑换码**：输入兑换码增加起名次数，支持叠加
- **起名记录**：查看历史起名结果

### 管理后台
- **数据概览**：总用户数、总起名次数、今日数据、兑换码总量
- **用户管理**：查看普通用户列表、可用次数、启用/禁用
- **兑换码管理**：生成、编辑、启用/禁用兑换码
  - 支持自定义兑换次数、最大使用次数、过期时间
  - 支持批量生成
- **起名记录**：查看所有起名历史
- **起名知识**：文章管理（后台暂无编辑功能，暂通过数据库直接维护）
- **系统配置**：AI API Key、AI 模型、AI 接口地址

## API

| 接口 | 方法 | 说明 | 认证 |
|------|------|------|------|
| `/api/login` | POST | 登录 |
| `/api/redeem` | POST | 兑换码兑换 |
| `/api/naming` | POST | AI 生成名字 |
| `/api/article/{id}` | GET | 文章详情 |
| `/api/knowledge` | GET | 文章列表 |
| `/api/admin/stats` | GET | 数据统计 | admin |
| `/api/admin/users` | GET | 用户列表 | admin |
| `/api/admin/users/{id}?toggle` | POST | 启用/禁用用户 | admin |
| `/api/admin/codes` | GET/POST | 兑换码列表/生成 | admin |
| `/api/admin/codes/{id}?toggle` | POST | 启用/禁用兑换码 | admin |
| `/api/admin/codes/{id}` | PUT | 编辑兑换码 | admin |
| `/api/admin/configs` | GET/PUT/POST | 系统配置 | admin |

## 数据库

主要表：

| 表名 | 说明 |
|------|------|
| `users` | 普通用户（credits 余额） |
| `admins` | 管理员账号 |
| `redeem_codes` | 兑换码（amount/used_count/max_use/expired_at） |
| `name_records` | 起名记录 |
| `articles` | 起名知识文章 |
| `configs` | 系统配置（AI API Key 等） |

## 部署

- 域名：name.imoons.cn
- 框架：原生 PHP + MySQL + 静态 HTML/JS
- PHP-FPM：127.0.0.1:9000
- 数据库：name_imoons_cn
