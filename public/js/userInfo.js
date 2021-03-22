function showEdit(btnId){
  document.getElementById("delete").style.display = "none";
  document.getElementById(btnId).style.display = "none";
  document.getElementById(btnId + "Edit").style.display = "flex";
  //document.getElementById(btnId + "Edit").required = true;
  document.getElementById("saveNCancel").style.display = "flex";
}

function cancelEdit(){
  document.getElementById("username").style.display = "block";
  document.getElementById("usernameEdit").style.display = "none";
  document.getElementById("email").style.display = "block";
  document.getElementById("emailEdit").style.display = "none";
  document.getElementById("password").style.display = "block";
  document.getElementById("passwordEdit").style.display = "none";
  document.getElementById("department").style.display = "block";
  document.getElementById("departmentEdit").style.display = "none";
  document.getElementById("area").style.display = "block";
  document.getElementById("areaEdit").style.display = "none";
  document.getElementById("bio").style.display = "block";
  document.getElementById("bioEdit").style.display = "none";
  document.getElementById("delete").style.display = "block";
  document.getElementById("saveNCancel").style.display = "none";
//   document.getElementById("usernameEdit").style.required = false;
//   document.getElementById("emailEdit").style.required = false;
//   document.getElementById("passChange").style.required = false;
//   document.getElementById("passConfirm").style.required = false;
//   document.getElementById("departmentEdit").style.required = false;
//   document.getElementById("areaEdit").style.required = false;
//   document.getElementById("bioEdit").style.required = false;
}
