<%@page import="BeansShareDiary.ShareDiaryDTO"%>
<%@page import="Common.ComMgr"%>
<%@page import="BeansShareDiary.ShareDiaryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>공유일기 그룹원 초대 모달창</title>
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
	<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/ShareDiary/InviteGroupMemberModal.css">
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
	Boolean bJobProcess	 = null;
	Integer nUserId 	 = null;
	String sPickGroupId	 = null;
	String sEmail		 = null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	String sGroupname	= null;
	Integer nGroupId 	= null;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	Boolean bContinue	= true;	// 공유일기 그룹 목록 검색 유무	
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	bJobProcess = ComMgr.IsNull(request.getParameter("jobProcess"), false);
	nGroupId= ComMgr.IsNull(request.getParameter("grouppicker"), -1);
	sEmail = ComMgr.IsNull(request.getParameter("inviteemail"), "No Email");
	
	session.setAttribute("USER_ID", 1);
	
	nUserId = ComMgr.IsNull(session.getAttribute("USER_ID"), -1);
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
if (bContinue == true)
{
	ShareDiaryDTO.setUserId(nUserId);
}

//JobProcess가 true인 경우 INSERT/UPDATE 처리를 위한 파라미터 값을 DTO에 넣기
if (bJobProcess == true)
{
	ShareDiaryDTO.setGroupId(nGroupId);
	ShareDiaryDTO.setEmail(sEmail);
}		

%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
//공유일기 그룹 목록 검색
if (bContinue == true)
{
	if (this.shareDiaryDAO.ReadMyGroupList(ShareDiaryDTO) == true)
	{
		if (this.shareDiaryDAO.DBMgr != null && this.shareDiaryDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
}

if(bJobProcess == true)
{
	if (this.shareDiaryDAO.InviteShareDiaryGroup(ShareDiaryDTO) == true)
	{
		bContinue = true;
	}
}
	
%>
<body>
	<form name="form1" action="InviteGroupMemberModal.jsp?jobProcess=true" method="post">
	<!-- 모달 배경 -->
	<div class="InviteGroupModal" id="inviteGroupModal">
		<!-- 모달 창 -->
		<div class="ModalContent">
		
			<div class="InviteGMModalHeader">
				<h2 class="Header">그룹원 초대</h2>
      		</div>
      		
        	<div class="InviteGMModalBody">
        		<table class="GroupNameTool">
					<tr>
        				<td>
        					<label class="GroupChoiceText" for="GroupPicker">그룹 선택</label>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<select class="GroupPicker" id="groupPicker" name="grouppicker">
        						<option value="default" disabled selected>초대할 그룹을 선택하세요.</option>
					 			<%
								if(bContinue == true)
								{
									while (this.shareDiaryDAO.DBMgr.Rs.next() == true)
									{
										nGroupId	= ComMgr.IsNull(this.shareDiaryDAO.DBMgr.Rs.getInt("GROUP_ID"), -1);
										sGroupname	= ComMgr.IsNull(this.shareDiaryDAO.DBMgr.Rs.getString("GROUPNAME"), "No Group Name");
								%>
        							<option value="<%=nGroupId %>"><%=sGroupname %></option>
								<%
									}
								}
								%>
        					</select>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<label class="GroupInviteEmail" for="InputEmail">초대할 이메일</label>
        				</td>
        			</tr>
        			<tr>
        				<td>
        					<textarea class="InputEmail" name="inviteemail" placeholder="ex: kenkatsu@gyc.com"></textarea>
        				</td>
        			</tr>
        		</table>
        	</div>
        	
			<div class="InviteGMModalTail">
				<button type="button" class="InviteGroupCancel">취소</button>
				<button type="submit" class="InviteGroupButton">초대</button>
			</div>
        
		</div>
	</div>
	</form>	
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
</body>
</html>