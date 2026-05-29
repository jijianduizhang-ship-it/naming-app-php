<template>
    <view class="page-container">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">关于我们</text>
            <view class="nav-empty"></view>
        </view>

        <!-- 品牌信息 -->
        <view class="brand-section">
            <view class="card brand-card">
                <view class="brand-logo">
                <text class="logo-text">☯</text>
            </view>
            <text class="brand-name">瑞名阁</text>
            <text class="brand-slogan">传承千年·赐名有道</text>
            <text class="version">版本 1.0.0</text>
            <view class="divider"></view>
            <text class="brand-desc">
                瑞名阁致力于为每一位宝宝提供专业、吉祥的起名服务。融合传统国学与现代美学，
                结合八字命理、五行平衡、诗词典故等要素，为宝宝甄选一个寓意美好、朗朗上口的好名字。
            </text>
        </view>
        </view>

        <!-- 功能特点 -->
        <view class="features-section">
            <view class="card">
                <view class="section-header flex items-center space-x-2 mb-4">
                    <text class="header-icon">✨</text>
                    <text class="section-title">我们的特点</text>
                </view>

                <view class="feature-list space-y-4">
                    <view class="feature-item flex items-start space-x-3">
                        <view class="feature-icon" style="background: linear-gradient(135deg, #FFF3E0, #FFE0B2);">
                            <text class="icon">📖</text>
                        </view>
                        <view class="feature-info">
                            <text class="feature-title">国学传承</text>
                            <text class="feature-desc">结合传统国学文化，传承千年起名智慧</text>
                        </view>
                    </view>

                    <view class="feature-item flex items-start space-x-3">
                        <view class="feature-icon" style="background: linear-gradient(135deg, #E8F5E9, #C8E6C9);">
                            <text class="icon">🔮</text>
                        </view>
                        <view class="feature-info">
                            <text class="feature-title">八字分析</text>
                            <text class="feature-desc">根据生辰八字、五行相生相克分析</text>
                        </view>
                    </view>

                    <view class="feature-item flex items-start space-x-3">
                        <view class="feature-icon" style="background: linear-gradient(135deg, #E3F2FD, #BBDEFB);">
                            <text class="icon">🎨</text>
                        </view>
                        <view class="feature-info">
                            <text class="feature-title">美学设计</text>
                            <text class="feature-desc">注重音韵美、字形美、寓意美的结合</text>
                        </view>
                    </view>

                    <view class="feature-item flex items-start space-x-3">
                        <view class="feature-icon" style="background: linear-gradient(135deg, #FCE4EC, #F8BBD9);">
                            <text class="icon">🎯</text>
                        </view>
                        <view class="feature-info">
                            <text class="feature-title">个性定制</text>
                            <text class="feature-desc">根据偏好风格定制，满足不同需求</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 联系方式 -->
        <view class="contact-section">
            <view class="card">
                <view class="section-header flex items-center space-x-2 mb-4">
                    <text class="header-icon">📬</text>
                    <text class="section-title">联系我们</text>
                </view>

                <view class="contact-list space-y-3">
                    <view class="contact-item flex items-center justify-between">
                        <view class="contact-left flex items-center space-x-3">
                            <text class="contact-icon">📧</text>
                            <text class="contact-label">官方邮箱</text>
                        </view>
                        <text class="contact-value">contact@ruimingge.com</text>
                    </view>

                    <view class="contact-item flex items-center justify-between">
                        <view class="contact-left flex items-center space-x-3">
                            <text class="contact-icon">📱</text>
                            <text class="contact-label">客服微信</text>
                        </view>
                        <text class="contact-value">ruimingge_service</text>
                    </view>

                    <view class="contact-item flex items-center justify-between">
                        <view class="contact-left flex items-center space-x-3">
                            <text class="contact-icon">🌐</text>
                            <text class="contact-label">官方网站</text>
                        </view>
                        <text class="contact-value">www.ruimingge.com</text>
                    </view>
                </view>
            </view>
        </view>

        <!-- 法律信息 -->
        <view class="legal-section">
            <view class="card">
                <view class="legal-list space-y-3">
                    <view class="legal-item flex items-center justify-between">
                        <text class="legal-label">用户协议</text>
                        <text class="legal-arrow">→</text>
                    </view>

                    <view class="legal-item flex items-center justify-between">
                        <text class="legal-label">隐私政策</text>
                        <text class="legal-arrow">→</text>
                    </view>

                    <view class="legal-item flex items-center justify-between">
                        <text class="legal-label">用户反馈</text>
                        <text class="legal-arrow">→</text>
                    </view>

                    <view class="legal-item flex items-center justify-between">
                        <text class="legal-label">给我们评分</text>
                        <text class="legal-arrow">→</text>
                    </view>
                </view>
            </view>
        </view>

        <!-- 版权信息 -->
        <view class="copyright-section">
            <text class="copyright-text">© 2024 瑞名阁 All Rights Reserved</text>
        </view>
    </view>
