<template>
  <div class="main">
    <v-header class=""></v-header>
    <div id="article-container" class="container">
      <div class="post" v-for="item in artItemData">
        <div class="content">
          <div class="item-main">
            <div class="item-header">
              <h1 class="title">{{item.title}}</h1>
              <div class="date">
                <span> 发表于 {{fmtDate(item.ctime)}} </span>
                <span> 阅读次数 {{item.watch}} </span>
              </div>
              <div class="author">
                <span> 作者: <a :href="'#/personal/id='+item.id">{{item.author}}</a></span>
              </div>
            </div>
            <div class="item-body" ref="content"></div>
          </div>
        </div>
      </div>
    </div>
    <v-footer></v-footer>
  </div>
</template>

<script>
  import header from '../../components/header/header'
  import footer from '../../components/footer/footer'
  export default {
    name: "article_page",
    components: {
      'v-header': header,
      'v-footer': footer,
    },
    data: function () {
      return {
        noMsgList:false,
        like_status: false,
        collect_status: false,
        artItemData: [],
        login_status:false,
        artMsgList:[],
        editorContent: '',
        user_msg:{
          'id': null,
          'content':''
        }
      }
    },
    methods: {
      fmtDate(obj) {
        obj *= 1000;
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
      },
      getArticleIdInfo(){
        let param = {
          url: 'getDevIdInfo',
          data: {
            params: {
              "id": this.$route.params.id,
            },
            token: '123',
          },
          type: "get"
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.artItemData = res.data;
          } else {
            console.log('获取文章内容失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        });
      },
      addArticleWatch(){
        let param = {
          url: 'addDevWatch',
          data: this.$route.params.id,
          type: 'get'
        };
        severAjax(param,(res)=>{})
      },
    },
    created() {
      this.getArticleIdInfo();
      //浏览加1
      this.addArticleWatch();
    },
    updated() {
      if(this.$refs.content) {
        this.$refs.content[0].innerHTML = this.artItemData[0].content;
      }
    },
  }
</script>

<style scoped lang="stylus">
  .main
    padding-bottom:100px
    .banner-wrap
      right: 0
      left: 0
      top: 0
      bottom: 0
      position: fixed
      img
        width: 100%
    #article-container
      position: relative
      margin: 50px auto
      .post
        width: 100%
        .content
          position: relative;
          padding: 40px;
          background: #fff;
          padding-bottom :40px
          margin-bottom: 10px;
          border-radius: 5px;
          .item-header
            margin-bottom: 20px
            .like-collect
              position: absolute
              display: flex
              right: 40px
              div
                margin: 0 5px
                cursor: pointer
              .iconfont
                font-size: 30px
              span
                margin: 0 5px
              .active
                color: #8b0000
            .title
              text-align: center
              word-break: break-word
              color: #444
              font-size: 25px
              font-weight: 700
              a
                display: inline-block
                position: relative
                border-bottom: none
                line-height: 1.2
                vertical-align: top
                color: #444
                font-size: 25px
                font-weight: 700
            .date
              margin: 5px 0 30px 0;
              color: #999;
              font-family: "PingFang SC", "Microsoft YaHei", Lato, sans-serif;
              font-size: 14px;
              text-align: center;
            .author
              color: #999
              a
                text-decoration: underline
          .item-body
            margin-top: 60px
            text-align: left
      .item-sessmge
        background: #fff
        padding: 20px
      .comment
        position: relative
        overflow: hidden
        display: flex;
        align-items: flex-end;
        flex-wrap :wrap;
        >div
          padding: 0
      .comment-box
        padding-right:15px
      .comment-info
        font-size :20px
        .status-text
          line-height:30px
        .comment-btn
          width:100%
      .no-login-editor
        background-color:rgba(7,17,27,0.1);
        border-radius :5px
        height:100px
        line-height:100px
      .item-msgbrand
        background: #ffffff
        margin-bottom :40px
        text-align: left
        .user-msglist
          padding:0 15px
          .item-usermsg
            border-top:1px solid #eee
            padding: 20px 0
            position: relative;
            overflow: hidden
            .user-head
              border:1px solid #eee
              float: left
              padding: 0
              img
                width: 100%
                height:auto
            .user-content
              float: left
              padding-left: 20px
              overflow: hidden
              padding-right: 0
              .msg-header
                width:100%
                position: relative
                .user-name
                  font-weight:600
                  padding-right :20px
                .msg-top
                  margin-right: 20px;
              .msg-body
                text-align: left
                padding:10px 0
                min-height :65px
                max-height :200px
                overflow: hidden
                color:#666
          .msg-footer
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 100%
            a
              display: block
              position: absolute
              right:0
              bottom:10px

</style>
