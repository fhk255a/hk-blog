<template>
  <div class="main">
    <v-header class=""></v-header>
    <div class="banner">
      <v-banner></v-banner>
      <div class="toggleType" @click="loadArticle" v-if="toggleArtStatus">切换普通文章</div>
      <div class="toggleType" @click="loadDevList" v-else>切换开发日记</div>
    </div>

    <div class="add-artbtn" @click="addArtPage">
      <a class="iconfont icon-edit">新增文章</a>
    </div>
    <div class="main-inner container">
      <div class="content-wrap col-lg-8 col-md-8 col-sm-12 col-xs-12">
        <div class="content">
          <v-article :articleData="articleList"></v-article>
        </div>
      </div>
      <div class="seller-wrap col-lg-4 col-md-4 ">
        <v-userwrap></v-userwrap>
      </div>
    </div>
    <v-footer></v-footer>
  </div>





</template>

<script>
  import article from '../../components/article/articles'
  import banner from '../../components/banner/banner'
  import userwrap from '../../components/userwrap/userwrap'
  import header from '../../components/header/header'
  import footer from '../../components/footer/footer'

  export default {
    name: "artices",
    data: function () {
      return {
        userinfo: {},
        articleList: [],
        articleType:false
      }
    },
    components: {
      'v-article': article,
      'v-userwrap': userwrap,
      'v-header': header,
      'v-footer': footer,
      'v-banner': banner,
    },
    created() {
      if (sessionStorage['userinfo'] != null) {
        this.userinfo = JSON.parse(sessionStorage['userinfo']);
      }
      this.loadDevList();
    },
    computed: {
      getUserId: function () {
        if (sessionStorage['userinfo'] == null) {
          return false
        } else {
          return this.userinfo.id;
        }
      },
      toggleArtStatus(){
        if(this.articleType){
          return true;
        }else{
          return false;
        }
      }
    },
    methods: {
      addArtPage() {
        console.log(this.getUserId);
        if(this.getUserId){
          window.location.href='#/add_article';
        }else{
          alert('请先登录');
        }
      },
      fmtDate(obj) {
        var date = new Date(obj);
        var y = 1900 + date.getYear();
        var m = "0" + (date.getMonth() + 1);
        var d = "0" + date.getDate();
        return y + "-" + m.substring(m.length - 2, m.length) + "-" + d.substring(d.length - 2, d.length);
      },
      loadArticle(){
        this.articleType=false;
        let param = {
          url: "getArticleList",
          token: '123',
          type: "get",
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.articleList = res.data;
          } else {
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        })
      },
      loadDevList(){
        this.articleType = true;
        let param = {
          url: "getDevList",
          token: '123',
          type: "get",
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.articleList = res.data;
          } else {
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        })
      }
    },
  }
</script>

<style scoped lang='stylus' res='stylesheet'>
.main
  padding-bottom: 100px
.add-artbtn
  position: absolute;
  z-index: 999;
  background: black;
  color: #fff;
  left: 0
  display: none
  padding: 5px 10px;
  border-radius: 0 5px 5px 0;
  opacity: 0.5;
  .icon-edit
    color:#fff;
.dev-show
  margin-top: 50px;
  background: #555;
  color: #fff;
  line-height: 50px;
  margin-bottom: 5px;
.main-inner
  position: relative

.banner
  position: relative
  .toggleType
    position: absolute;
    bottom: 0;
    right: 0;
    background: beige;
    padding: 2px 0 2px 10px;
</style>
