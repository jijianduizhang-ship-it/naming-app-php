// 格式化日期
export function formatDate(isoStr) {
    const date = new Date(isoStr);
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hour = String(date.getHours()).padStart(2, '0');
    const minute = String(date.getMinutes()).padStart(2, '0');
    return `${month}月${day}日 ${hour}:${minute}`;
}

// 格式化数字，大于1000显示为k
export function formatNumber(num) {
    if (num >= 1000) {
        return (num / 1000).toFixed(1) + 'k';
    }
    return String(num);
}

// 获取本地起名记录
export function getRecords() {
    try {
        return uni.getStorageSync('name_records') || [];
    } catch (e) {
        return [];
    }
}

// 保存起名记录
export function saveRecord(record) {
    try {
        const records = getRecords();
        records.unshift(record);
        uni.setStorageSync('name_records', records.slice(0, 100));
    } catch (e) {
        console.error('保存记录失败:', e);
    }
}

// 获取剩余次数
export function getCredits() {
    try {
        return parseInt(uni.getStorageSync('naming_credits') || '0');
    } catch (e) {
        return 0;
    }
}

// 设置剩余次数
export function setCredits(credits) {
    try {
        uni.setStorageSync('naming_credits', credits);
    } catch (e) {
        console.error('设置次数失败:', e);
    }
}

// 保存兑换记录
export function saveRedeemHistory(item) {
    try {
        const history = uni.getStorageSync('redeem_history') || [];
        history.unshift(item);
        uni.setStorageSync('redeem_history', history);
    } catch (e) {
        console.error('保存兑换记录失败:', e);
    }
}

// 本地名字数据（用于离线时使用）
export function getLocalNames(gender) {
    if (gender === 'boy') {
        return [
            { name: '浩然', score: 98, meaning: '正气广大，胸怀宽广', source: '《孟子》', wuxing: '水' },
            { name: '明轩', score: 96, meaning: '聪明睿智，气宇轩昂', source: '成语', wuxing: '土' },
            { name: '思远', score: 95, meaning: '思虑深远，志存高远', source: '《诗经》', wuxing: '木' },
            { name: '一诺', score: 97, meaning: '一言九鼎，诚实守信', source: '成语', wuxing: '火' },
            { name: '宇航', score: 94, meaning: '遨游宇宙，探索未知', source: '现代', wuxing: '土' },
            { name: '子墨', score: 92, meaning: '文房四宝，诗书传家', source: '诗词', wuxing: '土' }
        ];
    } else {
        return [
            { name: '诗涵', score: 97, meaning: '诗情画意，含苞待放', source: '《诗经》', wuxing: '水' },
            { name: '雨晴', score: 96, meaning: '雨过天晴，清新美好', source: '诗词', wuxing: '火' },
            { name: '欣怡', score: 95, meaning: '欣喜愉悦，心旷神怡', source: '诗词', wuxing: '土' },
            { name: '梓萱', score: 94, meaning: '生机勃勃，美丽坚强', source: '诗词', wuxing: '木' },
            { name: '雅楠', score: 95, meaning: '高雅大方，坚韧不拔', source: '成语', wuxing: '木' },
            { name: '梦琪', score: 94, meaning: '梦回唐朝，美玉无瑕', source: '诗词', wuxing: '木' }
        ];
    }
}

// 显示提示信息
export function showToast(title, icon = 'none', duration = 2000) {
    uni.showToast({
        title,
        icon,
        duration
    });
}

// 显示加载提示
export function showLoading(title = '加载中...') {
    uni.showLoading({
        title,
        mask: true
    });
}

// 隐藏加载提示
export function hideLoading() {
    uni.hideLoading();
}
