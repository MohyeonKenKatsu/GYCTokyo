<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansCalendar.CalendarDAO, BeansCalendar.CalendarDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>일정 추가</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarModal.css">
</head>
<body>
<%
		//DAO와 DTO 초기화
		CalendarDAO dao = new CalendarDAO();
		CalendarDTO dto = new CalendarDTO();
		
		// 세션에서 사용자 ID 가져오기
		Integer userId = (Integer) session.getAttribute("USER_ID");
		if (userId == null) {
		    out.println("<script>console.log('USER_ID not found. Redirecting to Login page.');</script>");
		    response.sendRedirect(request.getContextPath() + "/Views/Pages/Login/Login.jsp");
		    return;
		}
		String userIdStr = userId.toString();
		out.println("<script>console.log('USER_ID in session: " + userIdStr + "');</script>");
		
		// 폼 파라미터 처리
		String calendarId = request.getParameter("calendar_id");
		String plan = request.getParameter("plan");
		String calendarDate = request.getParameter("calendar_date");
		String category = request.getParameter("category");
		String memo = request.getParameter("memo");
		boolean isSubmitted = request.getParameter("submit") != null;
		
		String message = "";
		
		// 폼 제출 처리
		if (isSubmitted) {
		    try {
		        // DTO에 값 설정
		        dto.setJobstatus("INSERT");
		        dto.setCalendar_id(calendarId != null && !calendarId.isEmpty() ? Integer.parseInt(calendarId) : null);
		        dto.setUser_id(userId);
		        dto.setPlan(plan);
		        dto.setCalendar_date(calendarDate);
		        dto.setCategory(category);
		        dto.setMemo(memo);
		
		        // DAO를 통해 일정 추가
		        boolean result = dao.addEvent(dto);
		
		        if (result) {
		            // 저장 성공 시 index.jsp로 리다이렉트
		            response.sendRedirect(request.getContextPath() + "/Views/Pages/Calendar/index.jsp");
		            return;
		        } else {
		            message = "일정 저장에 실패했습니다.";
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		        message = "오류가 발생했습니다. 관리자에게 문의하세요.";
		    }
		}
%>

<div id="modal" class="modal">
    <div class="modalContent">
        <div class="modalHeader">
            <h2>일정 추가</h2>
        </div>
        <div class="modalBody">
            <!-- 결과 메시지 표시 -->
            <% if (!message.isEmpty()) { %>
                <div class="message"><%= message %></div>
            <% } %>
            <!-- 일정 추가 폼 -->
            <form id="modalForm" action="<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarModal.jsp" method="post">
                <label for="plan">일정 제목</label>
                <input type="text" id="plan" name="plan" placeholder="일정 제목을 입력하세요" value="<%= plan != null ? plan : "" %>" required />

                <label for="calendar_date">날짜</label>
                <input type="date" id="calendar_date" name="calendar_date" value="<%= calendarDate != null ? calendarDate : "" %>" required />

                <label for="category">카테고리</label>
                <select id="category" name="category">
                    <option value="GYC" <%= "GYC".equals(category) ? "selected" : "" %>>GYC 일정</option>
                    <option value="기타" <%= "기타".equals(category) ? "selected" : "" %>>개인 일정</option>
                </select>

                <label for="memo">메모</label>
                <textarea id="memo" name="memo" placeholder="메모를 입력하세요"><%= memo != null ? memo : "" %></textarea>

                <!-- 숨겨진 필드: userId와 calendarId -->
                <input type="hidden" name="submit" value="true">
                <input type="hidden" name="user_id" value="<%= userId %>" />
                <input type="hidden" name="calendar_id" value="<%= calendarId != null ? calendarId : "" %>" />

                <div class="modalFooter">
                   <button type="button" class="calendarModalButtonCancel">취소</button>
                    <button type="submit" class="modalButtonSave">저장</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>