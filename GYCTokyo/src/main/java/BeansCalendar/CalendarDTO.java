package BeansCalendar;

public class CalendarDTO {

   /** jobstatus   : Beans 작업상태 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) **/
   private String jobstatus = null;
   /** group_id         : Beans 캘린 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer calendar_id = 0;
   /** user_id            : Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer user_id = 0;
   /** plan            : Beans 캘린더 일정만들기 모달창 일정명 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String plan = null;
   /** calendar_date         : Beans 캘린더 일정만들기 모달창 날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String calendar_date = null;
   /** category         : Beans 캘린더 일정만들기 모달창 종료날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String category = null;
   /** memo      : Beans 캘린더 일정만들기 모달창 메모 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String memo = null;
   
   
public String getJobstatus() {
	return jobstatus;
}
public void setJobstatus(String jobstatus) {
	this.jobstatus = jobstatus;
}
public Integer getCalendar_id() {
	return calendar_id;
}
public void setCalendar_id(Integer calendar_id) {
	this.calendar_id = calendar_id;
}
public Integer getUser_id() {
	return user_id;
}
public void setUser_id(Integer user_id) {
	this.user_id = user_id;
}
public String getPlan() {
	return plan;
}
public void setPlan(String plan) {
	this.plan = plan;
}
public String getCalendar_date() {
	return calendar_date;
}
public void setCalendar_date(String calendar_date) {
	this.calendar_date = calendar_date;
}
public String getCategory() {
	return category;
}
public void setCategory(String category) {
	this.category = category;
}
public String getMemo() {
	return memo;
}
public void setMemo(String memo) {
	this.memo = memo;
}
   
   }
   