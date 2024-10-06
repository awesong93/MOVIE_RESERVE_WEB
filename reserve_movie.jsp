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
<title>RESERVE MOVIE</title>

<link rel="stylesheet" href="reserve_movie.css" />


</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

    <h2 id="title">RESERVE YOUR FILM</h2>

<div class="container">

<form id="signup-form">

<%
    String userId = request.getParameter("userId");
    String movieTitle = request.getParameter("movieTitle");
    String director = request.getParameter("director");
    String genre = request.getParameter("genre");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // 데이터베이스 연결
        String url = "jdbc:mysql://127.0.0.1:3306/testdb?useSSL=false";
        String dbUser = "root";
        String dbPassword = "1234";
        conn = DriverManager.getConnection(url, dbUser, dbPassword);

        // SQL 쿼리문
        String sql = "INSERT INTO reservations (userId, movieTitle, director, genre) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, movieTitle);
        pstmt.setString(3, director);
        pstmt.setString(4, genre);

        int rowsAffected = pstmt.executeUpdate();
        
        if (rowsAffected > 0) {
            out.println("<h2>예매가 완료되었습니다!</h2>");
            out.println("<a href='check.jsp' class='button'>예매내역 확인</a>");
        } else {
            out.println("<h2>예매 실패했습니다.</h2>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>오류가 발생했습니다: " + e.getMessage() + "</h2>");
    } finally {
        // 자원 해제
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

        
	</form>
</div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>