//#################################################################################################
//BeansShareDiary.java - 그룹 내 공유일기 검색 DTO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansShareDiary;

import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ShareDiaryDTO	: 그룹 내 공유일기 DTO 클래스<br>
* Inheritance	: None
***********************************************************************/
public class ShareDiaryDTO
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
	private String date	= null;			// 날짜
	private Integer groupId	= null;		// 그룹번호
	private Integer userId = null;		// 유저번호
	private Integer contentId = null;	// 내용번호
	private String nickname = null;		// 닉네임
	private String groupname = null;	// 그룹 이름
	private String sdcontent = null;	// 내용
	private String jobStatus = null;	// 작업상태
	private String email = null;		// 이메일
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ShareDiaryDTO()	: 생성자
	 * @param void		: None
	 ***********************************************************************/
	public ShareDiaryDTO()
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
	public String getDate()
	{
		return date;
	}
	
	public void setDate(String date)
	{
		this.date = date;
	}
	
	public Integer getGroupId()
	{
		return groupId;
	}
	
	public void setGroupId(Integer groupId)
	{
		this.groupId = groupId;
	}
	
	public Integer getUserId()
	{
		return userId;
	}
	
	public void setUserId(Integer userId)
	{
		this.userId = userId;
	}

	public Integer getContentId()
	{
		return contentId;
	}
	
	public void setContentId(Integer contentId)
	{
		this.contentId = contentId;
	}

	public String getNickname()
	{
		return nickname;
	}

	public void setNickname(String nickname)
	{
		this.nickname = nickname;
	}

	public String getGroupname()
	{
		return groupname;
	}

	public void setGroupname(String groupname)
	{
		this.groupname = groupname;
	}

	public String getSdcontent()
	{
		if (sdcontent != null)
			sdcontent = sdcontent.replace("\r\n", "<br>");
		
		return sdcontent;
	}

	public void setSdcontent(String sdcontent)
	{
		this.sdcontent = sdcontent;
	}

	public String getJobStatus()
	{
		return jobStatus;
	}

	public void setJobStatus(String jobStatus)
	{
		this.jobStatus = jobStatus;
	}

	public String getEmail()
	{
		return email;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}
	
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
