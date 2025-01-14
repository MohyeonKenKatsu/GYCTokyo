<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.List, java.util.Map, BeansCalendar.CalendarDAO, BeansCalendar.CalendarDTO" %>
<%
	CalendarDAO dao = new CalendarDAO();
	Integer userId = (Integer) session.getAttribute("USER_ID");
	if (userId == null) {
	    response.sendRedirect(request.getContextPath() + "/Views/Pages/Login/Login.jsp");
	    return;
	}
	
	// `getUserEvents` 메서드가 `List<CalendarDTO>` 반환
	List<CalendarDTO> userEvents = dao.getUserEvents(userId);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FullCalendar Integration</title>
    <!-- FullCalendar CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/Calendar.css">
</head>
<body>
    <div id="calendarContainer">
        <div class="calendarHeader">
            <h1>캘린더</h1>
            <button class="openModalButton" onclick="location.href='<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarModal.jsp';">
   				 일정 추가
			</button>

        </div>
        <div id="calendar"></div>
    </div>

    <!-- FullCalendar JS -->
    <%
    // 디버깅 로그
    for (CalendarDTO event : userEvents) {
        out.println("<script>console.log('Event: " + event.getPlan() + ", " + event.getCalendar_date() + "');</script>");
    }
%>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

     // JSP에서 JavaScript 배열 생성
        const userEvents = [
            <% for (CalendarDTO event : userEvents) { %>
            {
                id: '<%= event.getCalendar_id() %>',
                title: '<%= event.getPlan() %>',
                start: '<%= event.getCalendar_date() %>',
                allDay: true,
                category: '<%= event.getCategory() %>',
                memo: '<%= event.getMemo() %>',
                backgroundColor: '<%= event.getCategory().equals("1") ? "#3688D8" : event.getCategory().equals("2") ? "#FF8FAB" : "#CCC" %>' // 배경색 지정
            },
            <% } %>
        ];
        console.log("User Events:", userEvents);
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko', // 한국어 지원
            events: userEvents, // FullCalendar에 이벤트 추가
        });

        calendar.render();
    });
</script>

</body>
</html>
