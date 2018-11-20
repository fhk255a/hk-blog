<template>
  <div>
    <div class="user-inner">
      <div class="author-info">
        <div class="author-img" >
          <a :href="'#/personal/id='+userinfo.id">
            <img :src="userinfo.image" class="img" alt="" >
          </a>
        </div>
        <div class="author-name">
          {{userinfo.nickname}}
        </div>
        <p class="author-motto">
          {{userinfo.motto}}
        </p>
        <div class="author-links">
        <span class="links-item" data-ps="QQ">
          <a href="">
            <i class="iconfont icon-qq"></i>
          </a>
        </span>
          <span class="links-item" data-email="邮箱">
          <a >
            <i class="iconfont icon-email"></i>
          </a>
        </span>
          <span class="links-item" data-phone="电话">
          <a href="">
            <i class="iconfont icon-shouye"></i>
          </a>
        </span>
          <span class="links-item" data-wechat="微信">
          <a href="">
            <i class="iconfont icon-weixin"></i>
          </a>
        </span>
          <span class="links-item" data-article="文章数量">
          <a href="">
            <i class="iconfont icon-copy"></i>
          </a>
        </span>
        </div>
        <div class="author-follow-fans">
          <a href="" class="follow">
            <i class="iconfont icon-add-account"></i><span>关注:{{userinfo.follow}}</span>
          </a>
          <a href="" class="fans">
            <i class="iconfont icon-supplierfeatures"></i><span>粉丝:{{userinfo.fans}}</span>
          </a>
        </div>
        <div class="author-article-class">
          <div class="article-class-item article">
            <a href="#">
              <span class="article-class-count">{{userinfo.article}}</span>
              <span class="article-class-name">文章</span>
            </a>
          </div>
          <div class="article-class-item class">
            <a href="#">
              <span class="article-class-count">{{userinfo.article}}</span>
              <span class="article-class-name">分类</span>
            </a>
          </div>
        </div>
      </div>
    </div>
    <a href="#/add_article" class="push-article" v-if="login_status">发表文章<i class="iconfont icon-add"></i></a>
  </div>
</template>

<script>
  export default {
    name: "userwrap",
    data: function () {
      return {
        userinfo: {
          article:"0",
          birthday:"0",
          collect:"0",
          comment:"0",
          ctime:"0",
          email:"hk255@foxmail.com",
          fans:"0",
          follow:"0",
          getcomment:"0",
          getlike:"0",
          id:"1",
          image:"@/../static/images/userimg/user_2.jpg",
          like:"0",
          ltime:"0",
          motto:"坑要一个个填，步要一步步走。",
          nickname:"FHK",
          price:"0",
          qq:"215537936",
          sign:"0",
          telphone:"2147483647",
          username:"fhk",
          wechat:"FHK255"
        },
        islogin:false
      }
    },
    methods:{
      toPersonal(){

      }
    },
    computed: {
      getUserInfo() {
        if (sessionStorage['userinfo'] == null) {
          this.islogin = false;
          return 1;
        } else {
          this.islogin = true;
          return JSON.parse(sessionStorage['userinfo']).id;
        }
      },
      login_status(){
        if( sessionStorage['userinfo']== undefined || sessionStorage['userinfo'].length < 1) {
          return false;
        } else {
          return true;
        }
      }
    },
    created() {
      let param = {
        url: 'getUserInfo',
        data: {
          params:{
            'id': this.getUserInfo
          }
        },
        type:'get'
      };
      severAjax(param, (res)=> {
        this.userinfo = res.data[0];
      })
    }
  }
</script>

<style scoped lang="stylus" res="">
  .user-inner
    padding: 20px;
    box-sizing: border-box;
    width: 100%;
    color: #555;
    background: #fff;
    box-shadow: initial;
    border-radius: initial;
    border-radius: 5px;
    z-index: 2;
    .author-info
      margin: 0 2px;
      text-align: left;
      .author-img
        width: 100%
        position: relative
        height: 150px
        a
          display: block;
          width: 100%;
          height: 100%;
          margin: 0 auto;
          text-align: center;
          .img
            width: auto
            height: 100%
      .author-name
        text-align: center;
        font-size: 30px;
        border-bottom: 1px solid #ddd;
      .author-motto
        font-size: 14px
        margin: 5px 0 8px
        font-weight: 700
        color: #555
        text-align: center
      .author-links
        display: flex
        flex-wrap: wrap
        justify-content: center
        margin: 0 0 20px
        .links-item
          margin: 5px 0 0
          a
            max-width: 216px
            box-sizing: border-box
            display: inline-block
            margin-right: 0
            margin-bottom: 0
            padding: 0 5px
            overflow: hidden
            white-space: nowrap
            text-overflow: ellipsis
            i
              font-size: 16px
              display: inline-block
              width: 42px
              height: 42px
              line-height: 42px
              border-radius: 42px
              color: rgba(0, 0, 0, .5)
              background-color: rgba(0, 0, 0, .1)
              transition: all .3s ease-in-out
              font-style: normal
              display: flex
              vertical-align: middle
              align-items: center
              justify-content: center
      .author-follow-fans
        text-align: center
        margin: 10px 0 10px
        display: flex
        a
          display: inline-block
          border: none
          flex: 1
        .follow
          color: #48c7fb
        .fans
          color: #fc6423
      .author-article-class
        overflow: hidden
        line-height: 1.4
        white-space: nowrap
        text-align: center
        .article-class-item
          padding: 0 10px
          display: inline-block
          border-left: 1px solid #eee
          a
            color: #555
            .article-class-count
              display: block
              text-align: center
              color: inherit
              font-weight: 600
              font-size: 16px
            .article-class-name
              color: #00a7e0
              font-size: 13px
        .article
          border-left: none
        .class a .article-class-name
          color: #ff3f1a


  .push-article
    background: #ddd
    display: block
    border:1px solid #ffffff
    -webkit-box-sizing: border-box
    -moz-box-sizing: border-box
    color:#999
    font-weight: 600
    box-sizing: border-box
    margin-top : 10px
    padding : 15px 10px
</style>
