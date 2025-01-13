//#################################################################################################
//GatheringDAO.java - 소모임 내용 DB INSERT 및 내용 가져오기 DAO클래스
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansGathering;
import java.util.ArrayList;
import Common.ComMgr;
import Common.ExceptionMgr;
import DAO.DBOracleMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* GatheringDAO	: 소모임 내용 DB INSERT 및 내용 가져오기 DAO클래스
* Inheritance	: None | 부모 클래스 명
***********************************************************************/
public class GatheringDAO
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
	public DBOracleMgr DBMgr = null;
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * GatheringDAO()	: 생성자
	 * @param void		: None
	 ***********************************************************************/
	public GatheringDAO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			
			this.DBMgr = new DBOracleMgr();
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
	 * GatheringSave()		: 모임 모집글을 오라클 데이터베이스에 저장
	 * @param JobStatus		: 모집글 작업 상태(Insert|Update|Delete)
	 * @param GatheringId	: 모집글 Id
	 * @param GatheringDTO	: 모집글 DTO 객체
	 * @return boolean		: true | false
	 ***********************************************************************/
	public boolean GatheringSave(String JobStatus, int GatheringId, GatheringDTO gatheringDTO)
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
					bResult = GatheringDetailInsert(gatheringDTO);				// 모집글 등록
					
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
	 * GatheringDetailInsert()	: 모임 모집글을 오라클 데이터베이스에 등록(Insert)
	 * @param GatheringDTO		: 모집글 DTO 객체
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean GatheringDetailInsert(GatheringDTO gatheringDTO)
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		int GatheringId = 0;					// 모집글 ID
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 모집글 등록
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				// 모집글 ID 추출
				sSql = "SELECT SEQ_GATHERING_ID.NEXTVAL AS GatheringId FROM DUAL";
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true) == true)
				{
					if (this.DBMgr != null && this.DBMgr.Rs != null)
					{
						if (this.DBMgr.Rs.next() == true)
						{
							GatheringId = this.DBMgr.Rs.getInt("GatheringId");
							
							// 모집글 등록
							sSql = "BEGIN SP_GATHERING_CUD(?,?,?,?,?,?,?,?,?); END;";
							
							// IN 파라미터 만큼만 할당
							oPaValue = new Object[9];
							
							oPaValue[0] = "INSERT";
							oPaValue[1] = GatheringId;
							oPaValue[2] = gatheringDTO.getUser_id();
							oPaValue[3] = gatheringDTO.getTitle();
							oPaValue[4] = gatheringDTO.getStart_date();
							oPaValue[5] = gatheringDTO.getFinish_date();
							oPaValue[6] = gatheringDTO.getActivity_date();
							oPaValue[7] = gatheringDTO.getNumber_limit();
							oPaValue[8] = gatheringDTO.getContent();
							
							if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true)
							{
								
								this.DBMgr.DbCommit();
								
								bResult = true;
							}
						}
					}
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
	/***********************************************************************
	 * GatheringDetailUpdate()	: 모집글을 오라클 데이터베이스에서 수정(Update)
	 * @param GatheringId		: 모집글 Id
	 * @param GatheringDTO		: 모집글 DTO 객체
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean GatheringDetailUpdate(int GatheringId, GatheringDTO gatheringDTO)
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
	/***********************************************************************
	 * GatheringDetailDelete()	: 모집글을 오라클 데이터베이스에서 삭제(Delete)
	 * @param GatheringId		: 모집글 Id
	 * @return boolean		: true | false
	 ***********************************************************************/
	public boolean GatheringDetailDelete(int GatheringId)
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 모집글 삭제
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				// 모집글 삭제
				sSql = "BEGIN SP_GATHERING_CUD(?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				
				oPaValue[0] = "DELETE";
				oPaValue[1] = GatheringId;
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true)
				{
					
					// IN 파라미터 만큼만 할당
					oPaValue = new Object[2];
					
					oPaValue[0] = "DELETE";
					oPaValue[1] = GatheringId;
					
					if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true)
					{
						this.DBMgr.DbCommit();
					
						bResult = true;
					}
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


	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################

