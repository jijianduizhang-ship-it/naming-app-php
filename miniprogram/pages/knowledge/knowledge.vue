<template>
    <view class="page-container">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">起名知识</text>
            <view class="nav-empty"></view>
        </view>

        <!-- 搜索栏 -->
        <view class="search-section px-5">
            <view class="search-box">
                <text class="search-icon">🔍</text>
                <input class="search-input" placeholder="搜索起名知识..." v-model="searchText" />
            </view>
        </view>

        <!-- 分类标签 -->
        <view class="tab-section px-5">
            <scroll-view class="tab-scroll" scroll-x="true" show-scrollbar="false">
                <view class="tab-list flex">
                    <view 
                        class="tab-item" 
                        :class="{ active: activeTab === index }" 
                        v-for="(tab, index) in tabs" 
                        :key="index"
                        @click="switchTab(index)"
                    >
                        {{ tab }}
                    </view>
                </view>
            </scroll-view>
        </view>

        <!-- 文章列表 -->
        <view class="article-section px-5">
            <view class="article-list">
                <view class="article-item card" v-for="(article, index) in filteredArticles" :key="index" @click="viewArticle(article)">
                    <view class="article-header flex items-start space-x-3">
                        <image class="article-cover" :src="article.cover" mode="aspectFill" />
                        <view class="article-info flex-1">
                            <text class="article-title">{{ article.title }}</text>
                            <text class="article-desc">{{ article.desc }}</text>
                            <view class="article-meta flex items-center space-x-4 mt-2">
                                <view class="meta-item flex items-center space-x-1">
                                    <text class="meta-icon">👁️</text>
                                    <text class="meta-text">{{ article.views }}</text>
                                </view>
                                <view class="meta-item flex items-center space-x-1">
                                    <text class="meta-icon">❤️</text>
                                    <text class="meta-text">{{ article.likes }}</text>
                                </view>
                                <text class="article-date">{{ article.date }}</text>
                            </view>
                        </view>
                    </view>
                    <view class="article-tags flex flex-wrap gap-2 mt-3" v-if="article.tags && article.tags.length">
                        <text class="article-tag" v-for="(tag, tagIndex) in article.tags" :key="tagIndex">{{ tag }}</text>
                    </view>
                </view>
            </view>

            <!-- 空状态 -->
            <view class="empty-state" v-if="filteredArticles.length === 0">
                <text class="empty-icon">📚</text>
                <text class="empty-text">暂无相关文章</text>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, computed } from 'vue';

const searchText = ref('');
const activeTab = ref(0);

const tabs = ['全部', '八字命理', '五行学说', '诗词典故', '起名技巧', '姓名文化'];

const articles = ref([
    {
        id: 1,
        title: '2024龙年宝宝起名技巧与注意事项',
        desc: '龙年宝宝起名有哪些讲究？如何结合龙年特点为宝宝起一个吉祥如意的好名字？',
        cover: 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=400&h=300&fit=crop',
        views: '12.5k',
        likes: '2.3k',
        date: '2024-01-15',
        category: 1,
        tags: ['龙年', '起名技巧']
    },
    {
        id: 2,
        title: '如何根据五行八字为宝宝选个好名字',
        desc: '深入解析五行相生相克原理，教你如何根据宝宝的八字命理选择最合适的名字。',
        cover: 'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=400&h=300&fit=crop',
        views: '8.9k',
        likes: '1.8k',
        date: '2024-01-10',
        category: 2,
        tags: ['五行', '八字']
    },
    {
        id: 3,
        title: '诗经楚辞中的绝美名字推荐',
        desc: '精选《诗经》《楚辞》中的经典名句，为宝宝起一个富有文化底蕴的好名字。',
        cover: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=400&h=300&fit=crop',
        views: '15.2k',
        likes: '3.1k',
        date: '2024-01-08',
        category: 3,
        tags: ['诗经', '楚辞']
    },
    {
        id: 4,
        title: '男宝宝起名：阳刚大气的名字精选',
        desc: '精选100个阳刚大气、寓意深远的男宝宝名字，附详细解析和出处。',
        cover: 'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?w=400&h=300&fit=crop',
        views: '11.3k',
        likes: '2.5k',
        date: '2024-01-05',
        category: 4,
        tags: ['男宝宝', '阳刚']
    },
    {
        id: 5,
        title: '女宝宝起名：温婉优雅的名字精选',
        desc: '精选100个温婉优雅、诗意盎然的女宝宝名字，附详细解析和出处。',
        cover: 'https://images.unsplash.com/photo-1519689680058-324335c77eba?w=400&h=300&fit=crop',
        views: '13.8k',
        likes: '2.9k',
        date: '2024-01-03',
        category: 4,
        tags: ['女宝宝', '优雅']
    },
    {
        id: 6,
        title: '中国姓名文化的发展与演变',
        desc: '从古代到现代，中国姓名文化经历了怎样的发展演变？本文为你详细解读。',
        cover: 'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?w=400&h=300&fit=crop',
        views: '6.7k',
        likes: '1.2k',
        date: '2024-01-01',
        category: 5,
        tags: ['姓名文化', '历史']
    },
    {
        id: 7,
        title: '起名避坑指南：这10种名字千万别用',
        desc: '起名时有哪些需要避开的坑？本文总结了10种常见的起名误区，帮你避免踩雷。',
        cover: 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&h=300&fit=crop',
        views: '9.4k',
        likes: '1.9k',
        date: '2023-12-28',
        category: 4,
        tags: ['避坑', '技巧']
    },
    {
        id: 8,
        title: '十二生肖与起名宜忌',
        desc: '不同生肖的宝宝起名有哪些宜忌？本文为你详解十二生肖与起名的关系。',
        cover: 'https://images.unsplash.com/photo-1532629345422-7515f3d16bb6?w=400&h=300&fit=crop',
        views: '7.8k',
        likes: '1.5k',
        date: '2023-12-25',
        category: 1,
        tags: ['生肖', '宜忌']
    }
]);

