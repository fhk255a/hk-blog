<template>
  <div class="regsiter-box">
    <div class="title">
      <h1>Regsiter</h1>
    </div>
    <p class="item">
      <span class="iconfont icon-user"></span>
      <input type="text" placeholder="用户名" class="reg-user" minlength="6" @focus="login_error=false" @blur="isRegsister"
             v-model="username" maxlength="12" required/>
    </p>
    <p class="item">
      <span class="iconfont icon-password"></span>
      <input type="password" minlength="6" class="reg-pwd" maxlength="18" @focus="login_error=false" v-model="password"
             placeholder="密码" required/>
    </p>
    <p class="item">
      <span class="iconfont icon-phone"></span>
      <input type="number" minlength="11" class="reg-phone" maxlength="11" @focus="login_error=false" v-model="phone"
             placeholder="手机" required/>
    </p>
    <p class="item item-btn" @click="regSisterBtn">
      <input type="submit" class="regsiter-btn" value="注册">
    </p>
    <p class="tip" v-show="login_error">{{login_tip}}</p>
  </div>
</template>

<script>
  export default {
    name: "regsister",
    data: function () {
      return {
        phone: '',
        username: '',
        password: '',
        login_error: false,
        login_tip: '账号或者密码错误'
      }
    },
    methods: {
      isRegsister() {
        let param = {
          url: 'getRegsisterList',
          data: {
            params: {
              username: this.username,
            },
            token: '123'
          },
          type: 'post'
        };
        severAjax(param,
          (res) => {
            if (parseInt(res.code) == 200) {
              this.login_tip = res.info;
              this.login_error = true;
            }
            else {
              this.login_tip = res.info;
              this.login_error = true;
            }
        })
      },
      regSisterBtn(){
        if($.trim(this.password) == '' || $.trim(this.password).length < 6){
          this.login_tip = '密码不能为空或者小于6位数';
          this.login_error = true;
          return;
        }
        if($.trim(this.username) == '' || $.trim(this.password).length < 6){
          this.login_tip = '用户名不能为空或者小于4位';
          this.login_error = true;
          return;
        }
        if($.trim(this.phone) == '' || $.trim(this.phone).length < 11){
          this.login_tip = '手机号码不能为空或者不能为小于11位';
          this.login_error = true;
          return;
        }
        let param = {
          url: 'addUsersList',
          data: {
            params: {
              username: this.username,
              phone: this.phone,
              password: this.password,
            },
            token: '123'
          },
          type: 'post'
        };
        severAjax(param,
          (res) => {
            if (parseInt(res.code) == 200) {
              this.login_tip = '注册成功';
              this.login_error = true;
              window.location.href='#/login';
            }
            else {
              this.login_tip = res.info;
              this.login_error = true;
            }
          })
      }
    },
    computed: {}
  }
</script>

<style scoped>
  @import '../../../static/css/login-regsiter.css';

  .tip {
    margin-top: 30px;
    color: #fff;
  }
</style>
