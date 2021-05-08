const passwordField = document.querySelector("input.val-psw");
const repeatPasswordField = document.querySelector("input.val-re-psw");
const form = document.querySelector("form.needs-validation");

repeatPasswordField?.addEventListener("input", event => {
    if(form.classList.contains("was-validated")) {
        repeatPasswordField.setCustomValidity(event.target.value !== passwordField.value ?
            "Passwords do not match" : "");
        repeatPasswordField.checkValidity();
    }
})
form.addEventListener("submit", event => {
    console.log("Validating...");
    repeatPasswordField?.setCustomValidity(repeatPasswordField.value !== passwordField.value ?
        "Passwords do not match" : "");
    if (!form.checkValidity() || (repeatPasswordField ? !repeatPasswordField?.checkValidity() : false)) {
        console.log("Validation failed.");
        event.preventDefault()
        event.stopPropagation()
    }
    form.classList.add('was-validated')
}, false)