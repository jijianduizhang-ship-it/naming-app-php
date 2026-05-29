<template>
    <view class="page-container pb-20">
        <!-- 导航栏 -->
        <view class="nav-bar">
            <view class="nav-back" @click="goBack">
                <text class="icon-text">←</text>
            </view>
            <text class="nav-title">宝宝起名</text>
            <view class="nav-help">
                <text class="icon-text">?</text>
            </view>
        </view>

        <!-- 表单内容 -->
        <scroll-view class="form-container" scroll-y="true">
            <!-- 姓氏 -->
            <view class="card mb-4">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon primary-bg">
                        <text class="icon">✏️</text>
                    </view>
                    <text class="form-label">姓氏</text>
                    <text class="required-tag">*必填</text>
                </view>
                <input 
                    class="input-field" 
                    v-model="formData.surname" 
                    placeholder="请输入宝宝姓氏" 
                    maxlength="2"
                />
                <text class="form-tip">请输入宝宝随父/母的姓氏</text>
            </view>

            <!-- 性别 -->
            <view class="card mb-4">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon pink-bg">
                        <text class="icon">⚤</text>
                    </view>
                    <text class="form-label">性别</text>
                    <text class="required-tag">*必填</text>
                </view>
                <view class="gender-select flex space-x-3">
                    <view 
                        class="gender-btn flex-1" 
                        :class="{ active: formData.gender === 'boy' }"
                        @click="selectGender('boy')"
                    >
                        <text class="gender-icon">♂</text>
                        <text class="gender-text">男宝宝</text>
                        <text class="gender-desc">阳刚大气</text>
                    </view>
                    <view 
                        class="gender-btn flex-1" 
                        :class="{ active: formData.gender === 'girl' }"
                        @click="selectGender('girl')"
                    >
                        <text class="gender-icon">♀</text>
                        <text class="gender-text">女宝宝</text>
                        <text class="gender-desc">温婉优雅</text>
                    </view>
                </view>
            </view>

            <!-- 名字字数 -->
            <view class="card mb-4">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon teal-bg">
                        <text class="icon">↔</text>
                    </view>
                    <text class="form-label">名字字数</text>
                    <text class="optional-tag">选填</text>
                </view>
                <view class="length-select flex space-x-3">
                    <view 
                        class="length-btn flex-1" 
                        :class="{ active: formData.nameLength === 2 }"
                        @click="selectNameLength(2)"
                    >
                        <text class="length-text">2字名</text>
                        <text class="length-desc">如：李明</text>
                    </view>
                    <view 
                        class="length-btn flex-1" 
                        :class="{ active: formData.nameLength === 3 }"
                        @click="selectNameLength(3)"
                    >
                        <text class="length-text">3字名</text>
                        <text class="length-desc">如：李子轩</text>
                    </view>
                </view>
            </view>

            <!-- 出生日期 -->
            <view class="card mb-4">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon blue-bg">
                        <text class="icon">📅</text>
                    </view>
                    <text class="form-label">出生日期</text>
                    <text class="required-tag">*必填</text>
                </view>
                <view class="date-select grid grid-cols-3 gap-3">
                    <picker mode="selector" :range="years" @change="onYearChange">
                        <view class="date-picker input-field text-center">
                            {{ formData.birthYear || '选年' }}
                        </view>
                    </picker>
                    <picker mode="selector" :range="months" @change="onMonthChange">
                        <view class="date-picker input-field text-center">
                            {{ formData.birthMonth || '选月' }}
                        </view>
                    </picker>
                    <picker mode="selector" :range="days" @change="onDayChange">
                        <view class="date-picker input-field text-center">
                            {{ formData.birthDay || '选日' }}
                        </view>
                    </picker>
                </view>
                <view class="lunar-info" v-if="showLunarInfo">
                    <text class="lunar-icon">🌙</text>
                    <text class="lunar-text">农历：{{ lunarInfo }}</text>
                    <text class="zodiac-tag">{{ zodiac }}年</text>
                </view>
            </view>

            <!-- 出生时辰 -->
            <view class="card mb-4">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon purple-bg">
                        <text class="icon">🕐</text>
                    </view>
                    <text class="form-label">出生时辰</text>
                    <text class="required-tag">*必填</text>
                </view>
                <view class="time-select grid grid-cols-2 gap-3">
                    <picker mode="selector" :range="shichenList" @change="onShichenChange">
                        <view class="time-picker input-field text-center">
                            {{ formData.shichen || '选时' }}
                        </view>
                    </picker>
                    <picker mode="selector" :range="minutesList" @change="onMinuteChange">
                        <view class="time-picker input-field text-center">
                            {{ formData.birthMinute || '选分' }}
                        </view>
                    </picker>
                </view>
                <view class="shichen-info" v-if="showShichenInfo">
                    <text class="shichen-icon">☀️</text>
                    <text class="shichen-text">对应时辰：{{ shichenInfo }}</text>
                </view>
            </view>

            <!-- 起名偏好 -->
            <view class="card mb-5">
                <view class="form-header flex items-center space-x-2 mb-4">
                    <view class="form-icon amber-bg">
                        <text class="icon">🎛️</text>
                    </view>
                    <text class="form-label">起名偏好</text>
                    <text class="optional-tag">选填</text>
                </view>
                <view class="tags-container flex flex-wrap gap-2">
                    <view 
                        class="tag-chip" 
                        :class="{ selected: selectedTags.includes(tag) }"
                        v-for="tag in preferenceTags" 
                        :key="tag"
                        @click="toggleTag(tag)"
                    >
                        {{ tag }}
                    </view>
                </view>
            </view>

            <!-- 提交按钮 -->
            <view class="px-5 mb-5">
                <button class="btn-primary w-full py-4" @click="submitForm">
                    <text class="btn-text">✨ 开始智能起名</text>
                </button>
            </view>
        </scroll-view>

        <!-- 加载遮罩 -->
        <view class="loading-overlay" v-if="isLoading">
            <view class="loading-content">
                <view class="spinner"></view>
                <text class="loading-text">AI 正在为您起名...</text>
                <text class="loading-subtext">请稍候</text>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { 
    showToast, 
    showLoading, 
    hideLoading, 
    getLocalNames, 
    saveRecord,
    getCredits,
    setCredits
} from '../../utils/index';

