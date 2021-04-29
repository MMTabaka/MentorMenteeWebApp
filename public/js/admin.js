/** Wrapper around Fetch to make requests */
async function requester(url, method="get", data) {
    return await fetch(url, {
        method: method,
        body: method === "post" ? getFormData(data) : undefined,
    });

}
/** Transforms JS object into FormData */
function getFormData(object) {
    const formData = new FormData();
    Object.keys(object).forEach(key => formData.append(key, object[key]));
    return formData;
}

const suspendBtns = document.querySelectorAll(".suspend-btn");
const resetBtns = document.querySelectorAll(".reset-btn");

suspendBtns.forEach(button => button.addEventListener("click", async (event) => {
    // What are we going to do?
    const operation = event.target.innerText.toLowerCase();
    if(window.confirm(`Do you want to ${operation} this user?`)){
        const res = await requester("/admin/suspend", "post", {id: event.target.getAttribute("data-id")});
        if(res.ok){
            event.target.innerText = operation === "suspend" ? "Unsuspend" : "Suspend";
        }
        else {
            window.alert(`Error: could not ${operation} user. Try again.`);
        }
    }
}));
resetBtns.forEach(button => button.addEventListener("click", async (event) => {
    if(window.confirm("Do you want to reset password for this user?")){
        const res = await requester("/admin/reset", "post", {id: event.target.getAttribute("data-id")});
        if(res.ok){
            window.alert("Operation Successful");
        }
        else {
            window.alert("Error: Could not reset password. Try again.");
        }
    }
}));