const filteredArticles = computed(() => {
    let result = articles.value;
    
    // 分类筛选
    if (activeTab.value !== 0) {
        result = result.filter(article => article.category === activeTab.value);
    }
    
    // 搜索筛选
    if (searchText.value.trim()) {
        const keyword = searchText.value.toLowerCase();
        result = result.filter(article => 
            article.title.toLowerCase().includes(keyword) || 
            article.desc.toLowerCase().includes(keyword) ||
            (article.tags && article.tags.some(tag => tag.toLowerCase().includes(keyword)))
        );
    }
    
    return result;
});

const goBack = () => {
    uni.switchTab({
        url: '/pages/home/home'
    });
};

const switchTab = (index) => {
    activeTab.value = index;
};

const viewArticle = (article) => {
    uni.showToast({
        title: '文章详情开发中',
        icon: 'none'
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

.search-section {
    padding-top: 24rpx;
}

.search-box {
    background: white;
    border-radius: 28rpx;
    padding: 20rpx 30rpx;
    display: flex;
    align-items: center;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
}

.search-icon {
    font-size: 28rpx;
    margin-right: 16rpx;
}

.search-input {
    flex: 1;
    font-size: 28rpx;
    color: #634d42;
}

.tab-section {
    padding-top: 24rpx;
    padding-bottom: 24rpx;
}

.tab-scroll {
    white-space: nowrap;
}

.tab-list {
    padding: 0 4rpx;
}

.tab-item {
    display: inline-block;
    padding: 16rpx 32rpx;
    margin-right: 16rpx;
    background: white;
    border-radius: 40rpx;
    font-size: 26rpx;
    color: #775c4c;
    transition: all 0.3s;
}

.tab-item.active {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    color: white;
    font-weight: 500;
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.article-section {
    padding-bottom: 30rpx;
}

.article-list {
    display: flex;
    flex-direction: column;
    gap: 24rpx;
}

.article-item {
    transition: transform 0.2s;
}

.article-item:active {
    transform: scale(0.98);
}

.article-cover {
    width: 200rpx;
    height: 160rpx;
    border-radius: 20rpx;
    flex-shrink: 0;
}

.article-info {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}

.article-title {
    font-size: 28rpx;
    font-weight: 600;
    color: #634d42;
    line-height: 1.5;
    margin-bottom: 8rpx;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.article-desc {
    font-size: 24rpx;
    color: #91705a;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.article-meta {
    display: flex;
    align-items: center;
}

.meta-item {
    display: flex;
    align-items: center;
}

.meta-icon {
    font-size: 22rpx;
}

.meta-text {
    font-size: 22rpx;
    color: #c7b59e;
}

.article-date {
    font-size: 22rpx;
    color: #c7b59e;
}

.article-tags {
    display: flex;
    flex-wrap: wrap;
    padding-top: 16rpx;
    border-top: 1px solid #efe9e0;
    margin-top: 16rpx;
}

.article-tag {
    padding: 8rpx 20rpx;
    background: #faf8f5;
    border-radius: 20rpx;
    font-size: 22rpx;
    color: #775c4c;
}

.empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 120rpx 0;
}

.empty-icon {
    font-size: 100rpx;
    margin-bottom: 24rpx;
    opacity: 0.5;
}

.empty-text {
    font-size: 28rpx;
    color: #c7b59e;
}

.flex {
    display: flex;
}

.flex-1 {
    flex: 1;
}

.flex-wrap {
    flex-wrap: wrap;
}

.items-center {
    align-items: center;
}

.items-start {
    align-items: flex-start;
}

.space-x-1 > view:not(:last-child),
.space-x-1 > text:not(:last-child) {
    margin-right: 4rpx;
}

.space-x-3 > view:not(:last-child),
.space-x-3 > text:not(:last-child) {
    margin-right: 12rpx;
}

.space-x-4 > view:not(:last-child),
.space-x-4 > text:not(:last-child) {
    margin-right: 16rpx;
}

.gap-2 {
    gap: 16rpx;
}

.mt-2 {
    margin-top: 8rpx;
}

.mt-3 {
    margin-top: 12rpx;
}

.px-5 {
    padding-left: 30rpx;
    padding-right: 30rpx;
}
</style>
