<script>
export default {
    onLaunch: function() {
        console.log('App Launch');
        this.initStorage();
    },
    onShow: function() {
        console.log('App Show');
    },
    onHide: function() {
        console.log('App Hide');
    },
    methods: {
        initStorage() {
            const credits = uni.getStorageSync('naming_credits');
            if (credits === '') {
                uni.setStorageSync('naming_credits', 0);
            }
            const records = uni.getStorageSync('name_records');
            if (records === '') {
                uni.setStorageSync('name_records', []);
            }
            const redeemHistory = uni.getStorageSync('redeem_history');
            if (redeemHistory === '') {
                uni.setStorageSync('redeem_history', []);
            }
        }
    }
};
</script>

<style>
/* 全局样式 */
@import url('./static/css/common.css');

page {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif;
    background-color: #F5F0EB;
    min-height: 100vh;
    font-size: 28rpx;
    color: #534138;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}
</style>
