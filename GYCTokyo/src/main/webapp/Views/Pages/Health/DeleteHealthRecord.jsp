<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="BeansHealth.HealthDAO" %>
<%
    response.setContentType("application/json; charset=UTF-8");
    String healthDate = request.getParameter("health_date");
    String userId = request.getParameter("user_id");
    boolean success = false;

    try {
        if (healthDate != null && userId != null) {
            HealthDAO dao = new HealthDAO();
            success = dao.deleteHealthRecord(healthDate, Integer.parseInt(userId));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    out.print("{\"success\": " + success + "}");
    out.flush();
%>
