<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>캘린더 및 투두 리스트</title>
     <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/index.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Header/Header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/Calendar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/TodoList.css">
</head>
<body>
    <!-- 헤더 포함 -->
    <%@ include file="/Views/Components/Header/Header.jsp" %>

    <div style="display: flex;">
        <!-- 사이드바 포함 -->
        <%@ include file="/Views/Components/Sider/Sider.jsp" %>

        <!-- 메인 콘텐츠 -->
        <main style="flex: 1; padding: 50px;">
            <!-- 캘린더 -->
            <%@ include file="/Views/Pages/Calendar/Calendar.jsp" %>

            <!-- To-Do 리스트 -->
            <%-- <%@ include file="/Views/Pages/Calendar/TodoList.jsp" %> --%>
        </main>
    </div>
</body>
</html>