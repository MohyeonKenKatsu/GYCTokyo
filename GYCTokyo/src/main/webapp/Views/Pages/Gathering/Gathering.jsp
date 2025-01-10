<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>소모임</title>
    <link rel="stylesheet" href="Gathering.css">
    
</head>
<body>

    <div class="main-container">
        <div class="main-content">
            <header>
                <h1 class="title">소모임</h1>
                <p class="date">2024.12.09</p>
            </header>

            <section class="event-header">
                <h2>함께 만드는 특별한 순간들</h2>
            </section>

            <div class="create-event">
                <button class="create-btn" onclick="location.href='NewGatheringModal.jsp'">모임 만들기</button>
            </div>
            
            <div class="event-cards">
                <div class="event-card" onclick="location.href='ViewGatheringModal.jsp'">
                    <h3>카모미 팟 모집</h3>
                    <p>시간: 12월 23일 18시</p>
                    <p>장소: 독서실 앞</p>
                    <p>내용: 카모미 보라각근데...</p>
                    <button>참가</button>
                    <span class="participant-count">11/15</span> <!-- 인원 수 추가 -->
                </div>
                <div class="event-card" onclick="location.href='ViewGatheringModal.jsp'">
                    <h3>마라상귀 먹어 모집</h3>
                    <p>시간: 12월 20일 19시</p>
                    <p>장소: 317호 앞</p>
                    <p>내용: 마라장량에서 시칼...</p>
                    <button>참가</button>
                    <span class="participant-count">11/15</span> <!-- 인원 수 추가 -->
                </div>
                <div class="event-card" onclick="location.href='ViewGatheringModal.jsp'">
                    <h3>마라상귀 먹어 모집</h3>
                    <p>시간: 11월 23일 18시</p>
                    <p>장소: 독서실 앞</p>
                    <p>내용: 카모미 보라각근데...</p>
                    <button>참가</button>
                    <span class="participant-count">11/15</span> <!-- 인원 수 추가 -->
                </div>
                <div class="event-card" onclick="location.href='ViewGatheringModal.jsp'">
                    <h3>퀴퀴로우 먹어 모집</h3>
                    <p>시간: 12월 2일 19시</p>
                    <p>장소: 바쿠스홀</p>
                    <p>내용: 꿔바로우를 먹자...</p>
                    <button>참가</button>
                    <span class="participant-count">11/15</span> <!-- 인원 수 추가 -->
                </div>
                <div class="event-card" onclick="location.href='ViewGatheringModal.jsp'">
                    <h3>일본어공부 모임</h3>
                    <p>시간: 11월 20일 19시</p>
                    <p>장소: 바쿠스홀</p>
                    <p>내용: 일본어 공부 모임...</p>
                    <button>참가</button>
                    <span class="participant-count">11/15</span> <!-- 인원 수 추가 -->
                </div>
            </div>

            <div class="footer">
                <button class="footer-btn" onclick="location.href='FinishedGathering.jsp'">끝난 모임 보기</button>
            </div>
        </div>
    </div>

</body>
</html>