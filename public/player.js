
getRedis(setButton);
getRedis(colorizeButton);
getRedis(refreshPlaylist);
getRedis(setPlayButton);


var colorActive = "#5896B2";
var colorDeactive = "#D8D8D8";
var state = "";

function setPlayButton() {
  playingAllButton = document.querySelectorAll('.playing');
  playingAllButtonSize = playingAllButton.length;

  for (var t=0; t<playingAllButtonSize; t++) {
    var playingButton = playingAllButton[t];
    switch (playingButton.getAttribute('player-button')) {
      case 'play':
        playingButton.addEventListener('click',function() {
            redisContent['currentStatus']['paused'] = false;
            play(redisContent['currentStatus']['trackNumber'], redisContent['currentStatus']['trackTime'], redisContent['currentStatus']['paused']);
          }
        )
        break;
      case 'next':
        playingButton.addEventListener('click',function() {
            next_prev(+1);
          }
        )
      break;
      case 'preview':
        playingButton.addEventListener('click',function() {
            next_prev(-1);
          }
        )
      break;
      case 'stop':
        playingButton.addEventListener('click',function() {
            redisContent['currentStatus']['paused'] = true;
            play(redisContent['currentStatus']['trackNumber'], redisContent['currentStatus']['trackTime'], redisContent['currentStatus']['paused']);
          }
        )
      break;
    }
  }
}

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
    element.addEventListener("click", function() {
      clickStatus(this)
    });
  }
}

function refreshPlaylist() {

  playlistEl = document.getElementById('playlist');
  playlistAll = redisContent['playlist']
  playlistLength = playlistAll.length
  playlistEl.innerHTML = "";
  for (var p=0; p < playlistLength ; p++)
  {
    var liEl = document.createElement("li")
    liEl.innerHTML = '<i class="fa fa-minus-circle fa-play player-delete" data-track="'+p+'" />&nbsp;&nbsp;<i player-button="player-playlist" class="playlist-track fa fa-fw fa-play" data-track="'+p+'"></i>'+playlistAll[p]['name'];
    liEl.querySelector('.player-delete').addEventListener('click', function() {
      trackNumber=this.getAttribute('data-track')
      delFromPlaylist(trackNumber)
    });
    playlistEl.appendChild(liEl);
  }
  getRedis(refreshTrackPlay);
}

function delFromPlaylist(trackNumber) {
//  index = redisContent['playlist'].indexOf(redisContent['playlist'][trackNumber])
  var currentTrackNumber = redisContent['currentStatus']['trackNumber'];
  if (trackNumber < currentTrackNumber) {
    redisContent['currentStatus']['trackNumber'] = redisContent['currentStatus']['trackNumber'] - 1
  }

  setRedis('replace','currentStatus', JSON.stringify(redisContent['currentStatus']), '');
  setRedis('del','playlist', trackNumber, refreshPlaylist);
  // getRedis(refreshPlaylist);
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
      setRedis("", 'status', JSON.stringify(redisContent['status']), getRedis)
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

function addToPlaylist() {
  elData = this.parentNode.querySelector('.file')
  elDataPath = elData.getAttribute('data-path')
  elDataName = elData.getAttribute('data-name')
  getLength = Object.keys(redisContent['playlist']).length
  if (getLength == 0) {
    nextNum = 0
  }
  else {
    nextNum = getLength
  }

  elAppend = "{\"track\":\""+nextNum+"\", \"name\":\""+elDataName+"\", \"path\":\""+elDataPath+"\"}"

  setRedis('append','playlist', elAppend, getRedis);
  getRedis(refreshPlaylist);
}

function play(trackNumber, trackTime, trackStatus) {
  var audioEl = document.getElementById('player');
  if (trackNumber == "") {
    trackNumber = 0;
  }
  if (trackTime == "") {
    trackTime = 0;
  }

  if (trackStatus === false && audioEl.paused === false) {
    redisContent['currentStatus']['paused'] = true;
    redisContent['currentStatus']['trackTime'] = audioEl.currentTime;
    audioEl.pause()
  }
  else if (trackStatus === true) {
    redisContent['currentStatus']['trackTime'] = 0;
    audioEl.pause()
  }
  else {
    redisContent['currentStatus']['paused'] = false
    var trackPath = "/media?track=" + redisContent['playlist'][trackNumber]['path'];
    audioEl.src = trackPath;
    audioEl.addEventListener('loadedmetadata', function() {
      audioEl.currentTime = trackTime;
    });
    audioEl.play();
  }

  audioEl.setAttribute('track-num',trackNumber)
  setRedis("replace", "currentStatus", JSON.stringify(redisContent['currentStatus']), getRedis);

  audioEl.addEventListener('ended', function() {
    var next_val = +1;
    if ( redisContent['status']['repeated'] == true ) {
      next_val = 0;
    }
      next_prev(next_val)
  });
  playpause();
  getRedis(refreshTrackPlay)
}

function playpause() {
  var ppEl = document.querySelector('i[player-button=play]');
  if (redisContent['currentStatus']['paused'] == true) {
    ppEl.className = "ba-player playing fa fa-fw fa-play fa-2x";
  }
  else {
    ppEl.className = "ba-player playing fa fa-fw fa-pause fa-2x";
  }
}

function next_prev(evSt) {
    var audioEl = document.getElementById('player');

    numberOfTrack = redisContent['playlist'].length;
    numberOfTrack = numberOfTrack - 1
    if ( redisContent['status']['shuffled'] == true ) {
      redisContent['currentStatus']['trackNumber'] = Math.floor((Math.random() * redisContent['playlist'].length));
    }
    else {
      if (evSt == -1 && audioEl.currentTime < 5 || evSt == 1) {
        if (numberOfTrack == redisContent['currentStatus']['trackNumber'] && evSt == 1) {
          redisContent['currentStatus']['trackNumber'] = 0;
        }
        else if (redisContent['currentStatus']['trackNumber'] == 0 && evSt == -1) {
          redisContent['currentStatus']['trackNumber'] = numberOfTrack;
        }
        else {
          redisContent['currentStatus']['trackNumber'] = redisContent['currentStatus']['trackNumber'] + evSt
        }
      }
    }

    redisContent['currentStatus']['trackTime'] = 0
    setRedis("replace", "currentStatus", JSON.stringify(redisContent['currentStatus']), getRedis);
    play(redisContent['currentStatus']['trackNumber'], redisContent['currentStatus']['trackTime']);
}

function refreshTrackPlay() {
  var audioEl = document.getElementById('player')
  var tpEl = document.querySelectorAll('.playlist-track');
  var tpElLen = tpEl.length;
  for (var j=0 ; j < tpElLen ; j++) {
    // if (tpEl[j].getAttribute('data-track') == audioEl.getAttribute('track-num')) {
    if (tpEl[j].getAttribute('data-track') == redisContent['currentStatus']['trackNumber']) {
      color = "#5896B2";
      weight = "bold";
      padding = "0px";
    }
    else {
      color = "black";
      weight = "normal";
      padding = "5px"
    }

    tpEl[j].parentNode.style.color = color;
    tpEl[j].parentNode.style["padding-left"] = padding;
    tpEl[j].parentNode.style["font-weight"] = weight;
  }

}
