/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */

function clearFilter() {
    window.location.href = window.location.href.split('?')[0];
}
function paginationClick(key, value) {
    let uri = window.location.href;
    let re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
    let separator = uri.indexOf('?') !== -1 ? "&" : "?";
    if (uri.match(re)) {
        window.location.href = uri.replace(re, '$1' + key + "=" + value + '$2');
    } else {
        window.location.href = uri + separator + key + "=" + value;
    }
}
function change_image(image) {
    var container = document.getElementById("img-main");
    container.src = image.src;
}
function loadReview(endpoint) {
    fetch(endpoint).then(function (res) {
        return res.json();
    }).then(function (data) {
        let review = document.getElementById("review");
        let h = '';
        for (let d of data)
            h += `   
                <div style="background-color: grey; margin: 10px; padding: 2px">
                    <div class="coment-bottom bg-white p-2 px-4">
                        <div class="d-flex flex-row comment-user"><img class="rounded-circle" src="https://res.cloudinary.com/dxs9d8uua/image/upload/v1661453159/urh0kmsgkxktheudu9m3.jpg" width="40">
                            <div class="ml-2">
                                <div class="d-flex flex-row align-items-center"><span class="name font-weight-bold">${d.idAccount.username}</span>
                                    <span class="dot"></span>
                                    <span class="my-date">${moment(d.reviewDate).locale("vi").fromNow()}</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-2">
                            <p class="comment-text">${d.content}</p>
                        </div>
                    </div>
                </div>`;
        review.innerHTML = h;
    });
}

function addReview(endpoint, productId) {
    fetch(endpoint, {
        method: "post",
        body: JSON.stringify({
            "content": document.getElementById("inputReview").value,
            "idProduct": productId
        }),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        return res.json();
    }).then(function (data) {
        let d = document.querySelector("#review div:first-child");
        let h = `   
                <div style="background-color: grey; margin: 10px; padding: 2px">
                    <div class="coment-bottom bg-white p-2 px-4">
                        <div class="d-flex flex-row comment-user"><img class="rounded-circle" src="https://res.cloudinary.com/dxs9d8uua/image/upload/v1661453159/urh0kmsgkxktheudu9m3.jpg" width="40">
                            <div class="ml-2">
                                <div class="d-flex flex-row align-items-center"><span class="name font-weight-bold">${data.idAccount.username}</span>
                                    <span class="dot"></span>
                                    <span class="my-date">${moment(data.reviewDate).locale("vi").fromNow()}</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-2">
                            <p class="comment-text">${data.content}</p>
                        </div>
                    </div>
                </div>
                `;

        d.insertAdjacentHTML("beforebegin", h);
        
    });
}
