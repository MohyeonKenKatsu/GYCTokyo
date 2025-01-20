<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="java.io.IOException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참가 처리</title>
</head>
<body>
<%
    Integer userId = (Integer) session.getAttribute("USER_ID");
    int groupId = Integer.parseInt(request.getParameter("group_id"));
    GatheringDAO gatheringDAO = new GatheringDAO();

    boolean result = gatheringDAO.JoinGathering(groupId, userId);
    if (result) {
        out.println("<script>alert('성공적으로 참가했습니다.'); location.href='ViewGatheringModal.jsp?GROUP_ID=" + groupId + "';</script>");
    } else {
        out.println("<script>alert('참가에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
</body>
</html>
