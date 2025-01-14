document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("modal");
    const cancelButton = document.querySelector(".calendarModalButtonCancel");
    const saveButton = document.querySelector(".modalButtonSave");

    // 디버깅: 선택된 요소 확인
    console.log("Modal Element:", modal);
    console.log("Cancel Button:", cancelButton);

    if (!cancelButton) {
        console.error("Cancel Button not found in the DOM.");
        return; // 버튼이 없으면 더 이상 진행하지 않음
    }

    // "취소" 버튼 클릭 시 동작
    cancelButton.addEventListener("click", function () {
        console.log("Cancel Button Clicked");
        window.location.href = contextPath + "/Views/Pages/Calendar/index.jsp";
    });

    // "저장" 버튼 클릭 시 동작 추가 (옵션)
    if (saveButton) {
        saveButton.addEventListener("click", function () {
            alert("일정이 저장되었습니다!");
            window.location.href = contextPath + "/Views/Pages/Calendar/index.jsp";
        });
    }
});
