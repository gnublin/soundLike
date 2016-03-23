
function redirect(idText, to) {
  var redirectEl = document.getElementById(idText);
  var redirectElP = document.createElement('p');
  redirectElP.className = "redirectMessage";
  var redirectElText = document.createTextNode("you will be redirect to: "+to);
  redirectElP.appendChild(redirectElText);
  redirectEl.appendChild(redirectElP);
  setTimeout(function(){window.location='/'}, 3000)
}

