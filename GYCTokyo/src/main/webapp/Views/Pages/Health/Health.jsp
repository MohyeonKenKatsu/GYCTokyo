<%@page import="java.time.LocalDate"%>
<%@page import="Common.ComMgr"%>
<%@page import="BeansHealth.HealthDAO"%>
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
    <title>건강기록</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
    <link rel="stylesheet" href="Health.css">
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
	// 건강기록 검색용 DAO 객체
	public HealthDAO healthDAO = new HealthDAO();
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
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	String sHealthDate = null;
	Integer nUserId = null;
	
	// session.setAttribute("USER_ID", 1);
	
	sHealthDate = ComMgr.IsNull(request.getParameter("textdate"), LocalDate.now().toString()).replace(".", "-");
	nUserId = ComMgr.IsNull(session.getAttribute("USER_ID"), -1);
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	Boolean bContinue		= false;						// 건강기록 검색 유무
	
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
	<jsp:useBean id="HealthDTO" class="BeansHealth.HealthDTO" scope="request"></jsp:useBean>
	
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
	HealthDTO.setHealth_date(sHealthDate);
	HealthDTO.setUser_id(nUserId);
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	// 로그인 한 경우 건강기록 검색
	if (nUserId > -1)
	{
		// 건강기록 검색
		if (this.healthDAO.ReadHeaderData(HealthDTO) == true)
		{
			if (this.healthDAO.DBMgr != null && this.healthDAO.DBMgr.Rs != null)
			{
				bContinue = true;
			}
		}
	}
	
%>

<%
    // 운동종목 매핑
    String exerciseType = ComMgr.IsNull(HealthDTO.getType_exercise(), "none");
    String exerciseImageSrc = "";
    String exerciseAltText = "";

    switch (exerciseType) {
        case "walk":
            exerciseImageSrc = "walk.png";
            exerciseAltText = "걷기";
            break;
        case "run":
            exerciseImageSrc = "running.png";
            exerciseAltText = "달리기";
            break;
        case "weight":
            exerciseImageSrc = "weight.png";
            exerciseAltText = "웨이트";
            break;
        case "hiking":
            exerciseImageSrc = "hiking.png";
            exerciseAltText = "등산";
            break;
        case "cycling":
            exerciseImageSrc = "cycling.png";
            exerciseAltText = "자전거";
            break;
        default:
            exerciseImageSrc = "question.png";
            exerciseAltText = "";
            break;
    }
%>
<body>
 	<%----------------------------------------------------------------------
	[HTML Page - FORM 디자인 영역]
	--------------------------------------------------------------------------%>
    <form class="main-content" name="form1" method="post">
        <div class="content-header">
            <h1>건강기록</h1>
            <div class="date-display">
                <input type="date" id="textdate" name="textdate" value="<%=sHealthDate%>" onchange="document.form1.submit()">
                <input type="hidden" id="textuserid" name="textuserid" value="<%=nUserId%>">
            </div>
        </div>
        <div class="content-navigation">
            <button class="nav-button prev">&lt;</button>
            <button class="nav-button next">&gt;</button>
            <button type="button" class="cancel-button" id="deleteRecordButton">기록삭제</button>
        </div>
        <div class="add-record">
            <button class="add-button" type="button">
                <span class="plus-icon">+</span>
            </button>
        </div>
        
        <!-- 선택 메뉴 -->
        <div class="select-menu" id="selectMenu">
            <div class="select-option" data-type="water">음수량</div>
            <div class="select-option" data-type="exercise">운동기록</div>
            <div class="select-option" data-type="sleep">수면기록</div>
            <div class="select-option" data-type="vitamin">영양제</div>
        </div>
        
        <!-- 모달 템플릿 -->
        <div class="modal" id="recordModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 id="modalTitle"></h2>
                    <button class="close-button">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- 모달 내용은 JavaScript에서 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="save-button" onclick="saveRecord()">저장</button>
                    <button type="button" class="cancel-button" onclick="closeModal()">취소</button>
                </div>
            </div>
        </div>
        
        <div class="health-record">
        <h3>음수량</h3>
        <br>
        <hr>
        <br>
        <p>목표 음수량 : <%=ComMgr.IsNull(HealthDTO.getGoal_water(), 0)*500%> ml | 달성 음수량 : <%=ComMgr.IsNull(HealthDTO.getAchieved_water(), 0)*500%> ml</p>
        </div>
        
        <div class="health-record">
        <h3>운동기록</h3>
        <br>
        <hr>
        <br>
	    <p>운동종목 : 
	        <img src="<%=exerciseImageSrc%>" alt="<%=exerciseAltText%>" style="width:30px; height:30px;">
	        <%=exerciseAltText%>
	    </p>
        <p>목표 운동시간 : <%=ComMgr.IsNull(HealthDTO.getGoal_exercise(), 0)*30%> 분 | 달성 운동시간 : <%=ComMgr.IsNull(HealthDTO.getAchieved_exercise(), 0)*30%> 분</p>
        </div>
        
        <div class="health-record">
        <h3>수면기록</h3>
        <br>
        <hr>
        <br>
        <p>취침시간 : <%=ComMgr.IsNull(HealthDTO.getBedtime(), "")%> | 기상시간 : <%=ComMgr.IsNull(HealthDTO.getWaketime(), "")%> </p>
        </div>
        
    </form>
 	<%----------------------------------------------------------------------
	[HTML Page - END]
	--------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역(하단)]
	[외부 자바스크립트 연결(각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
    <script src="Health.js"></script>
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
</body>
</html> 