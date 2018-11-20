<template>
  <div id="login-body" class="row"  ref="bg" >
    <div  class="container">
      <div id="login-register-box" class="col-lg-offset-8 col-md-offset-7 col-md-5 col-lg-4">
        <v-login v-if="isLogin" class="col-lg-12"></v-login>
        <v-regsister v-else></v-regsister>
        <div class="login-text" @click="isLogin=!isLogin">{{statusText}}</div>
      </div>
    </div>
  </div>
</template>

<script>
    import login from '../../components/login/login'
    import regsister from '../../components/regsister/regsister'
    export default {
        name: "login_reg_page",
        data:function(){
          return{
            isLogin:true,
            bgDataArr:[
              '../../static/images/banner-1.jpg',
              '../../static/images/banner-2.jpg',
              '../../static/images/banner-3.jpg',
              '../../static/images/banner-4.jpg'
            ]
          }
        },
        created(){
          if(sessionStorage['userinfo'] != null){
            window.history.back();
          }
        },
        computed:{
          loginStatus:function(){
            if(sessionStorage['userinfo']==null) {
              this.isLogin=true;
              return true;
            }else{
              this.isLogin=false;
              return false;
            }
          },
          statusText:function(){
            if(this.isLogin){
              return '没有账号，去注册';
            }else{
              return '已有账号，去登陆';
            }
          },
        },
        components:{
          'v-login':login,
          'v-regsister':regsister
        }
    }
</script>

<style scoped lang="stylus">
  #login-body
    height: 100%;
    background:url("~@/../static/images/banner-3.jpg") no-repeat center /100% 100%;
    position: fixed
    z-index: 99
    left:0
    top: 0
    right: 0
    bottom: 0
    .container
      height: 100%
      #login-register-box
        /*position: absolute;*/
        margin-top :100px
        overflow: hidden;
        height: 600px;
        border: 1px solid rgba(255,255,255,0.5);
        border-radius: 10px;
        box-shadow: 0 0 20px 5px rgba(255,255,255,0.5);
        background: rgba(7,17,27,0.2);
      .login-text
        position: absolute;
        bottom:50px;
        font-weight: 700;
        color:rgba(255,255,255,1);
        left: 50px;
        cursor: pointer;

</style>
