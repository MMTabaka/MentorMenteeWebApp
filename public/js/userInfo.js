/** Adds class .hidden to elements with class specified in hide
 * and removes that class from elements specified in show
 * */
function change(hide, show){
  for(let element of document.getElementsByClassName(hide)) {
    element.classList.add("hidden")
  }
  for(let element of document.getElementsByClassName(show)) {
    element.classList.remove("hidden");
  }
}


function editU(){
  change("text", "edit");
  document.getElementById("editNDelete").classList.add("hidden");
  document.getElementById("saveNCancel").classList.remove("hidden");
}

function cancelEdit(){
  change("edit", "text");
  document.getElementById("saveNCancel").classList.add("hidden");
  document.getElementById("editNDelete").classList.remove("hidden");

}
