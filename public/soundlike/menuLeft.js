jsLeft=false

function buttonLeftEntry(idName){

  if (jsLeft != true) {
  var leftEntryEl = document.querySelectorAll('.leftEntry')
  for (var e = 0, f = leftEntryEl.length; e < f; e++) {
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

function subMenu(subEl,extra=''){

  if (typeof(subEl) == 'object') {
    var reqId = subEl.id;
  }
  else {
    var reqId = subEl;
  }

  get = document.createElement('script');
  get.src = "api.js?type="+reqId+extra;
  get.id = "getMenuEl"
  document.body.appendChild(get);
  document.body.removeChild(get);

}
