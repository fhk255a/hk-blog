<template>
  <div>
    <div class="post article-item">
      <div class="item-main">
        <div class="item-header">
          <h1 class="title">留言板</h1>
        </div>
        <div class="item-body">
          <p>欢迎光临小饭博客。路过的朋友，来都来了，留下你的脚印吧~</p>
          <p>
              <img src="../../../static/images/fhk.jpg" class="img" alt="" />
          </p>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
    export default {
        name: "message"
    }
</script>

<style scoped lang="stylus" res='stylesheet'>
  @import "../../common/content.styl"
  .post
    position: relative
    padding: 40px
    background: #fff
    margin-bottom: 40px
    border-radius: 5px
    .item-header
      margin-bottom:20px
      .title
        text-align: center
        word-break: break-word
        color: #444
        font-size: 25px
        font-weight: 700
</style>
