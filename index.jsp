<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WATCH YOUR FILM</title>

<link rel="stylesheet" href="index.css" />
<link rel="stylesheet" href="mainbg.css" />

<script>
    function goToSignUp() {
        window.location.href = "signup.jsp";
    }
</script>


</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

<div id="content1">
      <div class="content1">
        <div id="main_text">
          <h1>WATCH YOUR FILM</h1>
        </div>
        <div id="line"></div>
        <div id="sub_text">
          <p>helps you conveniently manage<br>your movie viewing.</p>
        </div>
        <div id="btn">
          <button id="start" onclick="goToSignUp()">NOW JOIN</button>
        </div>
        
      </div>
    </div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
</html>