<template>
    <view class="page-container pb-32">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">名字详情</text>
            <view class="nav-share" @click="shareName">
                <text class="icon-text">⋮</text>
            </view>
        </view>

        <!-- 名字展示 -->
        <view class="name-display px-5 mb-4">
            <view class="card name-card">
                <view class="name-main text-center">
                    <view class="name-characters">
                        <view class="char-item" v-for="(char, index) in fullName" :key="index">
                            <text class="char-text">{{ char }}</text>
                        </view>
                    </view>
                    <text class="name-pinyin">{{ pinyin }}</text>
                    <view class="name-score-display">
                        <text class="score-number">{{ score }}</text>
                        <text class="score-unit">分</text>
                    </view>
                    <view class="name-tags flex flex-wrap justify-center gap-2 mt-4">
                        <view class="tag-item" v-for="tag in tags" :key="tag">{{ tag }}</view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 综合评分 -->
        <view class="px-5 mb-4">
            <view class="card">
                <text class="section-title mb-4">综合评分</text>
                <view class="score-items space-y-4">
                    <view class="score-item" v-for="item in scoreItems" :key="item.label">
                        <view class="flex items-center justify-between mb-2">
                            <text class="score-label">{{ item.label }}</text>
                            <text class="score-value">{{ item.value }}</text>
                        </view>
                        <view class="progress-bar">
                            <view class="progress-fill" :style="{ width: item.value + '%' }"></view>
                        </view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 字义解析 -->
        <view class="px-5 mb-4">
            <view class="card">
                <text class="section-title mb-4">字义解析</text>
                <view class="meaning-list space-y-4">
                    <view class="meaning-item" v-for="(item, index) in meanings" :key="index">
                        <view class="meaning-header flex items-center space-x-3">
                            <view class="char-badge">
                                <text class="char-badge-text">{{ item.char }}</text>
                            </view>
                            <view>
                                <text class="char-name">{{ item.char }}</text>
                                <text class="char-pinyin">{{ item.pinyin }}</text>
                            </view>
                        </view>
                        <view class="meaning-content mt-3">
                            <text class="meaning-text">{{ item.meaning }}</text>
                        </view>
                        <view class="char-stroke mt-3">
                            <text class="stroke-label">笔画：</text>
                            <text class="stroke-value">{{ item.stroke }}画</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>

        <!-- 名字寓意 -->
        <view class="px-5 mb-4">
            <view class="card">
                <text class="section-title mb-4">名字寓意</text>
                <view class="meaning-box">
                    <text class="meaning-desc">{{ meaningDesc }}</text>
                </view>
            </view>
        </view>

        <!-- 诗词出处 -->
        <view class="px-5 mb-4" v-if="poem">
            <view class="card poem-card">
                <view class="poem-header flex items-center space-x-2 mb-4">
                    <text class="poem-icon">📜</text>
                    <text class="section-title">诗词出处</text>
                </view>
                <view class="poem-content text-center">
                    <text class="poem-text">{{ poem.content }}</text>
                    <text class="poem-source mt-3">—— {{ poem.source }}</text>
                </view>
            </view>
        </view>

        <!-- 五行分析 -->
        <view class="px-5 mb-4">
            <view class="card">
                <text class="section-title mb-4">五行分析</text>
                <view class="wuxing-grid grid grid-cols-2 gap-3">
                    <view class="wuxing-item" v-for="item in wuxingItems" :key="item.element">
                        <view class="wuxing-icon" :style="{ background: item.color }">
                            <text class="wuxing-emoji">{{ item.emoji }}</text>
                        </view>
                        <view class="wuxing-info">
                            <text class="wuxing-name">{{ item.element }}</text>
                            <text class="wuxing-char">{{ item.char }}</text>
                        </view>
                    </view>
                </view>
                <view class="wuxing-summary mt-4">
                    <text class="summary-text">{{ wuxingSummary }}</text>
                </view>
            </view>
        </view>

        <!-- 五格数理 -->
        <view class="px-5 mb-4">
            <view class="card">
                <text class="section-title mb-4">五格数理</text>
                <view class="wuge-grid grid grid-cols-3 gap-3">
                    <view class="wuge-item" v-for="item in wugeItems" :key="item.name">
                        <view class="wuge-value">{{ item.value }}</view>
                        <text class="wuge-name">{{ item.name }}</text>
                        <text class="wuge-luck" :class="item.luck">{{ item.luckText }}</text>
                    </view>
                </view>
            </view>
        </view>

        <!-- 底部操作栏 -->
        <view class="bottom-bar fixed bottom-0 left-0 right-0">
            <view class="bar-content flex items-center px-5 py-4">
                <view class="bar-left flex items-center space-x-4">
                    <view class="bar-btn" @click="toggleFavorite">
                        <text class="bar-icon">{{ isFavorite ? '❤️' : '🤍' }}</text>
                        <text class="bar-text">{{ isFavorite ? '已收藏' : '收藏' }}</text>
                    </view>
                    <view class="bar-btn" @click="copyName">
                        <text class="bar-icon">📋</text>
                        <text class="bar-text">复制</text>
                    </view>
                </view>
                <view class="bar-right flex-1 ml-4">
                    <button class="btn-primary w-full" @click="useThisName">
                        <text class="btn-text">选用此名</text>
                    </button>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { showToast } from '../../utils/index';

