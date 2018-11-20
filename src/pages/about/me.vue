<template>
    <div id="about-me">
      <v_header></v_header>
      <div class="about-inner container">
        <div class="r-q-title row">
          <p>hr</p>
        </div>
        <div class="r-q row">
          <div class="hr col-lg-12">
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
            </div>
            <div class="right">
              <p class="bubble">能简单自我介绍一下吗?</p>
            </div>
          </div>
          <div class="me col-lg-12">
            <div class="right" >
              <div class="bubble">
                <p>姓名：<i style="color:darkred">范鸿楷</i></p>
                <p>居住：广东人</p>
                <p>其他：男/23岁</p>
                <p>学校：广州涉外经济职业技术学院</p>
                <p>专业：软件技术</p>
              </div>
            </div>
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_2.jpg" alt="">
            </div>
          </div>
        </div>
        <div class="r-q row">
          <div class="hr col-lg-12">
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
            </div>
            <div class="right ">
              <p class="bubble">为什么会想做这个轻论坛?</p>
            </div>
          </div>
          <div class="me col-lg-12">
            <div class="right" >
              <div class="bubble">
                <p>因为一直以来都想写一个类似博客的项目，用来保存一些项目中出现的问题以及一些日常技术分享。</p>
                <p>因为刚学习PHP，也算是PHP的第一个练手项目吧。</p>
              </div>
            </div>
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_2.jpg" alt="">
            </div>
          </div>
        </div>
        <div class="r-q row">
          <div class="hr col-lg-12">
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
            </div>
            <div class="right ">
              <p class="bubble">在编写该项目遇到过什么问题呢?</p>
            </div>
          </div>
          <div class="me col-lg-12">
            <div class="right" >
              <div class="bubble">
                <p class="a-title">①时间问题:</p>
                <p>这个项目都是在工作业余时间编写，所以该项目也是陆陆续续在填坑。想到新的思路或者新的想法(脑洞)就得改来改去(；′⌒`)</p>
                <p class="a-title">②技术问题:</p>
                <p>因为之前有都是用node充当后台，这次想前后端分离开，所以就学习了PHP，也算是PHP的第一个项目吧</p>
              </div>
            </div>
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_2.jpg" alt="">
            </div>
          </div>
        </div>
        <div class="r-q row">
          <div class="hr col-lg-12">
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
            </div>
            <div class="right ">
              <p class="bubble">该项目用了那些技术呢?人数是怎么分工？</p>
            </div>
          </div>
          <div class="me col-lg-12">
            <div class="right" >
              <div class="bubble">
                <p>
                  <span style="background:#f7ecb5">PHP</span>、
                  <span style="background:#f7ecb5">MYSQL</span>、
                  <span style="background:#f7ecb5">VUE-cli</span>、
                  <span style="background:#f7ecb5">VUE-route</span>、
                  <span style="background:#f7ecb5">stylus</span>、
                </p>
                <p>
                  没人搭伙，所以就
                  <span class="bg-success"> FHK</span> 一个
                </p>
              </div>
            </div>
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_2.jpg" alt="">
            </div>
          </div>
        </div>
        <div class="r-q row">
          <div class="hr col-lg-12">
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_3.jpg" alt="">
            </div>
            <div class="right ">
              <p class="bubble">联系方式？</p>
            </div>
          </div>
          <div class="me col-lg-12">
            <div class="right" >
              <div class="bubble">
                <p class="wechat">
                  <a>微信：FHK255</a><i style="margin-left: 20px" @click="isWechatShow=!isWechatShow">二维码</i>
                  <span v-show="isWechatShow">
                    <img class="img" src="../../../static/images/wechat.png" alt="">
                  </span>
                </p>
                <p class="qq">
                  <a href="tencent://message/?uin=215537936">QQ：215537936</a><i style="margin-left: 20px" @click="isQQShow=!isQQShow">二维码</i>
                  <span v-show="isQQShow">
                    <img class="img" src="../../../static/images/qq.jpg" alt="">
                  </span>
                </p>
                <p class="email">
                  <a href="mailto:hk255@foxmail.com">邮箱：hk255@foxmail.com</a>
                </p>
                <p class="phone">
                  <a href="tel:13226627208">电话：13226627208</a>
                </p>
              </div>
            </div>
            <div class="left header-img col-lg-2 col-md-3 col-xs-4">
              <img class="img" src="../../../static/images/userimg/user_2.jpg" alt="">
            </div>
          </div>
        </div>
        <div class="r-q-bottom">
          <div class="msg-left">
            😄
          </div>
          <div class="msg-middle">
            <input type="text" placeholder="hr，你好，请问贵公司有招聘前端岗位吗..">
          </div>
          <div class="msg-right">发送</div>
        </div>
      </div>
      <v_footer></v_footer>
    </div>
</template>

<script>
  import v_header from '../../components/header/header'
  import v_footer from '../../components/footer/footer'
    export default {
        name: "me",
      components:{
        'v_header':v_header,
        "v_footer":v_footer
      },
      data:()=>{
          return{
            isWechatShow:false,
            isQQShow:false
          }
      },

    }
</script>

<style scoped lang="stylus">
.text
  padding :40px 0 60px
#about-me
  .about-inner
    margin-top :70px
    padding: 20px
    padding-bottom: 40px
    background: #666
    .me
      justify-content: flex-end
    .hr,.me
      display: flex
      margin-bottom: 10px
      .left
        position: relative
        text-align: left
        .title
          font-size : 16px
          color:#fff
          background: #333
          line-height:30px
          text-indent :1em
      .header-img
        width :70px
        height:70px
        overflow: hidden
        border-radius :50%
        padding :0
    .me .header-img
      margin-left: 20px
    .hr .header-img
      margin-right :20px
    .r-q-title
      position: fixed
      right: 0
      left: 0
      top:38px
      text-align: center
      color: #666666
      margin:0 -20px
      z-index: 9999
      background: #eee
      line-height: 38px
      font-size :18px
      height:38px
    .r-q-bottom
      background: #eee
      position: fixed
      z-index: 9999
      bottom:0
      width: 100%
      padding: 5 0
      margin: 0 -20px;
      line-height: 38px
      border-top :1px solid #fff
      display: flex
      .msg-middle
        -webkit-border-radius: 50px
        -moz-border-radius: 50px
        border-radius: 50px
        overflow: hidden
        height: 38px
        flex:1
        margin :0 10px
        input
          text-indent :1em
          border:0
          height: 100%
          width:100%
      .msg-right
        background: #a6e1ec
        color:#666
        padding :0 10px
        text-align: center
        line-height:38px
        border-radius :5px
.right
  max-width:66.6666667%
.hr .bubble
  background:#ffeb3b
.a-title
  font-size:14px
  margin-left :-2em
  font-weight:600
.wechat span ,.qq span
  margin: 20px
  overflow: hidden
  display: block
</style>
