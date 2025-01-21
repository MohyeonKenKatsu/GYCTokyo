//#################################################################################################
//GatheringDAO.java - 소모임 내용 DB INSERT 및 내용 가져오기 DAO클래스
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansGathering;
import java.util.ArrayList;
import java.util.List;

import BeansGathering.GatheringDTO;
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
					
					bResult = GatheringDetailDelete(GatheringId);				// 모집글 삭제
					
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
	 * GatheringDetailDelete()	: 모집글을 오라클 데이터베이스에서 삭제(Delete)
	 * @param GroupId			: 모집글 Id
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean GatheringDetailDelete(int groupId) {
	    String sSql = "BEGIN SP_GATHERING_CUD('DELETE', ?, NULL, NULL, NULL, NULL, NULL, NULL, NULL); END;";
	    Object[] oPaValue = { groupId }; // Group_id만 전달
	    boolean bResult = false;

	    try {
	        if (this.DBMgr.DbConnect() == true) {
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false)) {
	                this.DBMgr.DbCommit();
	                bResult = true; // 삭제 성공
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception ex) {
	        Common.ExceptionMgr.DisplayException(ex);
	    }

	    return bResult;
	}
	/***********************************************************************
	 * ReadGatheringById() : 특정 GROUP_ID에 해당하는 모임 정보 가져오기
	 * @param groupId      : 조회하고자 하는 GROUP_ID
	 * @return GatheringDTO: 모임 정보 DTO
	 * @throws Exception 
	 ***********************************************************************/
	public GatheringDTO ReadGatheringById(int groupId) throws Exception {
	    GatheringDTO dto = null; // 반환할 DTO 객체
	    String sSql = null;      // SQL 쿼리


	    try {
	        // DB 연결 확인
	        if (this.DBMgr.DbConnect() == true) {
	            // SQL 쿼리 작성
	        	sSql = "SELECT g.GROUP_ID, g.USER_ID, g.TITLE, " +
	        	        "TO_CHAR(g.START_DATE, 'YYYY-MM-DD') AS START_DATE, " +
	        	        "TO_CHAR(g.FINISH_DATE, 'YYYY-MM-DD') AS FINISH_DATE, " +
	        	        "TO_CHAR(g.ACTIVITY_DAY, 'YYYY-MM-DD') AS ACTIVITY_DAY, " +
	        	        "g.NUMBER_LIMIT, g.CONTENT, u.NICKNAME " +
	        	        "FROM TB_GATHERING g " +
	        	        "JOIN TB_USERS u ON g.USER_ID = u.USER_ID " +
	        	        "WHERE g.GROUP_ID = ?";
	        	
	            Object[] oPaValue = { groupId };

	            // 쿼리 실행
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true) == true) {
	                if (this.DBMgr.Rs.next()) {
	                    dto = new GatheringDTO();
	                    dto.setGroup_id(this.DBMgr.Rs.getInt("GROUP_ID"));
	                    dto.setUser_id(this.DBMgr.Rs.getInt("USER_ID"));
	                    dto.setTitle(this.DBMgr.Rs.getString("TITLE"));
	                    dto.setStart_date(this.DBMgr.Rs.getString("START_DATE"));
	                    dto.setFinish_date(this.DBMgr.Rs.getString("FINISH_DATE"));
	                    dto.setActivity_date(this.DBMgr.Rs.getString("ACTIVITY_DAY"));
	                    dto.setNumber_limit(this.DBMgr.Rs.getInt("NUMBER_LIMIT"));
	                    dto.setContent(this.DBMgr.Rs.getString("CONTENT"));
	                    dto.setNickname(this.DBMgr.Rs.getString("NICKNAME"));
	                }
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return dto;
	}
	/***********************************************************************
	 * getAllGatherings : 전체 소모임 정보 가져오기
	 * @return List<GatheringDTO> : 소모임 정보 목록
	 ***********************************************************************/
	public List<GatheringDTO> getAllGatherings() throws Exception {
	    List<GatheringDTO> gatheringList = new ArrayList<>();
	    String sSql = null;

	    try {

	        if (this.DBMgr.DbConnect() == true) {
	            // 전체 소모임 정보 가져오는 SQL 작성
	        	sSql = "SELECT GROUP_ID, USER_ID, TITLE, " +
	        		       "TO_CHAR(START_DATE, 'YYYY-MM-DD') AS START_DATE, " +
	        		       "TO_CHAR(FINISH_DATE, 'YYYY-MM-DD') AS FINISH_DATE, " +
	        		       "TO_CHAR(ACTIVITY_DAY, 'YYYY-MM-DD') AS ACTIVITY_DAY, " +
	        		       "NUMBER_LIMIT, CONTENT " +
	        		       "FROM TB_GATHERING " +
	        		       "WHERE TO_DATE(FINISH_DATE, 'YYYY-MM-DD') >= TO_DATE(SYSDATE, 'YYYY-MM-DD') " +
	        		       "ORDER BY GROUP_ID DESC";
	        	
	            if (this.DBMgr.RunQuery(sSql, null, 0, true) == true) {
	                while (this.DBMgr.Rs.next()) {
	                    GatheringDTO dto = new GatheringDTO();
	                    dto.setGroup_id(this.DBMgr.Rs.getInt("GROUP_ID"));
	                    dto.setUser_id(this.DBMgr.Rs.getInt("USER_ID"));
	                    dto.setTitle(this.DBMgr.Rs.getString("TITLE"));
	                    dto.setStart_date(this.DBMgr.Rs.getString("START_DATE"));
	                    dto.setFinish_date(this.DBMgr.Rs.getString("FINISH_DATE"));
	                    dto.setActivity_date(this.DBMgr.Rs.getString("ACTIVITY_DAY"));
	                    dto.setNumber_limit(this.DBMgr.Rs.getInt("NUMBER_LIMIT"));
	                    dto.setContent(this.DBMgr.Rs.getString("CONTENT"));
	                    gatheringList.add(dto);
	                }
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return gatheringList;
	}


	/***********************************************************************
	 * JoinGathering()			: 모임 참여 정보를 오라클 데이터베이스에 등록(Insert)
	 * @param groupId			: 그룹 ID
	 * @param userId			: 유저 ID
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean JoinGathering(int groupId, int userId) {
	    String sSql = null; // SQL 문장
	    Object[] oPaValue = null; // SQL 파라미터
	    boolean bResult = false;

	    try {
	        // DB 연결
	        if (this.DBMgr.DbConnect()) {
	            // 소모임 참가 INSERT 쿼리
	            sSql = "INSERT INTO TB_GATHERING_JOINED (GROUP_ID, USER_ID) VALUES (?, ?)";

	            // 파라미터 설정
	            oPaValue = new Object[2];
	            oPaValue[0] = groupId; // GROUP_ID
	            oPaValue[1] = userId;  // USER_ID

	            // 쿼리 실행
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false)) {
	                this.DBMgr.DbCommit();
	                bResult = true; // 성공
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex); // 예외 처리
	    }

	    return bResult;
	}
	
	/***********************************************************************
	 * CancelJoinGathering()	: 참가정보를 오라클 데이터베이스에서 삭제(Delete)
	 * @param groupId			: 모집글 Id
	 * @param userId			: 유저 Id
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean CancelJoinGathering(int groupId, int userId) {
	    String sSql = "DELETE FROM TB_GATHERING_JOINED WHERE GROUP_ID = ? AND USER_ID = ?";
	    Object[] oPaValue = { groupId, userId };
	    boolean bResult = false;

	    try {
	        if (this.DBMgr.DbConnect()) {
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false)) {
	                this.DBMgr.DbCommit();
	                bResult = true;
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return bResult;
	}
	
	/***********************************************************************
	 * IsUserJoined() 			: User가 참가하고 있는지 조회하기
	 * @param groupId    		: 그룹 Id
	 * @param userId     		: 사용자 Id
	 * @return boolean			: true | false
	 ***********************************************************************/
	public boolean IsUserJoined(int groupId, int userId) {
	    String sSql = "SELECT 1 FROM TB_GATHERING_JOINED WHERE GROUP_ID = ? AND USER_ID = ?";
	    Object[] oPaValue = { groupId, userId };
	    boolean isJoined = false;

	    try {
	        if (this.DBMgr.DbConnect()) {
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true)) {
	                isJoined = this.DBMgr.Rs.next();
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return isJoined;
	}
	
	/***********************************************************************
	 * GetParticipants() : 특정 그룹의 참가자 닉네임 목록 조회
	 * @param groupId : 그룹 Id
	 * @return List<String> : 참가자의 닉네임 목록
	 ***********************************************************************/
	public List<String> GetParticipants(int groupId) {
	    List<String> participants = new ArrayList<>();
	    String sSql = "SELECT u.NICKNAME " +
	                  "FROM TB_GATHERING_JOINED j " +
	                  "JOIN TB_USERS u ON j.USER_ID = u.USER_ID " +
	                  "WHERE j.GROUP_ID = ?";
	    Object[] oPaValue = { groupId };

	    try {
	        if (this.DBMgr.DbConnect() == true) {
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true) == true) {
	                while (this.DBMgr.Rs.next()) {
	                    participants.add(this.DBMgr.Rs.getString("NICKNAME"));
	                }
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return participants;
	}
	/***********************************************************************
	 * GetParticipantCount() 	: 특정 그룹에 참가한 사용자 수 조회
	 * @param groupId 			: 그룹 Id
	 * @return int 				: 참가한 사용자 수
	 ***********************************************************************/
	public int GetParticipantCount(int groupId) {
	    String sSql = "SELECT COUNT(*) + 1 AS PARTICIPANT_COUNT " +
	                  "FROM TB_GATHERING_JOINED " +
	                  "WHERE GROUP_ID = ?";
	    Object[] oPaValue = { groupId };
	    int count = 0;

	    try {
	        if (this.DBMgr.DbConnect() == true) {
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, true) == true) {
	                if (this.DBMgr.Rs.next()) {
	                    count = this.DBMgr.Rs.getInt("PARTICIPANT_COUNT");
	                }
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return count;
	}
	/***********************************************************************
	 * getFinishedGatherings() 	: 끝난 모임
	 * @return list 				: 참가한 사용자 수
	 ***********************************************************************/
	public List<GatheringDTO> getFinishedGatherings() throws Exception {
	    List<GatheringDTO> gatheringList = new ArrayList<>();
	    String sSql = "SELECT GROUP_ID, USER_ID, TITLE, START_DATE, FINISH_DATE, ACTIVITY_DAY, NUMBER_LIMIT, CONTENT " +
	                  "FROM TB_GATHERING " +
	                  "WHERE FINISH_DATE < SYSDATE " + // Filter based on current date
	                  "ORDER BY FINISH_DATE DESC";

	    try {
	        if (this.DBMgr.DbConnect()) {
	            if (this.DBMgr.RunQuery(sSql, null, 0, true)) {
	                while (this.DBMgr.Rs.next()) {
	                    GatheringDTO dto = new GatheringDTO();
	                    dto.setGroup_id(this.DBMgr.Rs.getInt("GROUP_ID"));
	                    dto.setUser_id(this.DBMgr.Rs.getInt("USER_ID"));
	                    dto.setTitle(this.DBMgr.Rs.getString("TITLE"));
	                    dto.setStart_date(this.DBMgr.Rs.getString("START_DATE"));
	                    dto.setFinish_date(this.DBMgr.Rs.getString("FINISH_DATE"));
	                    dto.setActivity_date(this.DBMgr.Rs.getString("ACTIVITY_DAY"));
	                    dto.setNumber_limit(this.DBMgr.Rs.getInt("NUMBER_LIMIT"));
	                    dto.setContent(this.DBMgr.Rs.getString("CONTENT"));
	                    gatheringList.add(dto);
	                }
	            }
	            this.DBMgr.DbDisConnect();
	        }
	    } catch (Exception Ex) {
	        Common.ExceptionMgr.DisplayException(Ex);
	    }

	    return gatheringList;
	}
	/***********************************************************************
	 * GatheringDetailUpdate() 	: 모임 내용 수정
	 * @param groupId 			: 그룹 Id
	 * @param gatheringDTO 			: gatheringDTO
	 * @return boolean 				: true | false
	 * @throws Exception 
	 ***********************************************************************/
	public boolean GatheringDetailUpdate(int groupId, GatheringDTO gatheringDTO) throws Exception {
	    String sSql = "UPDATE TB_GATHERING " +
	                  "SET TITLE = ?, START_DATE = ?, FINISH_DATE = ?, ACTIVITY_DAY = ?, NUMBER_LIMIT = ?, CONTENT = ? " +
	                  "WHERE GROUP_ID = ?";
	    Object[] params = {
	        gatheringDTO.getTitle(),
	        gatheringDTO.getStart_date(),
	        gatheringDTO.getFinish_date(),
	        gatheringDTO.getActivity_date(),
	        gatheringDTO.getNumber_limit(),
	        gatheringDTO.getContent(),
	        groupId
	    };

	    boolean result = false;
	    try {
	        if (this.DBMgr.DbConnect() && this.DBMgr.RunQuery(sSql, params, 0, false)) {
	            this.DBMgr.DbCommit();
	            result = true;
	        }
	    } catch (Exception ex) {
	        Common.ExceptionMgr.DisplayException(ex);
	    } finally {
	        this.DBMgr.DbDisConnect();
	    }
	    return result;
	}
	
}
	//#################################################################################################
//<END>
//#################################################################################################

