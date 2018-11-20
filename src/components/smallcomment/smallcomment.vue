<template>
  <div id="wangeditor">
    <div ref="editorElem" style="text-align:left;height:200px" ></div>
    <input type="submit" value="发布" class="putOut" @click="showMsgBox" ref="putOutBtn">
    <v-msg ref="msgBox" v-if="msgStatus" :msgData="msg" @my-event="pushArticleHtml" @btn-status="status"></v-msg>
  </div>
</template>

<script>
  import E from '../../../static/js/wangEditor'
  import msg from '../../components/msgbox/msgbox'

  export default {
    name: 'editor',
    components: {
      'v-msg': msg
    },
    data() {
      return {
        editorContent: '',
        msgStatus: false,
        msg: {
          'title': '提示',
          'msg': '确定提交吗？',
          'btn': [
            'ok',
            'cannel'
          ]
        }
      }
    },
    methods: {
      pushArticleHtml() {
        this.hideMsgBox();
        let param = {
          url: 'pushArticle',
          data: {
            "content": this.editorContent,
            "title": "123123",
            "token": "12312",
          },
          type: 'post'
        };
        let that = this;
        severAjax(param,
          function (res) {
            if (parseInt(res.code) == 200) {
              that.msg.msg = '提交成功';
              that.msg.btn = ['ok'];
              that.showMsgBox();
            }
          })
      },
      showMsgBox() {
        this.msgStatus = true;
      },
      hideMsgBox() {
        this.msgStatus = false;
      },
      status(status) {
        this.msgStatus = status;
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
      // 自定义菜单配置
      if(isMobile){
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
          content: ['😀', '😃', '😄', '😁', '😆', '😁', '😔', '😊', '😜', '😳', '👄', '😱', '😌', '😍', '😣', '😓', '😏', '😭', '😒', '😄', '😖', '😲', '😉', '😘', '😝', '😂', '😡', '😠', '😥', '😷', '😪', '😨', '😰', '😞', '👿','😌', '😚', '😃']
        },
        {
          // tab 的标题
          title: '鸿楷专用',
          // type -> 'emoji' / 'image'
          type: 'image',
          // content -> 数组
          content: [
            {
              alt:'[哆啦A梦1]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/08/dorahaose_thumb.gif'
            },
            {
              alt:'[哆啦A梦2]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/61/dorahan_thumb.gif'
            },
            {
              alt:'[哆啦A梦3]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/jiqimaojingxiang_thumb.gif'
            },
            {
              alt:'[胖虎]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/2f/jiqimaopanghu_org.gif'
            },
            {
              alt:'[静香]',
              src:"http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/29/jiqimaojingxiang_org.gif"
            },
            {
              alt:'[大熊]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/8e/jiqimaodaxiong_org.gif'
            },
            {
              alt:'[小黄人]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b2/xhrnew_buxie_org.png'
            },
            {
              alt:'[小黄人剪刀手]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/63/xhrnew_jiandaoshou_org.png'
            },
            {
              alt:'[小黄人不屑]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/b2/xhrnew_buxie_org.png'
            },
            {
              alt:'[小黄人高兴]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/41/xhrnew_gaoxing_org.png'
            },
            {
              alt:'[小黄人惊讶]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/fd/xhrnew_jingya_thumb.png'
            },
            {
              alt:'[小黄人委屈]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/79/xhrnew_weiqu_org.png'
            },
            {
              alt:'[小黄人坏笑]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/be/xhrnew_huaixiao_thumb.png'
            },
            {
              alt:'[小黄人白眼]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/e2/xhrnew_baiyan_org.png'
            },
            {
              alt:'[小黄人无奈]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/15/xhrnew_wunai_thumb.png'
            },
            {
              alt:'[小黄人得意]',
              src:'http://img.t.sinajs.cn/t4/appstyle/expression/ext/normal/c8/xhrnew_deyi_thumb.png'
            }
          ]
        }
      ]
      editor.create();
    }
  }


</script>

<style scoped lang='stylus' res='stylesheet'>
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
