<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/TodoModal.css">

<div id="todoModal" class="modal">
    <div class="modalContent">
        <div class="modalHeader">
            <h2>오늘의 할일</h2>
        </div>
        <div class="modalBody">
            <form id="todoForm">
                <label for="todoDate">날짜</label>
                <input type="date" id="todoDate" name="todoDate" />

                <label for="todoText">할일</label>
                <input type="text" id="todoText" name="todoText" placeholder="할 일을 입력하세요" />
            </form>
        </div>
        <div class="modalFooter">
            <button class="todoModalButtonCancel">취소</button>
            <button class="modalButtonSave">저장</button>
        </div>
    </div>
</div>


