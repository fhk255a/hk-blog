<script src="../../../static/js/js.js"></script>
<template>
  <div class="container">
    <v-header @deleteLoginStatus="deleteUserStatus"></v-header>
    <div class="main-inner">
      <div class="content-wrap col-lg-8 col-md-8 ">
        <div class="content">
          <v-message></v-message>
          <div id="comment">
            <div class="comment"  v-if="loginStatus">
              <div class="no-login-editor col-log-12 col-sm-12 col-md-12 col-xs-12">
                <p>Hi！guy，留言需要先 <a href="#/login" class="login-btn btn btn-sm btn-success">登录</a> 哦</p>
              </div>
            </div>
            <div class="comment" v-else>
              <div class="comment-box col-log-10 col-md-10 col-sm-9 col-xs-12" >
                <v-editor :content="content" @change="updateData" :height="150" :z-index="9999999"></v-editor>
              </div>
              <div class="comment-info col-lg-2 col-md-2 col-sm-3 col-xs-12">
                <div class="comment-btn btn btn-info " @click="postUserComment">发布</div>
              </div>
            </div>
            <div class="user-msg-box">
              <div class="comment-list" ref="msgEleList">
                <div class="msg-status">
                  <span :class="{'msg-status-active':all_msg}" @click="getUserMsgList('all'),all_msg=true">全部留言</span>
                  <span :class="{'msg-status-active':!all_msg}" @click="getUserMsgList('hot') ,all_msg = false">热门留言</span>
                </div>
                <div class="hr"></div>
                <ul class="">
                  <li class="comment-item" v-for="(msg ,index) in msg_list" :class="{'hot-msg-top':index<3}">
                    <div class="author">
                      <a href="#" class="author-user">
                        <img class="img" src="../../assets/logo.png" alt="">
                      </a>
                      <div v-if="index<3" class="author-collect btn btn-info">关注</div>
                    </div>
                    <div class="comment-body">
                      <div class="comment-header">
                        <a class="comment-author" :href="'#/personal/id='+msg.id">{{msg.info.nickname}}</a>
                      </div>
                      <div class="comment-text"></div>
                      <div class="comment-info">
                        <span class="msg-top" :msgid="msg.msgid" :user-id="msg.id">#{{msg.msgid}}</span>
                        <span class="comment-date">{{msg.ctime}}</span>
                        <span class="msg-like" @click="addLikeFun(msg.msgid)">{{msg.clike}}<i class="iconfont icon-like"></i></span>
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
  import VueHtml5Editor from 'vue-html5-editor-master'
  const editor1 = new VueHtml5Editor(
    {
      // 全局组件名称，使用new VueHtml5Editor(options)时该选项无效
      // global component name
      name: "vue-html5-editor",
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
        sizeLimit: 2097152,  //2兆
        // 上传参数,默认把图片转为base64而不上传
        // upload config,default null and convert image to base64
        upload: {
          /*本地测试地址*/url: 'http://oootb.com/bolg/sever.php?url=uploadMsgImg',
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
      ],
      // 自定义要显示的模块，并控制顺序
      // keep only the modules you want and customize the order.
      // can be used with hiddenModules together
      visibleModules: [
        'text',
        "color",
        "font",
        "link",
        "unlink",
        'align',
        'list',
        "image",
        "eraser",
        "undo",
        "full-screen",
        'tabulation',
        'hr',
        'info',
      ],
      // 扩展模块，具体可以参考examples或查看源码
      // extended modules
      // 扩展模块，具体可以参考examples或查看源码
      // extended modules
      modules: {}
    }
  );
  export default {
    name: "message",
    components: {
      'v-userwrap': userwrap,
      'v-message': message,
      'v-header': header,
      'v-footer': footer,
      'v-editor': editor1
    },
    data:function(){
      return {
        content:'',
        login_status:false,
        msg_list:[],
        all_msg:true,
      }
    },
    methods:{
      //获取富文本框内容
      updateData(e = ''){
        let c1 = e.replace(/<img style="max-width:90%"/g, '<img');
        let c2 = c1.replace(/<img/g, '<img style="max-width:90%"');
        this.content = c2;
      },
      //发表评论
      postUserComment(){
        let param = {
          url: 'addMsg',
          data: {
            params:{
              "content": this.content,
              "id": JSON.parse(sessionStorage['userinfo']).id,
            },
            token: "12312",
          },
          type: 'post'
        };
        severAjax(param,(res)=>{
          if(res.info == 'OK'){
            alert('评论成功');
            this.content='';
            this.getUserMsgList('all');
          }
          else{
            alert('失败');
          }
        })
      },
      //获取留言信息列表
      getUserMsgList(orderType){
        let msgData = {
          url: 'getMsgList',
          data: orderType,
          type: 'get',
        };
        severAjax(msgData,(msg)=>{
          if(msg.info == 'OK') {
            this.msg_list = msg.data;
          }
        })
      },
      //点赞
      addLikeFun(msgid){
        let updateMsg = {
          url: 'updateMsgLike',
          data: msgid,
          type: 'get',
        };
        severAjax(updateMsg,(msg)=>{
          console.log(msg);
          if(msg.info == 'OK') {
            this.getUserMsgList('hot');
          }
        })
      },
      //清空用户信息
      deleteUserStatus(loginStatus){
        this.login_status = loginStatus;
      }
    },
    created(){
      if(sessionStorage['userinfo']==null){
        this.login_status = true;
      }
      else{
        this.login_status = false;
      }
      //加载全部用户留言信息
      this.getUserMsgList('all');
    },
    computed:{
      loginStatus:function(){
        return this.login_status;
      },
    },
    updated(){
      let msgEle = this.$refs.msgEleList.getElementsByClassName('comment-text');
      for(let i =0 ; i<msgEle.length;i++){
        msgEle[i].innerHTML=this.msg_list[i].content;
      }
    }
  }
</script>

<style scoped lang="stylus">

  .container
    padding: 0
    padding-top: 38px
    padding-bottom:100px
    .comment
      position: relative
      overflow: hidden
      >div
        padding: 0
      .comment-info
        position: absolute
        bottom: 1px
        font-size :20px
        right: 0
        .status-text
          line-height:30px
        .comment-btn
          width:100%
      .no-login-editor
        background-color: #ded2d2;
        border-radius :5px
        height:100px
        line-height:100px
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
        margin-right :30px
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
        margin:10px
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
            height:24px
            line-height: 10px
            margin :6px 0 0
        .comment-body
          flex: 1
          border-bottom :1px solid #e8e8e8
          overflow: hidden
          margin-left: 20px
          padding :10px 0
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
              line-height:20px
          .comment-info
            text-align: left
            height:20px
            font-size :12px;
            line-height:20px
            color:#656c7a
            span
              margin-right : 10px
            .comment-date
              font-size :12px;
              color: #656c7a;
            .icon-like
              margin-left:5px
.msg-status
  -webkit-box-sizing: border-box
  -moz-box-sizing: border-box
  box-sizing: border-box
  position: relative
  .msg-status-active
    padding-bottom :8px
    border-bottom :2px solid #ff9900
    color :#ff9900
</style>
