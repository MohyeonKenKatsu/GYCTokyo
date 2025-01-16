<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="BeansGathering.GatheringDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 조회</title>
    <link rel="stylesheet" href="ViewGatheringModal.css">
</head>
<body>
<%
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
%>
    <div class="modal" id="modal">
        <div class="modal-content">
            <% if (gathering != null) { %>
                <h2><%= gathering.getTitle() %></h2>
                <div class="form-group">
                    <p><strong>모집시작날짜</strong>: <%= gathering.getStart_date() %></p>
                    <p><strong>모집종료날짜</strong>: <%= gathering.getFinish_date() %></p>
                    <p><strong>활동일</strong>: <%= gathering.getActivity_date() %></p>
                </div>
                <!-- 상세내용 섹션 -->
                <hr class="section-line">
					<div class="event-card" onclick="location.href='ViewGatheringModal.jsp?GROUP_ID=<%= gathering.getGroup_id() %>'">
					    <h3><%= gathering.getTitle() %></h3>
					    <p>활동 날짜: <%= gathering.getActivity_date() %></p>
					    <p>내용: <%= gathering.getContent() %></p>
					</div>
                <hr class="section-line">
            <% } else { %>
                <p>모임 정보를 불러올 수 없습니다.</p>
            <% } %>
            
            <!-- 댓글 섹션 -->
            <div class="comment-section">
                <div class="comment-header">
                    <h3>댓글</h3>
                    <div class="comment-input-container">
                        <input type="text" id="comment-input" placeholder="댓글을 입력하세요">
                        <button type="button" id="submit-comment">등록</button>
                    </div>
                </div>
                
                
                
                <!--  댓글기능 -->
<!--                 <div class="comments">
                    <div class="comment-item">
                        <strong class="username">1234</strong>
                        <span class="comment-text">근데 현금 얼마 들고가야하는데?</span>
                        <span class="time">18:50</span>
                    </div>
                    <div class="comment-item">
                        <strong class="username">아오지</strong>
                        <span class="comment-text">나도 갈래 근데 19시에 참여 가능?</span>
                        <span class="time">13:20</span>
                    </div>
                    <div class="comment-item">
                        <strong class="username">탄광</strong>
                        <span class="comment-text">갈거</span>
                        <span class="time">11:00</span>
                    </div>
                </div> -->
                
                
                
            </div>
            <div class="button-group">
                <button class="reset-btn" onclick="location.href='Index.jsp'">취소</button>
                <button class="submit-btn">참가</button>
            </div>
        </div>
    </div>
</body>
</html>