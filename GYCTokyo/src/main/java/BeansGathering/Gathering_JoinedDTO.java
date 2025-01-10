package BeansGathering;

public class Gathering_JoinedDTO {
	
	/** group_id			: Beans 그룹 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private Integer group_id = 0;
	/** user_id				: Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private Integer user_id = 0;
	/** is_joined			: Beans 모임 참여 여부 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
	private String is_joined = null;
	
	
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
	public String getIs_joined() {
		return is_joined;
	}
	public void setIs_joined(String is_joined) {
		this.is_joined = is_joined;
	}
	
}
