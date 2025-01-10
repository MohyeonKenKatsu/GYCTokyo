<%@page import="BeansUsers.LoginDAO"%>
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
    <title>GYC, 그 해 우리는</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="Login.css">
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
	// 사원정보 검색용 DAO 객체
	public LoginDAO loginDAO = new LoginDAO();
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
	Boolean bJobProcess	= null;		// 파라미터 : 작업처리 - DB 접속 여부
	String  sEMAIL		= null;		// 파라미터 : 이메일
	String  sPASSWORD	= null;		// 파라미터 : 비밀번호
	Boolean bLoginFail	= null;		// 파라미터 : 로그인 실패
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	String[] USER_ID_DATA = null;	// 파라미터 : 로그인 성공 시 회원정보 전달용
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	bJobProcess	= ComMgr.IsNull(request.getParameter("jobprocess"), false);		// 파라미터 : 작업처리 : null 확인(false : 아무동작 없음)
	sEMAIL		= ComMgr.IsNull(request.getParameter("email"), "");				// 파라미터 : 이메일
	sPASSWORD	= ComMgr.IsNull(request.getParameter("password"), "");			// 파라미터 : 이메일
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	USER_ID_DATA = new String[] {"0", "0", "0"};	// 사용자 아이디, 닉네임, 교육과정을 전달
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
	// bJobProcess 작업처리 허용인 경우
	if (bJobProcess == true)
	{
		// 로그인 정보가 사용자 테이블에 있을 경우 = 로그인 성공
		if (this.loginDAO.Login(sEMAIL, sPASSWORD, USER_ID_DATA) == true)
		{
			bLoginFail = false;

			// 아이디, 닉네임, 과정을 넘겨주면서 캘린더 index 페이지로 이동
			//response.sendRedirect("../Calendar/index.jsp?USER_ID=" + USER_ID_DATA[0]);
			
			//response.sendRedirect(
			//out.println(
			//String.format("../Calendar/index.jsp?USER_ID=%s",// &NICKNAME=%s&COURSE=%s",
			//			   USER_ID_DATA[0])//, USER_ID_DATA[1], USER_ID_DATA[2])
			//);
		}
		// 로그인 정보가 사용자 테이블에 없을 경우 = 로그인 실패
		else {
			bLoginFail = true;
		}
	}
%>

<body>
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
	<!-- 로그인 영역 -->
	<div class="form-container">
	
		<!-- 페이지 제목 영역 -->
        <h1 class="login-title">SIGN IN</h1>
        
        <!-- 입력 양식 영역 -->
        <form name="loginform" action="" method="post">
        	
        	<!-- 이메일 입력 칸 -->
	        <div class="input-container">
	            <input type="email" id="email" name="email" placeholder="이메일" value="<%= sEMAIL %>" required>
	        </div>
	        
			<!-- 비밀번호 입력 칸 -->
	        <div class="input-container">
	            <input type="password" id="password" name="password" placeholder="비밀번호" required>
	        </div>
	        
			<!-- DB 접속 제어 변수 -->
	       	<input type="hidden" id="jobprocess" name="jobprocess" value="true">
	       	
			<!-- 버튼 영역 -->
	        <div class="button-container">
	        	
	        	<!-- 로그인 버튼 -->
	            <button type="submit" class="signin-btn">SIGN IN</button>
	            
	            <!-- 회원가입 버튼 -->
	            <button type="button" class="signup-btn" onclick="window.location.href='SignUp.jsp'">SIGN UP</button>
	        
	        </div>
		</form>
	</div>
	<%----------------------------------------------------------------------
	[HTML Page - END]
	--------------------------------------------------------------------------%>
	
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역(하단)]
	[외부 자바스크립트 연결(각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
		// -----------------------------------------------------------------
		// [사용자 함수 및 로직 구현]
		// -----------------------------------------------------------------
		
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

<script type="text/javascript">
	
	//POST 요청을 수행하는 함수
	function postToDestination() {
	    const form_user_id = document.createElement('form');
	    form_user_id.method = 'POST';
	    form_user_id.action = '../Calendar/index.jsp';
		
	    // 숨겨진 필드에 데이터 추가
	    const user_id = document.createElement('input');
	    user_id.type = 'hidden';
	    user_id.name = 'USER_ID';
	    user_id.value = '<%=USER_ID_DATA[0]%>';
		
	    form_user_id.appendChild(user_id);
	    document.body.appendChild(form_user_id);
	    form_user_id.submit();
	}
	
	// 로그인 실패일 경우 alert창 출력 
	if (<%= bLoginFail %> == false) {
		// POST 요청 실행
        // console.log('<%=bJobProcess%>');
        // postToDestination();
        <% session.setAttribute("USER_ID", USER_ID_DATA[0]); %>
        location.href="../Calendar/index.jsp";
	}
	if (<%= bLoginFail %> == true) {
		DocumentInit('로그인에 실패했습니다.');
	}

</script>
</body>
</html>