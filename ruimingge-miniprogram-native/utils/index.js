const API_BASE = 'https://api.ruimingge.com'

const mockNames = [
  {
    name: '明远',
    pinyin: 'Míng Yuǎn',
    score: 98,
    meaning: '明智而远见',
    wuxing: '火土',
    strokes: 17,
    analysis: '明：光明磊落，明白事理；远：志向远大，前程似锦',
    poems: ['非淡泊无以明志，非宁静无以致远 —— 诸葛亮']
  },
  {
    name: '思齐',
    pinyin: 'Sī Qí',
    score: 96,
    meaning: '见贤思齐',
    wuxing: '金金',
    strokes: 15,
    analysis: '思：思维敏捷，深思熟虑；齐：整齐划一，追求卓越',
    poems: ['见贤思齐焉，见不贤而内自省也 —— 《论语》']
  },
  {
    name: '雨晴',
    pinyin: 'Yǔ Qíng',
    score: 97,
    meaning: '雨过天晴',
    wuxing: '水火',
    strokes: 20,
    analysis: '雨：润泽万物，温柔体贴；晴：阳光明媚，积极向上',
    poems: ['东边日出西边雨，道是无晴却有晴 —— 刘禹锡']
  },
  {
    name: '文轩',
    pinyin: 'Wén Xuān',
    score: 95,
    meaning: '文采飞扬，气宇轩昂',
    wuxing: '水土',
    strokes: 11,
    analysis: '文：文采斐然，博学多才；轩：气宇轩昂，气度不凡',
    poems: ['载书兼两诏，负笈向三秦 —— 温庭筠']
  },
  {
    name: '若溪',
    pinyin: 'Ruò Xī',
    score: 94,
    meaning: '上善若水',
    wuxing: '木水',
    strokes: 19,
    analysis: '若：温柔如水，沉静内敛；溪：清澈见底，纯净善良',
    poems: ['山中兰叶径，城外李桃园 —— 王勃']
  },
  {
    name: '浩然',
    pinyin: 'Hào Rán',
    score: 97,
    meaning: '浩然正气',
    wuxing: '水金',
    strokes: 19,
    analysis: '浩：浩然正气，胸怀宽广；然：明辨是非，坦荡自然',
    poems: ['一点浩然气，千里快哉风 —— 苏轼']
  }
]

function generateNames(params) {
  return new Promise((resolve) => {
    setTimeout(() => {
      const results = mockNames.slice(0, 6).map((item, index) => ({
        id: Date.now() + index,
        ...item,
        createdAt: new Date().toISOString()
      }))
      resolve(results)
    }, 1500)
  })
}

function getKnowledge() {
  return [
    { id: 1, title: '生辰八字与起名的关系', preview: '生辰八字是中国传统命理学的重要组成部分...' },
    { id: 2, title: '五行相生相克原理', preview: '五行学说是中国古代哲学思想的精华...' },
    { id: 3, title: '如何选择寓意美好的字', preview: '一个好名字不仅要好听，更要有美好的寓意...' }
  ]
}

function getCredits() {
  const credits = wx.getStorageSync('naming_credits') || 0
  return credits
}

function useCredit() {
  const credits = wx.getStorageSync('naming_credits') || 0
  if (credits > 0) {
    wx.setStorageSync('naming_credits', credits - 1)
    return true
  }
  return false
}

function addCredits(amount, code) {
  const current = wx.getStorageSync('naming_credits') || 0
  wx.setStorageSync('naming_credits', current + amount)
  
  const history = wx.getStorageSync('redeem_history') || []
  history.unshift({ code, amount, time: new Date().toLocaleString() })
  wx.setStorageSync('redeem_history', history)
}

function saveRecord(record) {
  const records = wx.getStorageSync('name_records') || []
  records.unshift(record)
  wx.setStorageSync('name_records', records)
}

function getRecords() {
  return wx.getStorageSync('name_records') || []
}

function deleteRecord(id) {
  const records = wx.getStorageSync('name_records') || []
  const filtered = records.filter(r => r.id !== id)
  wx.setStorageSync('name_records', filtered)
  return filtered
}

function saveFavorite(name) {
  const records = wx.getStorageSync('name_records') || []
  const record = records.find(r => r.name === name)
  if (record) {
    record.favorite = true
    wx.setStorageSync('name_records', records)
  }
}

function removeFavorite(name) {
  const records = wx.getStorageSync('name_records') || []
  const record = records.find(r => r.name === name)
  if (record) {
    record.favorite = false
    wx.setStorageSync('name_records', records)
  }
}

function getRedeemHistory() {
  return wx.getStorageSync('redeem_history') || []
}

module.exports = {
  generateNames,
  getKnowledge,
  getCredits,
  useCredit,
  addCredits,
  saveRecord,
  getRecords,
  deleteRecord,
  saveFavorite,
  removeFavorite,
  getRedeemHistory
}
