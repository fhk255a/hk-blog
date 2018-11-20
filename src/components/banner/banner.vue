<template>
  <div class="banner-inner">
    <div class="brand-wrapper col-lg-12" style="background-image:url(@/../static/images/banner-3.jpg)">
    </div>
    <div class="master container">
      <div class="master-header ">
        <img src="../../assets/logo.png" class="img" alt="">
      </div>
      <div class="master-motto">
        <i class="motto-item iconfont icon-edit"></i>
        <p class="motto-item text">坑要一个个填，步要一步步走。</p>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "banner"
  }
</script>

<style scoped lang="stylus">
.banner-inner
  height:750px
  position: relative
  .brand-wrapper
    position: relative
    height: 650px
    top:-80px
    /*width: 100%*/
    background-size: cover
    background-position: center 50%
    background-repeat: no-repeat
  .master
    text-align: center
    overflow: hidden
    /*width: 70%*/
    margin: auto
    top: -170px
    padding: 40px 0
    padding-bottom: 40px
    font-size: 16px
    opacity: .98
    background: rgba(255, 255, 255, .7)
    z-index: 1
    animation: b 1s ease-out
    position: relative
    border-radius: 5px
    .master-header
      width: 100px
      height: 100px
      border-radius: 100%
      margin: 0 auto
      background: #fff
      overflow: hidden
      .img
        width: 100%
        height: 100%
    .master-motto
      margin: 0 auto
      overflow: hidden
      text-align: center
      .motto-item
        display: inline-block
</style>
