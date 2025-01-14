document.addEventListener("DOMContentLoaded", function () {
	const divModalFrame = document.getElementById("divModalFrame");
	const iframe = document.getElementById("ifModalWindow");
	
	// 디버깅: 선택된 요소 확인
	console.log("Clicked Outside Modal");
		
// iframe이 로드되었을 때 실행
	iframe.onload = function() {
		const iframeDoc = iframe.contentDocument || iframe.contentWindow.document; // iframe 내부 문서 접근
		
		const NewDiaryCancel = iframeDoc.querySelector(".NewDiaryCancel");
		const NewDiarySave = iframeDoc.querySelector(".NewDiarySave");
		
		const ViewDiaryCancel = iframeDoc.querySelector(".ViewDiaryCancel");
		const ViewDiaryChange = iframeDoc.querySelector(".ViewDiaryChange");
		
		const GroupMemberListCancel = iframeDoc.querySelector(".GroupMemberListCancel");
		
		console.log("New Diary Cancel:", NewDiaryCancel);
		console.log("New Diary Save:", NewDiarySave);
		
		console.log("View Diary Cancel:", ViewDiaryCancel);
		console.log("View Diary Change:", ViewDiaryChange);
		
		console.log("Group Member List Cancel:", GroupMemberListCancel);
	
			// "글쓰기 취소" 버튼 클릭 시 모달 닫기

			if (NewDiaryCancel) {
				NewDiaryCancel.addEventListener("click", function () {
				divModalFrame.style.display = "none"; // 모달창 숨기기
				});
			}
			
			// "글쓰기 저장" 버튼 클릭 시 동작 추가 (옵션)
			if (NewDiarySave) {
			    NewDiarySave.addEventListener("click", function () {
			        alert("일기가 저장되었습니다!");
			        divModalFrame.style.display = "none"; // 모달창 숨기기
			    });
			}
			
			// "조회 취소" 버튼 클릭 시 모달 닫기

			if (ViewDiaryCancel) {
				ViewDiaryCancel.addEventListener("click", function () {
				divModalFrame.style.display = "none"; // 모달창 숨기기
				});
			}

			// "조회 수정" 버튼 클릭 시 동작 추가 (옵션)
			if (ViewDiaryChange) {
			    ViewDiaryChange.addEventListener("click", function () {
			        alert("일기가 수정됩니다!");
			    });
			}
			
			// "그룹원 조회 취소" 버튼 클릭 시 모달 닫기

			if (GroupMemberListCancel) {
				GroupMemberListCancel.addEventListener("click", function () {
				divModalFrame.style.display = "none"; // 모달창 숨기기
				});
			}
			
	}

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener("click", function (event) {
		    if (event.target === divModalFrame) {
		        divModalFrame.style.display = "none"; // 모달창 숨기기
		    }
		});

	});	