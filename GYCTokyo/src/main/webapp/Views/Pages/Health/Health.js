document.addEventListener('DOMContentLoaded', function() {

    // 내비게이션 버튼 이벤트
    const prevButton = document.querySelector('.prev');
    const nextButton = document.querySelector('.next');
    
    prevButton.addEventListener('click', () => {
        // 이전 날짜로 이동
		const textdate = document.getElementById('textdate');

		date = textdate.value.split('-');

		d = new Date(parseInt(date[0]), date[1]-1, date[2]);

		d.setDate(d.getDate() - 1);

		year = d.getFullYear().toString();
		month = (d.getMonth()+1).toString();
		month = month.length == 1 ? '0' + month : month;
		month = '-' + month + '-';
		day = d.getDate().toString();
		day = day.length == 1 ? '0' + day : day;

		textdate.value = year+month+day;
    });
    
    nextButton.addEventListener('click', () => {
        // 다음 날짜로 이동
		const textdate = document.getElementById('textdate');
		
		date = textdate.value.split('-');
		
		d = new Date(parseInt(date[0]), date[1]-1, date[2]);
		
		d.setDate(d.getDate() + 1);
		
		year = d.getFullYear().toString();
		month = (d.getMonth()+1).toString();
		month = month.length == 1 ? '0' + month : month;
		month = '-' + month + '-';
		day = d.getDate().toString();
		day = day.length == 1 ? '0' + day : day;
		
		textdate.value = year+month+day;
    });
	
	const deleteButton = document.getElementById('deleteRecordButton');
	const textDate = document.getElementById('textdate').value;
	const userId = document.getElementById('textuserid').value;

	deleteButton.addEventListener('click', () => {
	    if (confirm(`${textDate}의 기록을 삭제하시겠습니까?`)) {
	        fetch('DeleteHealthRecord.jsp', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded',
	            },
	            body: `health_date=${encodeURIComponent(textDate)}&user_id=${encodeURIComponent(userId)}`,
	        })
	            .then(response => response.json())
	            .then(data => {
	                if (data.success) {
	                    alert('기록이 삭제되었습니다.');
	                    location.reload();
	                } else {
	                    alert('기록 삭제에 실패했습니다.');
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert('삭제 중 오류가 발생했습니다.');
	            });
	    }
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
		
	document.addEventListener('change', function (event) {
		   if (event.target.id === 'achievedExerciseTime') {
		       updateExerciseProgress();
		    }
		});
		
		// 수면시간 계산 이벤트
		document.addEventListener('change', function (event) {
		    if (event.target.id === 'wakeTime' || event.target.id === 'sleepTime') {
		        console.log('수면시간 계산 이벤트 호출됨'); // 디버깅용 로그
		        calculateSleepDuration();
		    }
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

	    modalTitle.textContent = titles[type]; // 제목 설정
	    modal.classList.add('active'); // 모달 활성화

	    const modalBody = modal.querySelector('.modal-body');
	    modalBody.innerHTML = ''; // 기존 내용을 초기화
	    modalBody.innerHTML = getModalContent(type); // 새로운 내용 삽입
	}

    // 모달 내용 생성 함수
    function getModalContent(type) {
		let textdate = document.getElementById('textdate').value;
		let textuserid = document.getElementById('textuserid').value;
		
        switch(type) {
            case 'water':
                return `
					<div id="waterBottleContainer" style="margin-top: 15px;"></div>
					<div style="height: 15px;"></div>

						<div class="input-group">
                        <label>오늘의 목표 음수량을 알려주세요! (ml)</label>
						<input type="hidden" name="jobstatus" value="WATER">
						<input type="hidden" name="textdate" value="` + textdate + `">
						<input type="hidden" name="textuserid" value="` + textuserid + `">
						<div style="height: 5px;"></div>
						<select id="goalWater" name="goal_water" onchange="updateWaterBottles(this.value)" required>
						    <option value=""> &nbsp;선택하세요&nbsp; </option>
						    <option value="1"> 500 ml </option>
						    <option value="2"> 1000 ml </option>
						    <option value="3"> 1500 ml </option>
						    <option value="4"> 2000 ml </option>
						    <option value="5"> 2500 ml </option>
						    <option value="6"> 3000 ml </option>
						</select>
						
						<div style="height: 15px;"></div>

						<label>오늘 성공한 음수량을 알려주세요! (ml)</label>
						<select id="achievedWater" name="achieved_water" required>
						<div style="height: 5px;"></div>
						    <option value=""> &nbsp;선택하세요&nbsp; </option>
						    <option value="1"> 500 ml </option>
						    <option value="2"> 1000 ml </option>
						    <option value="3"> 1500 ml </option>
						    <option value="4"> 2000 ml </option>
						    <option value="5"> 2500 ml </option>
						    <option value="6"> 3000 ml </option>
						</select>
                    </div>
					
					<div id="commentContainer" style="margin-top: 15px; font-size: 20px; color: #666;"></div>
					<div id="commentContainerDetail" style="margin-top: 15px; font-size: 16px; color: #666;"></div>

                `;
				    
				case 'exercise':
				    return `
				        <div class="exercise-icons">
				            <img src="walk.png" alt="걷기" data-type="walk" onclick="selectExerciseType(this)">
				            <img src="running.png" alt="달리기" data-type="run" onclick="selectExerciseType(this)">
				            <img src="weight.png" alt="웨이트" data-type="weight" onclick="selectExerciseType(this)">
				            <img src="hiking.png" alt="등산" data-type="hiking" onclick="selectExerciseType(this)">
				            <img src="cycling.png" alt="자전거" data-type="cycling" onclick="selectExerciseType(this)">
				        </div>
						<input type="hidden" id="selectedExerciseType" name="type_exercise">
				        <div class="input-group">
				            <label>오늘의 목표 운동시간을 알려주세요!</label>
							<input type="hidden" name="jobstatus" value="EXERCISE">
							<input type="hidden" name="textdate" value="` + textdate + `">
							<input type="hidden" name="textuserid" value="` + textuserid + `">
				            <select id="goalExerciseTime" name="goal_exercise">
				                <option value="">선택하세요</option>
				                <option value="1">30분</option>
				                <option value="2">60분</option>
				                <option value="3">90분</option>
				            </select>
				        </div>
				        <div class="input-group">
				            <label>오늘의 성공한 운동시간을 알려주세요!</label>
				            <select id="achievedExerciseTime" name="achieved_exercise">
				                <option value="">선택하세요</option>
				                <option value="1">30분</option>
				                <option value="2">60분</option>
				                <option value="3">90분</option>
				            </select>
				        </div>
				        <div id="exerciseProgressBar" class="progress-bar">
				            <div id="exerciseProgressFill" class="progress-fill"></div>
				        </div>
				        <p id="exerciseComment" class="exercise-comment"></p>
				    `;
					case 'sleep':
					    return `
					        <div class="input-group">
					            <label>취침시간을 알려주세요!</label>
								<input type="hidden" name="jobstatus" value="SLEEP">
								<input type="hidden" name="textdate" value="` + textdate + `">
								<input type="hidden" name="textuserid" value="` + textuserid + `">
					            <input type="time" id="sleepTime" name="bedtime">
					            <div style="height: 15px;"></div>
					            <label>기상시간을 알려주세요!</label>
					            <input type="time" id="wakeTime" name="waketime">
					        </div>
					        <p id="sleepDurationComment" style="margin-top: 15px; font-size: 16px; color: #666;"></p>
					    `;
				        default:
				            return '<p>준비 중입니다.</p>';
				    }
				}	
				
	document.addEventListener('change', function(event) {
	    const target = event.target;
	    if (target.id === 'goalWater') { // 목표 음수량 선택 시 물병 출력
	        updateWaterBottles(target.value);
	    }
		if (target.id === 'achievedWater') {
		    updateAchievedWater(target.value); // 달성 음수량 선택 시 물병 상태 변경
		}
	});
	
	
	// 선택한 음수량에 따라 빈 물통 이미지를 업데이트하는 함수 추가
	function updateWaterBottles(value) {
	    const container = document.getElementById('waterBottleContainer');
	    container.innerHTML = ''; // 기존 이미지 초기화

	    const bottleCount = parseInt(value, 10); // 선택된 value를 숫자로 변환
	    if (!bottleCount || bottleCount < 1 || bottleCount > 6) return; // 유효하지 않은 선택 방지

	    for (let i = 0; i < bottleCount; i++) {
	        const img = document.createElement('img');
	        img.src = `bottle.png`; 
	        img.alt = `빈 물통 ${500 * (i + 1)}ml`;
			img.classList.add('water-bottle');
	        img.style.margin = '5px'; 
	        img.style.width = '65px'; 
	        container.appendChild(img);
	    }
	}
	
	function updateAchievedWater(value) {
	    const bottles = document.querySelectorAll('.water-bottle'); // 모든 물통 이미지 선택
	    const achievedCount = parseInt(value, 10); // 선택된 달성 음수량을 숫자로 변환
	    const goalCount = parseInt(document.getElementById('goalWater').value, 10); // 목표 음수량 가져오기
	    const commentContainer = document.getElementById('commentContainer'); // 코멘트 영역

	    if (!achievedCount || achievedCount < 1 || achievedCount > bottles.length) return; // 유효하지 않은 선택 방지

	    // 물통 상태 변경
	    bottles.forEach((bottle, index) => {
	        if (index < achievedCount) {
	            bottle.src = `bottleBlue.png`; // 물이 찬 물통 이미지
	            bottle.alt = `물이 찬 물통 ${500 * (index + 1)}ml`;
	        } else {
	            bottle.src = `bottle.png`; // 빈 물통 이미지
	            bottle.alt = `빈 물통 ${500 * (index + 1)}ml`;
	        }
	    });

	    // 목표와 달성 음수량 비교
	    if (achievedCount >= goalCount) {
			commentContainer.textContent = "🎉 축하합니다! 목표 음수량을 달성했습니다!"; // 성공 메시지
			commentContainer.style.color = "green"; // 성공 색상
			commentContainerDetail.textContent = "충분한 수분 섭취는체온을 조절하며, 땀과 소변을 통해 노폐물을 효과적으로 배출합니다. 혈액 순환을 개선해 세포에 산소와 영양소를 원활히 공급하고, 소화를 도와 변비를 예방합니다. 피부는 수분을 공급받아 탄력을 유지하고 건강한 상태를 지속할 수 있습니다. 관절과 근육의 윤활 역할을 하여 운동 시 부상을 방지하며, 신진대사를 촉진해 에너지 생산을 지원합니다. 또한, 뇌 기능을 활성화해 집중력과 기억력을 높이는 데 기여합니다.";
			commentContainerDetail.style.color = "black";
	    } else {
	        commentContainer.textContent = "😔 오늘의 목표 음수량을 달성하지 못했습니다."; // 실패 메시지
	        commentContainer.style.color = "red"; // 실패 색상
			commentContainerDetail.textContent = "수분 섭취가 부족하면 탈수가 발생하며 산소와 영양소 공급이 원활하지 않아 피로와 어지럼증을 유발할 수 있습니다. 신장이 소변 농도를 높이면서 노폐물 배출이 어려워지고, 변비가 생길 가능성도 커집니다. 피부가 건조해지고 탄력이 떨어지며 뇌 기능이 저하되어 집중력과 기억력이 감소하며, 심할 경우 두통과 혼란 상태를 초래할 수 있습니다. 심박수와 체온 조절 능력도 저하되어 심각한 건강 문제로 이어질 수 있습니다.";
			commentContainerDetail.style.color = "black";
	    }
	}

	// 기록 저장 함수
	window.saveRecord = function () {
	    const formData = new URLSearchParams();

	    // 모달 제목에서 type 값 추출
	    const type = modalTitle.textContent.trim();
	    formData.append('type', type);

	    // 모달 내부 입력값 수집
	    const inputs = modal.querySelectorAll('input, select');
	    inputs.forEach(input => {
	        if (input.name) {
	            formData.append(input.name, input.value || ""); // 빈 값도 처리
	        }
	    });

	    console.log("전송할 데이터:", formData.toString()); // 디버깅 로그

	    fetch('saveHealth.jsp', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body: formData.toString(),
	    })
	        .then(response => response.json())
	        .then(data => {
	            console.log("서버 응답 데이터:", data);
	            if (data.success) {
	                alert('저장되었습니다.');
	                modal.classList.remove('active');
					parent.form1.submit();
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

function selectExerciseType(element) {
    const icons = document.querySelectorAll('.exercise-icons img');
    icons.forEach(icon => icon.classList.remove('selected'));
    element.classList.add('selected');

    // 선택된 운동종류를 hidden input에 저장
    const selectedType = element.getAttribute('data-type');
    const hiddenInput = document.getElementById('selectedExerciseType');
    if (hiddenInput) {
        hiddenInput.value = selectedType;
    } else {
        const input = document.createElement('input');
        input.type = 'hidden';
        input.id = 'selectedExerciseType';
        input.name = 'type_exercise';
        input.value = selectedType;
        document.body.appendChild(input); // body에 추가
    }

    console.log('선택된 운동종류:', selectedType); // 디버깅용
}


function updateExerciseProgress() {
    const goalTime = document.getElementById('goalExerciseTime').value;
    const achievedTime = document.getElementById('achievedExerciseTime').value;

    if (!goalTime || !achievedTime) {
        return; // 값이 없을 경우 진행률 바를 업데이트하지 않음
    }

    // 진행률 계산
    const progressBar = document.getElementById('exerciseProgressFill');
    const percentage = (achievedTime / goalTime) * 100;

    // 진행률 바 업데이트
    progressBar.style.width = `${Math.min(percentage, 100)}%`; // 최대 100%로 제한

    // 코멘트 업데이트
    const comment = document.getElementById('exerciseComment');
    if (percentage >= 100) {
        comment.textContent = '🎉 축하합니다! 목표 운동 시간을 달성했습니다!';
        comment.style.color = 'green';
    } else {
        comment.textContent = '😔 목표 운동 시간을 달성하지 못했습니다.';
        comment.style.color = 'red';
    }
}

// 수면시간 계산
function calculateSleepDuration() {
    const sleepTime = document.getElementById('sleepTime').value;
    const wakeTime = document.getElementById('wakeTime').value;

    if (!sleepTime || !wakeTime) {
        console.log('취침시간 또는 기상시간이 설정되지 않음');
        return;
    }

    console.log('취침시간:', sleepTime, '기상시간:', wakeTime); // 디버깅 로그

    const [sleepHours, sleepMinutes] = sleepTime.split(':').map(Number);
    const [wakeHours, wakeMinutes] = wakeTime.split(':').map(Number);

    const sleepDate = new Date();
    sleepDate.setHours(sleepHours, sleepMinutes, 0);

    const wakeDate = new Date();
    wakeDate.setHours(wakeHours, wakeMinutes, 0);

    let duration = (wakeDate - sleepDate) / (1000 * 60 * 60); // 밀리초를 시간으로 변환
    if (duration < 0) {
        duration += 24; // 자정 넘어 기상한 경우
    }

    console.log('계산된 수면시간:', duration); // 디버깅 로그

    const comment = document.getElementById('sleepDurationComment');
    comment.textContent = `오늘의 수면시간은 ${duration.toFixed(1)}시간 입니다.`;
	comment.style.fontSize = '24px';
    comment.style.color = duration >= 7 ? 'green' : 'red';
}
