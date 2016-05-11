'use strict';

clickButton();

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