const formData = ref({
    surname: '',
    gender: 'boy',
    nameLength: 2,
    birthYear: '',
    birthMonth: '',
    birthDay: '',
    shichen: '',
    birthMinute: ''
});

const preferenceTags = ref([
    '诗词典故',
    '成语起名',
    '现代简约',
    '儒雅古风',
    '霸气响亮',
    '清新文艺'
]);

const selectedTags = ref(['诗词典故']);

const years = ref([]);
const months = ref([]);
const days = ref([]);
const shichenList = ref([
    '子时(23点)', '丑时(1点)', '寅时(3点)', '卯时(5点)', 
    '辰时(7点)', '巳时(9点)', '午时(11点)', '未时(13点)', 
    '申时(15点)', '酉时(17点)', '戌时(19点)', '亥时(21点)'
]);
const shichenHours = [23, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21];
const shichenNames = ['子', '丑', '寅', '卯', '辰', '巳', '午', '未', '申', '酉', '戌', '亥'];
const minutesList = ref([]);

const isLoading = ref(false);
const lunarInfo = ref('');
const zodiac = ref('');

const showLunarInfo = computed(() => {
    return formData.value.birthYear && formData.value.birthMonth && formData.value.birthDay;
});

const showShichenInfo = computed(() => {
    return formData.value.shichen;
});

const shichenInfo = computed(() => {
    if (!formData.value.shichen) return '';
    const idx = shichenList.value.findIndex(s => s === formData.value.shichen);
    if (idx === -1) return '';
    const startHour = shichenHours[idx];
    const endHour = (startHour + 2) % 24;
    return `${shichenNames[idx]}时 (${startHour}:00-${endHour}:00)`;
});

const zodiacList = ['鼠', '牛', '虎', '兔', '龙', '蛇', '马', '羊', '猴', '鸡', '狗', '猪'];

onMounted(() => {
    initYears();
    initMonths();
    initMinutes();
    updateDays();
});

const initYears = () => {
    const currentYear = new Date().getFullYear();
    for (let y = currentYear; y >= 1950; y--) {
        years.value.push(y + '年');
    }
};

const initMonths = () => {
    for (let m = 1; m <= 12; m++) {
        months.value.push(m + '月');
    }
};

const initMinutes = () => {
    for (let m = 0; m <= 59; m++) {
        minutesList.value.push(String(m).padStart(2, '0') + '分');
    }
};

