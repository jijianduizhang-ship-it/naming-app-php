const utils = require('../../utils/index')

Page({
  data: {
    features: [
      { icon: '📜', title: '生辰八字', desc: '基于传统命理学分析' },
      { icon: '⚡', title: '五行平衡', desc: '追求最佳五行搭配' },
      { icon: '📚', title: '诗词典故', desc: '名字出处有据可考' },
      { icon: '⭐', title: '评分系统', desc: '多维度综合评分' }
    ]
  },

  goToNaming() {
    wx.switchTab({
      url: '/pages/naming/naming'
    })
  },

  goToKnowledge() {
    wx.navigateTo({
      url: '/pages/knowledge/knowledge'
    })
  },

  goToAbout() {
    wx.navigateTo({
      url: '/pages/about/about'
    })
  }
})
