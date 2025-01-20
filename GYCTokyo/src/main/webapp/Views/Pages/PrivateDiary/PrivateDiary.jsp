<%@page import="BeansPrivateDiary.PrivateDiaryDTO"%>
<%@page import="BeansPrivateDiary.PrivateDiaryDAO"%>
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
    <title>마음일기</title>
	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css?version=1.1"/>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/index.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Header/Header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/PrivateDiary/PrivateDiary.css">
	<style type="text/css">
		/* -----------------------------------------------------------------
			HTML Page 스타일시트
		   ----------------------------------------------------------------- */
			
        /* ----------------------------------------------------------------- */
	</style>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역 (상단)]
	[외부 자바스크립트 연결 (각각) : <script type="text/javascript" src="Hello.js"></script>]
	--------------------------------------------------------------------------%>
	<script type="text/javascript">
		// -----------------------------------------------------------------
		// [브라우저 갱신 완료 시 호출 할 이벤트 핸들러 연결 - 필수]
		// -----------------------------------------------------------------
		// window.onload = function () { DocumentInit('페이지가 모두 로드되었습니다!'); }
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
	// 사원정보 검색용 DAO 객체
	public PrivateDiaryDAO privateDiaryDAO = new PrivateDiaryDAO();
	// ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[JSP 지역 변수 선언 및 로직 구현 영역 - 스크립트릿 영역]
	- this 로 접근 불가 : 같은 페이지가 여러번 갱신되면 변수/함수 유지 안 됨
	- 즉 현재 페이지가 여러번 갱신 될 때마다 스크립트릿 영역이 다시 실행되어 모두 초기화 됨
------------------------------------------------------------------------------%>
<%	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 웹 페이지 get/post 파라미터]
	// ---------------------------------------------------------------------
	String  sJobStatus		= null;				// 작업상태(Insert | Update | Delete)
	Boolean bJobProcess 	= null;				// 작업 진행 여부
	// 기본 정보 변수
	Integer user_id			= null;				// 작성자
	String pd_date			= null;				// 개인일기 날짜
	String pd_content		= null;				// 글내용
	String emoji			= null;				// 이모지
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
    sJobStatus = ComMgr.IsNull(request.getParameter("JobStatus"), ""); // 작업 상태 (INSERT, UPDATE, DELETE)
	bJobProcess = ComMgr.IsNull(request.getParameter("JobProcess"), false); // 작업 진행 여부
	
	// 작업상태 파라미터 확인
	user_id = ComMgr.IsNull(session.getAttribute("USER_ID"), 123); // 작성자 ID
    pd_date = ComMgr.IsNull(request.getParameter("today"), ""); // 개인 일기 날짜
    pd_content = ComMgr.IsNull(request.getParameter("content"), ""); // 일기 내용
    emoji = ComMgr.IsNull(request.getParameter("weather"), ""); // 이모지

	// 작업처리 파라미터 확인
    // ---------------------------------------------------------------------
	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
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
	<jsp:useBean id="PrivateDiaryDTO" class="BeansPrivateDiary.PrivateDiaryDTO" scope="request"></jsp:useBean>
	
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
	<jsp:setProperty name="HelloDTO" property="data2"/>--%>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법3	: Beans 메서드 직접 호출
						:---------------------------------------------------
						: Beans 메서드를 각각 직접 호출 해야함!
	--------------------------------------------------------------------------%>

