<template>
    <view class="page-container">
        <!-- 顶部用户信息区 -->
        <view class="profile-header">
            <view class="header-content">
                <view class="user-avatar">
                    <image src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&h=200&fit=crop&crop=face" class="avatar-img" mode="aspectFill" />
                </view>
                <view class="user-info">
                    <text class="user-name">起名用户</text>
                    <text class="user-id">ID: 888888</text>
                </view>
                <view class="edit-btn">
                    <text class="edit-icon">✏️</text>
                </view>
            </view>
        </view>

        <!-- 统计卡片 -->
        <view class="stats-card card">
            <view class="stats-grid grid grid-cols-3">
                <view class="stat-item" @click="goHistory">
                    <text class="stat-number">{{ recordCount }}</text>
                    <text class="stat-label">起名记录</text>
                </view>
                <view class="stat-item">
                    <text class="stat-number">{{ credits }}</text>
                    <text class="stat-label">剩余次数</text>
                </view>
                <view class="stat-item" @click="goRedeem">
                    <text class="stat-icon">🎁</text>
                    <text class="stat-label">兑换码</text>
                </view>
            </view>
        </view>

        <!-- 功能菜单 -->
        <view class="menu-section">
            <view class="menu-item card" @click="goHistory">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #FCE4EC, #F8BBD9);">
                        <text class="icon">📝</text>
                    </view>
                    <text class="menu-text">历史记录</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>

            <view class="menu-item card" @click="goRedeem">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #FFF3E0, #FFE0B2);">
                        <text class="icon">🎁</text>
                    </view>
                    <text class="menu-text">兑换码</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>

            <view class="menu-item card" @click="goKnowledge">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #E8F5E9, #C8E6C9);">
                        <text class="icon">📚</text>
                    </view>
                    <text class="menu-text">起名知识</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>

            <view class="menu-item card" @click="goAbout">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #E3F2FD, #BBDEFB);">
                        <text class="icon">ℹ️</text>
                    </view>
                    <text class="menu-text">关于我们</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>
        </view>

        <!-- 设置菜单 -->
        <view class="menu-section">
            <view class="menu-item card">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #F3E5F5, #E1BEE7);">
                        <text class="icon">⚙️</text>
                    </view>
                    <text class="menu-text">设置</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>

            <view class="menu-item card">
                <view class="menu-left flex items-center space-x-3">
                    <view class="menu-icon" style="background: linear-gradient(135deg, #FFF8E1, #FFE082);">
                        <text class="icon">📞</text>
                    </view>
                    <text class="menu-text">联系客服</text>
                </view>
                <view class="menu-right flex items-center">
                    <text class="menu-arrow">→</text>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { getRecords, getCredits } from '../../utils/index';

const recordCount = ref(0);
const credits = ref(0);

onMounted(() => {
    const records = getRecords() || [];
    recordCount.value = records.length;
    credits.value = getCredits();
});

const goHistory = () => {
    uni.navigateTo({
        url: '/pages/history/history'
    });
};

const goRedeem = () => {
    uni.navigateTo({
        url: '/pages/redeem/redeem'
    });
};

const goKnowledge = () => {
    uni.navigateTo({
        url: '/pages/knowledge/knowledge'
    });
};

const goAbout = () => {
    uni.navigateTo({
        url: '/pages/about/about'
    });
};
</script>

<style scoped>
.page-container {
    min-height: 100vh;
    background: #F5F0EB;
}

.profile-header {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    padding: 60rpx 30rpx 40rpx;
}

.header-content {
    display: flex;
    align-items: center;
}

.user-avatar {
    width: 120rpx;
    height: 120rpx;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.3);
    overflow: hidden;
    margin-right: 24rpx;
}

.avatar-img {
    width: 100%;
    height: 100%;
}

.user-info {
    flex: 1;
}

.user-name {
    display: block;
    font-size: 36rpx;
    font-weight: 700;
    color: white;
    margin-bottom: 8rpx;
}

.user-id {
    display: block;
    font-size: 24rpx;
    color: rgba(255, 255, 255, 0.8);
}

.edit-btn {
    width: 64rpx;
    height: 64rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.edit-icon {
    font-size: 28rpx;
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.stats-card {
    margin: -30rpx 30rpx 30rpx;
    position: relative;
    z-index: 10;
}

.stats-grid {
    display: flex;
}

.stat-item {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 16rpx 0;
}

.stat-number {
    font-size: 40rpx;
    font-weight: 700;
    color: #C41E3A;
    margin-bottom: 8rpx;
}

.stat-icon {
    font-size: 40rpx;
    margin-bottom: 8rpx;
}

.stat-label {
    font-size: 24rpx;
    color: #775c4c;
}

.menu-section {
    padding: 0 30rpx;
    margin-bottom: 24rpx;
}

.menu-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16rpx;
    padding: 28rpx 30rpx;
}

.menu-left {
    flex: 1;
}

.menu-icon {
    width: 80rpx;
    height: 80rpx;
    border-radius: 20rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.menu-icon .icon {
    font-size: 36rpx;
}

.menu-text {
    font-size: 28rpx;
    font-weight: 500;
    color: #634d42;
}

.menu-arrow {
    font-size: 28rpx;
    color: #c7b59e;
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

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}
</style>
