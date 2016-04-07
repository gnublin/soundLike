
function buttonLeftEntry(idName){

  var leftEntryEl = document.getElementById("list-"+idName).querySelectorAll('.leftEntry')
  for (var e = 0, f = leftEntryEl.length; e < f; e++) {
    leftEntryEl[e].addEventListener('click', function(){
      subMenuActiv(leftEntryEl,this.id);
      subMenu(this);
    })
  }

}

function subMenuActiv(listEl, idActiv) {

  for (var g = 0, h = listEl.length; g < h ; g++) {
    console.log(listEl[g].id)
    if (listEl[g].id == idActiv) {
      listEl[g].className = "leftEntry leftEntryActiv"
    }
    else {
      listEl[g].className = "leftEntry"
    }
  }

}

function subMenu(subEl){

  console.log(subEl.id);
  var toto = document.createElement("div")
  toto.html("<%= j render(:partial => 'test') %>");

  //document.getElementById('mainFrame').appendChild(toto);
  document.getElementById('mainFrame').appendChild(toto);
}

