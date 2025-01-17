// #################################################################################################
// UsersDTO.java - USERS 테이블 정보 전달용 DTO
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansHealth;

import Common.ExceptionMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * UsersDTO	: 기본 DTO 클래스<br>
 * Inheritance	: None
 ***********************************************************************/
public class HealthDTO
{
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역상수 관리 - 필수영역
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(정적변수)
	// —————————————————————————————————————————————————————————————————————————————————————
    
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(인스턴스변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// 현재 작업상태
	private String jobstatus				= null;

	// 건강기록 날짜
	private String health_date 				= null;
	
	// 사용자 아이디 
	private Integer user_id 				= null;
	
	// 목표 음수량
	private String 	goal_water	 			= null;
	
	// 달성 음수량
	private String 	achieved_water 			= null;
	
	// 운동 종류
	private String 	type_exercise 			= null;
	
	// 목표 운동기록
	private String goal_exercise	 		= null;
	
	// 달성 운동기록
	private String achieved_exercise 		= null;
	
	// 취침시간
	private String 	bedtime		 			= null;
	
	// 기상시간
	private String waketime			 		= null;

	// —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * UsersDTO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public HealthDTO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
    }
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(정적함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	public String getJobstatus() {
		return jobstatus;
	}

	public void setJobstatus(String jobstatus) {
		this.jobstatus = jobstatus;
	}
	
	public String getHealth_date() {
		return health_date;
	}

	public void setHealth_date(String health_date) {
		this.health_date = health_date;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getGoal_water() {
		return goal_water;
	}

	public void setGoal_water(String goal_water) {
		this.goal_water = goal_water;
	}

	public String getAchieved_water() {
		return achieved_water;
	}

	public void setAchieved_water(String achieved_water) {
		this.achieved_water = achieved_water;
	}

	public String getType_exercise() {
		return type_exercise;
	}

	public void setType_exercise(String type_exercise) {
		this.type_exercise = type_exercise;
	}

	public String getGoal_exercise() {
		return goal_exercise;
	}

	public void setGoal_exercise(String goal_exercise) {
		this.goal_exercise = goal_exercise;
	}

	public String getAchieved_exercise() {
		return achieved_exercise;
	}

	public void setAchieved_exercise(String achieved_exercise) {
		this.achieved_exercise = achieved_exercise;
	}

	public String getBedtime() {
		return bedtime;
	}

	public void setBedtime(String bedtime) {
		this.bedtime = bedtime;
	}

	public String getWaketime() {
		return waketime;
	}

	public void setWaketime(String waketime) {
		this.waketime = waketime;
	}
}
// #################################################################################################
// <END>
// #################################################################################################
