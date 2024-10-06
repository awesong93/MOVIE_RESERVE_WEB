<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHECK RESERVE</title>

<link rel="stylesheet" href="check.css" />

</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

    <h2>CHECK YOUR FILM</h2>

<div class="container">

<%
	//사용자 ID를 세션에서 가져오기
	String userId = (String) session.getAttribute("userId");

	/* String userId = request.getParameter("userId"); */

    if (userId != null) {
        out.println("<h3 id='userid'><strong>예약자 ID</strong></h3><br>" + "<h3>" + userId + "</h3>");


        Connection conn = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 데이터베이스 연결
            String url = "jdbc:mysql://127.0.0.1:3306/testdb?useSSL=false";
            String dbUser = "root";
            String dbPassword = "1234";
            conn = DriverManager.getConnection(url, dbUser, dbPassword);

            // SQL 쿼리문
            String sql = "SELECT id, userId, movieTitle, reservationDate FROM reservations WHERE userId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            // SimpleDateFormat 객체 생성
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

            // 결과 출력
            while (rs.next()) {
                int id = rs.getInt("id");
                String movieTitle = rs.getString("movieTitle");
                Timestamp reservationDate = rs.getTimestamp("reservationDate");

                // 날짜 형식 변환
                String formattedDate = dateFormat.format(reservationDate);
%>
                <div class="reservation">
                    <h3 id="revnum"><strong>예매 번호</strong> </h3><br>
                    <h3>RESERVE NO. <%= id %></h3><br>
                    <h3 id="title"><strong>영화 제목</strong> </h3><br>
                    <h3> <%= movieTitle %> </h3><br>
                    <h3 id="date"><strong>예매 날짜</strong> </h3><br>
                    <h3><%= formattedDate %></h3>
                </div>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>오류가 발생했습니다: " + e.getMessage() + "</p>");
        } finally {
            // 자원 해제
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
%>
        
        <!-- 확인 버튼 추가 -->
        <div class="button-container">
            <form action="index.jsp" method="get">
                <button type="submit">확인</button>
            </form>
        </div>

    <% } else { %>
        <p>로그인이 필요합니다.</p>
    <% } %>


</div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>
</body>
</html>