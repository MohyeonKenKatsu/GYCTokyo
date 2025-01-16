package BeansPrivateDiary;

public class PrivateDiaryDTO {

   /** jobstatus   : Beans 작업상태 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
   private String jobstatus = null;
   /** pd_date         : Beans 개인일기 날짜 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String pd_date = null;
   /** user_id         : Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer user_id = 0;
   /** pd_content      : Beans 내용 입력 모달창 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String pd_content = null;
   /** emoji           : Beans 날씨 이모지 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String emoji = null;
   

	public String getJobstatus()
	{
		return jobstatus;
	}
	public void setJobstatus(String jobstatus)
	{
		this.jobstatus = jobstatus;
	}
	public String getPd_date()
	{
		return pd_date;
	}
	public void setPd_date(String pd_date)
	{
		this.pd_date = pd_date;
	}
	public Integer getUser_id()
	{
		return user_id;
	}
	public void setUser_id(Integer user_id)
	{
		this.user_id = user_id;
	}
	public String getPd_content()
	{
		return pd_content;
	}
	public void setPd_content(String pd_content)
	{
		this.pd_content = pd_content;
	}
	public String getEmoji()
	{
		return emoji;
	}
	public void setEmoji(String emoji)
	{
		this.emoji = emoji;
	}
 
}