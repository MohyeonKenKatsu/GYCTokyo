<%@page import="BeansShareDiary.ShareDiaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
	<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>공유일기</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiary.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Header/Header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역(상단)]
	[외부 자바스크립트 연결(각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
		// -----------------------------------------------------------------
		// [사용자 함수 및 로직 구현]
		// -----------------------------------------------------------------
		function openModal(modalType, date, group_id, user_id)
		{
			let ifModalWindow = document.getElementById('ifModalWindow');
			//alert(date);
			divModalFrame.style.display = "block";
			
			if(modalType === 'NewSDModal')
			{			
				ifModalWindow.src = 'NewSDModal.jsp';
			}
			else if(modalType === 'ViewSDModal')
			{
				ifModalWindow.src = 'ViewSDModal.jsp?date=' + date + '&group_id=' + group_id + '&user_id=' + user_id;
			}
			else if(modalType === 'ChangeSDModal')
			{
				ifModalWindow.src = 'ChangeSDModal.jsp'
			}
			else if(modalType === 'GroupMemberListModal')
			{
				ifModalWindow.src = 'GroupMemberListModal.jsp'
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
	// 그룹 내 공유일기 검색용 DAO 객체
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
	//Boolean bJobProcess = ComMgr.IsNull(request.getParameter("jobprocess"), false);
	String sDate = request.getParameter("date");
	Integer nGroupId = ComMgr.IsNull(request.getParameter("group_id"), -1);
	Integer nUserId = ComMgr.IsNull(request.getParameter("user_id"), -1);
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	Boolean bContinue		= false;						// 사원정보 검색 유무

	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	
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
	ShareDiaryDTO.setDate(sDate);
	ShareDiaryDTO.setGroupId(nGroupId);
	ShareDiaryDTO.setUserId(nUserId);
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	// bJobProcess 작업처리 허용 && 검색인 경우 사원정보 검색
	//if (bJobProcess == true && sJobStatus.equals("SELECT") == true)
	{
		// 사원정보 검색 결과용 ArrayList 객체 생성
		//Sawons = new ArrayList<SawonDTO>(); 
		
		// 사원정보 검색
		if (this.shareDiaryDAO.ReadShareDiaryInGroupList(ShareDiaryDTO) == true)
		{
			if (this.shareDiaryDAO.DBMgr != null && this.shareDiaryDAO.DBMgr.Rs != null)
			{
				bContinue = true;
			}
		}
	}

%>
<body>
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
    <!-- 헤더 포함 -->
    <%@ include file="/Views/Components/Header/Header.jsp" %>
    <div style="display: flex;">
    
    <!-- 사이드바 포함 -->
    <%@ include file="/Views/Components/Sider/Sider.jsp" %>
		<%------------------------------------------------------------------
			메인 페이지
		----------------------------------------------------------------------%>
		<!-- 메인 콘텐츠 -->
        <form class="MainContent" name="form1" action="ShareDiary.jsp?group_id=<%=nGroupId %>&user_id=<%=nUserId %>" method="post">
			<!-- 상단 날짜와 제목 -->
			<div class="Header">
			<h1 class="Title">공유일기</h1>
			<input type="date" class="Date" id="date" name="date" value="<%=sDate %>" required>
			<input type="submit" class="" id="submit" name="submit" value="검색">
			</div>
			<!-- 우측 메뉴 -->
			<table class="RightMenu">
				<tr>
					<td>
				    	<button class="MemberListButton" id="memberListButton" onclick="openModal('GroupMemberListModal')">그룹원</button>
					</td>
					<td>
				    	<button class="WriteButton" id="writeButton" onclick="openModal('NewSDModal')">글쓰기</button>
					</td>
					<td>
					    <div class="Sort">☰</div>
					</td>
				</tr>
			</table>
			
			<!-- 공유일기 게시글 리스트 -->
			<div class="DiaryList">
			<%
			if(bContinue == true)
			{
				while (this.shareDiaryDAO.DBMgr.Rs.next() == true)
				{
			%>
				<div class="DiaryPreview" id="diaryPreview" onclick="openModal('ViewSDModal', '<%=sDate %>', <%=nGroupId %>, <%=nUserId %>)">
					<h3 class="DiaryWriter">세니</h3>
					<p class="TextPreview"><%=this.shareDiaryDAO.DBMgr.Rs.getString("SD_CONTENT") %></p>
					<p class="EditGuide">일기를 조회하거나 수정하려면 클릭하세요.</p>
				</div>
			<%
				}
			}
			%>

			</div>
		<%------------------------------------------------------------------
		[모달 창 페이지 - START]
		----------------------------------------------------------------------%>
		<div class="Modal-Frame" id="divModalFrame">
	        <div class="Modal-Content">
	            <iframe class="Modal-Window" id="ifModalWindow"></iframe>
	        </div>
        </div>
		<%------------------------------------------------------------------
		[모달 창 페이지 - END]
		----------------------------------------------------------------------%>
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
	<script src="<%= request.getContextPath() %>/Views/Pages/ShareDiary/ShareDiary.js" defer></script>
</body>
</html>