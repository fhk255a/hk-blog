<template>
  <div class="main">
    <v-header class=""></v-header>
    <div class="banner-wrap ">
      <img src="../../../static/images/banner-1.jpg" alt="">
    </div>
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
          <div id="wangeditor" v-if="login_status">
            <div ref="editorElem" style="text-align:left;height:300px"></div>
            <input type="submit" value="发布" class="putOut" @click="initMsgBox" ref="putOutBtn">
            <v-msg ref="msgBox" v-if="msgStatus" :msgData="msg" @push-art-msg="pushArticleMsg" @btn-status="status"></v-msg>
          </div>
          <div v-else>
            <h2>请先<a href="#/login" style="text-decoration: underline;color:#d2691e">登录</a>后评价</h2>
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
                  <span class="ctime">{{item.ctime}}</span>
                  <span class="msg-top">#{{index+1}}</span>
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
  import msg from '../../components/msgbox/msgbox'
  import E from '../../../static/js/wangEditor'
  import editor from '../../components/smallcomment/smallcomment'

  export default {
    name: "article_page",
    components: {
      'v-header': header,
      'v-footer': footer,
      'v-msg': msg,
      'v-editor': editor
    },
    data: function () {
      return {
        noMsgList:false,
        like_status: false,
        collect_status: false,
        artItemData: [],
        artMsgList:[],
        editorContent: '',
        msgStatus: false,
       // login_status:false,
        msg: {
          'title': '提示',
          'msg': '确定提交吗？',
          'btn': [
            'ok',
            'cannel'
          ]
        },
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
      update_clike() {
        this.like_status = !this.like_status;
        this.artItemData[0].like = this.like_status ? parseInt(this.artItemData[0].like) + 1 : parseInt(this.artItemData[0].like) - 1;
      },
      update_collect() {
        this.collect_status = !this.collect_status;
        this.artItemData[0].collect = this.collect_status ? parseInt(this.artItemData[0].collect) + 1 : parseInt(this.artItemData[0].collect) - 1;
      },
      pushArticleMsg() {
        this.hideMsgBox();
        let param = {
          url: 'pushArticleMsg',
          data: {
            params:{
              "content": this.editorContent,
              "id": JSON.parse(sessionStorage['userinfo']).id,
              "artid":this.$route.params.id
            },
            token: "12312",
          },
          type: 'get'
        };
        severAjax(param,(res)=>{
            if (parseInt(res.code) == 200) {
              this.msg.msg = '提交成功';
              this.msg.btn = ['ok'];
              this.noMsgList;
              this.showMsgBox();
              this.artMsgList.push({
                id:JSON.parse(sessionStorage['userinfo']).id,
                content:this.editorContent,
                ctime:new Date(),
                info:{
                  'username':JSON.parse(sessionStorage['userinfo']).username,
                  'image':JSON.parse(sessionStorage['userinfo']).image,
                }
              })
            }else{
              this.msg.msg = '因某种不可阻挡因素，导致你评论失败。';
              this.msg.btn = ['err'];
              this.showMsgBox();
            }
          })
      },
      initMsgBox(){
        this.msg= {
          'title': '提示',
          'msg': '确定提交吗？',
          'btn': [
            'ok',
            'cannel'
          ]
        };
        this.showMsgBox();
      },
      showMsgBox() {
        this.msgStatus = true;
      },
      hideMsgBox() {
        this.msgStatus = false;
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
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
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
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        });
      }
    },
    computed:{
      login_status(){
        if( sessionStorage['userinfo']== undefined || sessionStorage['userinfo'].length < 1) {
          return false;
        } else {
          return true;
        }
      }
    },
    created() {
      this.getArticleMsg();
      this.getArticleIdInfo();
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
      this.artItemData[0].watch = parseInt(this.artItemData[0].watch) + 1;
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
    mounted() {
      if(this.$refs.editorElem){
        var editor = new E(this.$refs.editorElem);        //创建富文本实例
        editor.customConfig.onchange = (html) => {
          this.editorContent = html;
          // this.catchData(html)  //把这个html通过catchData的方法传入父组件
        }
        editor.customConfig.uploadImgServer = 'http://localhost/bolg/sever.php?url=upimg'
        editor.customConfig.uploadFileName = 'articleImgName'
        editor.customConfig.debug = true;
        // 自定义菜单配置
        if(isMobile()){
          editor.customConfig.menus = [
            'emoticon',  // 表情
            'foreColor',  // 文字颜色
            'backColor',  // 背景颜色
            'link',  // 插入链接
            'code',  // 插入代码
          ]
        }else{
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
            'redo'  // 重复
          ]
        }
        editor.customConfig.emotions = [
          {
            // tab 的标题
            title: '默认',
            // type -> 'emoji' / 'image'
            type: 'image',
            // content -> 数组
            content: [
              {
                alt: '[坏笑]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/50/pcmoren_huaixiao_org.png'
              },
              {
                alt: '[舔屏]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/40/pcmoren_tian_org.png'
              }
            ]
          },
          {
            // tab 的标题
            title: 'emoji',
            // type -> 'emoji' / 'image'
            type: 'emoji',
            // content -> 数组
            content: ['😀', '😃', '😄', '😁', '😆', '😁', '😔', '😊', '😜', '😳', '👄', '😱', '😌', '😍', '😣', '😓', '😏', '😭', '😒', '😄', '😖', '😲', '😉', '😘', '😝', '😂', '😡', '😠', '😥', '😷', '😪', '😨', '😰', '😞', '👿', '😌', '😚', '😃']
          },
          {
            // tab 的标题
            title: '鸿楷专用',
            // type -> 'emoji' / 'image'
            type: 'image',
            // content -> 数组
            content: [
              {
                alt: '[哆啦A梦1]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/08/dorahaose_thumb.gif'
              },
              {
                alt: '[哆啦A梦2]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/61/dorahan_thumb.gif'
              },
              {
                alt: '[哆啦A梦3]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/jiqimaojingxiang_thumb.gif'
              },
              {
                alt: '[胖虎]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/2f/jiqimaopanghu_org.gif'
              },
              {
                alt: '[静香]',
                src: "http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/jiqimaojingxiang_org.gif"
              },
              {
                alt: '[大熊]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8e/jiqimaodaxiong_org.gif'
              },
              {
                alt: '[小黄人]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b2/xhrnew_buxie_org.png'
              },
              {
                alt: '[小黄人剪刀手]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/63/xhrnew_jiandaoshou_org.png'
              },
              {
                alt: '[小黄人不屑]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b2/xhrnew_buxie_org.png'
              },
              {
                alt: '[小黄人高兴]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/41/xhrnew_gaoxing_org.png'
              },
              {
                alt: '[小黄人惊讶]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/fd/xhrnew_jingya_thumb.png'
              },
              {
                alt: '[小黄人委屈]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/79/xhrnew_weiqu_org.png'
              },
              {
                alt: '[小黄人坏笑]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/be/xhrnew_huaixiao_thumb.png'
              },
              {
                alt: '[小黄人白眼]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e2/xhrnew_baiyan_org.png'
              },
              {
                alt: '[小黄人无奈]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/15/xhrnew_wunai_thumb.png'
              },
              {
                alt: '[小黄人得意]',
                src: 'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c8/xhrnew_deyi_thumb.png'
              }
            ]
          }
        ]
        editor.create();
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
      #wangeditor
        overflow: hidden
        display: flex
        flex-direction :column
        div
          display: flex
          flex-direction :column
          flex:1
        .putOut
          background: #282a2c 99
          width: 100px
          height: 40px
          border: 1px solid #ccc
          font-size: 16px
          color: #333
          float: left
          margin-top: 10px

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
                position: absolute
                right: 20px
                bottom:0
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
