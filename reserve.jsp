<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RESERVE</title>

<link rel="stylesheet" href="reserve.css" />

</head>
<body>

<header>
	<jsp:include page ="header.jsp"></jsp:include>
</header>

<h2>RESERVE YOUR FILM</h2>

<div id="content">
	<div class="content">
		
		<%
			// 예매 가능한 영화 목록 (예시)
			String[][] movies = {
				{"장손", "오정민", "미스터리", "12세", "장손.jpg"},
				{"딸에 대하여", "이미랑", "드라마", "12세", "딸에대하여.jpg"},
				{"수유천", "홍상수", "드라마", "15세", "수유천.jpg"},
				{"새벽의 모든", "미야케 쇼", "드라마", "전체", "새벽의모든.jpg"},
				{"로봇 드림", "파블로 베르헤르", "애니메이션", "전체", "로봇드림.jpg"},
				{"세기말의 사랑", "임선애", "드라마", "15세", "세기말의사랑.jpg"},
				{"해야 할 일", "박홍준", "드라마", "12세", "해야할일.jpg"},
				{"독립시대", "애드워드 양", "코미디", "15세", "독립시대.jpg"},
				{"너와 나", "조현철", "드라마", "15세", "너와나.jpg"},
				{"그녀에게", "이상철", "드라마", "12세", "그녀에게.jpg"},
				{"바델과 아다마", "-", "드라마", "12세", "바델과아다마.jpg"},
				{"피닉스", "크리스티안 펫졸드", "드라마", "12세", "피닉스.jpg"}
			};
		
			// 사용자 ID를 세션에서 가져오기
			String userId = (String) session.getAttribute("userId");

			// 영화 목록 출력
			for (String[] movie : movies) {
		%>
			<div class="movie-card">
				<img src="<%= request.getContextPath() + "/2PROJECT/POSTER/" + movie[4] %>" alt="<%= movie[0] %>">
				<div class="movie-title"><%= movie[0] %></div>
				<div class="sub-title">감독: <%= movie[1] %> / <%= movie[2] %> / <%= movie[3] %></div>
				
				<form method="post" action="reserve_movie.jsp">
					<input type="hidden" name="userId" value="<%= userId %>">
					<input type="hidden" name="movieTitle" value="<%= movie[0] %>">
					<input type="hidden" name="director" value="<%= movie[1] %>">
					<input type="hidden" name="genre" value="<%= movie[2] %>">
					
					<button type="submit" id="reserve">예매하기</button>
				</form>
			</div>
		<%
			}	
		%>

	</div>
</div>
		

<footer>
	<jsp:include page="footer.jsp"></jsp:include>
</footer>

</body>
</html>