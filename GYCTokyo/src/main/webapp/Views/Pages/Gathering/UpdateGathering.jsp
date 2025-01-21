<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="BeansGathering.GatheringDTO"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Gathering</title>
</head>
<body>
<%
    String groupIdParam = request.getParameter("group_id");
    String title = request.getParameter("title");
    String startDate = request.getParameter("start_date");
    String finishDate = request.getParameter("finish_date");
    String activityDate = request.getParameter("activity_date");
    String numberLimitParam = request.getParameter("number_limit");
    String content = request.getParameter("content");

    if (groupIdParam != null && title != null && startDate != null && finishDate != null &&
        activityDate != null && numberLimitParam != null && content != null) {
        try {
            int groupId = Integer.parseInt(groupIdParam);
            int numberLimit = Integer.parseInt(numberLimitParam);

            GatheringDTO gatheringDTO = new GatheringDTO();
            gatheringDTO.setTitle(title);
            gatheringDTO.setStart_date(startDate);
            gatheringDTO.setFinish_date(finishDate);
            gatheringDTO.setActivity_date(activityDate);
            gatheringDTO.setNumber_limit(numberLimit);
            gatheringDTO.setContent(content);

            GatheringDAO gatheringDAO = new GatheringDAO();
            boolean isUpdated = gatheringDAO.GatheringDetailUpdate(groupId, gatheringDTO);

            if (isUpdated) {
%>
                <script>alert('모임이 성공적으로 수정되었습니다!'); location.href='Index.jsp';</script>
<%
            } else {
%>
                <script>alert('모임 수정에 실패했습니다. 다시 시도해주세요.'); history.back();</script>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>
<%
        }
    } else {
%>
        <script>alert('모든 필드를 올바르게 입력해주세요.'); history.back();</script>
<%
    }
%>
</body>
</html>
