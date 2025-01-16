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
            
           <form action="Index.jsp?JobProcess=true&jobstatus=INSERT" method="post">
		   <!-- DB Insert를 알리는 파라미터 -->
		   <input type="hidden" name="JobProcess" value="true">
		   <input type="hidden" name="jobStatus" value="INSERT">
		   
		   <label for="title">제목</label>
    	   <input type="text" id="title" name="title" placeholder="제목을 입력하세요." class="title-input">
    	   <hr>
                <div class="form-group flex-row">
                    <label for="start_date">모집 시작 날짜</label>
                    <input type="date" id="start_date" name="start_date">
                </div>
                <div class="form-group flex-row">
                    <label for="finish_date">모집 종료 날짜</label>
                    <input type="date" id="finish_date" name="finish_date">
                </div>
                <div class="form-group flex-row">
                    <label for="activity_date">활동일</label>
                    <input type="date" id="activity_date" name="activity_date">
                </div>
                <div class="form-group flex-row">
                    <label for="number_limit">모집 인원수</label>
                    <select id="number_limit" name="number_limit">
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
                    <label for="content">상세내용</label>
                    <textarea id="content" name="content" rows="5" placeholder="시간 : O월 OO일 OO시
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
