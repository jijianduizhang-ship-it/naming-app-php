# 快速启动指南

## 🎯 最快方式（推荐）

### 使用 HBuilderX（5分钟搞定）

1. **下载 HBuilderX**
   - 官网：https://www.dcloud.io/hbuilderx.html
   - 下载「App开发版」

2. **打开项目**
   - 解压 ruimingge-miniprogram.zip
   - 打开 HBuilderX
   - 文件 → 打开目录 → 选择 `miniprogram` 文件夹

3. **运行到微信**
   - 点击顶部菜单：运行 → 运行到小程序模拟器 → 微信开发者工具
   - 会自动打开微信开发者工具并编译

---

## 🔧 原生微信小程序方式（不推荐，需要转换）

由于当前是 uni-app 项目，如需原生开发，需要：

1. 安装依赖：`npm install`
2. 编译项目：`npm run dev:mp-weixin`
3. 在微信开发者工具中打开 `dist/dev/mp-weixin` 目录

---

## 📋 已有的页面

| 页面 | 路径 | 功能 |
|------|------|------|
| 首页 | pages/home/home | 首页展示 |
| 起名 | pages/naming/naming | 起名表单 |
| 结果 | pages/result/result | 起名结果 |
| 详情 | pages/name-detail/name-detail | 名字详情 |
| 历史 | pages/history/history | 历史记录 |
| 我的 | pages/profile/profile | 个人中心 |
| 兑换码 | pages/redeem/redeem | 兑换码 |
| 关于 | pages/about/about | 关于我们 |
| 知识 | pages/knowledge/knowledge | 起名知识 |

---

## 💡 提示

- 当前使用本地模拟数据，起名功能会生成预设的名字
- 实际使用需要修改 api/index.js 对接后端 API
- 在微信开发者工具中，记得勾选「不校验合法域名」

---

**如有问题，查看 README.md 获取更多信息！**
