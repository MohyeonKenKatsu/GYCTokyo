<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
<aside class="sidebar">
    <ul class="menu">
        <li>
            <a href="<%= request.getContextPath() %>/Views/Pages/Calendar/index.jsp" class="active">
                캘린더 및 투두
                <img src="<%= request.getContextPath() %>/Views/resources/images/CalendarLogo.png" alt="캘린더아이콘" class="icon">
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Views/Pages/Health/Health.jsp">
                건강기록
                <img src="<%= request.getContextPath() %>/Views/resources/images/HealthLogo.png" alt="운동아이콘" class="icon">
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Views/Pages/PrivateDiary/PrivateDiary.jsp">
                마음일기
                <img src="<%= request.getContextPath() %>/Views/resources/images/PrivateDiaryLogo.png" alt="다이어리아이콘" class="icon">
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiaryIntro.jsp">
                공유일기
                <img src="<%= request.getContextPath() %>/Views/resources/images/ShareDiaryLogo.png" alt="다이어리아이콘" class="icon">
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/Views/Pages/Group/Group.jsp">
                소모임
                <img src="<%= request.getContextPath() %>/Views/resources/images/GatheringLogo.png" alt="소모임아이콘" class="icon">
            </a>
        </li>
    </ul>
</aside>