<%
	if (bJobProcess) {
		PrivateDiaryDTO.setUser_id(user_id);
		PrivateDiaryDTO.setPd_date(pd_date);
		PrivateDiaryDTO.setPd_content(pd_content);
		PrivateDiaryDTO.setEmoji(emoji);
	}
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	if (bJobProcess) {
	    if (this.privateDiaryDAO.PrivateDiaryInsert(PrivateDiaryDTO)) {
	        out.println("<script>alert('일기가 성공적으로 저장되었습니다!');</script>");
	    } else {
	        out.println("<script>alert('일기 저장에 실패했습니다. 다시 시도해주세요.');</script>");
	}
}
%>
<body>
    <!-- 헤더 포함 -->
    <%@ include file="/Views/Components/Header/Header.jsp" %>

    <div style="display: flex;">
        <!-- 사이드바 포함 -->
        <%@ include file="/Views/Components/Sider/Sider.jsp" %>

        <!-- 메인 콘텐츠 -->
        <section class="diary-content">
            <div class="diary-header">
                <h2 class="diary-title">마음일기</h2>
                <div class="date-display">
                    <span id="currentDate"></span>
                </div>
            </div>

           <div class="add-entry"></div>
		    <button class="add-button" id="openModalButton">
		        <span class="plus-icon">+</span>
		    </button>
		
		<!-- 일기 카드 리스트 -->

			<%@ page import="BeansPrivateDiary.PrivateDiaryDTO" %>
			<%@ page import="BeansPrivateDiary.PrivateDiaryDAO" %>
			<%@ page import="java.util.List" %>
			
			<%
			    PrivateDiaryDAO diaryDAO = new PrivateDiaryDAO();
			    List<PrivateDiaryDTO> diaryList = diaryDAO.getAllPrivateDiaries();
			%>
			
			<div class="diary-entries">
		    <h2>모든 마음일기</h2>
		    <% for (PrivateDiaryDTO diary : diaryList) { %>
		        <div class="diary-entry" >
		            <!-- 날짜만 표시 -->
		            <h3><%= diary.getPd_date().split(" ")[0] %></h3>
		            <p><strong>날씨:</strong> <%= diary.getEmoji() %></p>
		            <p><strong>내용:</strong> <%= diary.getPd_content() %></p>
		        </div>
		    <% } %>
			</div>

    	

    <!-- 모달창 -->
    <form action="PrivateDiary.jsp?JobProcess=true" method="post">
	    <div class="modal" id="diaryModal">
	        <div class="modal-header">일기 쓰기</div>
	        <label for="today">날짜를 선택하세요</label>
	        <input type="date" id="today" name="today" required>
	
	        <div class="weather-icons">
	            날씨를 선택하세요
	            <div class="sun-icon" data-weather="맑음">☀️</div>
	            <div class="rain-icon" data-weather="비">🌧️</div>
	            <div class="cloud-icon" data-weather="흐림">☁️</div>
	            <div class="snow-icon" data-weather="눈">❄️</div><br>
	            <span class="selected-weather-icon" id="selectedWeatherIcon">선택없음</span>
	            <input type="hidden" id="weather" name="weather">
	        </div>
	        <div class="modal-body">
	            <textarea id="content" name="content" placeholder="오늘 하루는 어땠나요? 마음일기를 자유롭게 작성해주세요."></textarea>
	        </div>
	        <div class="modal-footer">
	            <button class="cancel-button" id="closeModalButton">취소</button>
	            <button class="save-button" type="submit">저장</button>
	        </div>
	    </div>
    </form>

    <!-- 알림창 -->
    <div class="alert-modal" id="alertModal">
        <div class="alert-message">
            작성한 내용이 저장되지 않았습니다.<br>
            정말 작성을 취소하시겠습니까?<br>
            (작성 취소 확인 버튼 클릭)
        </div>
        <div class="alert-buttons">
            <button class="cancel-button" id="cancelAlertButton">취소</button>
            <button class="confirm-button" id="confirmAlertButton">확인</button>
        </div>
    </div>
    <div class="alert-backdrop" id="alertBackdrop"></div>

    <script>
    // 오늘 날짜 표시
    const currentDateElement = document.getElementById('currentDate');
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0].replace(/-/g, '.'); // YYYY.MM.DD 형식
    currentDateElement.textContent = formattedDate;

    // 모달 열고 닫기
    const openModalButton = document.getElementById('openModalButton');
    const closeModalButton = document.getElementById('closeModalButton');
    const modal = document.getElementById('diaryModal');

    // 알림창 요소
    const alertModal = document.getElementById('alertModal');
    const alertBackdrop = document.getElementById('alertBackdrop');
    const cancelAlertButton = document.getElementById('cancelAlertButton');
    const confirmAlertButton = document.getElementById('confirmAlertButton');

    // 성공 알림창 모달 생성
    const successModal = document.createElement('div');
    successModal.id = 'successModal';
    successModal.classList.add('modal');
    successModal.innerHTML = `
        <div class="modal-header">저장 완료</div>
        <div class="modal-body">
            일기가 성공적으로 저장되었습니다!
        </div>
        <div class="modal-footer">
            <button class="close-button" id="closeSuccessModalButton">확인</button>
        </div>
    `;
    document.body.appendChild(successModal);

    const closeSuccessModalButton = document.getElementById('closeSuccessModalButton');

    openModalButton.addEventListener('click', () => {
        modal.style.display = 'block';
    });

    closeModalButton.addEventListener('click', () => {
        // 취소 버튼 클릭 시 알림창 표시
        alertModal.style.display = 'block';
        alertBackdrop.style.display = 'block';
    });

    // 알림창 "취소" 버튼 클릭 시 알림창 닫기
    cancelAlertButton.addEventListener('click', () => {
        alertModal.style.display = 'none';
        alertBackdrop.style.display = 'none';
    });

    // 알림창 "확인" 버튼 클릭 시 작성 모달 닫기
    confirmAlertButton.addEventListener('click', () => {
        alertModal.style.display = 'none';
        alertBackdrop.style.display = 'none';
        modal.style.display = 'none'; // 작성 모달도 닫음
    });

    // 날씨 선택 기능
    const weatherIcons = document.querySelectorAll('.weather-icons div');
    const selectedWeatherIcon = document.getElementById('selectedWeatherIcon');
    const selectedWeather = document.getElementById('weather');

    weatherIcons.forEach((icon) => {
        icon.addEventListener('click', () => {
            // 선택된 날씨 아이콘 표시
            selectedWeatherIcon.innerHTML = icon.outerHTML;
            selectedWeather.value = icon.innerText;

            // 스타일 업데이트
            weatherIcons.forEach(i => i.style.color = ''); // 모든 아이콘 초기화
            icon.style.color = '#007bff'; // 선택된 아이콘 강조
        });
    });
    
	// 일기 조회 페이지로 이동 
    const viewDiaryButton = document.getElementById('PrivateDiaryButton');

    viewDiaryButton.addEventListener('click', () => {
        
        window.location.href = '/GYCTokyo/Views/Pages/PrivateDiary/ViewPrivateDiary.jsp';
    });
    
 	// 20자 이상인 내용은 '...'으로 처리
    document.querySelectorAll('.diary-content').forEach((content) => {
        const text = content.textContent.trim();
        if (text.length > 20) {
            content.textContent = text.slice(0, 20) + '...'; // 20자 이후는 '...' 추가
        }
    });

	 
</script>