<template>
  <div id="link_page">
    <v_header></v_header>
    <div class="main container">
      <ul class="row link-list">
        <li class="item-link col-lg-4 col-md-6 col-xs-12 col-sm-12" v-for="(item ,index) in linkList">
          <div class="link-main">
            <div class="ding"></div>
            <div class="left col-lg-8 col-md-7 col-sm-6 col-xs-8">
              <h1 class="left-img">{{item.linktitle}}</h1>
            </div>
            <div class="right col-lg-4 col-md-5 col-sm-6 col-xs-4">
              <p class="title">{{item.linktitle}}</p>
              <p class="name">{{item.linkname}}</p>
              <a :href="item.linkhref" target="_blank" class="button">点击进入</a>
            </div>
          </div>
        </li>
      </ul>
    </div>
    <v_footer></v_footer>
  </div>
</template>

<script>
  import v_header from '../../components/header/header'
  import v_footer from '../../components/footer/footer'
    export default {
      name: "link_html",
      components:{
        'v_header':v_header,
        'v_footer':v_footer
      },
      data:()=>{
        return {
          linkList:[]
        }
      },
      created(){
        let param = {
          url: "getLinkList",
          token: '123',
          type: "get",
        };
        severAjax(param, (res) => {
          if (parseInt(res.code) == 200) {
            this.linkList = res.data;
            console.log(this.linkList);
          } else {
            console.log('获取文章列表失败，状态码：' + res.code + '</br>原因：' + res.info);
          }
        })
      }
    }
</script>

<style scoped lang="stylus">
#link_page
  margin: 0
  padding: 0
.container
  padding: 0
  margin: 0
  margin:38px auto
.row
  margin :30px 0
.item-link
  padding: 0
  .link-main
    background: #fff
    padding:10px 15px
    margin:10px
    height :120px
    overflow: hidden
    position: relative
    box-shadow : 1px 1px 50px 2px rgba(7,17,27,0.1)
    transform-origin: 15px 15px;
    transition :all 0.3s
    display: flex
    -webkit-border-radius: 8px
    -moz-border-radius: 8px
    border-radius: 8px
    text-align: left
  .button
    color:#999
    display: block
  .title
    font-size :18px
    font-weight:600
  .left
    padding: 5px 0
    line-height: 100px
  .right
    display: flex
    flex-direction:column
    justify-content :space-around
  .left-img
    font-size: 55px;
    text-align: center;
    font-weight: 700;
    color: #333;
    line-height: 55px;
    overflow: hidden;
    height: 55px;
    width: 100%;
    letter-spacing: 5px;
  .ding
    position: absolute
    width:20px
    height:20px
    top: 15px
    left:15px
    border-radius :50%
    background: #ddd
    border:3px solid rgba(7,17,27,0.5)
.item-link:hover .link-main
  transform: rotate(5deg);
</style>
