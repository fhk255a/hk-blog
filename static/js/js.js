function delestr(str){
  let newStr = str.replace(/\s/g,"").replace(/[^a-zA-Z0-9]/g,"").toLowerCase();
  return newStr;
}
function severAjax(param,_callback){
  let method = 'get';
  if(param.hasOwnProperty('type')){
    method = param.type;
  }
  $.ajax({
     // url:'http://localhost/bolg/sever.php?url='+param.url,
    url:'http://oootb.com/bolg/sever.php?url='+param.url,
    type:method,
    dataType:'json',
    data:{
      data:param.data
    },
    success:function(res) {
      if (_callback) {
        _callback(res);
      }
    },
    error:function(err) {
      console.log(err);
    }
  });
}
function log(str){
  console.log(str);
}

function isMobile(){
  if(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i.test(navigator.userAgent)) {
    return true;
  } else {
    return false;
  }
}


