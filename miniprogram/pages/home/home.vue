<template>
    <view class="page-container pb-20">
        <!-- 顶部渐变区域 -->
        <view class="gradient-header">
            <view class="header-content relative z-10">
                <view class="header-top flex items-center justify-between">
                    <view class="flex items-center space-x-2">
                        <view class="logo-icon">
                            <text class="logo-text">☯</text>
                        </view>
                        <text class="app-name">瑞名阁</text>
                    </view>
                    <view class="flex items-center space-x-3">
                        <view class="icon-btn">
                            <text class="icon-text">🔔</text>
                        </view>
                        <view class="avatar">
                            <image src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&h=100&fit=crop&crop=face" class="avatar-img" mode="aspectFill" />
                        </view>
                    </view>
                </view>
                <view class="slogan text-center">
                    <view class="badge">
                        <text class="badge-text">✨ 传承千年 · 赐名有道 ✨</text>
                    </view>
                    <view class="main-title">
                        <text>生辰八字</text>
                        <text>起名指南</text>
                    </view>
                    <text class="subtitle">融合传统命理与现代美学</text>
                    <text class="subtitle">为宝宝甄选吉祥美名</text>
                </view>
            </view>
            <view class="cloud-pattern"></view>
        </view>

        <!-- 快速起名入口 -->
        <view class="quick-naming -mt-16 relative z-10 px-5 mb-5">
            <view class="card">
                <view class="flex items-center justify-between mb-4">
                    <view>
                        <text class="section-title">开始起名</text>
                        <text class="section-subtitle">输入宝宝信息，获取专属好名</text>
                    </view>
                    <view class="feature-icon-primary">
                        <text class="icon-text">✒️</text>
                    </view>
                </view>
                <button class="btn-primary w-full" @click="goNaming">
                    <text class="btn-text">✨ 立即为宝宝起名</text>
                    <text class="btn-arrow">→</text>
                </button>
            </view>
        </view>

        <!-- 功能特色 -->
        <view class="px-5 mb-5">
            <view class="flex items-center justify-between mb-3">
                <text class="section-title">核心特色</text>
                <text class="link-text">了解更多 →</text>
            </view>
            <view class="grid grid-cols-4 gap-3">
                <view class="feature-item" v-for="(item, index) in features" :key="index">
                    <view class="feature-icon" :style="{ background: item.bg, color: item.color }">
                        <text class="icon-text">{{ item.icon }}</text>
                    </view>
                    <text class="feature-text">{{ item.name }}</text>
                </view>
            </view>
        </view>

        <!-- 精选套餐 -->
        <view class="px-5 mb-5">
            <view class="flex items-center justify-between mb-3">
                <text class="section-title">精选套餐</text>
                <text class="link-text">全部套餐 →</text>
            </view>
            <scroll-view class="package-scroll" scroll-x="true" show-scrollbar="false">
                <view class="package-list flex">
                    <view class="package-item" v-for="(pkg, index) in packages" :key="index">
                        <view class="package-tag" v-if="pkg.hot">
                            <text class="tag-text">{{ pkg.hot }}</text>
                        </view>
                        <view class="package-header flex items-center justify-between mb-3">
                            <view class="package-badge" :style="{ background: pkg.badgeBg }">
                                <text class="badge-text">{{ pkg.badge }}</text>
                            </view>
                            <text class="package-icon">{{ pkg.icon }}</text>
                        </view>
                        <text class="package-name">{{ pkg.name }}</text>
                        <text class="package-desc">{{ pkg.desc }}</text>
                        <view class="flex items-baseline mt-2">
                            <text class="package-price">{{ pkg.price }}</text>
                            <text class="package-original">{{ pkg.original }}</text>
                        </view>
                    </view>
                </view>
            </scroll-view>
        </view>

        <!-- 起名知识 -->
        <view class="px-5 mb-5">
            <view class="flex items-center justify-between mb-3">
                <text class="section-title">起名知识</text>
                <text class="link-text" @click="goKnowledge">更多 →</text>
            </view>
            <view class="space-y-3">
                <view class="article-item" v-for="(article, index) in articles" :key="index" @click="goArticleDetail(article.id)">
                    <image :src="article.cover" class="article-img" mode="aspectFill" />
                    <view class="article-content flex-1 flex flex-col justify-between">
                        <text class="article-title">{{ article.title }}</text>
                        <view class="flex items-center space-x-2">
                            <text class="article-meta">
                                <text class="meta-icon">👁️</text> {{ article.views }}
                            </text>
                            <text class="article-meta">
                                <text class="meta-icon">❤️</text> {{ article.likes }}
                            </text>
                        </view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 用户好评 -->
        <view class="px-5 mb-5">
            <view class="flex items-center justify-between mb-3">
                <text class="section-title">用户好评</text>
                <view class="flex items-center space-x-1">
                    <text class="star-icon">⭐</text>
                    <text class="star-icon">⭐</text>
                    <text class="star-icon">⭐</text>
                    <text class="star-icon">⭐</text>
                    <text class="star-icon">⭐</text>
                    <text class="rating-text">4.9分</text>
                </view>
            </view>
            <view class="card">
                <view class="flex items-start space-x-3">
                    <image src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80&h=80&fit=crop&crop=face" class="user-avatar" mode="aspectFill" />
                    <view class="flex-1">
                        <view class="flex items-center justify-between">
                            <text class="user-name">小宝妈咪</text>
                            <text class="review-time">3天前</text>
                        </view>
                        <view class="flex items-center space-x-1 my-1">
                            <text class="star-icon">⭐</text>
                            <text class="star-icon">⭐</text>
                            <text class="star-icon">⭐</text>
                            <text class="star-icon">⭐</text>
                            <text class="star-icon">⭐</text>
                        </view>
                        <text class="review-content">分析得非常详细，每个名字都有出处和寓意，最终选了"沐辰"这个名字，家人都很喜欢！</text>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { formatNumber } from '../../utils/index';

