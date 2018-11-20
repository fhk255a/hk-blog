<template>
  <div class="main" id="add-article-page">
    <v-header></v-header>
    <div class="">
      <div class="push"><h1>发表文章</h1></div>
      <div class="main-inner container">
        <div class="content-wrap">
          <div class="content">
            <div id="pushArticle">
              <p for="" class="f-title">标题</p>
              <div class="input-item">
                <input class="col-lg-10 col-md-9 col-xs-8 col-sm-8" v-model="articleArr.title" type="text" placeholder="请输入标题" required>
                <span class="wran-tip col-lg-2 col-md-3 col-xs-4 col-sm-4">* 最多输入50个字</span>
              </div>
              <p for="" class="f-title">系列</p>
              <div class="input-item">
                <select name="art-type" class="art-type col-lg-10 col-md-9 col-xs-8 col-sm-8" id="" required v-model="articleArr.type">
                  <option :value="index" v-for="(item,index) in artType">{{item}}</option>
                </select>
                <span class="wran-tip col-lg-2 col-md-3 col-xs-4 col-sm-4">* 必须选一个</span>
              </div>
              <p for="" class="f-title">标签</p>
              <div class="input-item">
                <div class="tag col-lg-10 col-md-9 col-xs-8 col-sm-8">
                  <input type="text" v-for="(item,index) in articleArr.tag" class="tag-item" v-model="articleArr.tag[index]"
                         required placeholder="请输入标签">
                  <div class="add-tag" @click="addTagInput">
                    <i class="iconfont icon-add "></i>
                  </div>
                </div>
                <span class="wran-tip col-lg-2 col-md-3 col-xs-4 col-sm-4" style="position: static;width: 100%;text-align: left">* 最多添加5个</span>
              </div>
              <p for="" class="f-title" style="margin-bottom:5px">内容</p>
              <div class="pcE" v-if="nowPcOrApp">
                <div id="wangeditor" class="comment-box col-lg-12 col-md-12 col-sm-12 col-xs-12">
                  <div ref="editorElem" id="editor-main"></div>
                </div>
                <div class="comment-info col-lg-2 col-md-3 col-sm-4 col-xs-12 btn btn-info">
                  <div class="comment-btn  " @click="pushArticleHtml">发布</div>
                </div>
              </div>
              <div class='mobileE' v-else>
                <div class="comment-box col-lg-12 col-md-12  col-sm-12 col-xs-12" >
                  <v-editor :content="content" @change="updateData" :height="300" :z-index="9999999"></v-editor>
                </div>
                <div class="comment-info col-lg-4 col-md-4 col-sm-5 col-xs-12">
                  <div class="comment-btn btn btn-info " @click="pushArticleCon">发布</div>
                </div>
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
  import E from '../../../static/js/wangEditor'
  import msg from '../../components/msgbox/msgbox'
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
    name: 'editor',
    components: {
      'v-msg': msg,
      'v-header': header,
      'v-footer': footer,
      'v-editor': editor1
    },
    data() {
      return {
        //文章类型
        artType:[
          '生活','技术','分享','记录','笔记'
        ],
        //PC端富文本框内容
        editorContent: '',
        //手机文本框内容
        content:'',
        //上传文章状态
        contentPutOut: false,
        //文章信息内容
        articleArr: {
          title: "",
          tag: [''],
          type: 0
        }
      }
    },
    created() {
      if (sessionStorage['userinfo'] == null) {
        window.history.go(-1);
      }
    },
    methods: {
      //获取富文本框内容
      updateData(e = ''){
        let c1 = e.replace(/<img style="max-width:90%"/g, '<img');
        let c2 = c1.replace(/<img/g, '<img style="max-width:90%"');
        this.content = c2;
      },
      //提交文章内容
      pushArticleHtml() {
        let param = {
          url: "addArticle",
          data: {
            params: {
              "content": this.editorContent,
              "title": this.articleArr.title,
              "type": this.articleArr.type,
              tag: this.tagInputNum,
              id: JSON.parse(sessionStorage['userinfo']).id,
              author: JSON.parse(sessionStorage['userinfo']).username
            },
            token: '123',
          },
          type: "post"
        };
        this.inspectIsNull();
        if (this.contentPutOut) {
          severAjax(param, (res) => {
            if (parseInt(res.code) == 200) {
              this.contentPutOut = false;
              this.articleArr = {
                title: "",
                tag: [''],
                type: 0
              };
              this.editorContent = '';
              alert('发布成功');
            } else {
              this.contentPutOut = false;
              alert('发布失败');
            }
          })
        }
      },
      pushArticleCon(){
        let param = {
          url: "addArticle",
          data: {
            params: {
              "content": this.content,
              "title": this.articleArr.title,
              "type": this.articleArr.type,
              tag: this.tagInputNum,
              id: JSON.parse(sessionStorage['userinfo']).id,
              author: JSON.parse(sessionStorage['userinfo']).username
            },
            token: '123',
          },
          type: "post"
        };
        this.inspectIsNull();
        if (this.contentPutOut) {
          severAjax(param, (res) => {
            if (parseInt(res.code) == 200) {
              this.contentPutOut = false;
              this.articleArr = {
                title: "",
                tag: [''],
                type: 0
              };
              this.content = '';
              $('.w-e-text').html('');
              alert('发布成功');
            } else {
              this.contentPutOut = false;
              alert('发布失败');
            }
          })
        }
      },
      //检查是否为空
      inspectIsNull() {
        if ($.trim(this.articleArr.title) == '') {
          alert('标题不能为空');
          return;
        }
        if (this.editorContent.length < 50) {
          alert('内容不能少于50个字符');
          return;
        }
        for (var i = 0; i < this.articleArr.tag.length; i++) {
          if ($.trim(this.articleArr.tag[i]).length < 1) {
            alert('标签不能为空');
            break;
          } else {
            this.contentPutOut = true;
          }
        }
      },
      //添加标签
      addTagInput() {
        if (this.tagInputNum.length < 5) {
          this.tagInputNum.push('');
        } else {
          return false;
        }
      },
    },
    computed: {
      //动态添加标签
      tagInputNum() {
        return this.articleArr.tag;
      },
      nowPcOrApp(){
        if(isMobile()){
          return false;
        }else{
          return true;
        }
      }
    },
    mounted() {
      if(this.nowPcOrApp){
        var editor = new E(this.$refs.editorElem);        //创建富文本实例
        editor.customConfig.onchange = (html) => {
          this.editorContent = html
          // this.catchData(html)  //把这个html通过catchData的方法传入父组件
        }
        editor.customConfig.uploadImgServer = 'http://oootb.com/bolg/sever.php?url=uploadEditorArticleImg';
        editor.customConfig.uploadFileName = 'hkimg';
        editor.customConfig.debug = true;
        editor.create();
      }
    }
  }
