<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.security.MessageDigest" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SIGN UP USER</title>

<link rel="stylesheet" href="signup_user.css" />

<script>
function redirectToLogin() {
    window.location.href = "login.jsp"; // 로그인 페이지로 이동
}
</script>

</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

    <h2 id="title">JOIN YOUR FILM</h2>

<div class="container">

<form id="signup-form">

<%
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");
    String username = request.getParameter("username");
    String phone = request.getParameter("phone");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = null;
    String errorMessage = null;

    try {
    	// JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 데이터베이스 연결
        String url = "jdbc:mysql://127.0.0.1:3306/testdb?useSSL=false";
        String dbUser = "root";
        String dbPassword = "1234";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // 비밀번호 해시 처리 (예시로 SHA-256 사용)
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedPassword = md.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashedPassword) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        String hashedPasswordStr = hexString.toString();

        // SQL 쿼리문
        String sql = "INSERT INTO users (userId, password, username, phone) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, hashedPasswordStr);
        pstmt.setString(3, username);
        pstmt.setString(4, phone);

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            message = "<h2>회원가입이 완료되었습니다!</h2> <br> 로그인을 클릭하면 <br> 로그인 페이지로 이동합니다.";
        } else {
            errorMessage = "가입 실패!";
        }
    } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "오류가 발생했습니다: " + e.getMessage();
    } finally {
        // 자원 해제
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<%
if (message != null) {
%>
    <div class="message"><%= message %></div>
    <div id="btn">
        <button type="button" id="submit" onclick="redirectToLogin()">로그인</button>
    </div>
<%
} else if (errorMessage != null) {
%>
    <div class="error-message"><%= errorMessage %></div>
    <div id="btn">
        <button type="button" id="submit" onclick="redirectToLogin()">로그인</button>
    </div>
<%
}
%>

		<!-- <div id="btn">
            <button type="submit" id="submit">로그인</button>
        </div> -->
        
	</form>
</div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>