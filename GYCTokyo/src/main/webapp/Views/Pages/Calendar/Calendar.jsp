<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.List, BeansCalendar.CalendarDAO, BeansCalendar.CalendarDTO" %>
<%
    CalendarDAO dao = new CalendarDAO();
    Integer userId = (Integer) session.getAttribute("USER_ID");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/Views/Pages/Login/Login.jsp");
        return;
    }

    // `getUserEvents` 메서드가 `List<CalendarDTO>` 반환
    List<CalendarDTO> userEvents = dao.getUserEvents(userId);
    if (userEvents == null || userEvents.isEmpty()) {
        userEvents = new ArrayList<>();
        System.out.println("userEvents is empty or null.");
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FullCalendar Integration</title>
    <!-- FullCalendar CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/Calendar.css">
</head>
<body>
    <div id="calendarContainer">
        <div class="calendarHeader">
            <h1>캘린더</h1>
            <button class="openModalButton" onclick="location.href='<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarModal.jsp';">일정 추가</button>
        </div>
        <div id="calendar"></div>
    </div>

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');
        const contextPath = "<%= request.getContextPath() %>"; // JSP에서 전달된 contextPath

        const userEvents = [
            <% for (CalendarDTO event : userEvents) { %>
            {
                id: '<%= event.getCalendar_id() %>',
                title: '<%= event.getPlan() %>',
                start: '<%= event.getCalendar_date() %>',
                allDay: true,
                category: <%= event.getCategory() %>,
                memo: '<%= event.getMemo() %>',
                backgroundColor: '<%= "1".equals(event.getCategory()) ? "#3688D8" : "2".equals(event.getCategory()) ? "#FF8FAB" : "#CCC" %>' // 배경색 지정
            },
            <% } %>
        ];

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            events: userEvents,
            eventClick: function (info) {
                const event = info.event;

                // 디버깅 로그
                console.log("Event Clicked:", event);

                // 이벤트 데이터 URL로 전달
                const modalUrl =
                    contextPath +
                    "/Views/Pages/Calendar/CalendarViewModal.jsp?plan=" +
                    encodeURIComponent(event.title) +
                    "&calendar_date=" +
                    encodeURIComponent(event.startStr) +
                    "&category=" +
                    encodeURIComponent(event.extendedProps.category || '') +
                    "&memo=" +
                    encodeURIComponent(event.extendedProps.memo || '');

                // 새 창이 아닌 모달로 열기
                const modalWindow = window.open(modalUrl, "Modal", "width=600,height=400");
                modalWindow.focus();
            },
        });

        calendar.render();
    });
    </script>
</body>
</html>
