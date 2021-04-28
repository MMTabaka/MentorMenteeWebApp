async function requester(url, method="get", data) {
    const res = await fetch(url, {
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
