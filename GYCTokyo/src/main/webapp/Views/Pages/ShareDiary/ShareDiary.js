document.addEventListener("DOMContentLoaded", function () {
	//"그룹원" 버튼 모달창 관련 변수
	const groupMemberListModal = document.getElementById("groupMemberListModal");
	const MemberListButton = document.querySelector(".MemberListButton");
	const GroupMemberListCancel = document.querySelector(".GroupMemberListCancel");
	
	//"글쓰기" 버튼 모달창 관련 변수
	const modal = document.getElementById("modal");
	const WriteButton = document.querySelector(".WriteButton");
	const DiaryCancel = document.querySelector(".DiaryCancel");
	const DiarySave = document.querySelector(".DiarySave");
	
	// 디버깅: 선택된 요소 확인
		//"그룹원" 버튼 모달창 디버깅
		console.log("Modal Element:", groupMemberListModal);
		console.log("Member List Button:", MemberListButton);
		console.log("Group Member List Cancel:", GroupMemberListCancel);
	
		//"글쓰기" 버튼 모달창 디버깅
		console.log("Modal Element:", modal);
		console.log("Write Button:", WriteButton);
		console.log("Diary Cancel:", DiaryCancel);
		console.log("Clicked Outside Modal");

//"그룹원" 버튼 모달(현재 그룹 그룹원 조회 모달창)

	// "그룹원" 버튼 클릭 시 모달 열기
	if (MemberListButton) {
	    MemberListButton.addEventListener("click", function () {
			groupMemberListModal.style.display = "block"; // 모달창 보이기
	    });
	}

	// "취소" 버튼 클릭 시 모달 닫기

	if (GroupMemberListCancel) {
		GroupMemberListCancel.addEventListener("click", function () {
		groupMemberListModal.style.display = "none"; // 모달창 숨기기
		});
	}
	
	// 모달 외부 클릭 시 모달 닫기
	window.addEventListener("click", function (event) {
	    if (event.target === groupMemberListModal) {
	        groupMemberListModal.style.display = "none"; // 모달창 숨기기
	    }
	});

//"글쓰기" 버튼 모달(새 공유일기 작성 모달창)

	// "글쓰기" 버튼 클릭 시 모달 열기
	if (WriteButton) {
	    WriteButton.addEventListener("click", function () {
			modal.style.display = "block"; // 모달창 보이기
	    });
	}
	
	// "취소" 버튼 클릭 시 모달 닫기

	if (DiaryCancel) {
		DiaryCancel.addEventListener("click", function () {
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
	if (DiarySave) {
	    DiarySave.addEventListener("click", function () {
	        alert("일기가 저장되었습니다!");
	        modal.style.display = "none"; // 모달창 숨기기
	    });
	}
	
});	