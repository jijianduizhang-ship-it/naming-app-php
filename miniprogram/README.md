# 瑞名阁 - 智能起名系统（微信小程序版）

基于 [瑞名阁官网](https://name.imoons.cn) 开发的微信小程序版本，使用 Vue3 + uni-app 框架实现。

## 📱 功能特性

- ✅ **首页**：展示核心功能、精选套餐、起名知识、用户好评
- ✅ **智能起名**：输入姓氏、性别、生日时辰、起名偏好，AI 为您生成好名
- ✅ **起名结果**：展示多个精选名字，支持收藏和查看详情
- ✅ **名字详情**：详细的名字分析，包括字义、五行、五格、诗词出处
- ✅ **历史记录**：保存所有起名记录，方便查看
- ✅ **个人中心**：用户信息、统计数据、功能入口
- ✅ **兑换码**：使用兑换码增加起名次数
- ✅ **起名知识**：丰富的起名知识文章

## 📂 项目结构

```
miniprogram/
├── api/
│   └── index.js                # API 接口封装
├── pages/
│   ├── about/                  # 关于我们页
│   ├── history/                # 历史记录页
│   ├── home/                   # 首页
│   ├── knowledge/              # 起名知识页
│   ├── name-detail/            # 名字详情页
│   ├── naming/                 # 起名页
│   ├── profile/                # 个人中心页
│   ├── redeem/                 # 兑换码页
│   └── result/                 # 结果页
├── static/
│   └── css/
│       └── common.css          # 全局通用样式
├── utils/
│   └── index.js                # 工具函数
├── App.vue                     # 小程序入口组件
├── main.js                     # 入口文件
├── manifest.json               # 应用配置
├── pages.json                  # 页面路由配置
├── package.json                # 依赖配置
└── README.md                   # 项目说明
```

## 🎨 设计规范

- **主色调**：`#C41E3A`（酒红）、`#E8837C`（浅粉）
- **背景色**：`#F5F0EB`
- **卡片圆角**：`28rpx`
- **字体**：系统默认字体，支持 Noto Sans SC 和 Noto Serif SC
- **图标**：使用 emoji 图标，避免外部依赖

## 🚀 快速开始

### 环境要求

- Node.js 14+
- HBuilderX 3.6+ 或 Vue CLI

### 开发步骤

1. **安装依赖**
   ```bash
   cd miniprogram
   npm install
   ```

2. **HBuilderX 开发**
   - 使用 HBuilderX 打开项目
   - 运行到微信开发者工具

3. **使用 Vue CLI 开发**
   ```bash
   # 微信小程序
   npm run dev:mp-weixin
   
   # 构建生产版本
   npm run build:mp-weixin
   ```

4. **微信开发者工具**
   - 打开微信开发者工具
   - 导入项目，选择 `dist/dev/mp-weixin` 或 `dist/build/mp-weixin` 目录
   - 填写 AppID（测试可使用测试号）

## 📱 页面说明

### 1. 首页 (home)
- 展示核心功能入口
- 精选套餐介绍
- 起名知识文章列表
- 用户好评展示

### 2. 起名页 (naming)
- 输入宝宝信息（姓氏、性别、名字字数）
- 选择出生日期和时辰
- 选择起名偏好
- 提交生成

### 3. 结果页 (result)
- 展示生成的名字列表
- 显示名字评分和含义
- 支持收藏功能
- 点击查看详情

### 4. 名字详情页 (name-detail)
- 详细的名字分析
- 字义解释
- 五行属性
- 五格数理
- 诗词出处

### 5. 历史记录页 (history)
- 展示所有历史起名记录
- 支持删除操作
- 按时间倒序排列

### 6. 个人中心页 (profile)
- 用户信息展示
- 统计数据（起名次数、收藏数、兑换数）
- 功能菜单

### 7. 兑换码页 (redeem)
- 显示剩余次数
- 输入兑换码
- 兑换历史记录

### 8. 关于页 (about)
- 品牌介绍
- 功能特点
- 联系方式

### 9. 起名知识页 (knowledge)
- 搜索功能
- 分类筛选
- 文章列表

## 🔧 技术栈

- **框架**：Vue 3 + uni-app
- **样式**：原生 CSS + rpx 响应式单位
- **存储**：uni-app 本地存储 API
- **路由**：uni-app 页面路由
- **组件**：uni-app 内置组件

## 💾 数据存储

使用 uni-app 本地存储 API 进行数据管理：

```javascript
// 存储起名记录
uni.setStorageSync('name_records', records);

// 存储剩余次数
uni.setStorageSync('naming_credits', credits);

// 存储兑换历史
uni.setStorageSync('redeem_history', history);
```

## 🔌 API 接口说明

在 `api/index.js` 中封装了 API 接口调用，当前为本地模拟数据，实际使用时需替换为真实后端接口：

- `getArticles()` - 获取文章列表
- `login()` - 登录
- `redeemCode()` - 兑换码兑换
- `naming()` - 发起起名请求
- `saveRecord()` - 保存记录

## 📄 许可证

MIT License

## 📞 联系我们

- 官网：https://name.imoons.cn
- 邮箱：support@imoons.cn

---

**温馨提示**：本项目为演示版本，起名功能使用本地模拟数据，实际使用需要对接后端 API。
