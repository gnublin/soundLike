'use strict';

var buttons = document.querySelectorAll('.switchBt');
var buttonsLength = buttons.length;
switchButtons();
disableErrMsg();

function switchButtons() {

  for (var i = 0; i < buttonsLength ; i++) {
    var button = buttons[i];
    var idName = button.id;
    button.addEventListener('click', switchTab);
  }
}

function switchTab() {

  var idName = this.id;

  for (var k = 0; k < buttonsLength; k++) {
    var kId = buttons[k].id;
    if ( kId == idName ) {
      buttons[k].className = 'switchBt tabActiv';
      var idFrameEl = idName+'Frame';
      document.getElementById(idFrameEl).className = 'tab tabShow';
    }
    else {
      buttons[k].className = 'switchBt';
      var idFrameEl = kId+'Frame';
      document.getElementById(idFrameEl).className = 'tab tabHidden';
    }
  }
}
