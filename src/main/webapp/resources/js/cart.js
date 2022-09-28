/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


function addProductIntoCart(id, name, price) {
    event.preventDefault();
    fetch("/WebEcommerce/api/cart/", {
        method: 'post',
        body: JSON.stringify({
            "productId": id,
            "productName": name,
            "price": price,
            "count": 1
        }),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        return res.json();
    }).then(function (data) {
        let counter = document.getElementById("cartCounter");
        counter.innerText = data;
    });
}

function updateCart(obj, id) {
    fetch("/WebEcommerce/api/cart/", {
        method: 'put',
        body: JSON.stringify({
            "productId": id,
            "productName": "",
            "price": 0,
            "count": obj.value
        }),
        headers: {
            "Content-Type": "application/json"
        }
    }).then(function (res) {
        return res.json();
    }).then(function (data) {
        let counter = document.getElementById("cartCounter");
        counter.innerText = data;
    });
}
function deleteItemInCart(id) {
    if (confirm("Bạn có chắc muốn xóa sản phẩm khỏi giỏ hàng") == true) {
        fetch(`/WebEcommerce/api/cart/${id}`, {
            method: 'delete'
        }).then(function (res) {
            return res.json();
        }).then(function (data) {
            let counter = document.getElementById("cartCounter");
            counter.innerText = data;
//        location.reload()
            let row = document.getElementById(`product${id}`);
            row.style.display = "none";
            location.reload();
        });
    }
}