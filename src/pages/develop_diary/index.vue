<template>
    <div class="dev-index">
      <v-header></v-header>
      <div class="dev-main">
        <div class="banner">
          <img class='img ' src="@/../static/images/dev.jpg" alt="">
        </div>
        <div class="title">
          <h1>我的开发日记</h1>
        </div>
        <div class="dev-list">
          <div class="dev-item" v-for="(item) in devList">
            <div class="dev-date">
              <span>{{item.ctime}}</span>
            </div>
            <div class="dev-header">
              <div class="dev-title">
                <h3 class="dev-t">{{item.title}}</h3>
                <a href="#" class="dev-icon iconfont icon-moreunfold"></a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <v-footer></v-footer>
    </div>
</template>

<script>
  import header from '../../components/header/backheader'
  import footer from '../../components/footer/footer'
    export default {
      name: "index",
      components:{
        'v-header':header,
        'v-footer':footer
      },
      data(){
        return{
          devList:[],
        }
      },
      created(){
        let param = {
          url: "getDevList",
          token: '123',
          type: "get",
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.devList = res.data;
            console.log(this.devList);
          } else {
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        })
      }
    }
</script>

<style scoped lang='stylus'>
  .dev-main
    padding-top: 38px
    padding-bottom: 60px
    background: #fff
    h1
      margin: 0
      font-size :24px
      line-height: 48px
  .dev-list
    text-align: left
    overflow: hidden
    line-height:36px
    .dev-item
      margin-bottom: 10px
      background: aliceblue;
      padding: 0 10px;
      .dev-header
        position: relative
        .dev-t
          width:100%;
          margin:0 auto;
          line-height:36px
          font-size :18px
        .dev-icon
          line-height:36px
          top: 0
          text-decoration :none
          position: absolute
          right:10px

</style>
