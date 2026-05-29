# 瑞名阁 - 微信小程序

## 项目简介

瑞名阁是一款智能起名微信小程序，融合传统命理学与现代科技，为宝宝提供专业的起名服务。

## 快速开始

### 1. 导入项目

使用微信开发者工具打开此项目目录。

### 2. 配置AppID

在 `project.config.json` 中配置你的小程序 AppID。

### 3. 准备图标

在 `images` 目录下放置 tabBar 需要的图标，或临时注释掉 `app.json` 中的 tabBar 配置。

### 4. 运行项目

点击微信开发者工具的编译按钮即可预览。

## 项目结构

```
ruimingge-miniprogram-native/
├── app.js                 # 小程序入口
├── app.json              # 全局配置
├── app.wxss              # 全局样式
├── project.config.json   # 项目配置
├── sitemap.json          # 站点地图
├── utils/
│   └── index.js          # 工具函数
├── pages/
│   ├── home/             # 首页
│   ├── naming/           # 起名页
│   ├── result/           # 结果页
│   ├── name-detail/      # 详情页
│   ├── history/          # 记录页
│   ├── profile/          # 个人中心
│   ├── redeem/           # 兑换码
│   ├── about/            # 关于我们
│   └── knowledge/        # 知识页
└── images/               # 图标资源
```

## 功能说明

- 智能起名：根据姓氏、性别、生辰八字等生成好名字
- 名字详情：查看名字的寓意、五行、评分等详细信息
- 历史记录：保存历史起名记录，支持收藏
- 兑换码：通过兑换码获取起名次数
- 个人中心：管理个人信息，查看剩余次数
- 起名知识：了解更多起名相关知识

## 测试兑换码

- `TEST` - 兑换3次免费机会
- 任意6位以上字符 - 兑换1次机会

## 开发说明

当前使用本地模拟数据，实际开发时可替换 `utils/index.js` 中的接口对接真实后端。

## 技术栈

- 微信小程序原生开发
- WXML + WXSS + JavaScript

## 许可

MIT License
