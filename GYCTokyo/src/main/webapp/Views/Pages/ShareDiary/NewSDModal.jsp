<%@page import="java.time.LocalDate"%>
<%@page import="BeansShareDiary.ShareDiaryDAO"%>
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
	<title>공유일기 작성 모달창</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
		<style type="text/css">
		/* -----------------------------------------------------------------
			HTML Page 스타일시트
		   ----------------------------------------------------------------- */
			
        /* ----------------------------------------------------------------- */
	</style>	
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/NewSDModal.css">
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역(상단)]
	[외부 자바스크립트 연결(각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
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
	// 그룹 내 공유일기 저장용 DAO 객체
	public ShareDiaryDAO shareDiaryDAO = new ShareDiaryDAO();	
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
	Boolean bJobProcess		= null;
	String  sJobStatus		= null;

	String 	sDate			= null;
	Integer nGroupId		= null;
	Integer nDiaryUserId	= null;
	String	sSDContent		= null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	String  sNickname		= null;
	Boolean bSuccess		= false;
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	bJobProcess = ComMgr.IsNull(request.getParameter("jobProcess"), false);
	sJobStatus = ComMgr.IsNull(request.getParameter("jobStatus"), "INSERT");
	
	sDate = ComMgr.IsNull(request.getParameter("date"), LocalDate.now().toString());
	nGroupId = ComMgr.IsNull(request.getParameter("groupId"), -1);
	nDiaryUserId = ComMgr.IsNull(request.getParameter("diaryUserId"), -1);
	sSDContent = ComMgr.IsNull(request.getParameter("sdContent"), "");

	if (nGroupId != -1 && nDiaryUserId != -1)
	{
		bSuccess = true;
	}
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	session.setAttribute("NICKNAME", "태우");
	
	sNickname = ComMgr.IsNull(session.getAttribute("NICKNAME"), "태우");

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
	<jsp:useBean id="ShareDiaryDTO" class="BeansShareDiary.ShareDiaryDTO" scope="request"></jsp:useBean>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	------------------------------------------------------------------------
	<jsp:setProperty name="HelloDTO" property="*"/>
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
if (bJobProcess == true)
{
	switch (sJobStatus)
	{
		case "INSERT":
			ShareDiaryDTO.setJobStatus(sJobStatus);
			ShareDiaryDTO.setDate(sDate);
			ShareDiaryDTO.setGroupId(nGroupId);
			ShareDiaryDTO.setUserId(nDiaryUserId);
			ShareDiaryDTO.setSdcontent(sSDContent);
			
		break;
	}
}		
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	if(bJobProcess == true)
	{
		if (this.shareDiaryDAO.SaveShareDiary(ShareDiaryDTO) == true)
		{
			bSuccess = true;
		}
	}
%>
<body>
	<form name="form1" action="NewSDModal.jsp?jobProcess=true&jobStatus=INSERT" method="post">
	<input type="hidden" name="date" value="<%=sDate %>">
	<input type="hidden" name="groupId" value="<%=nGroupId %>">
	<input type="hidden" name="diaryUserId" value="<%=nDiaryUserId %>">
	<!-- 모달 배경 -->
	<div class="NewSDModal" id="newSDModal">
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="ModalHeader">
				<h2 class="Header">공유일기</h2>
				<div class="Date" id="date"><%=sDate %></div>
				<table class="ViewWriter">
					<tr>
						<td class="Writer">작성자</td>
						<td class="Nickname"><%=sNickname %></td>
					</tr>
				</table>
      		</div>
      		
        	<div class="ModalBody">
				<textarea class="InputDiary" name="sdContent" placeholder="오늘 어떤 하루를 보내셨나요? 친구들에게 나의 하루를 공유해 볼까요?"></textarea>
        	</div>
        	
			<div class="ModalTail">
				<button type="button" class="NewDiaryCancel">취소</button>
				<button type="submit" class="NewDiarySave" id="newDiarySave">등록</button>
			</div>
        
		</div>
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
</form>
</body>
</html>