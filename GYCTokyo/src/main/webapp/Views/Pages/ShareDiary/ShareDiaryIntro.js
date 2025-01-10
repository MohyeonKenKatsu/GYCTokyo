document.addEventListener("DOMContentLoaded", function () {
	const newGroupModal = document.getElementById("newGroupModal");
	const GroupPlusButton = document.querySelector(".GroupPlusButton");
	const NewGroupCancel = document.querySelector(".NewGroupCancel");
	const NewGroupButton = document.querySelector(".NewGroupButton");
	
	const inviteGroupModal = document.getElementById("inviteGroupModal");
	const GroupInviteButton = document.querySelector(".GroupInviteButton");
	const InviteGroupCancel = document.querySelector(".InviteGroupCancel");
	const InviteGroupButton = document.querySelector(".InviteGroupButton");
	
	// 디버깅: 선택된 요소 확인
	console.log("Modal Element:", newGroupModal);
	console.log("Group Plus Button:", GroupPlusButton);
	console.log("New Group Cancel:", NewGroupCancel);
	console.log("Clicked Outside Modal");
	
	console.log("Modal Element:", inviteGroupModal);
	console.log("Group Invite Button:", GroupInviteButton);
	console.log("Invite Group Cancel:", InviteGroupCancel);
	console.log("Clicked Outside Modal");
	
//"+" 버튼 모달(새 그룹 생성 모달창)
	
	// "+" 버튼 클릭 시 모달 열기
	if (GroupPlusButton) {
	    GroupPlusButton.addEventListener("click", function () {
	        newGroupModal.style.display = "block"; // 모달창 보이기
	    });
	}
	
	// "취소" 버튼 클릭 시 모달 닫기

	if (NewGroupCancel) {
		NewGroupCancel.addEventListener("click", function () {
		newGroupModal.style.display = "none"; // 모달창 숨기기
		});
	}

	// 모달 외부 클릭 시 모달 닫기
	window.addEventListener("click", function (event) {
	    if (event.target === newGroupModal) {
	        newGroupModal.style.display = "none"; // 모달창 숨기기
	    }
	});
	
	// "생성" 버튼 클릭 시 동작 추가 (옵션)
	if (NewGroupButton) {
	    NewGroupButton.addEventListener("click", function () {
	        alert("그룹이 생성되었습니다!");
	        newGroupModal.style.display = "none"; // 모달창 숨기기
	    });
	}
	
	
// "초대" 버튼 모달(그룹원 초대 모달창)

	// "초대" 버튼 클릭 시 모달 열기
	if (GroupInviteButton) {
	    GroupInviteButton.addEventListener("click", function () {
	        inviteGroupModal.style.display = "block"; // 모달창 보이기
	    });
	}	
	
	// "취소" 버튼 클릭 시 모달 닫기

	if (InviteGroupCancel) {
		InviteGroupCancel.addEventListener("click", function () {
		inviteGroupModal.style.display = "none"; // 모달창 숨기기
		});
	}
	
	// 모달 외부 클릭 시 모달 닫기
	window.addEventListener("click", function (event) {
	    if (event.target === inviteGroupModal) {
	        inviteGroupModal.style.display = "none"; // 모달창 숨기기
	    }
	});
	
	// "초대" 버튼 클릭 시 동작 추가 (옵션)
	if (InviteGroupButton) {
	    InviteGroupButton.addEventListener("click", function () {
	        alert("초대 메일이 발송되었습니다!");
	        inviteGroupModal.style.display = "none"; // 모달창 숨기기
	    });
	}
});	