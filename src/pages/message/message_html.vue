<script src="../../../static/js/js.js"></script>
<template>
  <div class="container">
    <v-header @deleteLoginStatus="deleteUserStatus"></v-header>
    <div class="main-inner">
      <div class="content-wrap col-lg-8 col-md-8 ">
        <div class="content">
          <v-message></v-message>
          <div id="comment">
            <div class="comment" v-if="loginStatus">
              <div class="no-login-editor col-log-12 col-sm-12 col-md-12 col-xs-12">
                <p>Hi！guy，留言需要先 <a href="#/login" class="login-btn btn btn-sm btn-success">登录</a> 哦</p>
              </div>
            </div>
            <div class="comment" v-else>
              <div id="wangeditor" class="comment-box col-log-10 col-md-10 col-sm-9 col-xs-12">
                <div ref="editorElem" id="editor-main"></div>
              </div>
              <div class="comment-info col-lg-2 col-md-2 col-sm-3 col-xs-12">
                <div class="comment-btn btn btn-info " @click="postUserComment">发布</div>
              </div>
            </div>
            <div class="user-msg-box">
              <div class="comment-list" ref="msgEleList">
                <div class="msg-status">
                  <span :class="{'msg-status-active':all_msg}" @click="getUserMsgList('all'),all_msg=true">全部留言</span>
                  <span :class="{'msg-status-active':!all_msg}"
                        @click="getUserMsgList('hot') ,all_msg = false">热门留言</span>
                </div>
                <div class="hr"></div>
                <ul class="">
                  <li class="comment-item" v-for="(msg ,index) in msg_list" :class="{'hot-msg-top':index<3}">
                    <div class="author">
                      <a href="#" class="author-user">
                        <img class="img" :src="msg.info.image" alt="">
                      </a>
                      <div v-if="index<3" class="author-collect btn btn-info">关注</div>
                    </div>
                    <div class="comment-body">
                      <div class="comment-header">
                        <a class="comment-author" :href="'#/personal/id='+msg.id">{{msg.info.nickname}}</a>
                      </div>
                      <div class="comment-text"></div>
                      <div class="comment-info">
                        <span class="msg-top" :msgid="msg.msgid" :user-id="msg.msgid">#{{msg.msgid}}</span>
                        <span class="comment-date">{{msg.ctime}}</span>
                        <span class="msg-like" @click="addLikeFun(msg.msgid)">{{msg.clike}}<i
                          class="iconfont icon-like"></i></span>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="seller-wrap col-lg-4 col-md-4 ">
        <v-userwrap></v-userwrap>
      </div>
    </div>
    <v-footer></v-footer>
  </div>
</template>

