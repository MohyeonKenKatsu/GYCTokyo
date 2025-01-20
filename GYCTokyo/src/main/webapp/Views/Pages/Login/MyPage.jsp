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
    <title>데이터 중복 확인</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="MyPage.css">
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
		
		
		function changeProcess(objname, DupNickname)
		{
			const objContent = document.getElementById(objname);
			
			// 닉네임 중복확인일 때
			if (objContent != null)
			{
				// 빈 칸일 때는 alert만 내보내고 submit하지 않음
				if (objContent.value == '')
				{
					alert('닉네임을 입력해주세요.');
					
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
				if (DupNickname) document.getElementById('jobprocess').value = objname;
				else alert('닉네임 중복 확인을 진행해주세요.');
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
	public Boolean DupNickname = false;
	// 사원정보 검색용 DAO 객체
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
	Integer iUSERID 		= null;		// 파라미터 : 사용자 아이디
	String  sNICKNAME		= null;		// 파라미터 : 비밀번호
	Integer iCOURSE			= null;		// 파라미터 : 교육과정
	String  sTEL			= null;		// 파라미터 : 전화번호 뒤 4자리
	String  sPASSWORD		= null;		// 파라미터 : 비밀번호
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	UsersDTO usersDTO = null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	String 	sJobProcess 	= null;				// 파라미터 : 수정 버튼을 눌렀을 때
	Boolean bEditSuccess	= null;				// 파라미터 : 회원정보 수정에 성공했을 때
	String 	sDupNickname		= null; 			// 파라미터 : 닉네임이 중복될 때
	HashMap<Integer, String> courseMap = null;	// 교육과정 동적 생성용 Hash Map
	String 	sSelectedCourse	= null;				// 파라미터 : 기존 교육과정 선택용 변수
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	sJobProcess	= ComMgr.IsNull(request.getParameter("jobprocess"), "read");	// 파라미터 : 작업처리 : null 확인(false : 아무동작 없음)
	sPASSWORD	= ComMgr.IsNull(request.getParameter("password"), "");			// 파라미터 : 이메일
	sNICKNAME	= ComMgr.IsNull(request.getParameter("nickname"), "");			// 파라미터 : 이메일
	iCOURSE		= ComMgr.IsNull(request.getParameter("course"), 0);				// 파라미터 : 이메일
	sTEL		= ComMgr.IsNull(request.getParameter("tel"), "");				// 파라미터 : 이메일
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	iUSERID = ComMgr.IsNull(session.getAttribute("USER_ID"), 0);
	courseMap = HeaderFlagHash.gethashCourse();
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
	usersDTO = new UsersDTO();
	
	switch (sJobProcess)
	{
		case("read"):
			if (this.usersDAO.ReadMyPageData(iUSERID, usersDTO) == true)
			{
				sNICKNAME = usersDTO.getNickname();
				iCOURSE = usersDTO.getCourse();
				sTEL = usersDTO.getTel();
				sPASSWORD = usersDTO.getPassword();
			}
			break;
		
		case ("save"):
			usersDTO.setUser_id(iUSERID);
			usersDTO.setNickname(sNICKNAME);
			usersDTO.setPassword(sPASSWORD);
			usersDTO.setCourse(iCOURSE);
			usersDTO.setTel(sTEL);
			
			if (this.usersDAO.EditUserData(usersDTO))
			{
				bEditSuccess = true;
			}
			else bEditSuccess = false;
			break;
			
		case("nickname"):
			usersDTO.setNickname(sNICKNAME);
			
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
	//중복된 닉네임이 존재할 경우
	if (<%= sDupNickname != null %>)
	{
		// console.log("<1%=sDupNickname %>");
		alert('<%=sDupNickname %>');
	}
</script>

<body>
	<div class="container">
		<div class="form-container">
			<h1 class="signup-title">My Page</h1>
			<form name="form1" action="" method="post">
				<table class="form-table">
				
					<tr>
						<td><label for="password">비밀번호</label></td>
						<td class="inputform"><input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" maxlength="12"
						value="<%= sPASSWORD %>"
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
						<td><button type="button" id="checkNickName" class="check-btn" onclick="changeProcess('nickname')">중복확인</button></td> 
					</tr>
					
					<tr>
						<td><label for="course">과정선택</label></td>
						<td class="inputform">
							<select id="course" name="course" required>
								<option value="0">선택하세요</option>
								<%
								for (int i : courseMap.keySet())
								{
									sSelectedCourse = (i == iCOURSE) ? "SELECTED" : "";
									
									out.println(String.format("<option value='%d'%s>%s</option>",
																			  i, sSelectedCourse, courseMap.get(i) ));
								}
								%>
							</select>
						</td>
					</tr>
					
					<tr>
						<td><label for="tel">전화번호 뒤 4자리</label></td>
						<td class="inputform"><input type="text" id="tel" name="tel" placeholder="전화번호 뒤 4자리를 입력하세요" maxlength="4"
						oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
						value="<%= sTEL %>" required></td>
					</tr>
				</table>
				
				<!-- DB 접속 제어 변수 -->
	    	   	<input type="hidden" id="jobprocess" name="jobprocess" value="true">
	    	   	
				<div class = button-container>
					<button type="button" class="reset-btn" onclick="gotologin()">로그아웃</button>
				
					<button type="reset" class="reset-btn" onclick="history.back()">취소</button>
					<button type="submit" id="submitbtn" class="signup-btn" onclick="changeProcess('save', <%=this.DupNickname %>)">수정</button>
				</div>
				
			</form>
		</div>
	</div>	
</body>

<script type="text/javascript">
	if (<%= bEditSuccess != null %>)
	{
		// 회원정보 수정에 성공했을 경우
		if (<%= bEditSuccess %> == true)
		{
			DocumentInit("개인정보 수정에 성공했습니다.");
	        <% session.setAttribute("NICKNAME", sNICKNAME); %>
	        <% session.setAttribute("COURSE", iCOURSE); %>
			location.href="<%= request.getContextPath() %>/Views/Pages/Calendar/index.jsp";
		}
		// 회원정보 수정에 실패했을 경우
		if (<%= bEditSuccess %> == false)
		{
			DocumentInit("개인정보 수정 시도 중 오류가 발생했습니다.");
			location.href="history.back()";
		}
	}
	
	function gotologin()
	{
		   if (!confirm("정말로 로그아웃하시겠습니까?")) {
		        // 취소(아니오) 버튼 클릭 시 이벤트
		    } else {
		        // 확인(예) 버튼 클릭 시 이벤트
				location.href="<%= request.getContextPath() %>/Views/Pages/Login/Login.jsp";
		    }
	}

</script>

</html>