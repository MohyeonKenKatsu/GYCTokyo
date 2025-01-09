document.addEventListener('DOMContentLoaded', function() {
	 // 현재 날짜 표시
	 const today = new Date();
	 const dateDisplay = document.getElementById('currentDate');
	 const year = today.getFullYear();
	 const month = String(today.getMonth() + 1).padStart(2, '0');
	 const day = String(today.getDate()).padStart(2, '0');
	 dateDisplay.textContent = `${year}.${month}.${day}`;
	 const formattedDate = today.toLocaleDateString('ko-KR', {
	     year: 'numeric',
	     month: '2-digit',
	     day: '2-digit'
	 }).split(' ').join('').replace(/\./g, '');
	 
	 const finalDate = formattedDate.slice(0, 4) + '.' + 
	                  formattedDate.slice(4, 6) + '.' + 
	                  formattedDate.slice(6, 8);
	 
	 dateDisplay.textContent = finalDate;

    // 내비게이션 버튼 이벤트
    const prevButton = document.querySelector('.prev');
    const nextButton = document.querySelector('.next');
    
    prevButton.addEventListener('click', () => {
        // 이전 날짜로 이동
    });
    
    nextButton.addEventListener('click', () => {
        // 다음 날짜로 이동
    });

    // 선택 메뉴와 모달 관련 요소
    const addButton = document.querySelector('.add-button');
    const selectMenu = document.getElementById('selectMenu');
    const modal = document.getElementById('recordModal');
    const modalTitle = document.getElementById('modalTitle');
    const closeButton = document.querySelector('.close-button');

    // + 버튼 클릭 시 선택 메뉴 표시
	addButton.addEventListener('click', (e) => {
	    const buttonRect = addButton.getBoundingClientRect();

	    // 버튼 바로 옆으로 선택 메뉴 위치 지정
	    selectMenu.style.top = `${buttonRect.top}px`; // 버튼과 수평 정렬
	    selectMenu.style.left = `${buttonRect.right + 10}px`; // 버튼 오른쪽에 약간 떨어져 표시 (10px 여백)

	    selectMenu.classList.add('active'); // 메뉴 활성화
	    e.stopPropagation(); // 이벤트 전파 방지
	});

    // 선택 메뉴 항목 클릭 이벤트
    document.querySelectorAll('.select-option').forEach(option => {
        option.addEventListener('click', () => {
            const type = option.dataset.type;
            openModal(type);
            selectMenu.classList.remove('active');
        });
    });

    // 모달 열기 함수
    function openModal(type) {
        const titles = {
            water: '음수량',
            exercise: '운동기록',
            sleep: '수면기록',
            vitamin: '영양제'
        };
        
        modalTitle.textContent = titles[type];
        modal.classList.add('active');
        
        const modalBody = modal.querySelector('.modal-body');
        modalBody.innerHTML = getModalContent(type);
    }

    // 모달 내용 생성 함수
    function getModalContent(type) {
        switch(type) {
            case 'water':
                return `
                    <div class="input-group">
                        <label>음수량 (ml)</label>
                        <input type="number" name="waterAmount" placeholder="음수량을 입력하세요">
                    </div>
                `;
            case 'exercise':
                return `
                    <div class="input-group">
                        <label>운동 종류</label>
                        <input type="text" name="exerciseType" placeholder="운동 종류를 입력하세요">
						
						<div style="height: 15px;"></div>
						
                        <label>운동 시간 (분)</label>
                        <input type="number" name="exerciseTime" placeholder="운동 시간을 입력하세요">
                    </div>
                `;
            case 'sleep':
                return `
                    <div class="input-group">
                        <label>취침 시간</label>
                        <input type="time" name="sleepTime">
						
						<div style="height: 15px;"></div>
						
                        <label>기상 시간</label>
                        <input type="time" name="wakeTime">
                    </div>
                `;
            case 'vitamin':
                return `
                    <div class="input-group">
                        <label>영양제 이름</label>
                        <input type="text" name="vitaminName" placeholder="영양제 이름을 입력하세요">
						
						<div style="height: 15px;"></div> 
						
                        <label>섭취량</label>
                        <input type="text" name="vitaminAmount" placeholder="섭취량을 입력하세요">
                    </div>
                `;
            default:
                return '<p>준비 중입니다.</p>';
        }
    }

    // 저장 함수
    window.saveRecord = function() {
        const type = modalTitle.textContent;
        const formData = new URLSearchParams();
        
        const inputs = modal.querySelectorAll('input');
        inputs.forEach(input => {
            formData.append(input.name, input.value);
        });
        
        formData.append('type', type);
        
        fetch('saveNewHealth.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData.toString()
        })
        .then(response => response.json())
        .then(data => {
            if(data.success) {
                alert('저장되었습니다.');
                modal.classList.remove('active');
            } else {
                alert('저장에 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('저장 중 오류가 발생했습니다.');
        });
    };

	// 모달 닫기
	window.closeModal = function() {
	    modal.classList.remove('active');
	};

	closeButton.addEventListener('click', () => {
	    closeModal();
	});

    // 외부 클릭 시 선택 메뉴와 모달 닫기
    document.addEventListener('click', (e) => {
        if (!selectMenu.contains(e.target) && !addButton.contains(e.target)) {
            selectMenu.classList.remove('active');
        }
        if (e.target === modal) {
            modal.classList.remove('active');
        }
    });
}); 