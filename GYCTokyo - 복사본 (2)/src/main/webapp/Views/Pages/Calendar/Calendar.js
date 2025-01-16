document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("modal");
    const openModalButton = document.querySelector(".openModalButton");
    const cancelButton = document.querySelector(".calendarModalButtonCancel");
    const saveButton = document.querySelector(".modalButtonSave");

    // 디버깅: 선택된 요소 확인
    console.log("Modal Element:", modal);
    console.log("Open Modal Button:", openModalButton);
    console.log("Cancel Button:", cancelButton);

    // "일정 추가" 버튼 클릭 시 모달 열기
    if (openModalButton) {
        openModalButton.addEventListener("click", function () {
            modal.style.display = "block"; // 모달창 보이기
        });
    }

    // "취소" 버튼 클릭 시 모달 닫기
    if (cancelButton) {
        cancelButton.addEventListener("click", function () {
            console.log("Cancel Button Clicked"); // 디버깅 로그 추가
            modal.style.display = "none"; // 모달창 숨기기
        });
    }

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener("click", function (event) {
        if (event.target === modal) {
            console.log("Clicked Outside Modal"); // 디버깅 로그 추가
            modal.style.display = "none"; // 모달창 숨기기
        }
    });

    // "저장" 버튼 클릭 시 동작 추가 (옵션)
    if (saveButton) {
        saveButton.addEventListener("click", function () {
            alert("일정이 저장되었습니다!");
            modal.style.display = "none"; // 모달창 숨기기
        });
    }
});