</template>

<script setup>
const goBack = () => {
    uni.navigateBack();
};
</script>

<style scoped>
.page-container {
    min-height: 100vh;
    background: #F5F0EB;
}

.nav-bar {
    background: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(20rpx);
    padding: 30rpx;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid rgba(239, 233, 224, 0.5);
    position: sticky;
    top: 0;
    z-index: 50;
}

.nav-back, .nav-empty {
    width: 72rpx;
    height: 72rpx;
    background: #f8f6f3;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.nav-empty {
    background: transparent;
}

.nav-title {
    font-size: 32rpx;
    font-weight: 700;
    color: #634d42;
}

.icon-text {
    font-size: 28rpx;
    color: #91705a;
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.brand-section {
    padding: 30rpx;
}

.brand-card {
    text-align: center;
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    padding: 50rpx 30rpx;
}

.brand-logo {
    width: 120rpx;
    height: 120rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 32rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 24rpx;
}

.logo-text {
    font-size: 64rpx;
}

.brand-name {
    display: block;
    font-size: 36rpx;
    font-weight: 700;
    color: white;
    margin-bottom: 8rpx;
}

.brand-slogan {
    display: block;
    font-size: 26rpx;
    color: rgba(255, 255, 255, 0.9);
    margin-bottom: 16rpx;
}

.version {
    display: block;
    font-size: 24rpx;
    color: rgba(255, 255, 255, 0.75);
}

.divider {
    height: 1px;
    background: rgba(255, 255, 255, 0.2);
    margin: 30rpx 0;
}

.brand-desc {
    font-size: 26rpx;
    color: rgba(255, 255, 255, 0.85);
    line-height: 1.8;
    text-align: left;
}

.features-section,
.contact-section,
.legal-section {
    padding: 0 30rpx;
    margin-bottom: 24rpx;
}

.section-header {
    margin-bottom: 8rpx;
}

.header-icon {
    font-size: 32rpx;
}

.section-title {
    font-size: 28rpx;
    font-weight: 600;
    color: #634d42;
}

.feature-list {
    margin-top: 16rpx;
}

.feature-item {
    padding: 24rpx 0;
}

.feature-icon {
    width: 80rpx;
    height: 80rpx;
    border-radius: 20rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.feature-icon .icon {
    font-size: 36rpx;
}

.feature-info {
    flex: 1;
}

.feature-title {
    display: block;
    font-size: 28rpx;
    font-weight: 500;
    color: #634d42;
    margin-bottom: 6rpx;
}

.feature-desc {
    display: block;
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.5;
}

.contact-list {
    margin-top: 16rpx;
}

.contact-item {
    padding: 20rpx 0;
    border-bottom: 1px solid #efe9e0;
}

.contact-item:last-child {
    border-bottom: none;
}

.contact-icon {
    font-size: 32rpx;
}

.contact-label {
    font-size: 26rpx;
    color: #634d42;
    font-weight: 500;
}

.contact-value {
    font-size: 24rpx;
    color: #775c4c;
}

.legal-list {
    margin-top: 16rpx;
}

.legal-item {
    padding: 24rpx 0;
    border-bottom: 1px solid #efe9e0;
}

.legal-item:last-child {
    border-bottom: none;
}

.legal-label {
    font-size: 26rpx;
    color: #634d42;
    font-weight: 500;
}

.legal-arrow {
    font-size: 28rpx;
    color: #c7b59e;
}

.copyright-section {
    padding: 40rpx 30rpx;
    text-align: center;
}

.copyright-text {
    font-size: 24rpx;
    color: #c7b59e;
}

.flex {
    display: flex;
}

.items-center {
    align-items: center;
}

.items-start {
    align-items: flex-start;
}

.justify-between {
    justify-content: space-between;
}

.space-x-2 > view:not(:last-child),
.space-x-2 > text:not(:last-child) {
    margin-right: 8rpx;
}

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-y-3 > view:not(:last-child) {
    margin-bottom: 12rpx;
}

.space-y-4 > view:not(:last-child) {
    margin-bottom: 16rpx;
}

.mb-4 {
    margin-bottom: 16rpx;
}
</style>
