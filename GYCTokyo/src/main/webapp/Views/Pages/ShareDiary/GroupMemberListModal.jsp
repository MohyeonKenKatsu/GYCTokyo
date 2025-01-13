<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공유일기 그룹원 조회 모달창</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/GroupMemberListModal.css">
</head>
<body>
	<!-- 모달 배경 -->
	<div class="GroupMemberListModal" id="groupMemberListModal">
	
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="GMLModalHeader">
				<h2 class="Header">그룹원 조회</h2>
      		</div>
      		
        	<div class="GMLModalBody">
				<div class="GroupMemberList">
					<%
						for(int i=0; i<10; i++)
						{
					%>
						<div class="GroupMemberCard">
							<h3 class="MemberNickname" id="memberNickname<%=i %>">세니<%=i %></h3>
							<p class="MemberEmail" id="memberEmail<%=i %>">oio3121<%=i %>@naver.com</p>
						</div>
					<%
						}
					%>
				</div>
        	</div>
        	
			<div class="GMLModalTail">
				<button class="GroupMemberListCancel">취소</button>
			</div>
			
		</div>
	</div>
</body>
</html>