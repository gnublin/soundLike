
getRedis(setButton);
getRedis(colorizeButton);


var colorActive = "#5896B2";
var colorDeactive = "#D8D8D8";
var state = "";

allElements = document.querySelectorAll("[player-button]");

//for (var p=0, q=allElements.length; p<q ; p++) {
//    allElements[p].addEventListener('click',clickStatus);
//}

function setButton() {

  var buttonStatus = redisContent['status'];
  var buttonTrack = redisContent['track'];
  var keysStatus = Object.keys(buttonStatus);
  var keysTrack = Object.keys(buttonStatus);
  var elements = "";
  var button = "";

  for (var i=keysStatus.length, j=0; i>j; j++) {
    button = keysStatus[j];
    state = buttonStatus[button];
    element = document.querySelectorAll("[player-button="+button+"]")[0];
    console.log(element)
    element.addEventListener("click", function() {
      clickStatus(this)
    });
  }
}

function clickStatus(element) {

  var elAttribute = element.getAttribute('player-button');

  if (elAttribute) {
    var newState = false;
    var currentState = redisContent['status'][elAttribute];
    if (typeof currentState != 'undefined') {
      if (currentState == false ) {
        newState = true;
      }
      redisContent['status'][elAttribute] = newState;
      setRedis('status', JSON.stringify(redisContent['status']), getRedis)
    }
  }
  colorizeButton()
}

function colorizeButton() {
  var buttonStatus = redisContent['status'];
  var keysStatus = Object.keys(buttonStatus);
  var elements = "";
  var button = "";

  for (var i=keysStatus.length, j=0; i>j; j++) {
    button = keysStatus[j];
    state = buttonStatus[button];
    element = document.querySelectorAll("[player-button="+button+"]")[0];
    state = redisContent['status'][element.getAttribute('player-button')]
    if (state == true) {
      element.style.color = colorActive;
    }
    else {
      element.style.color = colorDeactive;
    }
  }
}


