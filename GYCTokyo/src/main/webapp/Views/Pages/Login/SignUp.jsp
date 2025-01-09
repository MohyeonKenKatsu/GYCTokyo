<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Sign Up</title>
	<link rel="stylesheet" href="SignUp.css">
</head>
<body>
	<div class="container">
		<div class="form-container">
			<h1 class="signup-title">SIGN UP</h1>
			<form action="Login.jsp" method="post">
				<table class="form-table" >
				
					<tr>
						<td><label for="email">이메일</label></td>
						<td><input type="email" id="email" name="email" placeholder="이메일을 입력하세요." required="required"></td>
						<td><button type="button" id="checkEmail" class="check-btn">중복확인</button></td>
					</tr>
					
					<tr>
						<td><label for="password">비밀번호</label></td>
						<td><input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" maxlength="12" required></td>
					</tr>
					
					<tr>
						<td><label for="confirmPassword">비밀번호 확인</label></td>
						<td><input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 한 번 더 입력하세요." required="required"></td>
					</tr>
					
					<tr>
						<td><label for="nickname">닉네임</label></td>
						<td><input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요." required="required"></td>
						<td><button type="button" id="checkNickName" class="check-btn">중복확인</button></td> 
					</tr>
					
					<tr>
						<td><label for="course">과정선택</label></td>
						<td>
							<select id="course" name="course" required>
								<option value="">선택하세요</option>
								<option value="Japan">일본</option>
								<option value="Vietnam">베트남</option>
								<option value="Hungary">헝가리</option>
								<option value="Poland">폴란드</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td><label for="birthday">생일</label></td>
						<td><input type="date" id="birthday" name="birthday" required></td>
					</tr>
					
					<tr>
						<td><label for="tel">전화번호 뒤 4자리</label></td>
						<td><input type="text" id="tel" name="tel" placeholder="비밀번호를 입력하세요" maxlength="4" required></td>
					</tr>
				</table>
				
				<div class = button-container>
					<button type="reset" class="reset-btn" onclick="window.location.href='Login.jsp'">취소</button>
					<button type="submit" class="signup-btn">등록</button>
				</div>
				
			</form>
		</div>
	</div>
</body>
<script>
	document.getElementById('birthday').value = new Date().toISOString().substring(0, 10);
</script>
</html>
