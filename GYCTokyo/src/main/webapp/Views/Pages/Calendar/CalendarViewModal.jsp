<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
    // URL 파라미터에서 데이터 읽기
    String plan = URLDecoder.decode(request.getParameter("plan"), "UTF-8");
    String calendarDate = request.getParameter("calendar_date");
    String category = URLDecoder.decode(request.getParameter("category"), "UTF-8");
    String memo = URLDecoder.decode(request.getParameter("memo"), "UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>일정 상세 보기</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarViewModal.css">
</head>
<body>
    <div id="modal" class="modal">
        <div class="modalContent">
            <div class="modalHeader">
                <h2>일정 상세 보기</h2>
            </div>
            <div class="modalBody">
                <form id="modalForm">
                    <label for="plan">일정 제목</label>
                    <input type="text" id="plan" name="plan" value="<%= plan %>" readonly />

                    <label for="calendar_date">날짜</label>
                    <input type="date" id="calendar_date" name="calendar_date" value="<%= calendarDate %>" readonly />

                    <label for="category">카테고리</label>
					<select id="category" name="category" disabled>
					    <option value="1" <%= "1".equals(category) ? "selected" : "" %>>GYC 일정</option>
					    <option value="2" <%= "2".equals(category) ? "selected" : "" %>>개인 일정</option>
					</select>

                    <label for="memo">메모</label>
                    <textarea id="memo" name="memo" readonly><%= memo %></textarea>

                   <!-- Hidden Inputs -->
				    <input type="hidden" id="calendarId" value="<%= request.getParameter("calendar_id") %>">
				    <input type="hidden" id="userId" value="<%= session.getAttribute("USER_ID") %>">
				    
				    
				
				    <div class="modalFooter">
				        <button type="button" id="deleteModal" class="modalButtonDelete">삭제</button>
				    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="<%= request.getContextPath() %>/Views/Pages/Calendar/Calendar.js"></script>
    <script> const contextPath = "<%= request.getContextPath() %>"; // 서버 컨텍스트 경로 </script>
</body>
</html>
    
</body>
</html>
