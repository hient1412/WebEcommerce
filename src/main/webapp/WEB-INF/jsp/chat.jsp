<%-- 
    Document   : chat
    Created on : Jun 18, 2023, 1:51:22 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script src="https://www.gstatic.com/firebasejs/9.22.2/firebase-app.js"></script>
<input id="name" hidden="true" value="${seller}"/>
<input id="date" hidden="true" value="${createdAt}"/>
<script>
    const firebaseConfig = {
        apiKey: "AIzaSyCxfDMsYffl04ItHdKwNF1rHjnQwkd1iKA",
        authDomain: "webecommercechat.firebaseapp.com",
        databaseURL: "https://webecommercechat-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "webecommercechat",
        storageBucket: "webecommercechat.appspot.com",
        messagingSenderId: "24161843065",
        appId: "1:24161843065:web:10df0d79e5de23e953e1a8"
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    var myName = document.getElementById("name").value;
    var date = document.getElementById("date").value;
    function sendMessage() {
        var message = document.getElementById("message").value;

        firebase.database().ref("messages").push().set({
            "sender": myName,
            "message": message,
            "createdAt": date
        });

        return false;
    }
    firebase.database().ref("messages").on("child_added", function (snapshot) {
        var html = "<li id='message-" + snapshot.key + "'><h3>";
        html += snapshot.val().sender + ": " + snapshot.val().message;
        html += "<span class='text-secondary'> vào lúc:" + snapshot.val().createdAt + "</span>";
        html += "</h3></li>";
        document.getElementById("messages").innerHTML += html;
    });
</script>
<div class="py-5">
<div class="center p-4 border border-dark mt-4">
    <h1>Trò chuyện</h2>
</div>

<ul id="messages" class="mt-2"></ul>

<div class="my-4">
    <form onsubmit="return sendMessage();">
        <input id="message" placeholder="Nhập nội dung" autocomplete="off" style="width: 89%;height: 70px">
        <input type="submit" value="Gửi" style="width: 10%;height: 70px">
    </form>
</div>

</div>