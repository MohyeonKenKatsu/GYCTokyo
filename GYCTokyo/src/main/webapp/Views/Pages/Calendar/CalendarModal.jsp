<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- CalendarModal.jsp -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/CalendarModal.css">

<div id="modal" class="modal">
    <div class="modalContent">
        <div class="modalHeader">
            <h2>일정명</h2>
        </div>
        <div class="modalBody">
            <form id="modalForm">
                <label for="date">날짜</label>
                <input type="date" id="date" name="date" />

                <label for="category">카테고리</label>
                <select id="category" name="category">
                    <option value="GYC">GYC 일정</option>
                    <option value="기타">개인 일정</option>
                </select>

                <label for="memo">메모</label>
                <textarea id="memo" name="memo"></textarea>
            </form>
        </div>
        <div class="modalFooter">
            <button class="calendarModalButtonCancel">취소</button>
            <button class="modalButtonSave">저장</button>
        </div>
    </div>
</div>
