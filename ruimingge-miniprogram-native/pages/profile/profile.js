const utils = require('../../utils/index')

Page({
  data: {
    credits: 0
  },

  onLoad() {
    this.refreshCredits()
  },

  onShow() {
    this.refreshCredits()
  },

  refreshCredits() {
    this.setData({
      credits: utils.getCredits()
    })
  },

  goToRedeem() {
    wx.navigateTo({
      url: '/pages/redeem/redeem'
    })
  },

  goToAbout() {
    wx.navigateTo({
      url: '/pages/about/about'
    })
  },

  goToKnowledge() {
    wx.navigateTo({
      url: '/pages/knowledge/knowledge'
    })
  },

  contactUs() {
    wx.showToast({
      title: '感谢您的支持！',
      icon: 'none'
    })
  }
})