</script>

<style scoped lang='stylus' res='stylesheet'>
.main
  padding-bottom: 80px
  .push
    height:200px
    margin-bottom :30px
    background: #fff
    line-height:200px
    h1
      line-height:200px
  .main-inner
    background: #fff
    border-radius :30px
    padding:100px 30px 30px
    overflow: hidden
  .content-wrap
    width: 100%
    .f-title
      font-weight: 600
      color: #666
      font-size: 16px
      text-align: left
      padding-left: 10px
    .wran-tip
      color: darkred
      position: absolute
      top: 0
      right: 0
      padding: 0
      line-height: 40px
    .input-item
      width: 100%
      overflow: hidden
      position: relative
      margin: 5px 0
      input, .art-type
        float: left;
        height: 40px
        background: transparent
        border: 1px solid #ccc
        -webkit-box-sizing: border-box
        -moz-box-sizing: border-box
        box-sizing: border-box
      .art-type
        color: chocolate;
      .tag
        display: flex
        padding: 0
        height: 100%
        .tag-item
          margin-right: 5px
          text-indent :1em
          flex:1
        .add-tag
          border-radius: 50%
          width: 40px;
          z-index :2
          height: 40px;
          position: relative
          right: 0
          border: 1px solid #ccc
          -webkit-box-sizing: border-box
          -moz-box-sizing: border-box
          box-sizing: border-box
          line-height: 40px;
        .iconfont
          font-size: 24px
          font-weight: 700
.comment-box
  padding: 0
#wangeditor
  padding: 0
#editor-main
  display: flex;
  border: 1px solid #ddd;
  background: #fff
  border-radius: 6px;
  overflow: hidden;
  flex-direction: column;
  text-align: left;
  height: 300px
#wangeditor .all-screen
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  height: auto;
  right: 0;
  z-index: 999999;
</style>
