<template>
  <div id="footer">
    <div class="footer-inner">
      <p class="footer-item time">
        服务器已经运行23天5小时36分40秒😄
        {{time}}
      </p>
      <p>
        粤ICP备18071261号-1.
      </p>
    </div>
  </div>
</template>

<script>
    export default {
      name: "footer",
      data(){
        return{
          beginTime:1540718372000,
          time:{
            D:'',
            H:'',
            M:'',
            S:''
          }
        }
      },
      methods:{
        longTime:(time)=>{
          let that = this;
          let D,H,M,S;
          updataTime(time);
          function updataTime(time){
            let nowTime = new Date().getTime();
            let timed = (nowTime - time)/1000;
            D = Math.floor(timed / 24 / 3600);
            H = Math.floor(timed / 3600 % 24)< 10?'0'+Math.floor(timed / 3600 % 24):Math.floor(timed / 3600 % 24);
            M = Math.floor(timed / 60 % 60)<10?'0'+Math.floor(timed / 60 % 60):Math.floor(timed / 60 % 60);
            S = (Math.floor(timed % 60)<10)?'0'+Math.floor(timed % 60):Math.floor(timed % 60);
            console.log(D,M,H,S);
            setTimeout(function(){
              updataTime(timed);
            },1000)
          }
        }
      },
      created(){
        this.longTime(this.beginTime)
      }
    }
</script>

<style scoped lang='stylus' res='stylesheet'>
  #footer
    background: #232323
    padding: 15px 0 10px
    text-align: center
    color: #888
    font-size: 12px
    line-height: 1.5
    position: absolute;
    left: 0;
    bottom: 0;
    width: 100%;
    min-height: 50px;
    .footer-inner
      width: 100%;
      margin: 0;
</style>
