
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
    if (listEl[g].id == idActiv) {
      listEl[g].className = "leftEntry leftEntryActiv"
    }
    else {
      listEl[g].className = "leftEntry"
    }
  }

}

function subMenu(subEl){

  var oReq = new XMLHttpRequest();
//  oReq.onload = mainContent;
  oReq.open("get", "api?type="+subEl.id, true);
  oReq.send();

}


function mainContent () {

  var jsonContent = JSON.parse(this.response);
  var jsonType = jsonContent['type'];
  var jsonData = jsonContent['data'];
  var jsonDataLength = Object.keys(jsonData).length;

  switch (jsonType) {
   case "users_manage":
    tplUsersManage(jsonDataLength, jsonData)
   break;
  }

}

function tplUsersManage (length, data){
  var mainFrame = document.getElementById('mainFrame');

mainFrame.textContent = "#{escape_javascript render(<%= render :layout => 'test', :partial => 'rr' %>)}";
  console.log(length)
  console.log(data)
}

