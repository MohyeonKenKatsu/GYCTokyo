<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마음일기</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/index.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Header/Header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Components/Sider/Sider.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/PrivateDiary/PrivateDiary.css">
</head>
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

            <div class="add-entry">
                <button class="add-button" id="openModalButton">
                    <span class="plus-icon">+</span>
                </button>
            </div>
        </section>
    </div>

    <!-- 모달창 -->
    <div class="modal" id="diaryModal">
        <div class="modal-header">일기 쓰기</div>
        <label for="today">날짜를 선택하세요</label>
        <input type="date" id="today" name="today" required>

        <div class="weather-icons">
            날씨를 선택하세요
            <i class="sun-icon" data-weather="맑음">☀️</i>
            <i class="rain-icon" data-weather="비">🌧️</i>
            <i class="cloud-icon" data-weather="흐림">☁️</i>
            <i class="snow-icon" data-weather="눈">❄️</i><br>
            <span class="selected-weather-icon" id="selectedWeatherIcon">선택없음</span>
        </div>
        <div class="modal-body">
            <textarea placeholder="오늘 하루는 어땠나요? 마음일기를 자유롭게 작성해주세요."></textarea>
        </div>
        <div class="modal-footer">
            <button class="cancel-button" id="closeModalButton">취소</button>
            <button class="save-button">저장</button>
        </div>
    </div>

    <!-- 알림창 -->
    <div class="alert-modal" id="alertModal">
        <div class="alert-message">
            지금까지 작성한 내용이 저장되지 않습니다.<br>
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
        const weatherIcons = document.querySelectorAll('.weather-icons i');
        const selectedWeatherIcon = document.getElementById('selectedWeatherIcon');

        weatherIcons.forEach((icon) => {
            icon.addEventListener('click', () => {
                // 선택된 날씨 아이콘 표시
                selectedWeatherIcon.innerHTML = icon.outerHTML;

                // 스타일 업데이트
                weatherIcons.forEach(i => i.style.color = ''); // 모든 아이콘 초기화
                icon.style.color = '#007bff'; // 선택된 아이콘 강조
            });
        });
    </script>
</body>
</html>
