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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/NewSDModal.css">
</head>
<body>
	<!-- 모달 배경 -->
	<div class="Modal">
	
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="ModalHeader">
				<h2>공유일기</h2>
      		</div>
      		
        	<div class="ModalBody">
				<input type="date" class="DatePicker"/>
				<table class="ViewWriter" border="1">
					<tr>
						<td class="Writer">작성자</td>
						<td class="Nickname">세니</td>
					</tr>
				</table>
				<textarea class="InputDiary" placeholder="오늘 어떤 하루를 보내셨나요? 친구들에게 나의 하루를 공유해 볼까요?"></textarea>
        	</div>
		</div>
	</div>
</body>
</html>