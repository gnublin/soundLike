
function disableErrMsg() {

  var errMsgEl = document.getElementById('msgErr');
  var errMsgContent = document.getElementById('msgContent').innerHTML;
  if (errMsgContent) {
    if (errMsgContent.match(/^OK*/)) {
      errMsgEl.style.backgroundColor = '#8ABF7C';
    }
    else if (errMsgContent.match(/^NOK*/)) {
      errMsgEl.style.backgroundColor = 'red';
    }
    setTimeout(function(){errMsgEl.classList.toggle('fade')}, 3000)
  }

}
