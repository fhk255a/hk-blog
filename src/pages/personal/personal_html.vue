<template>
  <div id="person_page" style="padding-bottom: 70px">
    <v-header></v-header>
    <div id="user-inner">
      <div class="user-header" style="background-image:url(@/../static/images/banner-1.jpg)">
        <div class="user-bg">
          <div class="user-info container" v-for='it in userInfoData'>
            <div class="row">
              <div class="user-pic col-lg-2 col-md-3 col-sm-3 col-xs-4">
                <div class="img">
                  <img :src="it.image" alt="">
                </div>
              </div>
              <div class="user-info-right col-lg-10 col-md-9 col-sm-9 col-xs-8">
                <div class="u-row-left col-lg-9 col-md-8 col-sm-8 col-xs-6">
                  <div class="u-row user-name">
                    <span class="item level admin-bg">超级管理员</span>
                    <h3 class="item">{{it.nickname}}</h3>
                    <span class="item"><i class="iconfont icon-ic_userlevel_1"></i>41</span>
                  </div>
                  <div class="u-row user-sketch">
                    <span class="item sex">男</span>
                    <span class="item address">广州</span>
                    <span class="item job">程序员</span>
                    <span class="item more">查看更多<i class="iconfont icon-moreunfold"></i></span>
                  </div>
                  <div class="u-motto">
                    {{it.motto}}
                  </div>
                </div>
                <div class="u-row-right user-related col-lg-3 col-md-4 col-sm-4 col-xs-6">
                  <div class="item">
                    <p class="num">{{it.article}}</p>
                    <p>文章</p>
                  </div>
                  <div class="item">
                    <p class="num">{{it.collect}}</p>
                    <p>关注</p>
                  </div>
                  <div class="item">
                    <p class="num">{{it.fans}}</p>
                    <p>粉丝</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="user-body container">
        <div class="user-menu col-lg-2 col-md-3 col-sm-3 col-xs-12">
          <ul>
            <li class="active">
              <i class="iconfont icon-edit"></i>个人资料
            </li>
            <li>
              <i class="iconfont icon-note"></i>文章列表
            </li>
            <li>
              <i class="iconfont icon-atmaway"></i>最新动态
            </li>
          </ul>
        </div>
        <div class="user-main col-lg-10 col-md-9 col-sm-9 col-xs-12">
          <div class="">
            <div class="main-item article-info">
              <ul>
                <li class="item" v-for="(item,index) in userArticles">
                  <a :href="'#/artilce/'+item.artid">
                    <div class="left col-lg-2 col-md-4 col-sm-4 col-xs-2">
                      <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
                    </div>
                    <div class="col-lg-10 col-md-8 col-sm-8 col-xs-10">
                      <div class="right col-lg-10 col-md-10 col-sm-8 col-xs-8">
                        <h3 class="it title">{{item.title}}</h3>
                        <p class='it tip'>这是文章描述</p>
                        <ul class="it tag">
                          <li  v-for="(tag,index) in item.tag">{{tag}}</li>
                        </ul>
                      </div>
                      <div class="ctime col-lg-2 col-md-2 col-sm-4 col-xs-4" style="padding: 0">{{fmtDate(item.ctime)}}</div>
                    </div>
                  </a>
                </li>
              </ul>
            </div>
            <div class="main-item user-info" v-for="date in userInfoData">
              <div class="info-inner">
                <div class="item bday">
                  <i><span>生日:{{date.birthday}}</span></i>
                </div>
                <div class="item telphone">
                  <i><span>电话:{{date.telphone}}</span></i>
                </div>
                <div class="item ctime">
                  <i><span>创建日期:{{fmtDate(date.ctime)}}</span></i>
                </div>
                <div class="item updatePwd">
                  <i><a>修改密码</a></i>
                </div>
                <div class="item ltime">
                  <i><span>最后登录:2018-10-24</span></i>
                </div>
              </div>
            </div>
            <div class="main-item user-date">
              <div class="">
                <ul>
                  <li>暂无动态</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <v-footer></v-footer>
  </div>
</template>

<script>
  import header from '../../components/header/backheader'
  import footer from '../../components/footer/footer'

  export default {
    name: "personal_html",
    components: {
      'v-header': header,
      'v-footer': footer
    },
    data:()=>{
      return {
        userArticles:[],
        userInfoData:{}
      }
    },
    beforeCreate(){
      let idIndex = window.location.hash.lastIndexOf('=');
      let userId = window.location.hash.substr(idIndex+1);
      let param = {
        url: "getUserArticles",
        data:{
          params:{
            id:userId
          }
        },
        token: '123',
        type: "get",
      };
      severAjax(param, (res) => {
        if (parseInt(res.code) == 200) {
          this.userArticles = res.data;
        } else {
          console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
        }
      });
      let param1 = {
        url: "getUserInfo",
        data:{
          params:{
            id:userId
          }
        },
        token: '123',
        type: "get",
      };
      severAjax(param1, (res) => {
        if (parseInt(res.code) == 200) {
          this.userInfoData = res.data;
        } else {
          let param1 = {
            url: "getUserInfo",
            data:{
              params:{
                id:1
              }
            },
            token: '123',
            type: "get",
          };
          severAjax(param1, (res) => {
            if (parseInt(res.code) == 200) {
              this.userInfoData = res.data;
            }
          });
        }
      });
    },
    methods: {
      fmtDate(obj) {
        obj *= 1000;
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
      }
    }
  }
