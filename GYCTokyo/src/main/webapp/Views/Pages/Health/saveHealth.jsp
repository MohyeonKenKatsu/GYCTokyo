<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String type = request.getParameter("type");
    String goal = request.getParameter("goal");
    String achieved = request.getParameter("achieved");

    System.out.println("Type: " + type);
    System.out.println("Goal: " + goal);
    System.out.println("Achieved: " + achieved);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (type == null || goal == null || achieved == null || type.isEmpty() || goal.isEmpty() || achieved.isEmpty()) {
        response.getWriter().write("{\"success\": false, \"message\": \"입력 데이터가 올바르지 않습니다.\"}");
    } else {
        response.getWriter().write("{\"success\": true, \"type\": \"" + type + "\", \"goal\": \"" + goal + "\", \"achieved\": \"" + achieved + "\"}");
    }
%>
