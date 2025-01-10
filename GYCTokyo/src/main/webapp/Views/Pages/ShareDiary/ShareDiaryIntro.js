document.addEventListener("DOMContentLoaded", function () {
	const modal = document.getElementById("modal");
	const GroupPlusButton = document.querySelector(".GroupPlusButton");
	const NewGroupCancel = document.querySelector(".NewGroupCancel");
	const NewGroupButton = document.querySelector(".NewGroupButton");
	
	// 디버깅: 선택된 요소 확인
	console.log("Modal Element:", modal);
	console.log("Group Plus Button:", GroupPlusButton);
	console.log("New Group Cancel:", NewGroupCancel);
	console.log("Clicked Outside Modal");
	
	// "글쓰기" 버튼 클릭 시 모달 열기
	if (GroupPlusButton) {
	    GroupPlusButton.addEventListener("click", function () {
	        modal.style.display = "block"; // 모달창 보이기
	    });
	}
	
	// "취소" 버튼 클릭 시 모달 닫기

	if (NewGroupCancel) {
		NewGroupCancel.addEventListener("click", function () {
		modal.style.display = "none"; // 모달창 숨기기
		});
	}

	// 모달 외부 클릭 시 모달 닫기
	window.addEventListener("click", function (event) {
	    if (event.target === modal) {
	        modal.style.display = "none"; // 모달창 숨기기
	    }
	});
	
	// "저장" 버튼 클릭 시 동작 추가 (옵션)
	if (NewGroupButton) {
	    NewGroupButton.addEventListener("click", function () {
	        alert("그룹이 생성되었습니다!");
	        modal.style.display = "none"; // 모달창 숨기기
	    });
	}
	
});	