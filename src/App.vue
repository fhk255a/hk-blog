<template>
  <div id="app"  class="container-fluid">
    <div id="main"  >
        <router-view/>
    </div>
  </div>
</template>

<script>
  import msgbox from './components/msgbox/msgbox'
  export default {
    name: 'App',
    components:{
      'v-msg':msgbox
    },
    data:function(){
      return {
        msg:{
          'title':'提示',
          'msg':'确定提交吗？',
          'btn': [
            'ok',
            'cannel'
          ],
          'methods':[
            function(){

            },
          ]
        }
      }
    },
    methods:{

    }
  }
</script>

<style scoped lang='stylus' res='stylesheet'>
#app
  font-family: 'Avenir', Helvetica, Arial, sans-serif
  -webkit-font-smoothing: antialiased
  -moz-osx-font-smoothing: grayscale
  text-align: center
  color: #2c3e50
  min-height:100%
  padding: 0
  position: relative
  #main::before, #main::after
    content: ""
    display: table
  #main::after
    clear: both
</style>
