<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="BeansGathering.GatheringDTO"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 수정</title>
    <link rel="stylesheet" href="EditGathering.css">
</head>
<body>
<%
    // 세션에서 사용자 ID 가져오기
    Integer userId = (Integer) session.getAttribute("USER_ID");

    // 전달받은 groupId를 파라미터에서 가져옵니다.
    String groupIdParam = request.getParameter("GROUP_ID");
    GatheringDTO gathering = null;

    if (groupIdParam != null) {
        try {
            int groupId = Integer.parseInt(groupIdParam); // groupId를 정수로 변환
            GatheringDAO gatheringDAO = new GatheringDAO();
            gathering = gatheringDAO.ReadGatheringById(groupId); // groupId로 모임 정보 조회
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 날짜 형식 변환기 생성
    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // DB 날짜 형식
    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd"); // HTML5 형식

    String startDate = "";
    String finishDate = "";
    String activityDate = "";

    try {
        if (gathering != null) {
            startDate = outputFormat.format(inputFormat.parse(gathering.getStart_date()));
            finishDate = outputFormat.format(inputFormat.parse(gathering.getFinish_date()));
            activityDate = outputFormat.format(inputFormat.parse(gathering.getActivity_date()));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<div class="modal-content">
    <% if (gathering != null) { %>
        <h2>모임 수정</h2>
        <form action="UpdateGathering.jsp" method="post">
            <input type="hidden" name="group_id" value="<%= gathering.getGroup_id() %>">

            <div class="form-group">
                <label for="title">모임 제목:</label>
                <input type="text" id="title" name="title" value="<%= gathering.getTitle() %>" required>
            </div>
            <div class="form-group">
                <label for="start_date">시작 날짜:</label>
                <input type="date" id="start_date" name="start_date" value="<%= startDate %>" required>
            </div>
            <div class="form-group">
                <label for="finish_date">종료 날짜:</label>
                <input type="date" id="finish_date" name="finish_date" value="<%= finishDate %>" required>
            </div>
            <div class="form-group">
                <label for="activity_date">활동 날짜:</label>
                <input type="date" id="activity_date" name="activity_date" value="<%= activityDate %>" required>
            </div>
            <div class="form-group">
                <label for="number_limit">모집 인원:</label>
                <input type="number" id="number_limit" name="number_limit" value="<%= gathering.getNumber_limit() %>" required>
            </div>
            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" required><%= gathering.getContent() %></textarea>
            </div>

            <div class="button-group">
                <button type="submit" class="edit-btn">수정</button>
                <button type="button" class="reset-btn" onclick="location.href='Index.jsp';">취소</button>
            </div>
        </form>
    <% } else { %>
        <p>모임 정보를 불러올 수 없습니다.</p>
    <% } %>
</div>
</body>
</html>
