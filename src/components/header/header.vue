<template>
  <div id="header" class="">
    <div class="menu-wrapper  row">
      <div class="toggle-menu col-xs-3">
        <i class="iconfont icon-category nav-more-btn" @click="nav_toggle"></i>
        <a v-if="login_status" href="#/login" class="iconfont icon-account nav-user-btn"></a>
        <a v-else :href="'#/personal/id=1'" class="iconfont icon-account nav-user-btn"></a>
      </div>
      <ul class="menu container">
        <li class="menu-mo col-lg-10 col-md-9 col-xs-12">
          <div class="">
            <ul class="menu-left col-lg-10 col-md-9 col-xs-12">
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/">
                  <i class="iconfont icon-bank"></i>
                  首页
                </a>
              </li>
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/">
                  <i class="iconfont icon-store"></i>
                  商店
                </a>
              </li>
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/about">
                  <i class="iconfont icon-smile"></i>
                  关于我
                </a>
              </li>
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/message">
                  <i class="iconfont icon-comments"></i>
                  留言板
                </a>
              </li>
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/">
                  <i class="iconfont icon-pic"></i>
                  照片墙
                </a>
              </li>
              <li class="menu-item col-lg-2 col-md-2 col-sm-2">
                <a href="#/link">
                  <i class="iconfont icon-atmaway"></i>
                  友链
                </a>
              </li>
            </ul>
            <div class="user-status col-lg-2 col-md-3 col-xs-2">
              <div class="useri-name">
                <p class="name" v-if="login_status">{{userinfo.username}}</p>
                <a :href="'#/personal/id='+userinfo.id" v-else>{{userinfo.username}}</a>
              </div>
              <div class="status-btn">
                <a href="#/login" v-if="login_status" class="login">登录</a>
                <a href="#" @click="logout" class="logout" v-else>退出</a>
              </div>
            </div>
          </div>
        </li>
        <div class="menu-right col-lg-2 col-md-3 col-sm-12 col-xs-9">
          <li class="menu-item search col-lg-12 col-md-12 col-xs-12">
            <input type="text" class="log-lg-9 col-xs-10 col-md-9" placeholder="请输入...">
            <a href="#/" class="col-lg-1 col-xs-2 col-md-2 iconfont icon-search1">
            </a>
          </li>
        </div>
      </ul>

    </div>
  </div>
</template>

<script>
  export default {
    name: "header",
    data: function () {
      return {
        userinfo: {'username': '未登录'},
        login_s: true
      }
    },
    created() {
      if (sessionStorage['userinfo'] == null) {
        this.userinfo.username = '未登录';
        this.login_s = true;
      } else {
        this.userinfo = JSON.parse(sessionStorage['userinfo']);
        this.login_s = false;
      }
    },
    computed: {
      login_status() {
        if (this.login_s) {
          return true;
        } else {
          return false;
        }
      },
    },
    methods: {
      nav_toggle() {
        $('.menu-mo').slideToggle(500);
      },
      logout() {
        sessionStorage.removeItem('userinfo');
        this.userinfo.username = '未登录';
        this.login_s = true;
        this.$emit('deleteLoginStatus',this.login_s);
      }
    }
  }
</script>

<style scoped lang='stylus' res='stylesheet'>
  #header
    position: relative;
    width: 100%;
    padding: 0;
    box-shadow: initial;
    border-radius: initial;
    .menu-wrapper
      background: rgba(40, 42, 44, .6)
      left: 0
      right: 0
      top: 0
      position: fixed
      z-index: 99999
      margin: 0
      .toggle-menu
        height: 38px
        width: 100%
        display: none
        color: #fff
        font-weight: 600
        position: relative
        z-index: 999999
        text-align: right
        .iconfont
          font-size: 28px
          line-height: 38px
          float: right
          height: 38px
          display: block
          font-weight: 600
          color: #fff
        .icon-account
          font-size: 20px
          padding-right: 15px
          font-weight: lighter
      .menu
        padding: 0
        text-align: center
        .menu-mo
          overflow: hidden
          margin: 0
          .menu-item
            border: 0
            display: inline-block
            height: 38px
            line-height: 38px
            position: relative
            text-align: center
            color: #fff
            a
              position: relative
              box-sizing: border-box
              line-height: inherit
              transition-property: background-color
              transition-duration: .2s
              transition-timing-function: ease-in-out
              transition-delay: 0s
              color: #fff
              font-size: 14px
              border-bottom: none
              .iconfont
                margin-right: 2px
        .search
          float: right
          border-radius: 10px
          border: 1px solid rgba(7, 17, 27, 0.3)
          -webkit-box-sizing: border-box
          -moz-box-sizing: border-box
          box-sizing: border-box
          height: 30px
          line-height: 38px
          margin: 4px 0
          padding: 0
          position: relative
          background: rgba(255, 255, 255, 0.8)
          overflow: hidden
          input
            //position: absolute
            left: 0
            background: transparent
            border: 0
            height: 100%
          //background: rgba(255,255,255,0.8)
          a
            line-height: 30px
            line-height: 28px
            font-size: 20px
            height: 100%
            color: #333
            height: 100%
        .time
          float: right
          font-size: 12px
          margin: 0
          width: 200px
          overflow: hidden

      .user-status
        position: absolute
        right: 10px
        bottom: 0
        height: 38px
        div
          float: left
          line-height: 38px
          margin: 0 10px
          .name
            color: #ff9900
            font-weight: 600
        .status-btn a
          display: block
          height: 100%
          margin: 5px 0
          line-height: 20px
          padding: 4px 8px
          color: #fff
        .useri-name a
          color:#ff9900
          background: transparent
        .login
          background: skyblue
        .logout
          background: deeppink
          color: #fff

</style>
