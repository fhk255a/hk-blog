<template>
  <div class="login-box ">
    <div class="title">
      <h1>Login</h1>
    </div>
    <p class="item">
      <span class="iconfont icon-user"></span>
      <input type="text" placeholder="用户名" @focus="login_error=false" v-model="username" class="login-user" required/>
    </p>
    <p class="item">
      <span class="iconfont icon-password"></span>
      <input type="password" placeholder="密码" @focus="login_error=false" v-model="password" class="login-pwd" required/>
    </p>
    <p class="item item-btn" @click="loginPost">
      <input type="submit" class="login-btn" value="登录" >
    </p>
    <p class="tip" v-show="login_error">{{login_tip}}</p>
  </div>
</template>

<script>
    export default {
        name: "login",
        data:function(){
          return{
            username:'',
            password:'',
            login_error:false,
            login_tip:'账号或者密码错误'
          }
        },
        methods: {
          loginPost: function () {
            let param = {
              url:'login',
              data:{
                params:{
                  username:this.username,
                  password:this.password,
                },
                token:''
              },
              type:'post'
            };
            let that = this;
            severAjax(param,
              (res)=>{
                if(parseInt(res.code)==200){
                  sessionStorage['token']=res.token;
                  let userinfo = JSON.stringify(res.data[0]);
                  this.login_tip='登录成功,正在返回...';
                  this.login_error=true;
                  sessionStorage['userinfo'] = userinfo;
                  window.history.back();
                }
                else{
                  this.login_tip='账号或者密码有误,请重新输入';
                  this.login_error=true;
                  this.password='';
                }
              })
          }
        }
    }
</script>

<style scoped>
  @import '../../../static/css/login-regsiter.css';
  .tip{
    margin-top: 30px;
    color:#fff;
  }
</style>
