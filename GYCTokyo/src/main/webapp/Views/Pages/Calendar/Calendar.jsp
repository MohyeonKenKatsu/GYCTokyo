<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>FullCalendar Integration</title>
    <!-- FullCalendar CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="Views/Pages/Calendar/Calendar.css">
</head>
<body>
    <div id="calendarContainer">
        <!-- 캘린더와 일정 추가 버튼을 한 컨테이너에 배치 -->
        <div class="calendarHeader">
            <h1>캘린더</h1>
            <button class="openModalButton">일정 추가</button>
        </div>
        <div id="calendar"></div>
    </div>

    <!-- Include CalendarModal.jsp -->
    <jsp:include page="CalendarModal.jsp" />

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
    <!-- Custom JS -->
    <script src="<%= request.getContextPath() %>/Views/Pages/Calendar/Calendar.js" defer></script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko', // 한국어 지원
                events: [
                    {
                        title: '회의',
                        start: '2024-12-16',
                    },
                    {
                        title: '생일 파티',
                        start: '2024-12-20',
                    },
                ],
            });
            calendar.render();
        });
    </script>
</body>
</html>
