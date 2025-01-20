
// #################################################################################################
// NBoardDAO.java - 게시판 DAO 모듈
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package BeansGathering;
import Common.ExceptionMgr;

// ═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
 * GatheringDTO	: 모임만들기 GatheringDTO 클래스<br>
 * Inheritance	: None | 부모 클래스 명
 ***********************************************************************/


public class GatheringDTO {
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역상수 관리 - 필수영역
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(정적변수)
	// —————————————————————————————————————————————————————————————————————————————————————
    
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(인스턴스변수)
	// —————————————————————————————————————————————————————————————————————————————————————

	/** jobstatus			: Beans 작업상태 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String jobstatus = null;
	/** group_id			: Beans 그룹 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private Integer group_id = 0;
	/** user_id				: Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private Integer user_id = 0;
	/** title				: Beans 모임만들기 모달창 제목 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String title = null;
	/** start_date			: Beans 모임만들기 모달창 시작날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String start_date = null;
	/** finish_date			: Beans 모임만들기 모달창 종료날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String finish_date = null;
	/** activity_date		: Beans 모임만들기 모달창 활동날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String activity_date = null;
	/** number_limit		: Beans 모임만들기 모달창 모집인원 수(최대) (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private Integer number_limit = 0;
	/** content				: Beans 모임만들기 모달창 상세내용 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String content = null;
	/** nickname				: Beans 사용자 닉네임 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String nickname = null;

	// —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * GatheringDTO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public GatheringDTO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 초기화 작업 관리
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
	public Integer getGroup_id() {
		return group_id;
	}
	public void setGroup_id(Integer group_id) {
		this.group_id = group_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getFinish_date() {
		return finish_date;
	}
	public void setFinish_date(String finish_date) {
		this.finish_date = finish_date;
	}
	public String getActivity_date() {
		return activity_date;
	}
	public void setActivity_date(String activity_date) {
		this.activity_date = activity_date;
	}
	public Integer getNumber_limit() {
		return number_limit;
	}
	public void setNumber_limit(Integer number_limit) {
		this.number_limit = number_limit;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
