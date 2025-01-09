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
                <!-- <img src="캘린더 흰색.png" alt="달력 아이콘">-->
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
    </main>
    <script src="Health.js"></script>
</body>
</html> 