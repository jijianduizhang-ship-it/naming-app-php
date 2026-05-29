const utils = require('../../utils/index')

Page({
  data: {
    surname: '',
    gender: 'male',
    birthday: '',
    generation: '',
    requirements: '',
    loading: false,
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

  setGender(e) {
    this.setData({
      gender: e.currentTarget.dataset.gender
    })
  },

  handleInput(e) {
    const field = e.currentTarget.dataset.field
    this.setData({
      [field]: e.detail.value
    })
  },

  goToRedeem() {
    wx.navigateTo({
      url: '/pages/redeem/redeem'
    })
  },

  async generateNames() {
    if (!this.data.surname) {
      wx.showToast({
        title: '请输入姓氏',
        icon: 'none'
      })
      return
    }

    if (this.data.credits <= 0) {
      wx.showToast({
        title: '起名次数不足',
        icon: 'none'
      })
      setTimeout(() => {
        wx.navigateTo({
          url: '/pages/redeem/redeem'
        })
      }, 1500)
      return
    }

    this.setData({ loading: true })

    try {
      const names = await utils.generateNames({
        surname: this.data.surname,
        gender: this.data.gender,
        birthday: this.data.birthday,
        generation: this.data.generation,
        requirements: this.data.requirements
      })

      utils.useCredit()

      names.forEach(name => {
        utils.saveRecord(name)
      })

      wx.navigateTo({
        url: '/pages/result/result?names=' + encodeURIComponent(JSON.stringify(names))
      })
    } catch (error) {
      wx.showToast({
        title: '生成失败，请重试',
        icon: 'none'
      })
    } finally {
      this.setData({ loading: false })
      this.refreshCredits()
    }
  }
})