<script>
  import message from '../../components/messagewrap/message'
  import userwrap from '../../components/userwrap/userwrap'
  import header from '../../components/header/header'
  import footer from '../../components/footer/footer'
  import E from '../../../static/js/wangEditor'

  export default {
    name: "message",
    components: {
      'v-userwrap': userwrap,
      'v-message': message,
      'v-header': header,
      'v-footer': footer,
    },
    data: function () {
      return {
        content: '',
        login_status: false,
        msg_list: [],
        all_msg: true,
      }
    },
    methods: {
      //获取富文本框内容
      updateData(e = '') {
        let c1 = e.replace(/<img style="max-width:90%"/g, '<img');
        let c2 = c1.replace(/<img/g, '<img style="max-width:90%"');
        this.content = c2;
      },
      //发表评论
      postUserComment() {
        let param = {
          url: 'addMsg',
          data: {
            params: {
              "content": this.editorContent,
              "id": JSON.parse(sessionStorage['userinfo']).id,
            },
            token: "12312",
          },
          type: 'post'
        };
        severAjax(param, (res) => {
          if (res.info == 'OK') {
            alert('留言成功');
            this.editorContent = '';
            this.getUserMsgList('all');
          }
          else {
            alert('留言失败');
          }
        })
      },
      //获取留言信息列表
      getUserMsgList(orderType) {
        let msgData = {
          url: 'getMsgList',
          data: orderType,
          type: 'get',
        };
        severAjax(msgData, (msg) => {
          if (msg.info == 'OK') {
            this.msg_list = msg.data;
          }
        })
      },
      //点赞
      addLikeFun(msgid) {
        let updateMsg = {
          url: 'updateMsgLike',
          data: msgid,
          type: 'get',
        };
        severAjax(updateMsg, (msg) => {
          console.log(msg);
          if (msg.info == 'OK') {
            this.getUserMsgList('hot');
          }
        })
      },
      //清空用户信息
      deleteUserStatus(loginStatus) {
        this.login_status = loginStatus;
      }
    },
    created() {
      if (sessionStorage['userinfo'] == null) {
        this.login_status = true;
      }
      else {
        this.login_status = false;
      }
      //加载全部用户留言信息
      this.getUserMsgList('all');
    },
    computed: {
      loginStatus: function () {
        return this.login_status;
      },
    },
    updated() {
      let msgEle = this.$refs.msgEleList.getElementsByClassName('comment-text');
      for (let i = 0; i < msgEle.length; i++) {
        msgEle[i].innerHTML = this.msg_list[i].content;
      }
    },
    mounted() {
      if (this.$refs.editorElem) {
        var editor = new E(this.$refs.editorElem);        //创建富文本实例
        editor.customConfig.onchange = (html) => {
          this.editorContent = html;
          // this.catchData(html)  //把这个html通过catchData的方法传入父组件
        }
        editor.customConfig.uploadImgServer = 'http://oootb.com/bolg/sever.php?url=uploadEditorImg'
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
  }
</script>

<style scoped lang="stylus">

  .container
    padding: 0
    padding-top: 38px
    padding-bottom: 100px
    .comment
      position: relative
      display: flex;
      align-items: flex-end;
      overflow: hidden
      flex-wrap: wrap;
      > div
        padding: 0
      .comment-info .status-text
        line-height: 30px
      .comment-btn
        width: 100%
      .no-login-editor
        background-color: #ded2d2;
        border-radius: 5px
        height: 100px
        line-height: 100px

  #comment
    background: #fff
    margin: 0
    padding: 10px
    border-radius: 5px
    .msg-status
      overflow: hidden
      span
        display: block
        float: left
        margin-right: 30px
    .comment-list
      margin: 20px 0 0
      padding: 0
      font-family: -apple-system, system-ui, BlinkMacSystemFont, "Segoe UI", Roboto, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", "Helvetica Neue", sans-serif;
      -webkit-font-smoothing: antialiased
      -moz-osx-font-smoothing: grayscale
      color: #2a2e2e
      .comment-item
        display: flex
        align-items: left
        margin: 10px
        .author
          padding: 10px 0
          overflow: hidden
          .author-user
            width: 60px
            height: 60px
            overflow: hidden;
            border: 1px solid rgba(221, 221, 221, .4);
            border-radius: 50%;
            display: block
            background: #fff
          .author-collect
            height: 24px
            line-height: 10px
            margin: 6px 0 0
        .comment-body
          flex: 1
          border-bottom: 1px solid #e8e8e8
          overflow: hidden
          margin-left: 20px
          padding: 10px 0
          .comment-header
            line-height: 1.5em;
            font-size: 13px;
            text-align: left
            .comment-author
              line-height: 1.5em;
              color: #2479cc;
              font-weight: 700;
              color: #076dd0;
          .comment-text
            text-align: left
            padding: 10px 0
            font
              line-height: 20px
          .comment-info
            text-align: left
            height: 20px
            font-size: 12px;
            line-height: 20px
            color: #656c7a
            span
              margin-right: 10px
            .comment-date
              font-size: 12px;
              color: #656c7a;
            .icon-like
              margin-left: 5px

  .msg-status
    -webkit-box-sizing: border-box
    -moz-box-sizing: border-box
    box-sizing: border-box
    position: relative
    .msg-status-active
      padding-bottom: 8px
      border-bottom: 2px solid #ff9900
      color: #ff9900
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
