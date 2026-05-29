App({
  onLaunch() {
    // 初始化本地存储
    const credits = wx.getStorageSync('naming_credits')
    if (credits === '') {
      wx.setStorageSync('naming_credits', 0)
    }
    const records = wx.getStorageSync('name_records')
    if (records === '') {
      wx.setStorageSync('name_records', [])
    }
    const redeemHistory = wx.getStorageSync('redeem_history')
    if (redeemHistory === '') {
      wx.setStorageSync('redeem_history', [])
    }
  },
  globalData: {
    userInfo: null
  }
})
