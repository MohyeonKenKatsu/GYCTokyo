<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 만들기</title>
    <link rel="stylesheet" href="NewGatheringModal.css">
</head>
<body>
    <!-- 모달 -->
    <div class="modal" id="modal">
        <div class="modal-content">
            <!-- 제목 입력칸 -->
            <input 
                type="text" 
                id="title-input" 
                placeholder="제목을 입력하세요."
                class="title-input">
            <hr>
            <form>
                <div class="form-group flex-row">
                    <label for="startDate">모집 시작 날짜</label>
                    <input type="date" id="startDate" name="startDate">
                </div>
                <div class="form-group flex-row">
                    <label for="endDate">모집 종료 날짜</label>
                    <input type="date" id="endDate" name="endDate">
                </div>
                <div class="form-group flex-row">
                    <label for="activityDate">활동일</label>
                    <input type="date" id="activityDate" name="activityDate">
                </div>
                <div class="form-group flex-row">
                    <label for="participants">모집 인원수</label>
                    <select id="participants" name="participants">
					    <option value="">선택하세요</option>
					    <option value="1">1명</option>
					    <option value="2">2명</option>
					    <option value="3">3명</option>
					    <option value="4">4명</option>
					    <option value="5">5명</option>
					    <option value="6">6명</option>
					    <option value="7">7명</option>
					    <option value="8">8명</option>
					    <option value="9">9명</option>
					    <option value="10">10명</option>
					    <option value="11">11명</option>
					    <option value="12">12명</option>
					    <option value="13">13명</option>
					    <option value="14">14명</option>
					    <option value="15">15명</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="details">상세내용</label>
                    <textarea id="details" name="details" rows="5" placeholder="시간 : O월 OO일 OO시
장소 : OO앞
내용 : 소모임에 대한 내용을 자유롭게 작성해주세요.
위의 가이드에 맞춰서 작성해주세요."></textarea>
                </div>
                <div class="button-group">
                    <button type="button" class="reset-btn" onclick="location.href='Index.jsp'">취소</button>
                    <button type="submit" class="submit-btn">등록</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
