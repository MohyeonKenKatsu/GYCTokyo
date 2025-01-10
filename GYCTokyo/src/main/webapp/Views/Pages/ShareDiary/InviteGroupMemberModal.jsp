<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공유일기 작성 모달창</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/InviteGroupMemberModal.css">
</head>
<body>
	<!-- 모달 배경 -->
	<div class="InviteGroupModal" id="inviteGroupModal">
	
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="InviteGMModalHeader">
				<h2 class="Header">그룹원 초대</h2>
      		</div>
      		
        	<div class="InviteGMModalBody">
        		<table class="GroupNameTool">
					<tr>
        				<td>
        					<label class="GroupChoiceText" for="GroupPicker">그룹 선택</label>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<select class="GroupPicker" id="groupPicker" name="GroupPicker">
        						<option value="default" disabled selected>초대할 그룹을 선택하세요.</option>
        						<option value="option1">사랑비 내리는 켄카츠</option>
        						<option value="option2">당고링고</option>
        						<option value="option3">칵코모에</option>
        					</select>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<label class="GroupInviteEmail" for="InputEmail">초대할 이메일</label>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<textarea class="InputEmail" maxlength="15" placeholder="ex: kenkatsu@gyc.com"></textarea>
        				</td>
        			</tr>
        		</table>
        	</div>
        	
			<div class="InviteGMModalTail">
				<button class="InviteGroupCancel">취소</button>
				<button class="InviteGroupButton">초대</button>
			</div>
        
		</div>
	</div>
</body>
</html>