<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공유일기 조회 모달창</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ChangeSDModal.css">
</head>
<body>
	<!-- 모달 배경 -->
	<div class="ChangeSDModal" id="changeSDModal">
	
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="ModalHeader">
				<h2 class="Header">공유일기</h2>
				<input type="date" class="DatePicker"/>
				<table class="ViewWriter">
					<tr>
						<td class="Writer">작성자</td>
						<td class="Nickname">세니</td>
					</tr>
				</table>
      		</div>
      		
        	<div class="ModalBody">
				<textarea class="ChangeDiary">오늘은 GYC 친구들과 같이 마라탕을 먹으러 갔다. 서연이가 좋아하는 마라장룡 마라탕. 서연이는 이걸 왜 좋아하는 걸까? 맛있기는 한데 매일 먹을 수는 없을 것 같다...</textarea>
        	</div>
        	
			<div class="ModalTail">
				<button class="ChangeDiaryCancel">취소</button>
				<button class="ChangeDiaryDelete">삭제</button>
				<button class="ChangeDiarySave">저장</button>
			</div>
        
		</div>
	</div>
	
</body>
</html>