</script>

<style scoped lang="stylus">
  .container
    margin: 0 auto;
    padding: 0
  #user-inner
    width: 100%
  .user-header
    width: 100%
    height: 200px
    background-size: cover
    background-position: center 50%
    background-repeat: no-repeat
    .user-bg
      height: 100%
      width: 100%
      background: rgba(7, 17, 27, 0.15)
      position: relative
      .user-info
        height: 220px;
        padding-top: 60px;
      .row
        margin: 0
        height:100%
        .user-pic
          height: 100%
          position: relative
          float: left
          .img
            position:absolute
            width: 160px
            margin: 0 auto
            height: 160px
            border-radius 50%
            border: 5px solid #fff
            bottom: 10px
            box-shadow :0px 0px 8px 2px rgba(7,17,27,0.3)
            box-sizing: border-box;
            overflow: hidden
            img
              width: 100%
              height: 100%
        .user-info-right
          text-align: left
          padding: 0
          float: left
          height: 100%
          overflow: hidden
          color: #fff
          position: relative
          div
            text-align: left
            padding: 0
          .u-row
            text-align: left
            margin-bottom 10px
          .user-name
            display: inline-flex
            margin-top :50px
            align-items baseline
            .item
              margin-right: 10px
            h3
              font-size: 24px
            .level
              position: absolute
              left:0
              top:40px
              -webkit-border-radius: 5px
              -moz-border-radius: 5px
              border-radius: 5px
              padding: 1px 5px
            .admin-bg
              background: sandybrown
              opacity: .8
              display: block
              color: #f5f5f5
          .user-sketch
            .item
              font-weight: 600
              padding: 0 8px
            .sex
              padding-left: 0
            .job
              padding-right 12px
              border-right: 2px dotted #fff
            .more
              color: #666
              cursor: pointer
          .u-motto
            color: #333333
            height: 40px
            margin-top 40px
            display: none
            overflow: hidden
            position: relative
          .user-related
            text-align: right
            padding: 0
            color: #fff
            font-size: 14px
            .item
              width: 50px
              float: left
              margin: 0 5px
              text-align: center
              .num
                font-size: 22px
                font-weight: 600
  .user-body
    margin: 0 auto
    padding: 50px 0 100px
    .user-menu
      height: 200px
      overflow: hidden
      float: left
      ul
        display: block
        width: 100%
      li
        line-height: 50px
        cursor: pointer
        height: 50px
        margin-bottom: 5px
        position: relative
      .active
        color: #fff
        background: darkred
      .active:before
        content: ''
        background: #999
        position: absolute
        left: 0
        top: 0
        height: 100%
        width: 40px
      .active:after
        display: block;
        content: '';
        bottom: 0;
        right: 0;
        width: 0;
        height: 0;
        position: absolute;
        border-top: 26px solid #efefef;
        border-bottom: 24px solid #efefef;
        border-left: 21px solid transparent;
    .user-main
      background: #fff
      float: left
      padding: 0
      .main-item
        text-align: left
      .article-info .item
        overflow: hidden
        padding:5px 10px
        background: #fff
        position: relative
        margin-bottom :5px
        border-bottom: 1px solid #eee
        .left
          float: left
          padding:0
        .right
          float: left
          overflow: hidden
          display: flex
          flex-direction :column
          justify-content :space-around
          min-height: 120px
          text-align: left
          position: relative
          padding:5px 0
          padding-right: 0
        .ctime
          color: #ccc
          position: absolute
          right: 10px
          text-align: right
          top: 0px
          font-size: 14px
          padding: 0
        .tip
          color: #999
          flex:1
          margin-bottom:5px
        .it
          line-height: 26px
          font-size: 16px
          margin: 0
          margin-bottom:5px
        .title
          font-size: 20px
          margin-bottom:5px
        .tag
          overflow: hidden
          margin :0
          li
            float: left
            padding: 0px 8px
            background: lightblue
            margin-right: 8px
      .info-inner
        overflow: hidden
        padding :10px 30px
        .item
          width: 100%
          color: #999
          font-size: 16px
          line-height: 30px
          margin: 10px 0
        /*background: whitesmoke*/
      .user-date
        color :#ccc
        text-align: center
</style>