const updateDays = () => {
    days.value = [];
    if (!formData.value.birthYear || !formData.value.birthMonth) {
        return;
    }
    
    const year = parseInt(formData.value.birthYear);
    const month = parseInt(formData.value.birthMonth);
    const dayCount = new Date(year, month, 0).getDate();
    
    for (let d = 1; d <= dayCount; d++) {
        days.value.push(d + '日');
    }
    
    if (formData.value.birthDay) {
        const dayNum = parseInt(formData.value.birthDay);
        if (dayNum > dayCount) {
            formData.value.birthDay = '';
        }
    }
    
    updateLunarInfo();
};

const updateLunarInfo = () => {
    if (!formData.value.birthYear || !formData.value.birthMonth || !formData.value.birthDay) {
        return;
    }
    
    const year = parseInt(formData.value.birthYear);
    const month = parseInt(formData.value.birthMonth);
    const day = parseInt(formData.value.birthDay);
    
    const zodiacIdx = ((year - 4) % 12 + 12) % 12;
    zodiac.value = zodiacList[zodiacIdx];
    
    lunarInfo.value = `${month}月${day}日`;
};

const goBack = () => {
    uni.switchTab({
        url: '/pages/home/home'
    });
};

const selectGender = (gender) => {
    formData.value.gender = gender;
};

const selectNameLength = (length) => {
    formData.value.nameLength = length;
};

const onYearChange = (e) => {
    formData.value.birthYear = years.value[e.detail.value];
    updateDays();
};

const onMonthChange = (e) => {
    formData.value.birthMonth = months.value[e.detail.value];
    updateDays();
};

const onDayChange = (e) => {
    formData.value.birthDay = days.value[e.detail.value];
    updateLunarInfo();
};

const onShichenChange = (e) => {
    formData.value.shichen = shichenList.value[e.detail.value];
};

const onMinuteChange = (e) => {
    formData.value.birthMinute = minutesList.value[e.detail.value];
};

const toggleTag = (tag) => {
    const idx = selectedTags.value.indexOf(tag);
    if (idx > -1) {
        if (selectedTags.value.length > 1) {
            selectedTags.value.splice(idx, 1);
        }
    } else {
        selectedTags.value.push(tag);
    }
};

