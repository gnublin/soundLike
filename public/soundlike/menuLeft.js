jsLeft=false

function buttonLeftEntry(idName){
  if (jsLeft != true) { 
  var leftEntryEl = document.getElementById("left-"+idName).querySelectorAll('.leftEntry')
  for (var e = 0, f = leftEntryEl.length; e < f; e++) {
    console.log(leftEntryEl[e])
    leftEntryEl[e].removeEventListener
    leftEntryEl[e].addEventListener('click', function(){
      clearIdHtml("mainFrame");
      subMenuActiv(leftEntryEl,this.id);
      subMenu(this);
      jsLeft=true;
    })
  }
}}

function subMenuActiv(listEl, idActiv) {

  for (var g = 0, h = listEl.length; g < h ; g++) {
    if (listEl[g].id == idActiv) {
      listEl[g].className = "leftEntry leftEntryActiv"
    }
    else {
      listEl[g].className = "leftEntry"
    }
  }

}

function subMenu(subEl){

  var reqId = subEl.id
  get = document.createElement('script');
  get.src = "api.js?type="+reqId;
  get.id = "getMenuEl"
  document.body.appendChild(get);
  document.body.removeChild(get);

}
