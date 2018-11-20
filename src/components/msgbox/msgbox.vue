<template>
  <div class="msgBg" msgData >
    <div id="msgBox">
      <div class="msgContainer">
        <p class="title">{{msgData.title}}</p>
        <p class="content">{{msgData.msg}}</p>
        <div class="btns" ref="btn" v-if="msgData.btn.length>1">
          <button class="btn-item ok" @click="emitEvent">
            ok
          </button>
          <button class="btn-item cannel" @click="cannel">
            cannel
          </button>
        </div>
        <div class="btns" ref="btn" v-else>
          <button class="btn-item ok" @click="cannel">
            ok
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "msgbox",
    props:[
      'msgData'
    ],
    created(){

    },
    data:function(){
      return{
        btnStatus:false
      }
    },
    methods:{
      emitEvent(){
        this.$emit('my-event', 'test');
        this.$emit('push-art-msg','msg');
        this.cannel();
        //通过按钮的点击事件触发方法，然后用$emit触发一个my-event的自定义方法，传递this.msg数据。
      },
      cannel:function(){
        this.$emit('btn-status', this.btnStatus);
      }
    }
  }
</script>

<style scoped lang="stylus">
  .msgBg
    background: rgba(7, 17, 27, 0.2)
    position: fixed
    left: 0
    z-index: 99999
    right: 0
    bottom: 0
    top: 0
    display: table-cell;
    vertical-align: middle;
    text-align: center;
    #msgBox
      color: #666;
      width: 200px;
      min-height: 100px;
      height: 150px;
      vertical-align: middle;
      overflow: hidden
      margin: auto;
      position: absolute;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      .msgContainer
        width: 100%
        box-sizing: border-box;
        background: #fff;
        border: 1px solid #eee;
        overflow: hidden
        margin: 0 auto;
        .title
          font-weight: 700
          padding: 8px 15px
          font-size: 18px
          color: #333
          text-align: left
          border-bottom: 1px solid #eee
        .content
          font-size: 14px
          padding: 10px 15px
          text-align: left
        .btns
          display: flex
          justify-content: space-between
          width: 100%
          height: 30px
          .btn-item
            flex: 1
            height: 100%
            border: 1px solid #eeebe7
            -webkit-box-sizing: border-box
            -moz-box-sizing: border-box
            box-sizing: border-box
            cursor: pointer
</style>
