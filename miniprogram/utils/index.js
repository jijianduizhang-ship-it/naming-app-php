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

// 删除记录
export function deleteRecord(id) {
    try {
        const records = getRecords();
        const filtered = records.filter(r => r.id !== id);
        uni.setStorageSync('name_records', filtered);
        return filtered;
    } catch (e) {
        console.error('删除记录失败:', e);
        return [];
    }
}

// 保存收藏
export function saveFavorite(name) {
    try {
        const records = getRecords();
        const record = records.find(r => r.name === name);
        if (record) {
            record.favorite = true;
            uni.setStorageSync('name_records', records);
        }
    } catch (e) {
        console.error('保存收藏失败:', e);
    }
}

// 取消收藏
export function removeFavorite(name) {
    try {
        const records = getRecords();
        const record = records.find(r => r.name === name);
        if (record) {
            record.favorite = false;
            uni.setStorageSync('name_records', records);
        }
    } catch (e) {
        console.error('取消收藏失败:', e);
    }
}

// 获取兑换记录
export function getRedeemHistory() {
    try {
        return uni.getStorageSync('redeem_history') || [];
    } catch (e) {
        return [];
    }
}

// 获取起名知识
export function getKnowledge() {
    return [
        { id: 1, title: '生辰八字与起名的关系', preview: '生辰八字是中国传统命理学的重要组成部分...' },
        { id: 2, title: '五行相生相克原理', preview: '五行学说是中国古代哲学思想的精华...' },
        { id: 3, title: '如何选择寓意美好的字', preview: '一个好名字不仅要好听，更要有美好的寓意...' }
    ];
}

// 生成名字（本地模拟）
export function generateNames(params) {
    return new Promise((resolve) => {
        setTimeout(() => {
            const mockNames = [
                { name: '浩然', score: 98, meaning: '正气广大，胸怀宽广', wuxing: '水金', strokes: 19, analysis: '浩：浩然正气，胸怀宽广；然：明辨是非，坦荡自然', poems: ['一点浩然气，千里快哉风 —— 苏轼'] },
                { name: '明轩', score: 96, meaning: '聪明睿智，气宇轩昂', wuxing: '火土', strokes: 17, analysis: '明：光明磊落，明白事理；轩：气宇轩昂，气度不凡', poems: ['载书兼两诏，负笈向三秦 —— 温庭筠'] },
                { name: '思齐', score: 97, meaning: '见贤思齐', wuxing: '金金', strokes: 15, analysis: '思：思维敏捷，深思熟虑；齐：整齐划一，追求卓越', poems: ['见贤思齐焉，见不贤而内自省也 —— 《论语》'] },
                { name: '雨晴', score: 97, meaning: '雨过天晴', wuxing: '水火', strokes: 20, analysis: '雨：润泽万物，温柔体贴；晴：阳光明媚，积极向上', poems: ['东边日出西边雨，道是无晴却有晴 —— 刘禹锡'] },
                { name: '诗涵', score: 95, meaning: '诗情画意，含苞待放', wuxing: '金水', strokes: 22, analysis: '诗：文采飞扬，诗书传家；涵：修养深厚，内涵丰富', poems: ['腹有诗书气自华 —— 苏轼'] },
                { name: '欣怡', score: 94, meaning: '欣喜愉悦，心旷神怡', wuxing: '木土', strokes: 17, analysis: '欣：欣喜快乐，充满活力；怡：心情愉悦，舒适自在', poems: ['心旷神怡，宠辱偕忘 —— 范仲淹'] }
            ];
            const results = mockNames.map((item, index) => ({
                id: Date.now() + index,
                createdAt: new Date().toISOString(),
                ...item
            }));
            resolve(results);
        }, 1500);
    });
}
