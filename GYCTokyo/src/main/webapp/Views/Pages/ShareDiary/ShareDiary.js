document.addEventListener("DOMContentLoaded", function () {
	//"그룹원" 버튼 모달창 관련 변수
	const groupMemberListModal = document.getElementById("groupMemberListModal");
	const MemberListButton = document.querySelector(".MemberListButton");
	const GroupMemberListCancel = document.querySelector(".GroupMemberListCancel");
	
	//"글쓰기" 버튼 모달창 관련 변수
	const newSDModal = document.getElementById("newSDModal");
	const WriteButton = document.querySelector(".WriteButton");
	const NewDiaryCancel = document.querySelector(".NewDiaryCancel");
	const NewDiarySave = document.querySelector(".NewDiarySave");
	
	//"조회" 버튼 모달창 관련 변수
	const viewSDModal = document.getElementById("viewSDModal");
	const DiaryPreview = document.querySelector(".DiaryPreview");
	const ViewDiaryCancel = document.querySelector(".ViewDiaryCancel");
	const ViewDiaryChange = document.querySelector(".ViewDiaryChange");
	
	//"수정" 버튼 모달창 관련 변수
	const changeSDModal = document.getElementById("changeSDModal");
	const ChangeDiaryCancel = document.querySelector(".ChangeDiaryCancel");
	const ChangeDiaryDelete = document.querySelector(".ChangeDiaryDelete");
	const ChangeDiarySave = document.querySelector(".ChangeDiarySave");
	
	// 디버깅: 선택된 요소 확인
		//"그룹원" 버튼 모달창 디버깅
		console.log("Modal Element:", groupMemberListModal);
		console.log("Member List Button:", MemberListButton);
		console.log("Group Member List Cancel:", GroupMemberListCancel);
	
		//"글쓰기" 버튼 모달창 디버깅
		console.log("Modal Element:", newSDModal);
		console.log("Write Button:", WriteButton);
		console.log("New Diary Cancel:", NewDiaryCancel);
		console.log("New Diary Save:", NewDiarySave);
		console.log("Clicked Outside Modal");
		
		//"조회" 버튼 모달창 디버깅
		console.log("Modal Element:", viewSDModal);
		console.log("Diary Preview:", DiaryPreview);
		console.log("View Diary Cancel:", ViewDiaryCancel);
		console.log("View Diary Change:", ViewDiaryChange);
		console.log("Clicked Outside Modal");
		
		//"수정" 버튼 모달창 디버깅
		console.log("Change Diary Cancel:", ChangeDiaryCancel);
		console.log("Change Diary Delete:", ChangeDiaryDelete);
		console.log("Change Diary Save:", ChangeDiarySave);
		
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
			newSDModal.style.display = "block"; // 모달창 보이기
	    });
	}
	
	// "취소" 버튼 클릭 시 모달 닫기

	if (NewDiaryCancel) {
		NewDiaryCancel.addEventListener("click", function () {
		newSDModal.style.display = "none"; // 모달창 숨기기
		});
	}

	// 모달 외부 클릭 시 모달 닫기
	window.addEventListener("click", function (event) {
	    if (event.target === newSDModal) {
	        newSDModal.style.display = "none"; // 모달창 숨기기
	    }
	});
	
	// "저장" 버튼 클릭 시 동작 추가 (옵션)
	if (NewDiarySave) {
	    NewDiarySave.addEventListener("click", function () {
	        alert("일기가 저장되었습니다!");
	        newSDModal.style.display = "none"; // 모달창 숨기기
	    });
	}
	
//"조회" 버튼 모달(공유일기 조회 모달창)

		// "조회" 버튼 클릭 시 모달 열기
		if (DiaryPreview) {
		    DiaryPreview.addEventListener("click", function () {
				viewSDModal.style.display = "block"; // 모달창 보이기
		    });
		}
		
		// "취소" 버튼 클릭 시 모달 닫기

		if (ViewDiaryCancel) {
			ViewDiaryCancel.addEventListener("click", function () {
			viewSDModal.style.display = "none"; // 모달창 숨기기
			});
		}
		
		// "수정" 버튼 클릭 시 모달 이동

		if (ViewDiaryChange) {
			ViewDiaryChange.addEventListener("click", function () {
			viewSDModal.style.display = "none"; // 조회 모달창 숨기기
			changeSDModal.style.display = "block"; // 수정 모달창 보이기
			});
		}

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener("click", function (event) {
		    if (event.target === viewSDModal) {
		        viewSDModal.style.display = "none"; // 모달창 숨기기
		    }
		});
		
//"수정" 버튼 모달(공유일기 수정 모달창)
		
		// "취소" 버튼 클릭 시 모달 닫기

		if (ChangeDiaryCancel) {
			ChangeDiaryCancel.addEventListener("click", function () {
			changeSDModal.style.display = "none"; // 모달창 숨기기
			});
		}
		
		// "삭제" 버튼 클릭 시 동작 추가 (옵션)
		if (ChangeDiaryDelete) {
		    ChangeDiaryDelete.addEventListener("click", function () {
		        alert("일기가 삭제되었습니다!");
		        changeSDModal.style.display = "none"; // 모달창 숨기기
		    });
		}
		
		// "저장" 버튼 클릭 시 동작 추가 (옵션)
		if (ChangeDiarySave) {
		    ChangeDiarySave.addEventListener("click", function () {
		        alert("일기가 저장되었습니다!");
		        changeSDModal.style.display = "none"; // 모달창 숨기기
		    });
		}

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener("click", function (event) {
		    if (event.target === changeSDModal) {
		        changeSDModal.style.display = "none"; // 모달창 숨기기
		    }
		});	
	
});	