<template>
    <view class="page-container pb-20">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">起名结果</text>
            <view class="nav-share" @click="shareResult">
                <text class="icon-text">⋮</text>
            </view>
        </view>

        <!-- 成功提示 -->
        <view class="success-banner px-5 mb-4">
            <view class="card success-card">
                <view class="success-icon">
                    <text class="icon">✨</text>
                </view>
                <text class="success-title">恭喜，起名成功！</text>
                <text class="success-subtitle">为您精选了 {{ names.length }} 个好名字</text>
            </view>
        </view>

        <!-- 宝宝信息 -->
        <view class="px-5 mb-4">
            <view class="card">
                <view class="info-header flex items-center justify-between mb-3">
                    <text class="info-title">宝宝信息</text>
                    <text class="info-tag">{{ record.gender === 'boy' ? '男宝宝' : '女宝宝' }}</text>
                </view>
                <view class="info-grid grid grid-cols-2 gap-3">
                    <view class="info-item">
                        <text class="info-label">姓氏</text>
                        <text class="info-value">{{ record.surname }}</text>
                    </view>
                    <view class="info-item">
                        <text class="info-label">出生日期</text>
                        <text class="info-value">{{ record.birthday }}</text>
                    </view>
                    <view class="info-item col-span-2">
                        <text class="info-label">出生时辰</text>
                        <text class="info-value">{{ record.birthtime }}</text>
                    </view>
                </view>
            </view>
        </view>

        <!-- 名字列表 -->
        <view class="px-5 mb-4">
            <view class="flex items-center justify-between mb-3">
                <text class="section-title">精选名字</text>
                <text class="link-text">{{ names.length }}个名字</text>
            </view>
            <view class="space-y-3">
                <view 
                    class="name-card card" 
                    v-for="(name, index) in names" 
                    :key="index"
                    @click="goToDetail(name, index)"
                >
                    <view class="name-header flex items-center justify-between">
                        <view class="flex items-center space-x-3">
                            <view class="name-rank">
                                <text class="rank-text">{{ index + 1 }}</text>
                            </view>
                            <view>
                                <text class="full-name">{{ record.surname }}{{ name }}</text>
                                <text class="pinyin">{{ getPinyin(name) }}</text>
                            </view>
                        </view>
                        <view class="name-score">
                            <text class="score-value">{{ 90 + index }}</text>
                            <text class="score-label">分</text>
                        </view>
                    </view>
                    <view class="name-tags flex flex-wrap gap-2 mt-3">
                        <view class="name-tag" v-for="tag in getTags(name)" :key="tag">{{ tag }}</view>
                    </view>
                    <view class="name-desc mt-3">
                        <text class="desc-text">{{ getDesc(name) }}</text>
                    </view>
                    <view class="name-actions flex items-center justify-between mt-4">
                        <view class="flex items-center space-x-4">
                            <view class="action-btn" @click.stop="toggleFavorite(name, index)">
                                <text class="action-icon">{{ favorites.includes(index) ? '❤️' : '🤍' }}</text>
                                <text class="action-text">{{ favorites.includes(index) ? '已收藏' : '收藏' }}</text>
                            </view>
                            <view class="action-btn" @click.stop="copyName(name)">
                                <text class="action-icon">📋</text>
                                <text class="action-text">复制</text>
                            </view>
                        </view>
                        <view class="action-btn primary">
                            <text class="action-text">查看详情</text>
                            <text class="action-icon">→</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 底部操作 -->
        <view class="px-5 mb-5">
            <view class="card bottom-card">
                <view class="bottom-actions grid grid-cols-3 gap-3">
                    <view class="bottom-btn" @click="shareResult">
                        <text class="bottom-icon">📤</text>
                        <text class="bottom-text">分享</text>
                    </view>
                    <view class="bottom-btn" @click="saveToHistory">
                        <text class="bottom-icon">📝</text>
                        <text class="bottom-text">保存</text>
                    </view>
                    <view class="bottom-btn primary" @click="retryNaming">
                        <text class="bottom-icon">🔄</text>
                        <text class="bottom-text">重新起名</text>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { showToast, saveRecord, getRecords } from '../../utils/index';

const record = ref({});
const names = ref([]);
const favorites = ref([]);

onMounted(() => {
    const currentRecord = uni.getStorageSync('currentRecord');
    if (currentRecord) {
        record.value = currentRecord;
        names.value = currentRecord.names || [];
    }
});

const goBack = () => {
    uni.switchTab({
        url: '/pages/home/home'
    });
};

const goToDetail = (name, index) => {
    uni.setStorageSync('currentName', {
        name: name,
        surname: record.value.surname,
        index: index,
        record: record.value
    });
    uni.navigateTo({
        url: '/pages/name-detail/name-detail'
    });
};

const getPinyin = (name) => {
    const pinyinMap = {
        '子轩': 'zǐ xuān',
        '浩宇': 'hào yǔ',
        '诗涵': 'shī hán',
        '欣怡': 'xīn yí',
        '雨泽': 'yǔ zé',
        '梓萱': 'zǐ xuān',
        '晨逸': 'chén yì',
        '雅琪': 'yǎ qí',
        '睿博': 'ruì bó',
        '思彤': 'sī tóng'
    };
    return pinyinMap[name] || 'pīn yīn';
};

const getTags = (name) => {
    const tags = ['诗词典故', '寓意美好', '朗朗上口', '五行平衡'];
    return tags.slice(0, 3);
};

