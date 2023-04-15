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
                        <div class="d-flex flex-row comment-user"><img class="rounded-circle" src="${d.idAccount.customer.avatar}" height="50" width="45">
                            <div class="ml-2">
                                <div class="d-flex flex-row align-items-center"><span class="name font-weight-bold">${d.idAccount.username}</span>
                                    <span class="dot"></span>
                                    <span class="my-date">${moment(d.reviewDate).locale("vi").fromNow()}</span>
                                    
                                </div>
                                <span>${d.rating} <label style="color: yellow; font-size: 20px">&#9733;</label></span>
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
    var rates = document.getElementsByName("rating");
    var rate = 5;
    for (var i = 0; i < rates.length; i++) {
        if (rates[i].checked) {
            rate = i + 1;
        }
    }
    ;
    fetch(endpoint, {
        method: "post",
        body: JSON.stringify({
            "content": document.getElementById("inputReview").value,
            "idProduct": productId,
            "rating": rate
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
                        <div class="d-flex flex-row comment-user"><img class="rounded-circle" src="${data.idAccount.customer.avatar}" width="40">
                            <div class="ml-2">
                                <div class="d-flex flex-row align-items-center"><span class="name font-weight-bold">${data.idAccount.username}</span>
                                    <span class="dot"></span>
                                    <span class="my-date">${moment(data.reviewDate).locale("vi").fromNow()}</span>
                                </div>
                                <span>${data.rating}</span>
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
function loadShipAddress(endpoint) {
    fetch(endpoint).then(function (res) {
        return res.json();
    }).then(function (data) {
        let ship = document.getElementById("ship");
        let h = '';
        let priority = '';
        for (let d of data){
        priority = `${d.priority}`;
        if(priority === '1'){
            priority = `<b>[Mặc định] </b>`;
        }
        else {
            priority ='';
        }
        h += 
            `   
                        <div class="bg-light p-2 mt-4 border border-dark">
                            <div class="row">
                                <div class="col-md-9">
                                    <b>${d.name}</b> <span> | </span><label> ${d.phone}</label> 
                                    <p class="capitalizeText">${d.address}</p> 
                                    <p><span class="capitalizeText">${d.ward}</span><span class="capitalizeText">, ${d.district}</span><span>, ${d.city.name} </span>
                                    <br>  ${priority} 
                                </div>
                                <div class="col-md-3 center">
                                    <br>
                                    
                                    <a title="Sửa" href="/WebEcommerce/customer/ship-address-edit?id=${d.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-regular fa-pen-to-square p-1"></i></a>
                                    <a title="Xóa" href="/WebEcommerce/customer/ship-address-delete?id=${d.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-solid fa-trash-can p-1"></i></a>
                                    <a title="Đặt làm địa chỉ mặc định" href="/WebEcommerce/customer/ship-address-setdefault?id=${d.id}" data-toggle="tooltip"><i style="font-size: 22px" class="fa-regular fa-circle-check"></i></a>
                                </div>
                            </div>
                        </div>`;
        ship.innerHTML = h;
        }});
}
