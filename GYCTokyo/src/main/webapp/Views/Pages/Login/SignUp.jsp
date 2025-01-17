<%@page import="HeaderFlagMapping.HeaderFlagHash"%>
<%@page import="java.util.HashMap"%>
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
	<script type="text/javascript" src="SignUp.js"></script>
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
				
		function LengthLimit(id)
		{
			const len = document.getElementById(id).value.length;
			let shortMessage = document.getElementById("short");
	
			if (len > 0 && len < 8)
			{
				shortMessage.style.display="block";
			}
			else 
			{
				shortMessage.style.display="none";
			}
		}
		
		
		function SameCheck(id1, id2)
		{
			const val1 = document.getElementById(id1).value;
			const val2 = document.getElementById(id2).value;
			let shortMessage = document.getElementById("notsame");
	
			if (val1 == val2)
			{
				shortMessage.style.display="none";
			}
			else 
			{
				shortMessage.style.display="block";
			}
		}
		
		
		function DuplicateCheck(obj)
		{
			const inputContent = document.getElementById(obj).value;
			window.location.href='DupCheck.jsp?obj=' + obj + '&content=' + inputContent;
		}
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
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	UsersDTO usersDTO = null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	Boolean bSignupSuccess 	= null;		// 파라미터 : 회원가입 결과
	HashMap<Integer, String> courseMap = HeaderFlagHash.gethashCourse();
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
	// 회원가입 시도중일 경우
	if (bJobProcess == true)
	{
		// 입력받은 값을 DTO에 저장
		usersDTO = new UsersDTO();
		
		usersDTO.setEmail(sEMAIL);
		usersDTO.setPassword(sPASSWORD);
		usersDTO.setNickname(sNICKNAME);
		usersDTO.setBirthday(sBIRTHDAY);
		usersDTO.setTel(sTEL);
		usersDTO.setCourse(iCOURSE);
		
		// 회원가입에 성공했을 경우
		if (this.usersDAO.Signup(usersDTO) == true)
		{
			bSignupSuccess = true;
		}
		else bSignupSuccess = false;
	}
%>

<script type="text/javascript">
	// 회원가입에 성공했을 경우
	if (<%= bSignupSuccess %> == true)
	{
		DocumentInit("회원가입에 성공했습니다.");
		location.href="Login.jsp";
	}
	// 회원가입에 실패했을 경우
	if (<%= bSignupSuccess %> == false)
	{
		DocumentInit("회원가입 시도 중 오류가 발생했습니다.");
	}
</script>

<body>
	<div class="container">
		<div id="divModalParent" class="form-container">
			<h1 class="signup-title">SIGN UP</h1>
			<form action="" method="post">
				<table class="form-table">
				
					<tr>
						<td><label for="email">이메일</label></td>
						<td><input type="email" id="email" name="email" placeholder="이메일을 입력하세요." value="<%= sEMAIL %>" required></td>
						<td><button type="button" id="checkEmail" class="check-btn" onclick="DuplicateCheck('email')">중복확인</button></td>
					</tr>
					
					<tr>
						<td><label for="password">비밀번호</label></td>
						<td class="inputform"><input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" maxlength="12"
						oninput="LengthLimit('password')"
						required></td>
					</tr>
					
					<tr>
						<td></td>
						<td class="inputform"><p class="pwtext" id="short" style="display:none;">&nbsp;&nbsp;&nbsp;비밀번호의 길이는 8글자 이상 12글자 미만이어야 합니다.</p></td>
					</tr>
					
					<tr>
						<td><label for="confirmpassword">비밀번호 확인</label></td>
						<td class="inputform"><input type="password" id="confirmpassword" name="confirmpassword" placeholder="비밀번호를 한 번 더 입력하세요." maxlength="12"
						oninput="SameCheck('password', 'confirmpassword')"
						required></td>
					</tr>
					
					<tr>
						<td></td>
						<td class="inputform"><p class="pwtext" id="notsame" style="display:none;">&nbsp;&nbsp;&nbsp;비밀번호가 다릅니다.</p></td>
					</tr>
					
					<tr>
						<td><label for="nickname">닉네임</label></td>
						<td><input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요." maxlength="8" value="<%= sNICKNAME %>" required></td>
						<td><button type="button" id="checkNickName" class="check-btn" onclick="DuplicateCheck('nickname')">중복확인</button></td> 
					</tr>
					
					<tr>
						<td><label for="course">과정선택</label></td>
						<td>
							<select id="course" name="course" required>
								<option value="0">선택하세요</option>
								<% for (int i : courseMap.keySet())
								{
									out.println(String.format("<option value='%d'>%s</option>",
																			  i, courseMap.get(i) ));
								}
								%>
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
		// -----------------------------------------------------------------
	</script>
	<%------------------------------------------------------------------
	[JSP 페이지에서 바로 이동(바이패스)]
	----------------------------------------------------------------------%>
	<%------------------------------------------------------------------
	바이패스 방법1	: JSP forward 액션을 사용 한 페이지 이동
				:-------------------------------------------------------
				: page	- 이동 할 새로운 페이지 주소
				: name	- page 쪽에 전달 할 파라미터 명칭
				: value	- page 쪽에 전달 할 파라미터 데이터
				:		- page 쪽에서 request.getParameter("name1")로 읽음
				:-------------------------------------------------------
				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
				: 브라우저 Url 주소는 현재 페이지로 유지 됨
	--------------------------------------------------------------------
	<jsp:forward page="Hello.jsp">
		<jsp:param name="name1" value='value1'/>
		<jsp:param name="name2" value='value2'/>
	</jsp:forward>
	--%>
	<%
		// -----------------------------------------------------------------
		//	바이패스 방법2	: RequestDispatcher을 사용 한 페이지 이동
		//				:---------------------------------------------------
		//				: sUrl	- 이동 할 새로운 페이지 주소
		//				:		- sUrl 페이지 주소에 GET 파라미터 전달 가능
		//				:		- sUrl 페이지가 갱신됨 즉,
		//				:		- sUrl 페이지 주소에 GET 파라미터 유무에 상관없이
		//				:		- sUrl 페이지 쪽에서 request.getParameter() 사용가능
		//				:-------------------------------------------------------
		//				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
		//				: 브라우저 Url 주소는 현재 페이지로 유지 됨
		// -----------------------------------------------------------------
		// String sUrl = "Hello.jsp?name1=value1&name2=value2";
		//
		// RequestDispatcher dispatcher = request.getRequestDispatcher(sUrl);
		// dispatcher.forward(request, response);
		// -----------------------------------------------------------------
		//	바이패스 방법3	: response.sendRedirect을 사용 한 페이지 이동
		//				:---------------------------------------------------
		//				: sUrl	- 이동 할 새로운 페이지 주소
		//				:		- sUrl 페이지에 GET 파라미터만 전달 가능
		//				:		- sUrl 페이지 갱신 없음 즉,
		//				:		- sUrl 페이지 주소에 GET 파라미터 있는 경우만
		//				:		- sUrl 페이지 쪽에서 request.getParameter() 사용가능
		//				:-------------------------------------------------------
		//				: 이 방법은 기다리지 않고 바로 이동하기 때문에 현재 화면이 표시되지 않음
		//				: 브라우저의 Url 주소는 sUrl 페이지로 변경 됨
		// -----------------------------------------------------------------
		//String sUrl = "Hello.jsp?name1=value1&name2=value2";
		//
		//response.sendRedirect(sUrl);
		// -----------------------------------------------------------------
	%>
</body>
</html>