const getDesc = (name) => {
    const descs = [
        '此名字源于古诗词，寓意君子之风，气度不凡',
        '名字音律优美，朗朗上口，寓意前程似锦',
        '五行相生，数理吉祥，寓意智慧与勇气并存',
        '源于经典，寓意品德高尚，学识渊博'
    ];
    return descs[Math.floor(Math.random() * descs.length)];
};

const toggleFavorite = (name, index) => {
    const idx = favorites.value.indexOf(index);
    if (idx > -1) {
        favorites.value.splice(idx, 1);
        showToast('已取消收藏');
    } else {
        favorites.value.push(index);
        showToast('已收藏');
    }
};

const copyName = (name) => {
    const fullName = record.value.surname + name;
    uni.setClipboardData({
        data: fullName,
        success: () => {
            showToast('已复制到剪贴板');
        }
    });
};

const shareResult = () => {
    showToast('分享功能开发中');
};

const saveToHistory = () => {
    const records = getRecords() || [];
    if (!records.find(r => r.id === record.value.id)) {
        saveRecord(record.value);
    }
    showToast('已保存到历史记录');
};

const retryNaming = () => {
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

.nav-back, .nav-share {
    width: 72rpx;
    height: 72rpx;
    background: #f8f6f3;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
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

.success-banner {
    margin-top: 20rpx;
}

.success-card {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    text-align: center;
    padding: 40rpx 30rpx;
}

.success-icon {
    width: 96rpx;
    height: 96rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20rpx;
}

.success-icon .icon {
    font-size: 48rpx;
}

.success-title {
    display: block;
    font-size: 32rpx;
    font-weight: 700;
    color: white;
    margin-bottom: 8rpx;
}

.success-subtitle {
    display: block;
    font-size: 24rpx;
    color: rgba(255, 255, 255, 0.85);
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.info-header {
    margin-bottom: 20rpx;
}

.info-title {
    font-size: 28rpx;
    font-weight: 600;
    color: #634d42;
}

.info-tag {
    font-size: 24rpx;
    padding: 6rpx 20rpx;
    background: linear-gradient(135deg, #fef7ee, #fffbeb);
    color: #ee7711;
    border-radius: 20rpx;
}

.info-grid {
    display: flex;
    flex-wrap: wrap;
}

.grid-cols-2 {
    width: 100%;
}

.info-item {
    width: 50%;
}

.info-item.col-span-2 {
    width: 100%;
}

.info-label {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
    margin-bottom: 4rpx;
}

.info-value {
    font-size: 28rpx;
    font-weight: 500;
    color: #634d42;
}

.section-title {
    font-size: 32rpx;
    font-weight: 700;
    color: #634d42;
}

.link-text {
    font-size: 24rpx;
    color: #ee7711;
}

.name-card {
    transition: transform 0.3s;
}

.name-header {
    margin-bottom: 8rpx;
}

.name-rank {
    width: 56rpx;
    height: 56rpx;
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    border-radius: 14rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.rank-text {
    color: white;
    font-size: 24rpx;
    font-weight: 700;
}

.full-name {
    display: block;
    font-size: 36rpx;
    font-weight: 700;
    color: #634d42;
    line-height: 1.3;
}

.pinyin {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
}

.name-score {
    display: flex;
    align-items: baseline;
}

.score-value {
    font-size: 40rpx;
    font-weight: 700;
    color: #C41E3A;
}

.score-label {
    font-size: 24rpx;
    color: #c7b59e;
    margin-left: 4rpx;
}

.name-tags {
    display: flex;
    flex-wrap: wrap;
}

.name-tag {
    padding: 8rpx 20rpx;
    background: #faf8f5;
    border-radius: 20rpx;
    font-size: 22rpx;
    color: #91705a;
}

.name-desc {
    padding: 20rpx;
    background: linear-gradient(135deg, #fef7ee, #faf8f5);
    border-radius: 20rpx;
}

.desc-text {
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.6;
}

.name-actions {
    padding-top: 16rpx;
    border-top: 1px solid #efe9e0;
}

.action-btn {
    display: flex;
    align-items: center;
    gap: 8rpx;
    padding: 12rpx 24rpx;
    border-radius: 20rpx;
    background: #faf8f5;
}

.action-btn.primary {
    background: linear-gradient(135deg, rgba(196, 30, 58, 0.1), rgba(232, 131, 124, 0.1));
}

.action-icon {
    font-size: 24rpx;
}

.action-text {
    font-size: 24rpx;
    color: #775c4c;
}

.action-btn.primary .action-text {
    color: #C41E3A;
    font-weight: 500;
}

.bottom-card {
    padding: 20rpx;
}

.bottom-actions {
    display: flex;
}

.bottom-btn {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 24rpx 16rpx;
    border-radius: 20rpx;
    background: #faf8f5;
    transition: all 0.3s;
}

.bottom-btn:active {
    transform: scale(0.98);
}

.bottom-btn.primary {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
}

.bottom-icon {
    font-size: 32rpx;
    margin-bottom: 8rpx;
}

.bottom-text {
    font-size: 24rpx;
    color: #775c4c;
}

.bottom-btn.primary .bottom-text {
    color: white;
}

.px-5 {
    padding-left: 30rpx;
    padding-right: 30rpx;
}

.mb-4 {
    margin-bottom: 24rpx;
}

.mb-5 {
    margin-bottom: 30rpx;
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

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-x-4 > view:not(:last-child) {
    margin-right: 16rpx;
}

.space-y-3 > view:not(:last-child) {
    margin-bottom: 12rpx;
}

.gap-2 {
    gap: 16rpx;
}

.gap-3 {
    gap: 12rpx;
}

.mt-3 {
    margin-top: 12rpx;
}

.mt-4 {
    margin-top: 16rpx;
}
</style>
