document.addEventListener("DOMContentLoaded", function () {
    const todoModal = document.getElementById("todoModal");
    const todoAddButtons = document.querySelectorAll(".todoAddButton");
    const cancelTodoButton = document.querySelector(".todoModalButtonCancel");
    const saveTodoButton = document.querySelector(".modalButtonSave");

    // 디버깅: 요소 확인
    console.log("Todo Modal Element:", todoModal);
    console.log("Cancel Button Element:", cancelTodoButton);

    // "할 일 추가" 버튼 클릭 시 모달 열기
    todoAddButtons.forEach(button => {
        button.addEventListener("click", function () {
            console.log("Add Button Clicked:", button); // 디버깅 로그 추가
            if (todoModal) {
                todoModal.style.display = "block"; // 모달 보이기
            } else {
                console.error("Todo Modal not found!");
            }
        });
    });

    // "취소" 버튼 클릭 시 모달 닫기
    if (cancelTodoButton) {
        cancelTodoButton.addEventListener("click", function () {
            console.log("Cancel Button Clicked"); // 디버깅 로그 추가
            todoModal.style.display = "none"; // 모달 숨기기
        });
    } else {
        console.error("Cancel Button not found!");
    }

    // 모달 외부 클릭 시 모달 닫기
    window.addEventListener("click", function (event) {
        if (event.target === todoModal) {
            console.log("Clicked Outside Modal"); // 디버깅 로그 추가
            todoModal.style.display = "none"; // 모달창 숨기기
        }
    });

    // "저장" 버튼 클릭 시 동작 추가
    if (saveTodoButton) {
        saveTodoButton.addEventListener("click", function () {
            console.log("Save Button Clicked"); // 디버깅 로그 추가
            alert("할 일이 저장되었습니다!");
            todoModal.style.display = "none"; // 모달창 숨기기
        });
    }
});