const features = ref([
    { icon: '☯', name: '八字分析', bg: '#fef7ee', color: '#ee7711' },
    { icon: '🔥', name: '五行平衡', bg: '#fffbeb', color: '#f59e0b' },
    { icon: '✍️', name: '笔画吉凶', bg: '#ecfdf5', color: '#10b981' },
    { icon: '📖', name: '诗词典故', bg: '#faf5ff', color: '#a855f7' }
]);

const packages = ref([
    {
        hot: '热门',
        badge: '经典',
        badgeBg: '#ee7711',
        name: '经典起名',
        desc: '3组精选名字\n含八字分析',
        price: '¥29',
        original: '¥59',
        icon: '👑'
    },
    {
        hot: '推荐',
        badge: '精品',
        badgeBg: '#f59e0b',
        name: '臻选起名',
        desc: '8组精选名字\n完整命理报告',
        price: '¥59',
        original: '¥99',
        icon: '💎'
    },
    {
        badge: '尊享',
        badgeBg: '#a855f7',
        name: '大师起名',
        desc: '15组精选名字\n一对一解读',
        price: '¥99',
        original: '¥199',
        icon: '💠'
    }
]);

const articles = ref([
    {
        id: 1,
        title: '2024龙年宝宝起名技巧与注意事项',
        cover: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=200&h=150&fit=crop',
        views: 1234,
        likes: 234
    },
    {
        id: 2,
        title: '如何根据五行八字为宝宝选个好名字',
        cover: 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=200&h=150&fit=crop',
        views: 987,
        likes: 189
    }
]);

onMounted(() => {
    articles.value.forEach(article => {
        article.views = formatNumber(article.views);
        article.likes = formatNumber(article.likes);
    });
});

const goNaming = () => {
    uni.switchTab({
        url: '/pages/naming/naming'
    });
};

const goKnowledge = () => {
    uni.navigateTo({
        url: '/pages/knowledge/knowledge'
    });
};

const goArticleDetail = (id) => {
    uni.navigateTo({
        url: `/pages/knowledge/knowledge?id=${id}`
    });
};
</script>

<style scoped>
.page-container {
    min-height: 100vh;
    background: #F5F0EB;
}

.gradient-header {
    background: linear-gradient(135deg, #8B1A1A 0%, #C41E3A 40%, #D4456A 70%, #E8837C 100%);
    position: relative;
    overflow: hidden;
    padding-top: 80rpx;
    padding-bottom: 160rpx;
}

.gradient-header::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 60%);
    animation: shimmer 8s ease-in-out infinite;
}

@keyframes shimmer {
    0%, 100% { transform: translate(0, 0); }
    50% { transform: translate(10%, 10%); }
}

.header-content {
    padding: 0 30rpx;
}

.header-top {
    margin-bottom: 60rpx;
}

