<template>
    <div id="article-container">
      <div class="post article-item" v-for="item in articleData">
        <div class="item-date">
          <div class="month">{{fmtDate(item.ctime).substr(5,2)}}月</div>
          <div class="day">{{fmtDate(item.ctime).substr(8,2)}}</div>
        </div>
        <div class="item-tag" v-if="item.type">
          <span>
            <a href="#">{{articleType[item.type]}}</a>
          </span>
        </div>
        <div class="item-main">
          <div class="item-header">
            <h1 class="title">{{item.title}}</h1>
            <div class="date">
              <span> 发表于 {{fmtDate(item.ctime)}} </span>
              <span v-if="item.length"> 字数统计 {{item.length}} </span>
              <span> 阅读次数 {{item.watch}} </span>
            </div>
          </div>
          <div class="item-body" ref="artcontent">
            <div class="article-bg"></div>
            <div class="item_body_main"></div>
          </div>
          <div class="art-bottom" v-if="item.artid">
            <a class="art-all-btn" :href="'#/article/'+item.artid">阅读全文</a>
          </div>
          <div class="art-bottom" v-else>
            <a class="art-all-btn" :href="'#/devinfo/'+item.id">阅读全文</a>
          </div>
        </div>
      </div>
    </div>
</template>

<script>

  export default {

    name: "articles",
    props: ['articleData'],
    data: function () {
      return {
        articleType: [
          '生活', '技术', '分享', '记录', '笔记'
        ]
      }
    },
    methods: {
      fmtDate(obj) {
        obj *= 1000;
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
      },
    },
    computed: {
      artItemBody() {
        return this.$refs.artcontent;
      }
    },
    updated() {
      for (let i = 0; i < this.artItemBody.length; i++) {
        this.$refs.artcontent[i].childNodes[2].innerHTML = (this.articleData[i].content).substr(0, 2000);
      }
    }
  }
</script>

<style scoped lang="stylus" res='stylesheet'>
  .post
    position: relative
    padding: 40px
    background: #fff
    margin-bottom: 40px
    border-radius: 5px
    .item-header
      margin-bottom: 20px
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
        margin: 5px 0 50px 0;
        color: #999;
        font-family: "PingFang SC", "Microsoft YaHei", Lato, sans-serif;
        font-size: 12px;
        text-align: center;
    .item-tag
      position: absolute
      left: -16px
      top: 105px
      border-color: #47456d
      box-shadow: 0 2px 2px 0 rgba(0, 0, 0, .14), 0 3px 1px -2px rgba(0, 0, 0, .2), 0 1px 5px 0 rgba(0, 0, 0, .12)
      background-color: #97dffd
      margin: 5px 0 15px 2px
      font-size: 14px
      border-radius: 0 4px 4px 0
      display: inline-block
      padding: 7px 11px 7px 32px
      line-height: 1
      a
        color: #fff
      span:after
        position: absolute
        content: ""
        top: 100%
        left: 0
        border-top: 0 solid transparent
        border-right-width: 1em
        border-right-color: inherit
        border-right-style: solid
        border-bottom: 1em solid transparent
        border-left: 0 solid transparent
        width: 0
        height: 0
    .item-date
      background-color: #97dffd
      box-shadow: 0 2px 2px 0 rgba(0, 0, 0, .14), 0 3px 1px -2px rgba(0, 0, 0, .2), 0 1px 5px 0 rgba(0, 0, 0, .12)
      position: absolute
      top: -20px
      left: -30px
      height: 60px
      width: 60px
      padding-top: 10px
      border-radius: 100px
      color: #fff
      text-align: center
      line-height: 1.1
      .day
        font-size: 30px
        font-weight: 700
    .art-bottom
      position: absolute;
      z-index: 999;
      margin: 0 auto;
      width: 100%;
      bottom: 0;
      .art-all-btn
        background: #f0f8ff;
        border: 1px solid rgba(7,17,27,0.1)
        width: 150px;
        height: 40px;
        display: block;
        color: cadetblue;
        line-height: 40px;
        margin: 0px auto 0;
        border-radius: 5px;
        cursor: pointer;
        position: relative
        z-index: 2
.item-main
  position: relative
  .item-body
    text-align: left
    position: relative
    min-height: 200px
    max-height:400px
    .item_body_main
      overflow: hidden;
      height: 100%

</style>
