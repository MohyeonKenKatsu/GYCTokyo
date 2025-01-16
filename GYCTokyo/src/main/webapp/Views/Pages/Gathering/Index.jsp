<%@page import="BeansGathering.GatheringDTO"%>
<%@page import="Common.ComMgr"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.naming.java.javaURLContextFactory"%>
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
    <title>소모임</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Gathering/Index.css">
  <%--   <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Gathering/Header.css"> --%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Gathering/Gathering.css">
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
	// 게시판 검색(리스트,상세)/추가/수정/삭제 처리용 DAO 객체
	public GatheringDAO gatheringDAO = new GatheringDAO();
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
	Integer GatheringId		= null;				// 게시글 Id
	String  sJobStatus		= null;				// 작업상태(Insert | Update | Delete)
	
	// 모집글 기본 정보 변수
	Integer user_id			= null;				// 작성자
	String title			= null;				// 글제목
	String start_date		= null;				// 모집 시작날짜
	String finish_date		= null;				// 모집 종료날짜
	String activity_date	= null;				// 모집 활동날짜
	Integer number_limit	= null;				// 모집 인원 수
	String content			= null;				// 모집 글내용
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	// 게시글 정보 수집용 변수 및 객체
	Boolean bContinue 		= false;	// 게시글 저장(등록/수정/삭제) 진행 여부
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
    // 작업처리 파라미터 확인
    String jobProcessParam   = request.getParameter("JobProcess");  // 작업처리 여부 파라미터
    Boolean bJobProcess      = ComMgr.IsNull(jobProcessParam, false); // null 확인 및 기본값 설정
    
    // 작업상태 파라미터 확인
    sJobStatus               = ComMgr.IsNull(request.getParameter("jobStatus"), ""); // 작업상태 파라미터 확인
    
    
    title         = ComMgr.IsNull(request.getParameter("title"),         "제목없음");
    start_date    = ComMgr.IsNull(request.getParameter("start_date"),    "2023-01-01");
    finish_date   = ComMgr.IsNull(request.getParameter("finish_date"),   "2023-12-31");
    activity_date = ComMgr.IsNull(request.getParameter("activity_date"), "2023-01-01");
    number_limit  = Integer.valueOf(ComMgr.IsNull(request.getParameter("number_limit"),0));
    content       = ComMgr.IsNull(request.getParameter("content"),       "내용없음");

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
	<jsp:useBean id="GatheringDTO" class="BeansGathering.GatheringDTO" scope="request"></jsp:useBean>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	------------------------------------------------------------------------
	<jsp:setProperty name="GatheringDTO" property="*"/>--%>
	
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
	GatheringDTO.setUser_id(123);

	if (bJobProcess == true && "INSERT".equalsIgnoreCase(sJobStatus)) {
    // 소모임 기본 정보 설정

	GatheringDTO.setTitle(title);                 // 글 제목 설정
    GatheringDTO.setStart_date(start_date);       // 모집 시작 날짜 설정
    GatheringDTO.setFinish_date(finish_date);     // 모집 종료 날짜 설정
    GatheringDTO.setActivity_date(activity_date); // 모집 활동 날짜 설정
    GatheringDTO.setNumber_limit(number_limit);   // 모집 인원 수 설정 
    GatheringDTO.setContent(content);             // 글 내용 설정

    boolean result = gatheringDAO.GatheringSave("INSERT", 1, GatheringDTO);
    if (result) {
       out.println("<script>alert('등록 성공'); location.href='Index.jsp';</script>");
    } else {
       out.println("<script>alert('등록 실패'); history.back();</script>");
    }
}
%>


<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	// ---------------------------------------------------------------------
	// 게시글 저장(등록/수정/삭제) 진행 여부
	// ---------------------------------------------------------------------
	if (bContinue == true)
	{
		this.gatheringDAO.GatheringSave(sJobStatus, GatheringId, GatheringDTO);
	}
   	// ---------------------------------------------------------------------
%>


<body class="Body">
	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
    <!-- 헤더 포함 -->
 	<%@ include file="/Views/Components/Header/Header.jsp" %>

    <div style="display: flex;">
        <!-- 사이드바 포함 -->
        <%@ include file="/Views/Components/Sider/Sider.jsp" %>

        <!-- 메인 콘텐츠 -->
        <main style="flex: 1; padding: 50px;">
            <!-- 소모임 -->
            <%@ include file="/Views/Pages/Gathering/Gathering.jsp" %>

        </main>
    </div>
</body>
</body>
</html>
