const utils = require('../../utils/index')

Page({
  data: {
    name: null
  },

  onLoad(options) {
    if (options.name) {
      this.setData({
        name: JSON.parse(decodeURIComponent(options.name))
      })
    }
  },

  toggleFavorite() {
    const name = this.data.name
    if (name.favorite) {
      utils.removeFavorite(name.name)
    } else {
      utils.saveFavorite(name.name)
    }
    this.setData({
      'name.favorite': !name.favorite
    })
    wx.showToast({
      title: name.favorite ? '已取消收藏' : '已收藏',
      icon: 'success'
    })
  },

  goBack() {
    wx.navigateBack()
  }
})
