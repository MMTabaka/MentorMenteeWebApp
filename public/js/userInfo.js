function showEdit(btnId){
  document.getElementById("delete").style.display = "none";
  document.getElementById(btnId).style.display = "none";
  document.getElementById(btnId + "Edit").style.display = "flex";
  document.getElementById(btnId + "Edit").required = true;
  document.getElementById("saveNCancel").style.display = "flex";
}

function cancel(){
  document.getElementById("picture").style.display = "block";
  document.getElementById("pictureEdit").style.display = "none";
  document.getElementById("pictureEdit").style.required = false;
  document.getElementById("username").style.display = "block";
  document.getElementById("usernameEdit").style.display = "none";
  document.getElementById("usernameEdit").style.required = false;
  document.getElementById("email").style.display = "block";
  document.getElementById("emailEdit").style.display = "none";
  document.getElementById("emailEdit").style.required = false;
  document.getElementById("password").style.display = "block";
  document.getElementById("passwordEdit").style.display = "none";
  document.getElementById("passChange").style.required = false;
  document.getElementById("passConfirm").style.required = false;
  document.getElementById("department").style.display = "block";
  document.getElementById("departmentEdit").style.display = "none";
  document.getElementById("departmentEdit").style.required = false;
  document.getElementById("researchF").style.display = "block";
  document.getElementById("researchFEdit").style.display = "none";
  document.getElementById("researchFEdit").style.required = false;
  document.getElementById("personalIntro").style.display = "block";
  document.getElementById("personalIntroEdit").style.display = "none";
  document.getElementById("personalIntroEdit").style.required = false;
  document.getElementById("delete").style.display = "block";
  document.getElementById("saveNCancel").style.display = "none";
}
