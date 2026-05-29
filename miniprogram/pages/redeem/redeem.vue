<template>
    <view class="page-container">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">兑换码</text>
            <view class="nav-empty"></view>
        </view>

        <!-- 剩余次数卡片 -->
        <view class="credit-card card">
            <view class="credit-header flex items-center justify-between">
                <text class="credit-label">剩余起名次数</text>
                <text class="credit-icon">✨</text>
            </view>
            <view class="credit-count">
                <text class="count-number">{{ credits }}</text>
                <text class="count-unit">次</text>
            </view>
            <text class="credit-tip">每次起名消耗1次</text>
        </view>

        <!-- 兑换码输入区 -->
        <view class="redeem-section">
            <view class="card">
                <view class="section-header flex items-center space-x-2 mb-4">
                    <view class="header-icon">🎁</view>
                    <text class="section-title">兑换码兑换</text>
                </view>

                <view class="input-group mb-4">
                    <input 
                        class="code-input" 
                        v-model="redeemCode" 
                        placeholder="请输入兑换码" 
                        maxlength="16"
                    />
                    <button class="paste-btn" @click="pasteCode">粘贴</button>
                </view>

                <button class="redeem-btn w-full" :disabled="!redeemCode.trim()" @click="handleRedeem">
                    <text class="btn-text">立即兑换</text>
                </button>
            </view>
        </view>

        <!-- 兑换记录 -->
        <view class="history-section">
            <view class="section-top flex items-center justify-between mb-4">
                <text class="section-title">兑换记录</text>
            </view>

            <view class="history-list">
                <view class="history-item card" v-for="(item, index) in historyList" :key="index">
                    <view class="history-left flex items-center space-x-3">
                        <view class="history-icon">🎉</view>
                        <view class="history-info">
                            <text class="history-desc">{{ item.desc }}</text>
                            <text class="history-time">{{ item.time }}</text>
                        </view>
                    </view>
                    <view class="history-right">
                        <text class="history-amount">+{{ item.amount }}</text>
                    </view>
                </view>

                <view class="empty-history" v-if="historyList.length === 0">
                    <text class="empty-icon">📭</text>
                    <text class="empty-text">暂无兑换记录</text>
                </view>
            </view>
        </view>

        <!-- 常见问题 -->
        <view class="faq-section">
            <view class="card">
                <view class="section-header flex items-center space-x-2 mb-4">
                    <view class="header-icon">❓</view>
                    <text class="section-title">常见问题</text>
                </view>

                <view class="faq-list space-y-4">
                    <view class="faq-item">
                        <text class="faq-question">Q: 如何获取兑换码？</text>
                        <text class="faq-answer">A: 关注公众号、参与活动或联系客服获取。</text>
                    </view>
                    <view class="faq-item">
                        <text class="faq-question">Q: 兑换码有使用期限吗？</text>
                        <text class="faq-answer">A: 请在有效期内使用，过期后将无法兑换。</text>
                    </view>
                    <view class="faq-item">
                        <text class="faq-question">Q: 兑换码可以重复使用吗？</text>
                        <text class="faq-answer">A: 每个兑换码只能使用一次，不可重复兑换。</text>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { showToast, getCredits, setCredits } from '../../utils/index';

const credits = ref(0);
const redeemCode = ref('');
const historyList = ref([
    { desc: '新用户注册赠送', time: '2024-01-15 10:30', amount: 3 },
    { desc: '分享好友奖励', time: '2024-01-10 18:20', amount: 2 }
]);

onMounted(() => {
    credits.value = getCredits();
});

const goBack = () => {
    uni.navigateBack();
};

const pasteCode = () => {
    uni.getClipboardData({
        success: (res) => {
            redeemCode.value = res.data;
        }
    });
};

const handleRedeem = () => {
    if (!redeemCode.value.trim()) {
        showToast('请输入兑换码');
        return;
    }

    showToast('兑换成功！');
    const newCredits = credits.value + 3;
    setCredits(newCredits);
    credits.value = newCredits;
    
    historyList.value.unshift({
        desc: '兑换码兑换',
        time: new Date().toLocaleString(),
        amount: 3
    });
    
    redeemCode.value = '';
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

.credit-card {
    margin: 24rpx 30rpx;
    background: linear-gradient(135deg, #C41E3A, #E8837C);
}

.credit-label {
    font-size: 26rpx;
    color: rgba(255, 255, 255, 0.9);
}

.credit-icon {
    font-size: 36rpx;
}

.credit-count {
    display: flex;
    align-items: baseline;
    margin: 24rpx 0 12rpx;
}

.count-number {
    font-size: 72rpx;
    font-weight: 700;
    color: white;
}

.count-unit {
    font-size: 28rpx;
    color: rgba(255, 255, 255, 0.85);
    margin-left: 8rpx;
}

.credit-tip {
    font-size: 24rpx;
    color: rgba(255, 255, 255, 0.75);
}

.redeem-section {
    padding: 0 30rpx;
    margin-bottom: 30rpx;
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

.section-top {
    padding: 0 30rpx;
}

.input-group {
    display: flex;
    gap: 16rpx;
}

.code-input {
    flex: 1;
    background: #faf8f5;
    border: 2rpx solid #efe9e0;
    border-radius: 24rpx;
    padding: 24rpx 28rpx;
    font-size: 28rpx;
    color: #534138;
}

.paste-btn {
    padding: 24rpx 32rpx;
    background: linear-gradient(135deg, rgba(196, 30, 58, 0.1), rgba(232, 131, 124, 0.1));
    color: #C41E3A;
    border-radius: 24rpx;
    font-size: 26rpx;
    font-weight: 500;
    border: none;
}

.redeem-btn {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    color: white;
    border-radius: 28rpx;
    font-size: 30rpx;
    font-weight: 600;
    border: none;
    padding: 28rpx;
}

.redeem-btn[disabled] {
    opacity: 0.5;
}

.btn-text {
    color: white;
}

.history-section {
    margin-bottom: 30rpx;
}

.history-list {
    padding: 0 30rpx;
}

.history-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16rpx;
    padding: 24rpx 30rpx;
}

.history-icon {
    font-size: 36rpx;
}

.history-desc {
    display: block;
    font-size: 26rpx;
    font-weight: 500;
    color: #634d42;
    margin-bottom: 6rpx;
}

.history-time {
    display: block;
    font-size: 22rpx;
    color: #c7b59e;
}

.history-amount {
    font-size: 32rpx;
    font-weight: 700;
    color: #C41E3A;
}

.empty-history {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 80rpx 0;
}

.empty-icon {
    font-size: 80rpx;
    margin-bottom: 16rpx;
    opacity: 0.5;
}

.empty-text {
    font-size: 26rpx;
    color: #c7b59e;
}

.faq-section {
    padding: 0 30rpx 30rpx;
}

.faq-item {
    padding: 20rpx 0;
    border-bottom: 1px solid #efe9e0;
}

.faq-item:last-child {
    border-bottom: none;
}

.faq-question {
    display: block;
    font-size: 26rpx;
    font-weight: 500;
    color: #634d42;
    margin-bottom: 8rpx;
}

.faq-answer {
    display: block;
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.6;
}

.flex {
    display: flex;
}

.items-center {
    align-items: center;
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

.space-y-4 > view:not(:last-child) {
    margin-bottom: 16rpx;
}

.mb-4 {
    margin-bottom: 16rpx;
}

.w-full {
    width: 100%;
}
</style>