const currentName = ref({});
const isFavorite = ref(false);

const fullName = computed(() => {
    return (currentName.value.surname || '') + (currentName.value.name || '');
});

const pinyin = computed(() => {
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
    return pinyinMap[currentName.value.name] || 'pīn yīn';
});

const score = computed(() => {
    return 90 + (currentName.value.index || 0);
});

const tags = ref(['诗词典故', '寓意美好', '朗朗上口', '五行平衡']);

const scoreItems = ref([
    { label: '字音评分', value: 95 },
    { label: '字形评分', value: 92 },
    { label: '字义评分', value: 98 },
    { label: '五行评分', value: 90 },
    { label: '五格评分', value: 93 }
]);

const meanings = computed(() => {
    const surname = currentName.value.surname || '';
    const name = currentName.value.name || '';
    const chars = (surname + name).split('');
    const meaningMap = {
        '子': '本义为婴儿，引申为天之骄子、有学问、有德行的人',
        '轩': '古代车子前高后低叫"轩"，引申为高大、气度不凡',
        '浩': '本义指水势浩大，引申为广大、繁多、远大',
        '宇': '本义指屋檐，引申为风度、仪表、天地宇宙',
        '诗': '指诗歌，引申为富有文采、文雅美好',
        '涵': '本义指包容、包含，引申为涵养、修养',
        '欣': '指快乐、喜欢、高兴，引申为蓬勃发展',
        '怡': '指愉快、喜乐，引申为心旷神怡、幸福美满',
        '雨': '指雨水，引申为恩泽、滋润',
        '泽': '指光泽、润泽，引申为恩德、恩惠'
    };
    return chars.map((char, index) => ({
        char: char,
        pinyin: pinyin.value.split(' ')[index] || '',
        meaning: meaningMap[char] || '此字寓意美好，适合用于名字',
        stroke: 5 + Math.floor(Math.random() * 10)
    }));
});

const meaningDesc = computed(() => {
    return '此名字音律优美，朗朗上口，寓意品德高尚、学识渊博、前程似锦。名字组合典雅大气，蕴含着对孩子美好未来的期许，希望孩子能够成为一个有修养、有智慧、有担当的人。';
});

const poem = ref({
    content: '腹有诗书气自华，读书万卷始通神',
    source: '苏轼《和董传留别》'
});

const wuxingItems = computed(() => {
    const chars = fullName.value.split('');
    const elements = ['金', '木', '水', '火', '土'];
    const colors = ['#FFF4E6', '#E8F5E9', '#E3F2FD', '#FFF3E0', '#F5F0EB'];
    const emojis = '🔔🌲💧🔥🌍';
    return chars.slice(0, 4).map((char, index) => ({
        char: char,
        element: elements[index % 5],
        color: colors[index % 5],
        emoji: emojis[index]
    }));
});

