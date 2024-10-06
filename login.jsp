<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>

<link rel="stylesheet" href="login.css" />

<script>
//로그인 페이지에서 예매하기 페이지로 이동
function showAlertAndRedirect() {
 alert("로그인에 성공하였습니다.");
 window.location.href = "reserve.jsp"; 
}
</script>

</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

    <h2>LOGIN YOUR FILM</h2>
<div class="container">
    <form method="post" action="login.jsp">
        <input type="text" name="userId" placeholder="아이디" required />
        <input type="password" name="password" placeholder="비밀번호" required />
        <button type="submit" id="login-btn">로그인</button>
    </form>

    <%
    String userId = request.getParameter("userId");
    String password = request.getParameter("password");

    if (userId != null && password != null) {
        Connection conn = null;
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
            String sql = "SELECT * FROM users WHERE userId = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, hashedPasswordStr);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	
            	/* // 숨은 입력 필드로 사용자 아이디 전송
                out.println("<form id='redirectForm' method='post' action='reserve.jsp'>");
                out.println("<input type='hidden' name='userId' value='" + userId + "' />"); */
                
                session.setAttribute("userId", userId);
                
                out.println("</form>");
                
            	out.println("<script>showAlertAndRedirect();</script>");
                // 여기에서 로그인 후 수행할 작업을 추가할 수 있습니다.
            } else {
                out.println("<div class='error-message'>아이디 또는 비밀번호가 잘못되었습니다.</div>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='error-message'>오류가 발생했습니다: " + e.getMessage() + "</div>");
        } finally {
            // 자원 해제
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    %>
</div>

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
</html>