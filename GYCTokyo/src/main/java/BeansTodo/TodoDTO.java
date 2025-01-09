package BeansTodo;

public class TodoDTO {

   /** jobstatus   : Beans 작업상태 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) **/
   private String jobstatus = null;
   /** todo_id         : Beans 캘린 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer todo_id = 0;
   /** user_id            : Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer user_id = 0;
   /** todo_date            : Beans 캘린더 일정만들기 모달창 일정명 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String todo_date = null;
   /** todo         : Beans 캘린더 일정만들기 모달창 날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String todo = null;
public String getJobstatus() {
	return jobstatus;
}
public void setJobstatus(String jobstatus) {
	this.jobstatus = jobstatus;
}
public Integer getTodo_id() {
	return todo_id;
}
public void setTodo_id(Integer todo_id) {
	this.todo_id = todo_id;
}
public Integer getUser_id() {
	return user_id;
}
public void setUser_id(Integer user_id) {
	this.user_id = user_id;
}
public String getTodo_date() {
	return todo_date;
}
public void setTodo_date(String todo_date) {
	this.todo_date = todo_date;
}
public String getTodo() {
	return todo;
}
public void setTodo(String todo) {
	this.todo = todo;
}
   
   
}