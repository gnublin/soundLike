'use strict';

clickButton();
disableErrMsg();

function switchMainContent(activ) {

  var idName = activ.id.split(/menu-/).join('');
  var leftEl = document.querySelectorAll('.menuLeft')
  var leftElClass = "menuLeft";

  for (var d = 0, e = leftEl.length; d < e ; d++ ) {

    var leftIdName = leftEl[d].id.split(/left-/).join('')

    if ( leftIdName == idName ) {

      leftEl[d].className = leftElClass + " leftActiv"
      buttonLeftEntry(idName);
    }
    else {
      leftEl[d].className = leftElClass
    }
  }

}

function clearIdHtml(id){
  document.getElementById(id).innerHTML="";
}


function clickButton() {

  var tabEl = document.querySelectorAll('.menuTab');
  var tabElActiv = document.querySelector('.tabActiv');

  for (var a = 0, b = tabEl.length; a < b ; a++) {
    tabEl[a].addEventListener('click',function(){
      clearIdHtml("mainFrame");
      switchTab(tabEl,this);
      switchMainContent(this);
    });
  }

  switchMainContent(tabElActiv)
}

function switchTab(all, activ) {

    for (var c = 0, d = all.length; c < d; c++) {

      if (all[c] == activ) {
        all[c].className = "menuTab tabActiv"
      }
      else {
        all[c].className = "menuTab"
      }
    }

}

function setRedis(method, key, val, callback) {

  if (method == "") {
    method = "replace"
  }

  var redisUrl = "method="+method+"&key="+key+"&value="+val
  var redisD = document.createElement('script');

  redisD.src = "/napi/redisSet?"+redisUrl;
  redisD.method = 'POST';

  if (callback != "") {
    redisD.onload = callback;
  }

  document.body.appendChild(redisD);
  document.body.removeChild(redisD);
}


function getRedis(callback) {

  var redisG = document.createElement('script');

  redisG.src = "/napi/redisGetInfo?";

  if (callback != "") {
    redisG.onload = callback;
  }

  document.body.appendChild(redisG);
  document.body.removeChild(redisG);
}
