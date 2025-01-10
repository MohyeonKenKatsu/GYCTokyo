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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiary.css">
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
				<input type="date" class="DatePicker"/>
			</header>
			<!-- 우측 메뉴 -->
			<table class="RightMenu">
				<tr>
					<td>
				    	<button class="MemberListButton">그룹원</button>
					</td>
					<td>
				    	<button class="SD-Search">검색</button>
					</td>
					<td>
					    <div class="Sort">☰</div>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<button class="WriteButton">글쓰기</button>
					</td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			<!-- 공유일기 게시글 리스트 -->
			<div class="DiaryList">
				<div class="DiaryPreview">
					<h3 class="Writer">세니</h3>
					<p class="TextPreview">오늘은 GYC 친구들과 같이 마라탕을 먹으러 갔다. 서연이가 좋아하는 마라장룡 마라탕. 서연이는 이걸 왜 좋아하는 걸까? 맛있기는 한데 매일 먹을 수는 없을 것 같다...</p>
					<p class="EditGuide">일기를 조회하거나 수정하려면 클릭하세요.</p>
				</div>	
				<div class="DiaryPreview">
					<h3 class="Writer">김승희</h3>
					<p class="TextPreview">눈먼 손으로 나는 삶을 만져 보았네. 그건 가시투성이였어. 가시투성이 삶의 온몸을 만지며 나는 미소 지었지. 이토록 가시가 많으니 곧 장미꽃이 피겠구나 하고.</p>
					<p class="EditGuide">일기를 조회하거나 수정하려면 클릭하세요.</p>
				</div>
			</div>
        </main>
        
        <jsp:include page="NewSDModal.jsp" />
   		<script src="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiary.js" defer></script>
        
      </div>
</body>
</html>