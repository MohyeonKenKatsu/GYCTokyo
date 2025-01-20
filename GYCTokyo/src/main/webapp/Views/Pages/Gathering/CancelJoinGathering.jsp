<%@page import="BeansGathering.GatheringDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참가 삭제</title>
</head>
<body>
<%
    Integer userId = (Integer) session.getAttribute("USER_ID");
    String groupIdParam = request.getParameter("group_id"); // 정확한 파라미터 이름 사용

    if (groupIdParam == null || groupIdParam.isEmpty()) {
        out.println("<script>alert('유효하지 않은 요청입니다.'); history.back();</script>");
        return;
    }

    int groupId = Integer.parseInt(groupIdParam); // 올바른 값이 있을 때만 변환
    GatheringDAO gatheringDAO = new GatheringDAO();

    boolean result = gatheringDAO.CancelJoinGathering(groupId, userId);

    if (result) {
        out.println("<script>alert('참가가 취소되었습니다.'); location.href='ViewGatheringModal.jsp?GROUP_ID=" + groupId + "';</script>");
    } else {
        out.println("<script>alert('참가 취소에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>

</body>
</html>