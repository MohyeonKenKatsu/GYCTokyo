//#################################################################################################
//PrivateDiaryDAO.java - 개인일기 DB INSERT 및 내용 가져오기 DAO클래스
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansPrivateDiary;
import Common.ComMgr;
import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* PrivateDiaryDAO	: 개인일기 DAO 클래스<br>
* Inheritance		: None | 부모 클래스 명
***********************************************************************/
public class PrivateDiaryDAO
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
	/** DBMgr : 오라클 데이터베이스 DAO 객체 */
	public DAO.DBOracleMgr DBMgr = null;
	/** user_id : 임시 사용자 ID */
    private int user_id = 0;
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * GatheringDAO()	: 생성자
	 * @param void		: None
	 ***********************************************************************/
	public PrivateDiaryDAO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			
			this.DBMgr = new DAO.DBOracleMgr();
			this.DBMgr.SetConnectionString("gyctokyo.duckdns.org", 1521, "educ", "educ", "XE");
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
	/***********************************************************************
	 * SavePrivateDiary()		: 모임 모집글을 오라클 데이터베이스에 저장
	 * @param JobStatus			: 모집글 작업 상태(Insert|Update|Delete)
	 * @param PrivateDiaryDTO	: 모집글 DTO 객체
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean SavePrivateDiary(String JobStatus, PrivateDiaryDTO privateDiaryDTO)
	{
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 모집글 저장
	    	// -----------------------------------------------------------------------------
			switch (JobStatus)
			{
				case "INSERT":
					bResult = PrivateDiaryInsert(privateDiaryDTO);				// 모집글 등록
					
					break;
				case "UPDATE":
					//bResult = GatheringDetailUpdate(GatheringId, gatheringDTO);	// 모집글 수정
					
					break;
				case "DELETE":
					//bResult = GatheringDetailDelete(GatheringId);				// 모집글 삭제
					
					break;
			}
	    	// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		
		return bResult;
	}
	/***********************************************************************
     * ReadDiary() : 개인일기 데이터 읽기
     * @param diaryDTO : 개인일기 DTO (결과 반환용)
     * @return boolean : 처리 결과(true | false)
     ***********************************************************************/
    public boolean ReadDiary(PrivateDiaryDTO diaryDTO) throws Exception
    {
        String sSql = null;
        Object[] oPaValue = null;
        boolean bResult = false;

        try
        {
            // 일기 정보 검색
            if (this.DBMgr.DbConnect() == true)
            {
                // 일기 정보 읽기
                sSql = "SELECT SP_DIARY_R(?, ?, ?); END;";

                // IN 파라미터 갯수 만큼 메모리 할당
                oPaValue = new Object[2];
                oPaValue[0] = this.user_id; // 임시 user_id
                oPaValue[1] = diaryDTO.getPd_date();

                if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
                {
                    while (this.DBMgr.Rs.next() == true)
                    {
                        diaryDTO.setPd_content(ComMgr.IsNull(this.DBMgr.Rs.getString("DiaryContent"), ""));
                        diaryDTO.setEmoji(ComMgr.IsNull(this.DBMgr.Rs.getString("Emotion"), ""));
                    }

                    bResult = true;
                }
            }
        }
        catch (Exception Ex)
        {
            ExceptionMgr.DisplayException(Ex);
        }

        return bResult;
    }

	
	/***********************************************************************
	 * PrivateDiaryInsert()			: 개인일기를 오라클 데이터베이스에 등록(Insert)
	 * @param PrivateDiaryDTO		: 모집글 DTO 객체
	 * @return boolean				: true | false
	 * @throws Exception 
	 ***********************************************************************/
    public boolean PrivateDiaryInsert(PrivateDiaryDTO privateDiaryDTO) throws Exception {
        String sSql = null;
        Object[] oPaValue = null;
        boolean bResult = false;

        try {
            if (this.DBMgr.DbConnect()) {
                // SQL 프로시저 호출 준비
                sSql = "BEGIN SP_PRIVATEDIARY_CUD(?, ?, ?, ?, ?); END;";

                // 파라미터 설정
                oPaValue = new Object[5];
                //oPaValue[0] = privateDiaryDTO.getJobstatus();  // 작업 상태 (INSERT, UPDATE, DELETE)
                oPaValue[0] = "INSERT";  // 작업 상태 (INSERT, UPDATE, DELETE)
                oPaValue[1] = privateDiaryDTO.getUser_id();   // 사용자 ID
                oPaValue[2] = privateDiaryDTO.getPd_date();   // 날짜
                oPaValue[3] = privateDiaryDTO.getPd_content(); // 내용
                oPaValue[4] = privateDiaryDTO.getEmoji();      // 이모지

                // SQL 실행
                if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false)) {
                    this.DBMgr.DbCommit(); // 트랜잭션 커밋
                    bResult = true;
                }
            }
        } catch (Exception Ex) {
            this.DBMgr.DbRollback(); // 예외 발생 시 롤백
            ExceptionMgr.DisplayException(Ex);
        } finally {
            this.DBMgr.DbDisConnect(); // DB 연결 해제
        }

        return bResult;
    }



	/***********************************************************************
	 * GatheringDetailUpdate()	: 모집글을 오라클 데이터베이스에서 수정(Update)
	 * @param GatheringId		: 모집글 Id
	 * @param GatheringDTO		: 모집글 DTO 객체
	 * @return boolean			: true | false
	 ***********************************************************************/
/*	public boolean GatheringDetailUpdate(int GatheringId, GatheringDTO gatheringDTO)
	{
		String sSql	= null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 모집글 수정
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				// 모집글 수정
				sSql = "BEGIN SP_GATHERING_CUD(?,?,?,?,?,?,?,?); END;";

				// IN 파라미터 만큼만 할당
				oPaValue = new Object[8];
				
				oPaValue[0] = "INSERT";
				oPaValue[1] = GatheringId;
				oPaValue[2] = gatheringDTO.getTitle();
				oPaValue[3] = gatheringDTO.getStart_date();
				oPaValue[4] = gatheringDTO.getFinish_date();
				oPaValue[5] = gatheringDTO.getActivity_date();
				oPaValue[6] = gatheringDTO.getNumber_limit();
				oPaValue[7] = gatheringDTO.getContent();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true)
				{
					
					this.DBMgr.DbCommit();
					
					bResult = true;
				}
				
				this.DBMgr.DbDisConnect();
			}
	    	// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		
		return bResult;
	} 
	***********************************************************************
	 * GatheringDetailDelete()	: 모집글을 오라클 데이터베이스에서 삭제(Delete)
	 * @param GatheringId		: 모집글 Id
	 * @return boolean		: true | false
	 ***********************************************************************/



	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################

