const utils = require('../../utils/index')

Page({
  data: {
    names: []
  },

  onLoad(options) {
    if (options.names) {
      this.setData({
        names: JSON.parse(decodeURIComponent(options.names))
      })
    }
  },

  viewDetail(e) {
    const name = JSON.stringify(e.currentTarget.dataset.name)
    wx.navigateTo({
      url: '/pages/name-detail/name-detail?name=' + encodeURIComponent(name)
    })
  },

  goBack() {
    wx.switchTab({
      url: '/pages/naming/naming'
    })
  }
})