.logo-icon {
    width: 72rpx;
    height: 72rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 24rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.logo-text {
    color: white;
    font-size: 36rpx;
}

.app-name {
    color: white;
    font-size: 36rpx;
    font-weight: 700;
}

.icon-btn, .avatar {
    width: 72rpx;
    height: 72rpx;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.icon-text {
    color: white;
    font-size: 28rpx;
}

.avatar-img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
}

.slogan {
    margin-top: 40rpx;
}

.badge {
    display: inline-block;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 30rpx;
    padding: 8rpx 24rpx;
    margin-bottom: 24rpx;
}

.badge-text {
    color: rgba(255, 255, 255, 0.9);
    font-size: 24rpx;
    letter-spacing: 2rpx;
}

.main-title {
    display: block;
    margin-bottom: 16rpx;
}

.main-title text {
    display: block;
    color: white;
    font-size: 44rpx;
    font-weight: 700;
    line-height: 1.4;
}

.subtitle {
    display: block;
    color: rgba(255, 255, 255, 0.75);
    font-size: 28rpx;
    line-height: 1.6;
}

.cloud-pattern {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 120rpx;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1200 120'%3E%3Cpath d='M0,80 C200,40 400,100 600,60 C800,20 1000,80 1200,50 L1200,120 L0,120 Z' fill='%23F5F0EB'/%3E%3C/svg%3E");
    background-repeat: repeat-x;
    background-size: 1200rpx 120rpx;
}

.section-title {
    font-size: 32rpx;
    font-weight: 700;
    color: #634d42;
}

.section-subtitle {
    display: block;
    font-size: 24rpx;
    color: #b09478;
    margin-top: 4rpx;
}

.link-text {
    font-size: 24rpx;
    color: #ee7711;
}

.feature-icon-primary {
    width: 96rpx;
    height: 96rpx;
    background: linear-gradient(135deg, #ee7711, #f19333);
    border-radius: 28rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8rpx 32rpx rgba(238, 119, 17, 0.2);
}

.btn-text {
    font-size: 28rpx;
    font-weight: 500;
}

.btn-arrow {
    margin-left: 8rpx;
    opacity: 0.7;
}

.grid {
    display: flex;
    flex-wrap: wrap;
}

.grid-cols-4 {
    width: 100%;
}

.feature-item {
    width: 25%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.feature-icon {
    width: 96rpx;
    height: 96rpx;
    border-radius: 28rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 16rpx;
    font-size: 40rpx;
}

.feature-text {
    font-size: 24rpx;
    color: #775c4c;
    font-weight: 500;
}

.package-scroll {
    white-space: nowrap;
}

.package-list {
    padding: 8rpx 0;
}

.package-item {
    display: inline-block;
    width: 320rpx;
    margin-right: 24rpx;
    padding: 30rpx;
    border-radius: 28rpx;
    background: white;
    position: relative;
    vertical-align: top;
}

.package-item:first-child {
    background: linear-gradient(135deg, #fef7ee, #fffbeb);
    border: 1px solid rgba(238, 119, 17, 0.1);
}

.package-item:nth-child(2) {
    background: linear-gradient(135deg, #fffbeb, #fefce8);
    border: 1px solid rgba(245, 158, 11, 0.1);
}

.package-item:last-child {
    background: linear-gradient(135deg, #faf5ff, #fdf2f8);
    border: 1px solid rgba(168, 85, 247, 0.1);
}

.package-tag {
    position: absolute;
    top: -12rpx;
    left: 50%;
    transform: translateX(-50%);
    background: linear-gradient(135deg, #f59e0b, #fbbf24);
    padding: 4rpx 20rpx;
    border-radius: 20rpx;
    box-shadow: 0 4rpx 16rpx rgba(245, 158, 11, 0.2);
}

.tag-text {
    color: white;
    font-size: 20rpx;
    font-weight: 500;
}

.package-badge {
    padding: 4rpx 16rpx;
    border-radius: 20rpx;
    color: white;
    font-size: 20rpx;
}

.package-icon {
    font-size: 32rpx;
}

.package-name {
    display: block;
    font-size: 28rpx;
    font-weight: 700;
    color: #634d42;
    margin-bottom: 8rpx;
}

.package-desc {
    display: block;
    font-size: 24rpx;
    color: #b09478;
    line-height: 1.6;
    white-space: normal;
}

.package-price {
    font-size: 36rpx;
    font-weight: 700;
    color: #df5d07;
}

.package-original {
    font-size: 24rpx;
    color: #c7b59e;
    text-decoration: line-through;
    margin-left: 8rpx;
}

.article-item {
    background: white;
    border-radius: 28rpx;
    overflow: hidden;
    display: flex;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
}

.article-img {
    width: 224rpx;
    height: 192rpx;
    flex-shrink: 0;
}

.article-content {
    padding: 24rpx;
}

.article-title {
    font-size: 28rpx;
    color: #634d42;
    font-weight: 500;
    line-height: 1.5;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.article-meta {
    font-size: 24rpx;
    color: #c7b59e;
}

.meta-icon {
    margin-right: 4rpx;
}

.user-avatar {
    width: 80rpx;
    height: 80rpx;
    border-radius: 50%;
    flex-shrink: 0;
}

.user-name {
    font-size: 28rpx;
    font-weight: 500;
    color: #634d42;
}

.review-time {
    font-size: 24rpx;
    color: #c7b59e;
}

.star-icon {
    font-size: 24rpx;
}

.rating-text {
    font-size: 24rpx;
    color: #91705a;
    margin-left: 8rpx;
}

.review-content {
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.6;
}

.px-5 {
    padding-left: 30rpx;
    padding-right: 30rpx;
}

.mb-3 {
    margin-bottom: 12rpx;
}

.mb-5 {
    margin-bottom: 30rpx;
}

.mt-2 {
    margin-top: 8rpx;
}

.my-1 {
    margin-top: 4rpx;
    margin-bottom: 4rpx;
}

.space-x-2 > view:not(:last-child),
.space-x-2 > text:not(:last-child),
.space-x-2 > image:not(:last-child) {
    margin-right: 8rpx;
}

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-y-3 > view:not(:last-child) {
    margin-bottom: 12rpx;
}

.flex {
    display: flex;
}

.flex-col {
    flex-direction: column;
}

.items-center {
    align-items: center;
}

.justify-center {
    justify-content: center;
}

.justify-between {
    justify-content: space-between;
}

.flex-1 {
    flex: 1;
}

.w-full {
    width: 100%;
}

.relative {
    position: relative;
}

.z-10 {
    z-index: 10;
}

.text-center {
    text-align: center;
}
</style>
