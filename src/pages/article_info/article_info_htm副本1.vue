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
            <div class="comment-box col-lg-11 col-md-10 col-sm-10 col-xs-12" >
              <v-editor :content="content" @change="updateData" :height="150" :z-index="9999999"></v-editor>
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
  import VueHtml5Editor from 'vue-html5-editor'
  const editor2 = new VueHtml5Editor(
    {
      // 全局组件名称，使用new VueHtml5Editor(options)时该选项无效
      // global component name
      name: "editor2",
      // 是否显示模块名称，开启的话会在工具栏的图标后台直接显示名称
      // if set true,will append module name to toolbar after icon
      showModuleName: false,
      // 自定义各个图标的class，默认使用的是font-awesome提供的图标
      // custom icon class of built-in modules,default using font-awesome
      icons: {
        text: "fa iconfont icon-23",
        color: "fa iconfont icon-shiwu-huabi",
        font: "fa iconfont icon-zitishezhi  ",
        align: "fa iconfont icon-duiqi",
        list: "fa iconfont icon-liebiao",
        link: "fa iconfont icon-lianjie",
        unlink: "fa iconfont icon-weibiaoti--",
        tabulation: "fa iconfont icon-biaoge1",
        image: "fa iconfont icon-filepicture",
        hr: "fa iconfont icon-758bianjiqi_fengexian",
        eraser: "fa iconfont icon-qingchu",
        undo: "fa-undo iconfont icon-chexiaofanhuichehuishangyibu",
        "full-screen": "fa iconfont icon-quanping1",
        info: "fa iconfont icon-guanyu1",
      },
      // 配置图片模块
      // config image module
      image: {
        // 文件最大体积，单位字节  max file size
        sizeLimit: 512 * 1024,
        // 上传参数,默认把图片转为base64而不上传
        // upload config,default null and convert image to base64
        upload: {
          /*本地测试地址*/url: 'http://oootb.com/bolg/sever.php?url=uploadArticleMsgImg',
          /*服务器地址*/// url:  '../../bolg/sever.php?url=upimg',
          headers: {},
          params: {},
          fieldName: 'file'
        },
        // 压缩参数,默认使用localResizeIMG进行压缩,设置为null禁止压缩
        // compression config,default resize image by localResizeIMG (https://github.com/think2011/localResizeIMG)
        // set null to disable compression
        compress: {
          width: 1600,
          height: 1600,
          quality: 80
        },
        // 响应数据处理,最终返回图片链接
        // handle response data，return image url
        uploadHandler(responseText) {
          //default accept json data like  {ok:false,msg:"unexpected"} or {ok:true,data:"image url"}
          var json = JSON.parse(responseText)
          if (!json.ok) {
            alert(json.msg)
          } else {
            return json.data
          }
        }
      },
      // 语言，内建的有英文（en-us）和中文（zh-cn）
      //default en-us, en-us and zh-cn are built-in
      language: "zh-cn",
      // 自定义语言
      i18n: {
        //specify your language here
        "zh-cn": {
          "align": "对齐方式",
          "image": "图片",
          "list": "列表",
          "link": "链接",
          "unlink": "去除链接",
          "table": "表格",
          "font": "文字",
          "full screen": "全屏",
          "text": "排版",
          "eraser": "格式清除",
          "info": "关于",
          "color": "颜色",
          "please enter a url": "请输入地址",
          "create link": "创建链接",
          "bold": "加粗",
          "italic": "倾斜",
          "underline": "下划线",
          "strike through": "删除线",
          "subscript": "下标",
          "superscript": "上标",
          "heading": "标题",
          "font name": "字体",
          "font size": "文字大小",
          "left justify": "左对齐",
          "center justify": "居中",
          "right justify": "右对齐",
          "ordered list": "有序列表",
          "unordered list": "无序列表",
          "fore color": "前景色",
          "background color": "背景色",
          "row count": "行数",
          "column count": "列数",
          "save": "确定",
          "upload": "上传",
          "progress": "进度",
          "unknown": "未知",
          "please wait": "请稍等",
          "error": "错误",
          "abort": "中断",
          "reset": "重置"
        }
      },
      // 隐藏不想要显示出来的模块
      // the modules you don't want
      hiddenModules: [
        'tabulation',
        'hr',
        'info',
        'align',
        'list',
        'text'
      ],
      // 自定义要显示的模块，并控制顺序
      // keep only the modules you want and customize the order.
      // can be used with hiddenModules together
      visibleModules: [
        "color",
        "font",
        "link",
        "unlink",
        "image",
        "eraser",
        "undo",
        "full-screen",
      ],
    }
  );
  export default {
    name: "article_page",
    components: {
      'v-header': header,
      'v-footer': footer,
      'v-editor': editor2,
    },
    data: function () {
      return {
        noMsgList:false,
        like_status: false,
        collect_status: false,
        artItemData: [],
        content:'',
        login_status:false,
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
      //获取富文本框内容
      updateData(e = ''){
        let c1 = e.replace(/<img style="max-width:90%"/g, '<img');
        let c2 = c1.replace(/<img/g, '<img style="max-width:90%"');
        this.content = c2;
        console.log(this.content);
      },
      //发表评论
      postUserComment(){
        let param = {
          url: 'pushArticleMsg',
          data: {
            params:{
              "content": this.content,
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
            this.content='';
            this.getArticleMsg();
          }
          else{
            alert('失败');
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
      addArticleWatch(){
        let param = {
          url: 'addArticleWatch',
          data: this.$route.params.id,
          type: 'get'
        };
        severAjax(param,(res)=>{})
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
