<template>
  <div id="comment">
    <v-editor :height="300" v-if="login_status"></v-editor>
    <div class="comment-title" v-else>
      <h2>请先<a href="#/login" style="text-decoration: underline;color:#d2691e">登录</a>后留言</h2>
    </div>
    <div class="comment-list">
      <ul class="">
        <li class="comment-item">
          <div class="author">
            <a href="#">
              <img class="img" src="../../assets/logo.png" alt="">
            </a>
          </div>
          <div class="comment-body">
            <div class="comment-header">
              <span class="comment-author">沧水</span><span class="comment-date">2018-10-10 13:47:20</span>
            </div>
            <div class="comment-text">
              <p>这是一个很灵性的网站哦</p>
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import editor from './../editor/editor'
  export default {
    name: "comment",
    components:{
      'v-editor':editor
    },
    computed:{
      login_status(){
        if( sessionStorage['userinfo']== undefined || sessionStorage['userinfo'].length < 1) {
          return false;
        } else {
          return true;
        }
      }
    },
  }
</script>

<style scoped lang="stylus">
@import "../../common/content.styl"
  #comment
    background: #fff
    margin: 0
    padding: 40px
    border-radius: 5px
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
        .author
          width: 50px
          height: 50px
          a
            width: 100%
            height: 100%
            display: block
        .comment-body
          flex: 1
          overflow: hidden
          padding-left: 20px
          .comment-header
            line-height: 2;
            font-size: 13px;
            text-align: left
            .comment-author
              line-height: 1;
              color: #2479cc;
              font-weight: 700;
              color: #076dd0;
            .comment-author:after
              color: #c2c6cc;
              content: "•";
              margin: 0 4px;
            .comment-date
              color: #656c7a;
</style>
