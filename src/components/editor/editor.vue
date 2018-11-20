<template>
  <div id="wangeditor" :style="'height:'+height+'px'">
    <div ref="editorElem" ></div>
    <input type="submit" value="发布" class="putOut" @click="showMsgBox" ref="putOutBtn">
    <v-msg ref="msgBox" v-if="msgStatus" :msgData="msg" @my-event="pushArticleHtml" @btn-status="status"></v-msg>
  </div>
</template>

<script>
  import E from '../../../static/js/wangEditor'
  import msg from '../../components/msgbox/msgbox'
  export default {
      name: 'editor',
      components:{
        'v-msg':msg
      },
      props:[
        'height'
      ],
      data () {
        return {
          editorContent: '',
          msgStatus:false,
          msg:{
            'title':'提示',
            'msg':'确定提交吗？',
            'btn': [
              'ok',
              'cannel'
            ]
          }
        }
      },
      methods: {
        pushArticleHtml(){
          this.hideMsgBox();
          let param = {
            url:'pushArticle',
            data:{
              "content":this.editorContent,
              "title":"123123",
              "token":"12312",
            },
            type:'post'
          };
          let that = this;
          severAjax(param,
            function(res){
              if(parseInt(res.code)==200){
                that.msg.msg='提交成功';
                that.msg.btn=['ok'];
                that.showMsgBox();
              }
            })
        },
        showMsgBox(){
          this.msgStatus = true;
        },
        hideMsgBox(){
          this.msgStatus = false;
        },
        status(status){
          this.msgStatus = status;
        }
      },
      mounted(){
        var editor = new E(this.$refs.editorElem);        //创建富文本实例
        editor.customConfig.onchange = (html) => {
          this.editorContent = html
         // this.catchData(html)  //把这个html通过catchData的方法传入父组件
        }
        console.log(isMobile);
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
        editor.customConfig.uploadImgServer = 'http://localhost/bolg/sever.php?url=upimg'
        editor.customConfig.uploadFileName = 'articleImgName'
        editor.customConfig.debug = true;
        editor.create();
      }
  }


</script>

<style scoped lang='stylus' res='stylesheet'>
  #wangeditor
    overflow: hidden
    display: flex
    flex-direction :column
    div
      display: flex
      flex-direction :column
      flex:1
    .putOut
      background: #282a2c99
      width: 100px
      height:40px
      border:1px solid #ccc
      font-size: 16px
      color:#eee
      float: left
      margin-top: 10px
</style>
