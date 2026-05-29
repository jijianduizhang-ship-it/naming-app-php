const utils = require('../../utils/index')

Page({
  data: {
    records: [],
    showFavoritesOnly: false
  },

  onLoad() {
    this.refreshRecords()
  },

  onShow() {
    this.refreshRecords()
  },

  refreshRecords() {
    let records = utils.getRecords()
    if (this.data.showFavoritesOnly) {
      records = records.filter(r => r.favorite)
    }
    this.setData({ records })
  },

  toggleFilter() {
    this.setData({
      showFavoritesOnly: !this.data.showFavoritesOnly
    })
    this.refreshRecords()
  },

  viewDetail(e) {
    const name = JSON.stringify(e.currentTarget.dataset.record)
    wx.navigateTo({
      url: '/pages/name-detail/name-detail?name=' + encodeURIComponent(name)
    })
  },

  deleteRecord(e) {
    const id = e.currentTarget.dataset.id
    wx.showModal({
      title: '确认删除',
      content: '确定要删除这条记录吗？',
      success: (res) => {
        if (res.confirm) {
          utils.deleteRecord(id)
          this.refreshRecords()
          wx.showToast({
            title: '已删除',
            icon: 'success'
          })
        }
      }
    })
  },

  clearAll() {
    if (this.data.records.length === 0) return
    wx.showModal({
      title: '确认清空',
      content: '确定要清空所有历史记录吗？',
      success: (res) => {
        if (res.confirm) {
          this.data.records.forEach(r => {
            utils.deleteRecord(r.id)
          })
          this.refreshRecords()
          wx.showToast({
            title: '已清空',
            icon: 'success'
          })
        }
      }
    })
  }
})
