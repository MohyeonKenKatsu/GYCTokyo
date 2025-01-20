<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="BeansGathering.GatheringDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>끝난 모임 보기</title>
    <link rel="stylesheet" href="FinishedGathering.css">
</head>
<body>
    <!-- 헤더 -->
    <%@ include file="/Views/Components/Header/Header.jsp" %>

    <div class="container">
        <!-- 사이드바 -->
        <%@ include file="/Views/Components/Sider/Sider.jsp" %>

        <!-- 메인 콘텐츠 -->
        <main class="main-container">
            <header>
                <h2 class="title">끝난 모임</h2>
            </header>
            <div class="event-cards">
                <%
                    GatheringDAO gatheringDAO = new GatheringDAO();
                    List<GatheringDTO> finishedGatherings = gatheringDAO.getFinishedGatherings();

                    for (GatheringDTO gathering : finishedGatherings) {
                %>
                    <div class="event-card">
                        <h3><%= gathering.getTitle() %></h3>
                        <p>모집장: <%= gathering.getUser_id() %></p>
                        <p>모집 종료 날짜: <%= gathering.getFinish_date() %></p>
                        <p>활동일: <%= gathering.getActivity_date() %></p>
                        <p>내용: <%= gathering.getContent() %></p>
                    </div>
                <%
                    }
                %>
            </div>
        </main>
    </div>
</body>
</html>
