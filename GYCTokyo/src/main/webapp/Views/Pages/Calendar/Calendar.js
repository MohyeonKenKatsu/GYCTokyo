document.addEventListener("DOMContentLoaded", function () {
    const cancelButton = document.querySelector(".calendarModalButtonCancel");
    const saveButton = document.querySelector(".modalButtonSave"); //class로 가져오기
    const deleteButton = document.getElementById("deleteModal"); //id로 가져오기

    // 디버깅: 버튼 확인
    console.log("Cancel Button:", cancelButton);
    console.log("Save Button:", saveButton);
    console.log("Delete Button:", deleteButton);

    // "취소" 버튼 클릭 시 동작
    if (cancelButton) {
        cancelButton.addEventListener("click", function () {
            console.log("Cancel Button Clicked");
            window.location.href = `${contextPath}/Views/Pages/Calendar/index.jsp`;
        });
    }

    // "저장" 버튼 클릭 시 동작
    if (saveButton) {
        saveButton.addEventListener("click", function () {
            alert("일정이 저장되었습니다!");
            window.location.href = `${contextPath}/Views/Pages/Calendar/index.jsp`;
        });
    }

    // "삭제" 버튼 클릭 시 동작
    if (deleteButton) {
        deleteButton.addEventListener("click", function () {
            console.log("Delete Button Clicked");

            const urlParams = new URLSearchParams(window.location.search);
            const calendarId = urlParams.get("calendar_id");
            const userId = urlParams.get("user_id");

            if (!calendarId || !userId) {
                alert("유효하지 않은 요청입니다.");
                return;
            }

            if (confirm("정말로 이 일정을 삭제하시겠습니까?")) {
                fetch(`${contextPath}/Views/Pages/Calendar/DeleteCalendarEvent.jsp`, {
                    method: "POST",
                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
                    body: `calendar_id=${encodeURIComponent(calendarId)}&user_id=${encodeURIComponent(userId)}`,
                })
                    .then((response) => response.json())
                    .then((result) => {
                        if (result.success) {
                            alert("일정이 삭제되었습니다.");
                            window.close(); // 모달 닫기
                            opener.location.reload(); // 부모 창 새로고침
                        } else {
                            alert("일정 삭제에 실패했습니다.");
                        }
                    })
                    .catch((error) => {
                        console.error("Error:", error);
                        alert("서버와 통신 중 문제가 발생했습니다.");
                    });
            }
        });
    }
});
