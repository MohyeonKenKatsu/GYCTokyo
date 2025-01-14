<%@page import="BeansUsers.UsersDTO"%>
<%@page import="BeansUsers.UsersDAO"%>
<%@page import="Common.ComMgr"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="pragma" content="no-cache"/>
    <meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시"/>
    <meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시"/>
    <meta name="Author" content="문서의 저자를 명시"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>Sign Up</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
	<link rel="stylesheet" href="SignUp.css">
		<style type="text/css">
		/* -----------------------------------------------------------------
			HTML Page 스타일시트
		   ----------------------------------------------------------------- */
			
        /* ----------------------------------------------------------------- */
	</style>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역(상단)]
	[외부 자바스크립트 연결(각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
		// -----------------------------------------------------------------
		// [브라우저 갱신 완료 시 호출 할 이벤트 핸들러 연결 - 필수]
		// -----------------------------------------------------------------
		// window.onload = function () { DocumentInit('페이지가 모두 로드되었습니다!'); }
		// window.addEventListener('load', DocumentInit('페이지가 모두 로드되었습니다!'));
		// window.addEventListener('load', DocumentInit);
		// -----------------------------------------------------------------
		// [브라우저 갱신 완료 및 초기화 구현 함수 - 필수]
		// -----------------------------------------------------------------
		// 브라우저 갱신 완료 까지 기다리는 함수 - 필수
		// 일반적인 방식 : setTimeout(()=>alert('페이지가 모두 로드되었습니다!'), 50);
		function DocumentInit(Msg)
		{
			requestAnimationFrame(function() {
				requestAnimationFrame(function() {
					alert(Msg);
				});
			});
        }
		// -----------------------------------------------------------------
		// [사용자 함수 및 로직 구현]
		// -----------------------------------------------------------------
		
		// -----------------------------------------------------------------
	</script>
</head>
<%--------------------------------------------------------------------------
[JSP 전역 변수/함수 선언 영역 - 선언문 영역]
	- this 로 접근 가능 : 같은 페이지가 여러번 갱신 되더라도 변수/함수 유지 됨
	- 즉 현재 페이지가 여러번 갱신 되는 경우 선언문은 한번만 실행 됨
------------------------------------------------------------------------------%>
<%!
	// ---------------------------------------------------------------------
	// [JSP 전역 변수/함수 선언]
	// ---------------------------------------------------------------------
	// 회원가입 처리용 DTO 객체
	public UsersDAO usersDAO = new UsersDAO();
	// ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[JSP 지역 변수 선언 및 로직 구현 영역 - 스크립트릿 영역]
	- this 로 접근 불가 : 같은 페이지가 여러번 갱신되면 변수/함수 유지 안 됨
	- 즉 현재 페이지가 여러번 갱신 될 때마다 스크립트릿 영역이 다시 실행되어 모두 초기화 됨
------------------------------------------------------------------------------%>
<%
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 웹 페이지 get/post 파라미터]
	// ---------------------------------------------------------------------
	Boolean bJobProcess		= null;		// 파라미터 : 작업처리 - DB 접속 여부
	String  sEMAIL			= null;		// 파라미터 : 이메일
	String  sPASSWORD		= null;		// 파라미터 : 비밀번호
	String 	sNICKNAME 		= null;		// 파라미터 : 닉네임
	Integer iCOURSE 		= null;		// 파라미터 : 교육과정
	String 	sBIRTHDAY		= null;		// 파라미터 : 생일
	String	sTEL	 		= null;		// 파라미터 : 전화번호
	Boolean bSignupSuccess 	= null;		// 파라미터 : 회원가입 결과
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	UsersDTO usersDTO = null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	bJobProcess	= ComMgr.IsNull(request.getParameter("jobprocess"), false);		// 파라미터 : 작업처리 : null 확인(false : 아무동작 없음)
	sEMAIL		= ComMgr.IsNull(request.getParameter("email"), "");				// 파라미터 : 이메일
	sPASSWORD	= ComMgr.IsNull(request.getParameter("password"), "");			// 파라미터 : 이메일
	sNICKNAME	= ComMgr.IsNull(request.getParameter("nickname"), "");			// 파라미터 : 이메일
	iCOURSE		= ComMgr.IsNull(request.getParameter("course"), 0);				// 파라미터 : 이메일
	sBIRTHDAY	= ComMgr.IsNull(request.getParameter("birthday"), "");			// 파라미터 : 이메일
	sTEL		= ComMgr.IsNull(request.getParameter("tel"), "");				// 파라미터 : 이메일
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------

	// ---------------------------------------------------------------------
%>

<%--------------------------------------------------------------------------
[Beans/DTO 선언 및 속성 지정 영역]
------------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	Beans 객체 사용 선언	: id	- 임의의 이름 사용 가능(클래스 명 권장)
						: class	- Beans 클래스 명
 						: scope	- Beans 사용 기간을 request 단위로 지정 Hello.HelloDTO 
	--------------------------------------------------------------------------%>
	<jsp:useBean id="UsersDTO" class="BeansUsers.UsersDTO" scope="request"></jsp:useBean>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	--------------------------------------------------------------------------%>	
	<jsp:setProperty name="UsersDTO" property="*"/>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>

<%
	if (bJobProcess == true)
	{
		usersDTO = new UsersDTO();
		
		usersDTO.setEmail(sEMAIL);
		usersDTO.setPassword(sPASSWORD);
		usersDTO.setNickname(sNICKNAME);
		usersDTO.setBirthday(sBIRTHDAY);
		usersDTO.setTel(sTEL);
		usersDTO.setCourse(iCOURSE);
		
		if (this.usersDAO.Signup(usersDTO) == true)
		{
			bSignupSuccess = true;
		}
	}
%>

<script type="text/javascript">
	if (<%= bSignupSuccess %>)
	{
		DocumentInit("회원가입에 성공했습니다.");
		location.href="Login.jsp";
	}
</script>

<body>
	<div class="container">
		<div class="form-container">
			<h1 class="signup-title">SIGN UP</h1>
			<form action="" method="post">
				<table class="form-table">
				
					<tr>
						<td><label for="email">이메일</label></td>
						<td><input type="email" id="email" name="email" placeholder="이메일을 입력하세요." value="<%= sEMAIL %>" required></td>
						<td><button type="button" id="checkEmail" class="check-btn">중복확인</button></td>
					</tr>
					
					<tr>
						<td><label for="password">비밀번호</label></td>
						<td><input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" maxlength="12" required></td>
					</tr>
					
					<tr>
						<td><label for="confirmPassword">비밀번호 확인</label></td>
						<td><input type="password" id="confirmpassword" name="confirmpassword" placeholder="비밀번호를 한 번 더 입력하세요." maxlength="12" required></td>
					</tr>
					
					<tr>
						<td><label for="nickname">닉네임</label></td>
						<td><input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요."  maxlength="8" value="<%= sNICKNAME %>" required></td>
						<td><button type="button" id="checkNickName" class="check-btn">중복확인</button></td> 
					</tr>
					
					<tr>
						<td><label for="course">과정선택</label></td>
						<td>
							<select id="course" name="course" required>
								<option value="0">선택하세요</option>
								<option value="1">일본</option>
								<option value="2">베트남</option>
								<option value="3">헝가리</option>
								<option value="4">폴란드</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td><label for="birthday">생일</label></td>
						<td><input type="date" id="birthday" name="birthday" value="<%= sBIRTHDAY %>" min="1900-01-01"></td>
					</tr>
					
					<tr> 
						<td><label for="tel">전화번호 뒤 4자리</label></td>
						<td><input type="text" id="tel" name="tel" placeholder="전화번호 뒤 4자리를 입력하세요" maxlength="4"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						value="<%= sTEL %>" required></td>
					</tr>
				</table>
				
				<!-- DB 접속 제어 변수 -->
	    	   	<input type="hidden" id="jobprocess" name="jobprocess" value="true">
	    	   	
				<div class = button-container>
					<button type="reset" class="reset-btn" onclick="window.location.href='Login.jsp'">취소</button>
					<button type="submit" class="signup-btn">등록</button>
				</div>
				
			</form>
		</div>
	</div>
	
	<script>
		document.getElementById('birthday').value = new Date().toISOString().substring(0, 10);
	</script>
	
</body>
</html>