const wuxingSummary = computed(() => {
    return '此名字五行搭配均衡，相生相合，寓意一生平顺，事业有成，家庭和睦。';
});

const wugeItems = ref([
    { name: '天格', value: 8, luck: 'good', luckText: '吉' },
    { name: '人格', value: 15, luck: 'good', luckText: '大吉' },
    { name: '地格', value: 13, luck: 'good', luckText: '大吉' },
    { name: '外格', value: 6, luck: 'good', luckText: '吉' },
    { name: '总格', value: 21, luck: 'good', luckText: '大吉' }
]);

onMounted(() => {
    const data = uni.getStorageSync('currentName');
    if (data) {
        currentName.value = data;
    }
});

const goBack = () => {
    uni.navigateBack();
};

const shareName = () => {
    showToast('分享功能开发中');
};

const toggleFavorite = () => {
    isFavorite.value = !isFavorite.value;
    showToast(isFavorite.value ? '已收藏' : '已取消收藏');
};

const copyName = () => {
    uni.setClipboardData({
        data: fullName.value,
        success: () => {
            showToast('已复制到剪贴板');
        }
    });
};

const useThisName = () => {
    showToast('已选用此名');
};
</script>

<style scoped>
.page-container {
    min-height: 100vh;
    background: #F5F0EB;
    padding-bottom: 160rpx;
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

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.name-card {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    padding: 50rpx 30rpx;
}

.name-characters {
    display: flex;
    justify-content: center;
    gap: 24rpx;
    margin-bottom: 20rpx;
}

.char-item {
    width: 120rpx;
    height: 120rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 24rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.char-text {
    font-size: 64rpx;
    font-weight: 700;
    color: white;
}

.name-pinyin {
    display: block;
    font-size: 28rpx;
    color: rgba(255, 255, 255, 0.9);
    margin-bottom: 24rpx;
    letter-spacing: 8rpx;
}

.name-score-display {
    display: flex;
    align-items: baseline;
    justify-content: center;
}

.score-number {
    font-size: 72rpx;
    font-weight: 700;
    color: white;
}

.score-unit {
    font-size: 28rpx;
    color: rgba(255, 255, 255, 0.85);
    margin-left: 8rpx;
}

.tag-item {
    padding: 8rpx 24rpx;
    background: rgba(255, 255, 255, 0.2);
    border-radius: 20rpx;
    font-size: 22rpx;
    color: white;
}

.section-title {
    display: block;
    font-size: 28rpx;
    font-weight: 600;
    color: #634d42;
}

.score-items {
    margin-top: 8rpx;
}

.score-item {
    margin-bottom: 24rpx;
}

.score-label {
    font-size: 26rpx;
    color: #775c4c;
}

.score-value {
    font-size: 26rpx;
    font-weight: 600;
    color: #C41E3A;
}

.progress-bar {
    height: 12rpx;
    background: #f0ebe5;
    border-radius: 6rpx;
    overflow: hidden;
}

.progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #C41E3A, #E8837C);
    border-radius: 6rpx;
    transition: width 0.5s ease;
}

.meaning-list {
    margin-top: 8rpx;
}

.meaning-item {
    padding: 24rpx;
    background: #faf8f5;
    border-radius: 20rpx;
}

.char-badge {
    width: 64rpx;
    height: 64rpx;
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    border-radius: 16rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.char-badge-text {
    font-size: 28rpx;
    font-weight: 600;
    color: white;
}

.char-name {
    font-size: 28rpx;
    font-weight: 600;
    color: #634d42;
    margin-right: 12rpx;
}

.char-pinyin {
    font-size: 24rpx;
    color: #c7b59e;
}

.meaning-content {
    padding-top: 16rpx;
}

.meaning-text {
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.7;
}

.char-stroke {
    margin-top: 12rpx;
    padding-top: 12rpx;
    border-top: 1px solid #efe9e0;
}

.stroke-label {
    font-size: 24rpx;
    color: #c7b59e;
}

.stroke-value {
    font-size: 24rpx;
    color: #634d42;
    font-weight: 500;
}

.meaning-box {
    padding: 24rpx;
    background: linear-gradient(135deg, #fef7ee, #faf8f5);
    border-radius: 20rpx;
}

.meaning-desc {
    font-size: 26rpx;
    color: #775c4c;
    line-height: 1.8;
}

.poem-card {
    background: linear-gradient(135deg, #faf5ff, #fef7ee);
}

.poem-icon {
    font-size: 28rpx;
}

.poem-text {
    display: block;
    font-size: 30rpx;
    font-weight: 500;
    color: #634d42;
    line-height: 1.8;
    letter-spacing: 4rpx;
}

.poem-source {
    display: block;
    font-size: 24rpx;
    color: #91705a;
}

.wuxing-grid {
    display: flex;
    flex-wrap: wrap;
}

.wuxing-item {
    width: 50%;
    display: flex;
    align-items: center;
    gap: 16rpx;
    padding: 20rpx;
    background: #faf8f5;
    border-radius: 20rpx;
}

.wuxing-icon {
    width: 64rpx;
    height: 64rpx;
    border-radius: 16rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.wuxing-emoji {
    font-size: 32rpx;
}

.wuxing-name {
    display: block;
    font-size: 26rpx;
    font-weight: 600;
    color: #634d42;
}

.wuxing-char {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
}

.wuxing-summary {
    padding: 20rpx;
    background: linear-gradient(135deg, #fef7ee, #fffbeb);
    border-radius: 20rpx;
}

.summary-text {
    font-size: 24rpx;
    color: #775c4c;
    line-height: 1.7;
}

.wuge-grid {
    display: flex;
    flex-wrap: wrap;
}

.wuge-item {
    width: 33.33%;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 24rpx 16rpx;
    background: #faf8f5;
    border-radius: 20rpx;
}

.wuge-value {
    font-size: 36rpx;
    font-weight: 700;
    color: #C41E3A;
    margin-bottom: 8rpx;
}

.wuge-name {
    font-size: 24rpx;
    color: #775c4c;
    margin-bottom: 4rpx;
}

.wuge-luck {
    font-size: 22rpx;
    padding: 4rpx 16rpx;
    border-radius: 12rpx;
}

.wuge-luck.good {
    background: #E8F5E9;
    color: #2E7D32;
}

.bottom-bar {
    background: white;
    box-shadow: 0 -4rpx 24rpx rgba(139, 26, 26, 0.08);
    z-index: 100;
}

.bar-content {
    display: flex;
    align-items: center;
}

.bar-btn {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 8rpx 16rpx;
}

.bar-icon {
    font-size: 32rpx;
    margin-bottom: 4rpx;
}

.bar-text {
    font-size: 22rpx;
    color: #775c4c;
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

.px-5 {
    padding-left: 30rpx;
    padding-right: 30rpx;
}

.py-4 {
    padding-top: 24rpx;
    padding-bottom: 24rpx;
}

.mb-4 {
    margin-bottom: 24rpx;
}

.mt-3 {
    margin-top: 12rpx;
}

.mt-4 {
    margin-top: 16rpx;
}

.ml-4 {
    margin-left: 16rpx;
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

.text-center {
    text-align: center;
}

.fixed {
    position: fixed;
}

.bottom-0 {
    bottom: 0;
}

.left-0 {
    left: 0;
}

.right-0 {
    right: 0;
}

.space-x-2 > view:not(:last-child),
.space-x-2 > text:not(:last-child) {
    margin-right: 8rpx;
}

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-x-4 > view:not(:last-child) {
    margin-right: 16rpx;
}

.space-y-4 > view:not(:last-child) {
    margin-bottom: 16rpx;
}

.gap-2 {
    gap: 16rpx;
}

.gap-3 {
    gap: 12rpx;
}
</style>
