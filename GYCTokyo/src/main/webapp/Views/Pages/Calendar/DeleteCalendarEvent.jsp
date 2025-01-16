<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansCalendar.CalendarDAO" %>
<%
    response.setContentType("application/json; charset=UTF-8");
    String calendarId = request.getParameter("calendar_id");
    String userId = request.getParameter("user_id");
    boolean success = false;

    try {
        if (calendarId != null && userId != null) {
            CalendarDAO dao = new CalendarDAO();
            success = dao.deleteEvent(Integer.parseInt(calendarId), Integer.parseInt(userId));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // JSON 응답
    out.print("{\"success\": " + success + "}");
    out.flush();
%>
