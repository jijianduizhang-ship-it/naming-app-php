// API 基础配置
const API_BASE = '/api';

// 封装请求
function request(url, method = 'GET', data = {}) {
    return new Promise((resolve, reject) => {
        uni.request({
            url: API_BASE + url,
            method,
            data,
            success: (res) => {
                if (res.statusCode === 200) {
                    resolve(res.data);
                } else {
                    reject(res);
                }
            },
            fail: (err) => {
                reject(err);
            }
        });
    });
}

// 获取文章列表
export function getArticles(params = {}) {
    return request('/article', 'GET', params);
}

// 获取文章详情
export function getArticleDetail(id) {
    return request(`/article/${id}`, 'GET');
}

// 登录
export function login(data) {
    return request('/login', 'POST', data);
}

// 兑换码兑换
export function redeemCode(data) {
    return request('/redeem', 'POST', data);
}

// 起名请求
export function naming(data) {
    return request('/naming', 'POST', data);
}

// 保存记录
export function saveRecordToServer(data) {
    return request('/save-record', 'POST', data);
}

// 获取知识列表
export function getKnowledge(params = {}) {
    return request('/knowledge', 'GET', params);
}
