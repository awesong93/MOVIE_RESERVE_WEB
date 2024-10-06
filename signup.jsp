<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SIGNUP</title>

<link rel="stylesheet" href="signup.css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="script.js"></script>

</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

    <h2>JOIN YOUR FILM</h2>

<div class="container">
    
    <form action="signup_user.jsp" method="post" id="signup-form">
    	<div class="form-group">
            <label for="username">아이디 : </label>
            <input type="text" id="userId" name="userId" required>
            <span class="error-message" id="userId-error"></span>
        </div>
        <div class="form-group">
            <label for="password">비밀번호 : </label>
            <input type="password" id="password" name="password" required>
            <span class="error-message" id="password-error"></span>
        </div>
        <div class="form-group">
            <label for="username">이름 : </label>
            <input type="text" id="username" name="username" required>
            <span class="error-message" id="username-error"></span>
        </div>
        <div class="form-group">
            <label for="phone">연락처 : </label>
            <input type="text" id="phone" name="phone" required>
            <span class="error-message" id="phone-error"></span>
        </div>
        
        <div id="btn">
            <button type="submit" id="submit">가입하기</button>
        </div>
    </form>


</div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
</html>