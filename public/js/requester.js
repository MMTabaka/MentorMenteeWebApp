async function requester(url, method="get", data) {
    const res = await fetch(url, {
        method: method,
        body: method === "post" ? JSON.stringify(data) : undefined,
        headers: method === "post" ? {"Accept" : "application/json"} : {}
    })
}