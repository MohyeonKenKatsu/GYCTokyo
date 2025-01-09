package BeansHealth;

public class HealthDTO {

   
   /** group_id         : Beans 그룹 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer group_id = 0;
   /** user_id            : Beans 유저 아이디 필드 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private Integer user_id = 0;
   /** title            : Beans 모임만들기 모달창 제목 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String title = null;
   /** start_date         : Beans 모임만들기 모달창 시작날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String start_date = null;
   /** finish_date         : Beans 모임만들기 모달창 종료날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String finish_date = null;
   /** activity_date      : Beans 모임만들기 모달창 활동날짜 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String activity_date = null;
   /** number_limit      : Beans 모임만들기 모달창 모집인원 수(최대) (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String number_limit = null;
   /** content            : Beans 모임만들기 모달창 상세내용 (JSP 입력 객체와 1:1 대응, 소문자로 시작)*/
   private String content = null;
   
   
}
