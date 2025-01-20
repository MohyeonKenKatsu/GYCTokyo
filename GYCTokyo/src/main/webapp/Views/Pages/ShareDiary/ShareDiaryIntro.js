document.addEventListener("DOMContentLoaded", function () {
	const divModalFrame = document.getElementById("divModalFrame");
	const iframe = document.getElementById("ifModalWindow");
	
	// 디버깅: 선택된 요소 확인
	console.log("Clicked Outside Modal");

	// iframe이 로드되었을 때 실행
	iframe.onload = function() {
		const iframeDoc = iframe.contentDocument || iframe.contentWindow.document; // iframe 내부 문서 접근
		
		const NewGroupCancel = iframeDoc.querySelector(".NewGroupCancel");
		const NewGroupButton = iframeDoc.querySelector(".NewGroupButton");
		
		const InviteGroupCancel = iframeDoc.querySelector(".InviteGroupCancel");
		const InviteGroupButton = iframeDoc.querySelector(".InviteGroupButton");
		
		console.log("New Group Cancel:", NewGroupCancel);
		console.log("New Group Button:", NewGroupButton);
		
		console.log("Group Invite Cancel:", InviteGroupCancel);
		console.log("Group Invite Button:", InviteGroupButton);
	
		// "그룹 생성 취소" 버튼 클릭 시 모달 닫기
	
		if (NewGroupCancel) {
			NewGroupCancel.addEventListener("click", function () {
			divModalFrame.style.display = "none"; // 모달창 숨기기
			});
		}
		
		// "그룹 생성" 버튼 클릭 시 동작 추가 (옵션)
		if (NewGroupButton) {
		    NewGroupButton.addEventListener("click", function () {
		        alert("그룹이 생성되었습니다!");
		        divModalFrame.style.display = "none"; // 모달창 숨기기
				setTimeout(function () {location.reload(true);}, 850);
		    });
		}
		
		// "그룹 초대 취소" 버튼 클릭 시 모달 닫기
		if (InviteGroupCancel) {
			InviteGroupCancel.addEventListener("click", function () {
			divModalFrame.style.display = "none"; // 모달창 숨기기
			});
		}
		
		// "그룹 초대" 버튼 클릭 시 동작 추가 (옵션)
		if (InviteGroupButton) {
		    InviteGroupButton.addEventListener("click", function () {
		        alert("사용자가 초대되었습니다!");
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