
function disableErrMsg() {

  var errMsgEl = document.getElementById('msgErr');
  var errMsgContent = document.getElementById('msgContent').innerHTML;
  console.log(errMsgContent);
  if (errMsgContent) {
    if (errMsgContent.match(/^OK*/)) {
      errMsgEl.style.backgroundColor = '#5896B2';
    }
    else if (errMsgContent.match(/^NOK*/)) {
      errMsgEl.style.backgroundColor = 'red';
    }
    setTimeout(function(){errMsgEl.classList.toggle('fade')}, 500)
  }

}

