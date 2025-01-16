<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>건강기록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
    <link rel="stylesheet" href="Health.css">
</head>
<body>
    <main class="main-content">
        <div class="content-header">
            <h1>건강기록</h1>
            <div class="date-display">
                <span id="currentDate"></span>
            </div>
        </div>
        <div class="content-navigation">
            <button class="nav-button prev">&lt;</button>
            <button class="nav-button next">&gt;</button>
        </div>
        <div class="add-record">
            <button class="add-button">
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
        
        <div id="waterSection" class="health-record">
        <p>음수량</p>
        <p>목표 음수량 : ml | 달성 음수량 : ml</p>
        </div>
        
        <div id="exerciseSection" class="health-record">
        <p>운동기록</p>
		<p>운동종목 : </p>
        <p>목표 운동시간 : 분 | 달성 운동시간 : 분</p>
        </div>
        
        <div id="sleepSection" class="health-record">
        <p>수면기록</p>
        <p>취침시간 :  | 기상시간 : </p>
        </div>
        
    </main>
    <script src="Health.js"></script>
</body>
</html> 