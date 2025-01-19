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
			var submitButton = document.getElementById('submitbtn');
			
			if (val1 == val2)
			{
				shortMessage.style.display="none";
				submitButton.disabled = false;
			}
			else 
			{
				shortMessage.style.display="block";
				submitButton.disabled = true;
			}
		}
		
		
		function DuplicateCheck(objname, DupEmail, DupNickname)
		{
			const objContent = document.getElementById(objname);
			
			// 이메일, 닉네임일 때
			if (objContent != null)
			{
				// 빈 칸일 때는 alert만 내보내고 submit하지 않음
				if (objContent.value == '')
				{
					if (objname == 'email') alert('이메일을 입력해주세요.');
					else alert('닉네임을 입력해주세요.');
					
					objContent.focus();
				}
				// 값이 있으면 submit
				else
				{
					document.getElementById('jobprocess').value = objname;
					document.form1.submit();
				}
			}
			// 저장일 때
			else
			{
				// 중복확인이 끝났으면 JobProcess 지정
				if (DupEmail && DupNickname)
					document.getElementById('jobprocess').value = objname;
				else
				{
					// 중복확인이 안 됐으면 확인요청
					if (DupEmail == false)
					{
						alert('이메일 중복 확인을 진행해주세요.');
					}
					else
					{
						if (DupNickname == false)
						{
							alert('닉네임 중복 확인을 진행해주세요.');
						}
					}
				}
			}
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
	public Boolean DupEmail = false;
	public Boolean DupNickname = false;
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
	String  sJobProcess		= null;		// 파라미터 : 작업처리 - DB 접속 여부
	String  sJobProcess1	= null;		// 파라미터 : 작업처리 - DB 접속 여부
	String  sJobProcess2	= null;		// 파라미터 : 작업처리 - DB 접속 여부
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
	String 	sDupEmail 		= null;		// 파라미터 : 이메일 중복확인
	String 	sDupNickname 	= null;		// 파라미터 : 닉네임 중복확인

	Boolean bDupEmail		= null;		// 이메일 중복 데이터 존재
	Boolean bDupNickname	= null;		// 닉네임 중복 데이터 존재
	
	
	String sSelectedCourse	= null;		// 파라미터 : 기존 교육과정 선택용 변수
	Boolean bSignupSuccess 	= null;		// 파라미터 : 회원가입 결과
	HashMap<Integer, String> courseMap = HeaderFlagHash.gethashCourse();
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	sJobProcess		= ComMgr.IsNull(request.getParameter("jobprocess"), "");		// 파라미터 : 작업처리 : null 확인(false : 아무동작 없음)
	sEMAIL			= ComMgr.IsNull(request.getParameter("email"), "");				// 파라미터 : 이메일
	sPASSWORD		= ComMgr.IsNull(request.getParameter("password"), "");			// 파라미터 : 이메일
	sNICKNAME		= ComMgr.IsNull(request.getParameter("nickname"), "");			// 파라미터 : 이메일
	iCOURSE			= ComMgr.IsNull(request.getParameter("course"), 0);				// 파라미터 : 이메일
	sBIRTHDAY		= ComMgr.IsNull(request.getParameter("birthday"), "");			// 파라미터 : 이메일
	sTEL			= ComMgr.IsNull(request.getParameter("tel"), "");				// 파라미터 : 이메일
//	sDupEmail		= ComMgr.IsNull(request.getParameter("dupemail"), "");	
//	sDupNickname	= ComMgr.IsNull(request.getParameter("dupnickname"), "");	
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
	<jsp:useBean id="UsersDTO" class="BeansUsers.UsersDTO" scope="session"></jsp:useBean>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	------------------------------------------------------------------------
	<jsp:setProperty name="SawonDTO" property="*"/>
	--%>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법2	: Beans Property에 HTML 태그 name 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 name
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
						: Property를 각각 지정 해야 함!
	------------------------------------------------------------------------
	<jsp:setProperty name="HelloDTO" property="data1"/>
	<jsp:setProperty name="HelloDTO" property="data2"/>
	--%>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법3	: Beans 메서드 직접 호출
						:---------------------------------------------------
						: Beans 메서드를 각각 직접 호출 해야함!
	--------------------------------------------------------------------------%>
	<% 
		UsersDTO.setEmail(sEMAIL);
		UsersDTO.setPassword(sPASSWORD);
		UsersDTO.setNickname(sNICKNAME);
		UsersDTO.setCourse(iCOURSE);
		UsersDTO.setBirthday(sBIRTHDAY);
		UsersDTO.setTel(sTEL);
	%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>

<%
	// 회원가입 시도중일 경우
	switch (sJobProcess)
	{
		case "save":
			// 회원가입에 성공했을 경우
			if (this.usersDAO.Signup(UsersDTO) == true)
			{
				bSignupSuccess = true;
			}
			else bSignupSuccess = false;
			
			break;
		case "email":
			if (this.usersDAO.DuplicateEmail(UsersDTO) == true)
			{	
				// 이메일 검색결과가 있는지 확인
				if (this.usersDAO.DBMgr.Rs.next())
				{
					if (this.usersDAO.DBMgr.Rs.getInt("EMAIL") > 0) { sDupEmail = "사용 중인 이메일입니다.";		this.DupEmail = false;  }
					else											{ sDupEmail = "사용할 수 있는 이메일입니다.";	this.DupEmail = true; }
				}
			}
			
			break;
		case "nickname":
			if (this.usersDAO.DuplicateNickname(UsersDTO) == true)
			{
				// 닉네임 검색결과가 있는지 확인
				if (this.usersDAO.DBMgr.Rs.next())
				{
					if (this.usersDAO.DBMgr.Rs.getInt("NICKNAME") > 0)	{ sDupNickname = "사용 중인 닉네임입니다.";		this.DupNickname = false;  }
					else												{ sDupNickname = "사용할 수 있는 닉네임입니다.";	this.DupNickname = true; }
				}
			}
			
			break;
	}
%>

<script type="text/javascript">
	// 회원가입에 성공했을 경우
	if (<%= bSignupSuccess %> == true)
	{
		// DocumentInit("회원가입에 성공했습니다.");
		alert("회원가입에 성공했습니다.");
		location.href="Login.jsp";
	}

	// 회원가입에 실패했을 경우
	if (<%= bSignupSuccess %> == false)
	{
		DocumentInit("회원가입 시도 중 오류가 발생했습니다.");
	}
	
	// 중복된 이메일이 존재할 경우
	if (<%= sDupEmail != null %>)
	{
		console.log("<%=sDupEmail %>");
		alert('<%=sDupEmail %>');
	}
	
	// 중복된 닉네임이 존재할 경우
	if (<%= sDupNickname != null %>)
	{
		console.log("<%=sDupNickname %>");
		alert('<%=sDupNickname %>');
	}
</script>

<body>
	<div class="container">
		<div id="divModalParent" class="form-container">
			<h1 class="signup-title">SIGN UP</h1>
			<form name="form1" action="" method="post">
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
									sSelectedCourse = (i == iCOURSE) ? "SELECTED" : "";
									
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
	    	   	<input type="hidden" id="jobprocess" name="jobprocess" value="<%=sJobProcess %>">
				<div class = "button-container">
					<button type="reset" class="reset-btn" onclick="window.location.href='Login.jsp'">취소</button>
					<button type="submit" id="submitbtn" class="signup-btn" onclick="DuplicateCheck('save', <%=this.DupEmail %>, <%=this.DupNickname %>);">등록</button>
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