const submitForm = async () => {
    if (!formData.value.surname.trim()) {
        showToast('请输入姓氏');
        return;
    }
    if (!formData.value.birthYear || !formData.value.birthMonth || !formData.value.birthDay) {
        showToast('请选择完整出生日期');
        return;
    }
    if (!formData.value.shichen) {
        showToast('请选择出生时辰');
        return;
    }

    const credits = getCredits();
    if (credits <= 0) {
        showToast('请先兑换起名次数');
        setTimeout(() => {
            uni.navigateTo({
                url: '/pages/redeem/redeem'
            });
        }, 1500);
        return;
    }

    setCredits(credits - 1);

    isLoading.value = true;

    setTimeout(() => {
        const names = getLocalNames(formData.value.gender);
        
        const record = {
            id: Date.now(),
            surname: formData.value.surname,
            gender: formData.value.gender,
            birthday: `${formData.value.birthYear}-${formData.value.birthMonth}-${formData.value.birthDay}`,
            birthtime: formData.value.shichen,
            preferences: [...selectedTags.value],
            names: names,
            bazi: null,
            source: 'local',
            createdAt: new Date().toISOString()
        };
        
        saveRecord(record);
        
        isLoading.value = false;
        
        uni.setStorageSync('currentRecord', record);
        
        uni.navigateTo({
            url: '/pages/result/result'
        });
    }, 2000);
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

.nav-back, .nav-help {
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

.form-container {
    padding: 30rpx;
    height: calc(100vh - 200rpx);
}

.card {
    background: white;
    border-radius: 28rpx;
    box-shadow: 0 4rpx 32rpx rgba(139, 26, 26, 0.08);
    padding: 30rpx;
}

.form-header {
    margin-bottom: 24rpx;
}

.form-icon {
    width: 56rpx;
    height: 56rpx;
    border-radius: 14rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

.primary-bg { background: #fef7ee; }
.pink-bg { background: #fdf2f8; }
.teal-bg { background: #f0fdfa; }
.blue-bg { background: #eff6ff; }
.purple-bg { background: #faf5ff; }
.amber-bg { background: #fffbeb; }

.icon {
    font-size: 24rpx;
}

.form-label {
    font-size: 28rpx;
    font-weight: 500;
    color: #634d42;
}

.required-tag {
    font-size: 24rpx;
    color: #ee7711;
}

.optional-tag {
    font-size: 24rpx;
    color: #c7b59e;
}

.input-field {
    background: #faf8f5;
    border: 2rpx solid #efe9e0;
    border-radius: 28rpx;
    padding: 24rpx 28rpx;
    font-size: 28rpx;
    color: #534138;
    transition: all 0.3s;
}

.input-field:focus {
    border-color: #C41E3A;
    background: white;
}

.form-tip {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
    margin-top: 16rpx;
}

.gender-select, .length-select {
    display: flex;
}

.gender-btn, .length-btn {
    flex: 1;
    padding: 28rpx;
    border-radius: 28rpx;
    border: 2rpx solid #efe9e0;
    background: #faf8f5;
    text-align: center;
    transition: all 0.3s;
}

.gender-btn.active, .length-btn.active {
    border-color: #C41E3A;
    background: linear-gradient(135deg, rgba(196, 30, 58, 0.05), rgba(232, 131, 124, 0.05));
}

.gender-icon {
    display: block;
    font-size: 48rpx;
    margin-bottom: 8rpx;
}

.gender-btn.active .gender-icon {
    color: #C41E3A;
}

.gender-text, .length-text {
    display: block;
    font-size: 28rpx;
    font-weight: 500;
}

.gender-btn.active .gender-text,
.length-btn.active .length-text {
    color: #C41E3A;
}

.gender-desc, .length-desc {
    display: block;
    font-size: 24rpx;
    color: #c7b59e;
    margin-top: 4rpx;
}

.date-select, .time-select {
    display: flex;
}

.grid-cols-3 {
    width: 100%;
}

.grid-cols-2 {
    width: 100%;
}

.date-picker, .time-picker {
    flex: 1;
}

.lunar-info {
    background: linear-gradient(135deg, #fffbeb, #fef7ee);
    border-radius: 24rpx;
    padding: 24rpx;
    margin-top: 24rpx;
    display: flex;
    align-items: center;
}

.lunar-icon, .shichen-icon {
    font-size: 28rpx;
    margin-right: 12rpx;
}

.lunar-text, .shichen-text {
    font-size: 24rpx;
    color: #775c4c;
}

.zodiac-tag {
    font-size: 24rpx;
    color: #c7b59e;
    margin-left: auto;
}

.shichen-info {
    background: linear-gradient(135deg, #faf5ff, #eff6ff);
    border-radius: 24rpx;
    padding: 24rpx;
    margin-top: 24rpx;
    display: flex;
    align-items: center;
}

.tags-container {
    display: flex;
    flex-wrap: wrap;
}

.tag-chip {
    padding: 12rpx 28rpx;
    border-radius: 40rpx;
    font-size: 24rpx;
    border: 2rpx solid #efe9e0;
    background: white;
    color: #634d42;
    transition: all 0.2s;
}

.tag-chip.selected {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    color: white;
    border-color: transparent;
}

.btn-primary {
    background: linear-gradient(135deg, #C41E3A, #E8837C);
    color: white;
    border-radius: 28rpx;
    font-size: 32rpx;
    font-weight: 500;
    border: none;
    box-shadow: 0 8rpx 40rpx rgba(196, 30, 58, 0.3);
}

.btn-text {
    font-size: 32rpx;
    font-weight: 500;
}

.loading-overlay {
    position: fixed;
    inset: 0;
    background: rgba(245, 240, 235, 0.95);
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.spinner {
    width: 80rpx;
    height: 80rpx;
    border: 6rpx solid #f0ebe5;
    border-top-color: #C41E3A;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.loading-text {
    font-size: 28rpx;
    color: #775c4c;
    font-weight: 500;
    margin-top: 24rpx;
}

.loading-subtext {
    font-size: 24rpx;
    color: #c7b59e;
    margin-top: 8rpx;
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

.space-x-2 > view:not(:last-child),
.space-x-2 > text:not(:last-child) {
    margin-right: 8rpx;
}

.space-x-3 > view:not(:last-child) {
    margin-right: 24rpx;
}

.gap-2 {
    gap: 16rpx;
}

.w-full {
    width: 100%;
}

.flex-1 {
    flex: 1;
}

.py-4 {
    padding-top: 24rpx;
    padding-bottom: 24rpx;
}

.text-center {
    text-align: center;
}
</style>
