<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 조회</title>
    <link rel="stylesheet" href="ViewGatheringModal.css">
</head>
<body>
    <div class="modal" id="modal">
        <div class="modal-content">
            <h2>카모미 팟 모집</h2>
            <div class="form-group">
                <p><strong>모집시작날짜</strong>: 2024/11/23</p>
                <p><strong>모집종료날짜</strong>: 2024/11/30</p>
                <p><strong>활동일</strong>: 2024/12/27</p>
            </div>
            <!-- 상세내용 섹션 -->
            <hr class="section-line">
            <div class="form-group">
                <p><strong>상세내용</strong></p>
                <p>시간 : 11월 23일 18시<br>
                장소 : 독서실 앞<br>
                내용 : 카모미 보라 갈건데 다들 보러 갈 사람 현금 들고 뛰어오시도록</p>
            </div>
            <hr class="section-line">
            <!-- 댓글 섹션 -->
            <div class="comment-section">
                <div class="comment-header">
                    <h3>댓글</h3>
                    <div class="comment-input-container">
                        <input type="text" id="comment-input" placeholder="댓글을 입력하세요">
                        <button type="button" id="submit-comment">등록</button>
                    </div>
                </div>
                <div class="comments">
                    <div class="comment-item">
                        <strong class="username">1234</strong>
                        <span class="comment-text">근데 현금 얼마 들고가야하는데?</span>
                        <span class="time">18:50</span>
                    </div>
                    <div class="comment-item">
                        <strong class="username">아오지</strong>
                        <span class="comment-text">나도 갈래 근데 19시에 참여 가능?</span>
                        <span class="time">13:20</span>
                    </div>
                    <div class="comment-item">
                        <strong class="username">탄광</strong>
                        <span class="comment-text">갈거</span>
                        <span class="time">11:00</span>
                    </div>
                </div>
            </div>
            <div class="button-group">
                <button class="reset-btn" onclick="location.href='Index.jsp'">취소</button>
                <button class="submit-btn">참가</button>
            </div>
        </div>
    </div>
</body>
</html>
