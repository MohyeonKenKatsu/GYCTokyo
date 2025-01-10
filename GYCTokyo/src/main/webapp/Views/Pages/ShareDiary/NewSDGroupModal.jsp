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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/NewSDGroupModal.css">
</head>
<body>
	<!-- 모달 배경 -->
	<div class="Modal" id="modal">
	
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="ModalHeader">
				<h2 class="Header">새 그룹 생성</h2>
      		</div>
      		
        	<div class="ModalBody">
        		<table class="GroupNameTool">
        			<tr>
        				<td>
        					<label class="GroupName" for="InputGroupName">그룹명</label>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<textarea class="InputGroupName" maxlength="15" placeholder="최대 글자수 15자(공백 포함)"></textarea>
        				</td>
        			</tr>
        		</table>
        	</div>
        	
			<div class="ModalTail">
				<button class="NewGroupCancel">취소</button>
				<button class="NewGroupButton">생성</button>
			</div>
        
		</div>
	</div>
</body>
</html>