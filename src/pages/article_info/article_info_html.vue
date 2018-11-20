<template>
  <div class="main">
    <v-header class="" @deleteLoginStatus="deleteUserStatus"></v-header>
    <div id="article-container" class="container">
      <div class="post" v-for="item in artItemData">
        <div class="content">
          <div class="item-main">
            <div class="item-header">
              <div class="like-collect">
                <div class="like-box" @click="update_clike">
                  <i class="iconfont icon-like" :class="like_status==true?'active':''"></i>
                  <span>{{item.like}}</span>
                </div>
                <div class="collect-box" @click="update_collect">
                  <i class="iconfont icon-heart" :class="collect_status==true?'active':''"></i>
                  <span>{{item.collect}}</span>
                </div>
              </div>
              <h1 class="title">{{item.title}}</h1>
              <div class="date">
                <span> 发表于 {{fmtDate(item.ctime)}} </span>
                <span> 字数统计 {{item.length}} </span>
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
      <div class="message-main">
        <div class="item-sessmge">
          <div class="comment"  v-if="loginStatus">
            <div class="no-login-editor col-log-12 col-sm-12 col-md-12 col-xs-12">
              <p>Hi！guy，评论需要先 <a href="#/login" class="login-btn btn btn-sm btn-success">登录</a> 哦</p>
            </div>
          </div>
          <div class="comment" v-else>
            <div id="wangeditor" class="comment-box col-log-10 col-md-10 col-sm-9 col-xs-12">
              <div ref="editorElem" id="editor-main"></div>
            </div>
            <div class="comment-info col-lg-1 col-md-2 col-sm-2 col-xs-12">
              <div class="comment-btn btn btn-info " @click="postUserComment">发布</div>
            </div>
          </div>
        </div>
        <div class="item-msgbrand" >
          <ul class="user-msglist ">
            <p v-if="noMsgList" style="padding:40px 0 50px; text-align: center;color: #ccc;">暂无人评论哦~，快来抢沙发！</p>
            <li class="item-usermsg" v-for="(item,index) in artMsgList">
              <div class="user-head col-lg-2 col-md-3 col-xs-3 col-sm-3">
                <a :href="'#/personal/id='+item.id">
                  <img :src="item.info.image" alt="">
                </a>
              </div>
              <div class="user-content col-lg-10 col-md-9 col-xs-9 col-sm-9">
                <div class="msg-header">
                  <a :href="'#/personal/id='+item.id" class="user-name">{{item.info.username}}</a>
                  <span class="msg-top">#{{index+1}}</span>
                  <span class="ctime">{{item.ctime}}</span>
                </div>
                <div class="msg-body" ref="msgbrand">
                  {{item.content}}
                </div>
              </div>
              <div class="msg-footer">
                <a href="#">回复</a>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <v-footer></v-footer>
  </div>
</template>

<script>
  import header from '../../components/header/header'
  import footer from '../../components/footer/footer'
  import E from '../../../static/js/wangEditor'
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
      //清空用户信息
      deleteUserStatus(loginStatus){
        this.login_status = loginStatus;
      },
      fmtDate(obj) {
        obj *= 1000;
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
      },
      update_clike() {
        this.like_status = !this.like_status;
        this.artItemData[0].like = this.like_status ? parseInt(this.artItemData[0].like) + 1 : parseInt(this.artItemData[0].like) - 1;
      },
      update_collect() {
        this.collect_status = !this.collect_status;
        this.artItemData[0].collect = this.collect_status ? parseInt(this.artItemData[0].collect) + 1 : parseInt(this.artItemData[0].collect) - 1;
      },
      //发表评论
      postUserComment(){
        let param = {
          url: 'pushArticleMsg',
          data: {
            params:{
              "content": this.editorContent,
              "id": JSON.parse(sessionStorage['userinfo']).id,
              "artid":this.$route.params.id,
            },
            token: "12312",
          },
          type: 'post'
        };
        severAjax(param,(res)=>{
          if(res.info == 'OK'){
            alert('评论成功');
            this.editorContent='';
            $('.w-e-text').html('');
            this.getArticleMsg();
          }
          else{
            alert('失败');
          }
        })
      },
      addArticleWatch(){
        let param = {
          url: 'addArticleWatch',
          data: this.$route.params.id,
          type: 'get'
        };
        severAjax(param,(res)=>{})
      },
      status(status) {
        this.msgStatus = status;
      },
      getArticleMsg(){
        let param = {
          url: 'getArticleMsg',
          data: {
            params: {
              "artid": this.$route.params.id,
            },
            token: '123',
          },
          type: "get"
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.artMsgList = res.data;
          } else {
            this.noMsgList = true;
            console.log('获取文章评论列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        });
      },
      getArticleIdInfo(){
        let param = {
          url: 'getArticleIdInfo',
          data: {
            params: {
              "artid": this.$route.params.id,
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
      }
    },
    computed:{
      loginStatus:function(){
        return this.login_status;
      },
    },
    created() {
      this.getArticleMsg();
      this.getArticleIdInfo();
      //浏览加1
      this.addArticleWatch();
      if(sessionStorage['userinfo']==null){
        this.login_status = true;
      }
      else{
        this.login_status = false;
      }
    },
    mounted() {
      if (this.$refs.editorElem) {
        var editor = new E(this.$refs.editorElem);        //创建富文本实例
        editor.customConfig.onchange = (html) => {
          this.editorContent = html;
        }
        editor.customConfig.uploadImgServer = 'http://localhost/bolg/sever.php?url=uploadEditorArticleImg'
        editor.customConfig.uploadFileName = 'hkimg'
        editor.customConfig.debug = true;
        // 自定义菜单配置
        if (isMobile()) {
          editor.customConfig.menus = [
            'foreColor',  // 文字颜色
            'emoticon',  // 表情
            'backColor',  // 背景颜色
            'image',  // 插入图片
            'link',  // 插入链接
            'code',  // 插入代码
            'redo',  // 重复，
            'allScreen'//全屏
          ]
        } else {
          editor.customConfig.menus = [
            'bold',  // 粗体
            'fontSize',  // 字号
            'fontName',  // 字体
            'emoticon',  // 表情
            'image',  // 插入图片
            'underline',  // 下划线
            'strikeThrough',  // 删除线
            'foreColor',  // 文字颜色
            'backColor',  // 背景颜色
            'link',  // 插入链接
            'code',  // 插入代码
            'undo',  // 撤销
            'redo',  // 重复
            'allScreen'//全屏
          ]
        }
        editor.create();
      }
    },

    updated() {
      if(this.$refs.content) {
        this.$refs.content[0].innerHTML = this.artItemData[0].content;
      }
      if(this.$refs.msgbrand){
        for(var i = 0;i<this.$refs.msgbrand.length;i++){
          this.$refs.msgbrand[i].innerHTML = this.artMsgList[i].content;
        }
      }

    },
    destroyed() {
      let param = {
        url: 'updataArticleIdInfo',
        data: {
          params: this.artItemData[0],
          token: '123',
        },
        type: "get"
      };
      severAjax(param);
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
#editor-main
  display: flex;
  border: 1px solid #ddd;
  background: #fff
  border-radius: 6px;
  overflow: hidden;
  flex-direction: column;
  text-align: left;
  height: 200px
#wangeditor .all-screen
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  height: auto;
  right: 0;
  z-index: 999999;
</style>
