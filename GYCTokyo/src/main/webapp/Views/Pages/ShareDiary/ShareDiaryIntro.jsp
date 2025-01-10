<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공유일기</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiaryIntro.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Header/Header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
</head>
<body>
	<!-- 헤더 포함 -->
	<%@ include file="/Views/Components/Header/Header.jsp" %>
	<div style="display: flex;">
	
	<!-- 사이드바 포함 -->
	<%@ include file="/Views/Components/Sider/Sider.jsp" %>

		<!-- 메인 콘텐츠 -->
		<main class="MainContent">
        
			<!-- 상단 날짜와 제목 -->
			<header>
				<h1 class="Title">공유일기</h1>
				<div class="Date">
					<% 
						// 현재 날짜를 포맷
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
						String currentDate = dateFormat.format(new Date());
						out.print(currentDate);
					%>
				</div>
			</header>
			
			<!-- 우측 메뉴 -->
			<table class="RightMenu">
				<tr>
					<td>
				    	<button class="GroupInviteButton">초대</button>
					</td>
					<td>
				    	<div class="Sort">☰</div>
					</td>
				</tr>
			</table>
		  
			<!-- 추가(+) 버튼 -->
			<div class="GroupPlusButton">+</div>
		  
			<!-- 폴더 아이콘 -->
			<div class="GroupFolders" onclick="location.href='ShareDiary.jsp'">
				<div class="GroupFolder">사내켄</div>
				<div class="GroupFolder">사내켄</div>
			</div>
		</main>
		
		<jsp:include page="NewSDGroupModal.jsp" />
   		<script src="<%= request.getContextPath() %>/Views/Pages/ShareDiary/NewSDGroupModal.js" defer></script>
		
  	</div>        
</body>
</html>