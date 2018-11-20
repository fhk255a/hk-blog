<template>
  <div class="main" id="add-article-page">
    <v-header></v-header>
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
              <span class="wran-tip col-lg-2 col-md-3 col-xs-4 col-sm-4">* 最多添加5个</span>
            </div>
            <p for="" class="f-title" style="margin-bottom:5px">内容</p>
            <div id="wangeditor">
              <div ref="editorElem" style="display: flex;flex-direction: column;text-align:left;height:300px"></div>
              <input type="submit" value="发布" class="putOut" @click="inspectIsNull" ref="putOutBtn">
              <v-msg ref="msgBox" v-if="msgStatus" :msgData="msg" @my-event="pushArticleHtml"
                     @btn-status="status"></v-msg>
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

  export default {
    name: 'editor',
    components: {
      'v-msg': msg,
      'v-header': header,
      'v-footer': footer
    },
    data() {
      return {
        //文章类型
        artType:[
          '生活','技术','分享','记录','笔记'
        ],
        //富文本框内容
        editorContent: '',
        //信息弹出框状态
        msgStatus: false,
        //信息弹出框属性配置
        msg: {
          'title': '提示',
          'msg': '确定提交吗？',
          'btn': [
            'ok',
            'cannel'
          ]
        },
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
        if (this.contentPutOut) {
          severAjax(param, (res) => {
            if (parseInt(res.code) == 200) {
              this.msg.title = '成功';
              this.msg.msg = '发表成功';
              this.msg.btn = ['ok'];
              this.contentPutOut = false;
              this.articleArr = {
                title: "",
                tag: [''],
                type: 0
              };
              this.editorContent = '';
              this.showMsgBox();
            } else {
              this.msg.title = '错误';
              this.msg.msg = '发表失败';
              this.msg.btn = ['cannel'];
              this.contentPutOut = false;
              this.showMsgBox();
            }
          })
        }
      },
      //检查是否为空
      inspectIsNull() {
        if ($.trim(this.articleArr.title) == '') {
          this.msg.title = '错误';
          this.msg.msg = '标题不能为空';
          this.msg.btn = ['cannel'];
          this.showMsgBox();
          return;
        }
        if (this.editorContent.length < 50) {
          this.msg.title = '错误';
          this.msg.msg = '文章内容不能少于50个字符';
          this.msg.btn = ['cannel'];
          this.showMsgBox();
          return;
        }
        for (var i = 0; i < this.articleArr.tag.length; i++) {
          if ($.trim(this.articleArr.tag[i]).length < 1) {
            this.msg.title = '错误';
            this.msg.msg = '标签不能为空';
            this.msg.btn = ['cannel'];
            this.showMsgBox();
            break;
          } else {
            this.msg = {
              title: '提示',
              msg: '确定提交吗？',
              btn: [
                'ok',
                'cannel'
              ]
            };
            this.contentPutOut = true;
            this.showMsgBox();
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
      //显示弹出框
      showMsgBox() {
        this.msgStatus = true;
      },
      //隐藏弹出框
      hideMsgBox() {
        this.msgStatus = false;
      },
      //弹出框状态
      status(status) {
        this.msgStatus = status;
      }
    },
    computed: {
      //动态添加标签
      tagInputNum() {
        return this.articleArr.tag;
      }
    },
    mounted() {
      var editor = new E(this.$refs.editorElem);        //创建富文本实例
      editor.customConfig.onchange = (html) => {
        this.editorContent = html
        // this.catchData(html)  //把这个html通过catchData的方法传入父组件
      }
      editor.customConfig.uploadImgServer = 'http://localhost/bolg/sever.php?url=upimg'
      editor.customConfig.uploadFileName = 'articleImgName'
      editor.customConfig.debug = true;
      editor.create();
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

  #wangeditor
    overflow: hidden
    .putOut
      background: #282a2c 99
      width: 100px
      height: 40px
      border: 1px solid #ccc
      font-size: 16px
      color: #eee
      float: left
      margin-top: 10px
</style>
