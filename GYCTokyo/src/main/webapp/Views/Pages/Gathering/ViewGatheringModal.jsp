<%@page import="BeansGathering.CommentDTO"%>
<%@page import="java.util.List"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="BeansGathering.GatheringDTO"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
%>
        <% 
        GatheringDAO gatheringDAO = new GatheringDAO(); // GatheringDAO 객체 생성
        boolean isCreator = userId.equals(gathering.getUser_id()); // 현재 사용자가 모임의 생성자인지 확인
        List<String> participants = gatheringDAO.GetParticipants(gathering.getGroup_id());
        %>
        <div class="modal-content">
            <% if (gathering != null) { %>
                <h2><%= gathering.getTitle() %></h2>
                <div class="form-group">
                    <p><strong>모집장</strong>: <%= gathering.getNickname() %></p>
                    <p><strong>모집시작날짜</strong>: <%= gathering.getStart_date() %></p>
                    <p><strong>모집종료날짜</strong>: <%= gathering.getFinish_date() %></p>
                    <p><strong>활동일</strong>: <%= gathering.getActivity_date() %></p>
                </div>
                <!-- 상세내용 섹션 -->
                <hr class="section-line">
					<div class="event-card" onclick="location.href='ViewGatheringModal.jsp?GROUP_ID=<%= gathering.getGroup_id() %>'">
					    <p>내용: <%= gathering.getContent() %></p>
					</div>
                <hr class="section-line">
            <% } else { %>
                <p>모임 정보를 불러올 수 없습니다.</p>
            <% } %>
					<div class="participant-info">
					    <strong>참여자 목록 (<%= participants.size() %>/<%= gathering.getNumber_limit() %>)</strong>
					    <ul class="participant-list">
					        <% if (participants != null && !participants.isEmpty()) { %>
					            <% for (String nickname : participants) { %>
					                <li><%= nickname %></li>
					            <% } %>
					        <% } else { %>
					            <li>참여자가 없습니다.</li>
					        <% } %>
					    </ul>
					</div>
         	
         	
						<div class="comment-section">
						    <h3>댓글</h3>
						    
						    <div class="comment-input-container">
							    <form action="CommentHandler.jsp" method="post">
							        <input type="hidden" name="group_id" value="<%= gathering.getGroup_id() %>">
							        <input type="hidden" name="user_id" value="<%= userId %>">
							        <input type="hidden" name="action" value="insert">
							        <input type="text" name="content" placeholder="댓글을 입력하세요" required>
							        <button type="submit">등록</button>
							    </form>
							</div>
							<%
							    // 시간 포맷 설정
							    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
							%>
								<ul class="comment-list">
								    <% 
								    List<CommentDTO> comments = gatheringDAO.getComments(gathering.getGroup_id());
								    if (comments != null && !comments.isEmpty()) {
								        for (CommentDTO comment : comments) {
								    %>
								        <li class="comment-item">
								            <strong class="username"><%= comment.getNickname() %></strong>
								            <span class="comment-text"><%= comment.getContent() %></span>
								            <span class="time">
								                <% 
								                // Timestamp를 Date로 변환하고 포맷팅
								                if (comment.getCreatedAt() != null) {
								                    out.print(sdf.format(comment.getCreatedAt()));
								                } else {
								                    out.print("시간 정보 없음");
								                }
								                %>
								            </span>
								
								            <% if (comment.getUserId() == userId) { %>
<%-- 								                <form action="CommentHandler.jsp" method="post" style="display:inline;">
								                    <input type="hidden" name="action" value="delete">
								                    <input type="hidden" name="comment_id" value="<%= comment.getCommentId() %>">
								                    <button type="submit" class="delete-btn">삭제</button>
								                </form> --%>
								            <% } %>
								        </li>
								    <% 
								        }
								    } else {
								    %>
								        <li>등록된 댓글이 없습니다.</li>
								    <% } %>
								</ul>					
						</div>
				    <% 
				        boolean isJoined = gatheringDAO.IsUserJoined(gathering.getGroup_id(), userId); 
				    %>
				
			
				   <div class="button-group">
					    <!-- 항상 표시되는 취소 버튼 -->
					    <button class="reset-btn" onclick="location.href='Index.jsp';">취소</button>
					
					    <% if (isCreator) { %>
					        <!-- 수정 버튼 -->
					        <button class="edit-btn" onclick="location.href='EditGathering.jsp?GROUP_ID=<%= gathering.getGroup_id() %>'">수정</button>
					
					        <!-- 생성자일 경우: 삭제 버튼 표시 -->
					        <form action="Index.jsp" method="post" style="display:inline;">
					            <input type="hidden" name="jobStatus" value="DELETE">
					            <input type="hidden" name="group_id" value="<%= gathering.getGroup_id() %>">
					            <button type="submit" class="submit-btn" onclick="return confirm('모임을 삭제하시겠습니까?');">삭제</button>
					        </form>
					    <% } else { %>
					        <% if (!isJoined) { %>
					            <!-- 참가 버튼 -->
					            <form action="JoinGathering.jsp" method="post" style="display:inline;">
					                <input type="hidden" name="group_id" value="<%= gathering.getGroup_id() %>">
					                <button type="submit" class="submit-btn" onclick="return confirm('참가하시겠습니까?');">참가</button>
					            </form>
					        <% } else { %>
					            <!-- 참가 취소 버튼 -->
					            <form action="CancelJoinGathering.jsp" method="post" style="display:inline;">
					                <input type="hidden" name="group_id" value="<%= gathering.getGroup_id() %>">
					                <button type="submit" class="submit-btn" onclick="return confirm('참가를 취소하시겠습니까?');">참가 취소</button>
					            </form>
					        <% } %>
					    <% } %>
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
    </div>
    
</body>
</html>