const utils = require('../../utils/index')

Page({
  data: {
    articles: []
  },

  onLoad() {
    this.loadArticles()
  },

  loadArticles() {
    const articles = utils.getKnowledge()
    this.setData({ articles })
  },

  readArticle(e) {
    const article = e.currentTarget.dataset.article
    wx.showToast({
      title: article.title,
      icon: 'none'
    })
  }
})
