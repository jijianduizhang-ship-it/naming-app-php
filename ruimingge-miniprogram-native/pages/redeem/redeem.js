const utils = require('../../utils/index')

Page({
  data: {
    code: '',
    history: []
  },

  onLoad() {
    this.loadHistory()
  },

  loadHistory() {
    this.setData({
      history: utils.getRedeemHistory()
    })
  },

  handleInput(e) {
    this.setData({
      code: e.detail.value
    })
  },

  redeem() {
    const code = this.data.code.trim()
    if (!code) {
      wx.showToast({
        title: '请输入兑换码',
        icon: 'none'
      })
      return
    }

    let amount = 0
    if (code === 'TEST') {
      amount = 3
    } else if (code.length >= 6) {
      amount = 1
    } else {
      wx.showToast({
        title: '兑换码无效',
        icon: 'none'
      })
      return
    }

    utils.addCredits(amount, code)
    this.setData({ code: '' })
    this.loadHistory()
    wx.showToast({
      title: `兑换成功！获得${amount}次起名机会`,
      icon: 'success'
    })
  }
})
