<%@page import="BeansGathering.GatheringDTO"%>
<%@page import="java.util.List"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소모임</title>
    <link rel="stylesheet" href="Gathering.css">
    
</head>
<body>

    <div class="main-container">
        <div class="main-content">
            <header>
                <h1 class="title">소모임</h1>
                <p class="date">2024.12.09</p>
            </header>

            <section class="event-header">
                <h2>함께 만드는 특별한 순간들</h2>
            </section>

            <div class="create-event">
                <button class="create-btn" onclick="location.href='NewGatheringModal.jsp'">모임 만들기</button>
            </div>
            
		   <div class="event-cards">
		    <%-- GatheringDAO를 이용해 DB에서 데이터를 읽어옵니다. --%>
		    <%
		        GatheringDAO gatheringDAO = new GatheringDAO();
		        List<GatheringDTO> gatheringList = gatheringDAO.getAllGatherings(); // DB에서 모임 리스트 가져오기
		        for (GatheringDTO gathering : gatheringList) {
		    %>
		        <div class="event-card" onclick="location.href='ViewGatheringModal.jsp?GROUP_ID=<%= gathering.getGroup_id() %>'">
		            <h3><%= gathering.getTitle() %></h3> <!-- 제목 -->
		            <p>활동 날짜: <%= gathering.getActivity_date() %></p> <!-- 활동 날짜 -->
		            <p>내용: <%= gathering.getContent() %></p> <!-- 내용 -->
		        </div>
		    <% } %>
</div>

            <div class="footer">
                <button class="footer-btn" onclick="location.href='FinishedGathering.jsp'">끝난 모임 보기</button>
            </div>
        </div>
    </div>

</body>
</html>