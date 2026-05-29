<template>
    <view class="page-container">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">历史记录</text>
            <view class="nav-empty"></view>
        </view>

        <!-- 空状态 -->
        <view class="empty-state" v-if="records.length === 0">
            <text class="empty-icon">📝</text>
            <text class="empty-text">暂无历史记录</text>
            <text class="empty-sub">快去为宝宝起个好名字吧</text>
            <button class="btn-primary" @click="goNaming">
                <text class="btn-text">立即起名</text>
            </button>
        </view>

        <!-- 记录列表 -->
        <view class="record-list" v-else>
            <view class="record-item card" v-for="(record, index) in records" :key="record.id" @click="viewDetail(record)">
                <view class="record-header flex items-center justify-between">
                    <view class="record-info">
                        <text class="record-name">{{ record.surname }}{{ record.names?.[0] || '宝宝' }}</text>
                        <text class="record-meta">{{ record.gender === 'boy' ? '男宝' : '女宝' }} · {{ formatDate(record.createdAt) }}</text>
                    </view>
                    <view class="record-tag" :class="record.gender === 'boy' ? 'boy' : 'girl'">
                        {{ record.gender === 'boy' ? '♂' : '♀' }}
                    </view>
                </view>

                <view class="record-names flex flex-wrap gap-2 mt-3">
                    <view class="name-chip" v-for="(name, idx) in record.names?.slice(0, 4) || []" :key="idx">
                        {{ record.surname }}{{ name }}
                    </view>
                    <view class="name-chip more" v-if="record.names?.length > 4">
                        +{{ record.names.length - 4 }}
                    </view>
                </view>

                <view class="record-footer flex items-center justify-between mt-4">
                    <view class="record-stats flex items-center space-x-4">
                        <view class="stat-item">
                            <text class="stat-icon">👶</text>
                            <text class="stat-text">{{ record.names?.length || 0 }}个名字</text>
                        </view>
                    </view>
                    <view class="record-actions flex items-center space-x-3">
                        <view class="action-btn" @click.stop="deleteRecord(index)">
                            <text class="action-icon">🗑️</text>
                        </view>
                        <view class="action-btn primary">
                            <text class="action-text">查看</text>
                            <text class="action-icon">→</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { showToast, getRecords, deleteRecord as deleteRecordUtil } from '../../utils/index';

const records = ref([]);

onMounted(() => {
    loadRecords();
});

const loadRecords = () => {
    records.value = getRecords() || [];
};

const formatDate = (dateStr) => {
    if (!dateStr) return '';
    const date = new Date(dateStr);
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const hour = date.getHours().toString().padStart(2, '0');
    const minute = date.getMinutes().toString().padStart(2, '0');
    return `${month}月${day}日 ${hour}:${minute}`;
};

const goBack = () => {
    uni.switchTab({
        url: '/pages/home/home'
    });
};

const goNaming = () => {
    uni.switchTab({
        url: '/pages/naming/naming'
    });
};

const viewDetail = (record) => {
    uni.setStorageSync('currentRecord', record);
    uni.navigateTo({
        url: '/pages/result/result'
    });
};

const deleteRecord = (index) => {
    uni.showModal({
        title: '提示',
        content: '确定要删除这条记录吗？',
        success: (res) => {
            if (res.confirm) {
                deleteRecordUtil(index);
                loadRecords();
                showToast('已删除');
            }
        }
    });
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

.empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 160rpx 30rpx;
}

.empty-icon {
    font-size: 120rpx;
    margin-bottom: 24rpx;
}

.empty-text {
    font-size: 32rpx;
    font-weight: 600;
    color: #634d42;
    margin-bottom: 12rpx;
}

.empty-sub {
    font-size: 26rpx;
    color: #c7b59e;
    margin-bottom: 40rpx;
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.btn-primary {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    color: white;
    border-radius: 28rpx;
    font-size: 28rpx;
    font-weight: 600;
    border: none;
    padding: 24rpx 48rpx;
}

.btn-text {
    color: white;
}

.record-list {
    padding: 24rpx 30rpx;
}

.record-item {
    margin-bottom: 24rpx;
    transition: transform 0.2s;
}

.record-item:active {
    transform: scale(0.98);
}

.record-info {
    flex: 1;
}

.record-name {
    display: block;
    font-size: 32rpx;
    font-weight: 600;
    color: #634d42;
    margin-bottom: 6rpx;
}

.record-meta {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
}

.record-tag {
    width: 64rpx;
    height: 64rpx;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28rpx;
}

.record-tag.boy {
    background: linear-gradient(135deg, #E3F2FD, #BBDEFB);
}

.record-tag.girl {
    background: linear-gradient(135deg, #FCE4EC, #F8BBD9);
}

.record-names {
    display: flex;
    flex-wrap: wrap;
}

.name-chip {
    padding: 10rpx 20rpx;
    background: #faf8f5;
    border-radius: 20rpx;
    font-size: 24rpx;
    color: #775c4c;
}

.name-chip.more {
    background: linear-gradient(135deg, rgba(196, 30, 58, 0.1), rgba(232, 131, 124, 0.1));
    color: #C41E3A;
    font-weight: 500;
}

.record-footer {
    padding-top: 20rpx;
    border-top: 1px solid #efe9e0;
}

.stat-item {
    display: flex;
    align-items: center;
}

.stat-icon {
    font-size: 24rpx;
    margin-right: 8rpx;
}

.stat-text {
    font-size: 24rpx;
    color: #91705a;
}

.action-btn {
    display: flex;
    align-items: center;
    gap: 6rpx;
    padding: 12rpx 20rpx;
    border-radius: 20rpx;
    background: #faf8f5;
}

.action-btn.primary {
    background: linear-gradient(135deg, rgba(196, 30, 58, 0.1), rgba(232, 131, 124, 0.1));
}

.action-icon {
    font-size: 22rpx;
}

.action-text {
    font-size: 24rpx;
    color: #775c4c;
}

.action-btn.primary .action-text {
    color: #C41E3A;
    font-weight: 500;
}

.flex {
    display: flex;
}

.flex-col {
    flex-direction: column;
}

.flex-wrap {
    flex-wrap: wrap;
}

.items-center {
    align-items: center;
}

.justify-between {
    justify-content: space-between;
}

.flex-1 {
    flex: 1;
}

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-x-4 > view:not(:last-child) {
    margin-right: 16rpx;
}

.gap-2 {
    gap: 16rpx;
}

.mt-3 {
    margin-top: 12rpx;
}

.mt-4 {
    margin-top: 16rpx;
}
</style>
