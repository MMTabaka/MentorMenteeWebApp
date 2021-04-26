function change(a, b){
  var x = document.getElementsByClassName(a);
  var i;
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  var y = document.getElementsByClassName(b);
  var j;
  for (j = 0; j < y.length; j++) {
    y[j].style.display = "flex";
  }
}


function editU(){
  change("text", "edit");
  document.getElementById("editNDelete").style.display = "none";
  document.getElementById("saveNCancel").style.display = "flex";
}

function cancelEdit(){
  change("edit", "text");
  document.getElementById("editNDelete").style.display = "block";
  document.getElementById("saveNCancel").style.display = "none";
}