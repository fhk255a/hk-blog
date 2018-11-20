<template>
    <div class="back-header">
      <div class="back-container">
        <div class="back-left" onclick="javascript:history.back(-1);">
          <a class="iconfont icon-back"></a>
        </div>
        <div class="title-name">
          {{title}}标题
        </div>
        <div class="back-right">
          <a href="#/">
            <i class="iconfont icon-bank"></i>
          </a>
        </div>
      </div>
    </div>
</template>

<script>
    export default {
      name: "backheader",
      props:['title'],
      date:function(){
        return{

        }
      }
    }
</script>

<style scoped lang="stylus">
.back-header
  position: fixed
  top:0
  left:0
  right: 0
  z-index:10
  .back-container
    height:38px
    line-height: 38px;
    background: #f5f5f5;
    box-shadow :0 0 5px 0px rgba(7,17,27,0.2)
  .title-name
    margin:0 auto
    font-size :16px
  .back-left
    position: absolute
    left:10px
    top:0
    .iconfont
      line-height: 38px
      font-size :20px
      color:#000
  .back-right
    position: absolute
    right: 10px
    top: 0
    .iconfont
      line-height: 38px
      font-size :20px
</style>
