//#################################################################################################
//SawonDAO.java - 사원검색 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHealth;

import java.util.ArrayList;

import BeansUsers.UsersDTO;
import Common.ComMgr;
import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* SawonDAO		: 사원검색 Bean DAO 클래스<br>
* Inheritance	: None
***********************************************************************/
public class HealthDAO
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
	/** DBMgr : 오라클 데이터베이스 DAO 객체 선언 */
	public DAO.DBOracleMgr DBMgr = null;
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * SawonDAO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public HealthDAO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			
			this.DBMgr = new DAO.DBOracleMgr();								// DAO 객체 생성
			this.DBMgr.SetConnectionStringFromProperties("db.properties");	// DB 연결문자열 읽기 
			
			//this.DBMgr.SetConnectionString("172.30.1.44", 1521, "educ", "educ", "XE");	// My
			//this.DBMgr.SetConnectionString("192.168.0.100", 1521, "educ", "educ", "XE");	// My
			//this.DBMgr.SetConnectionString("172.24.210.162", 1521, "educ", "educ", "XE");	// 301
			//this.DBMgr.SetConnectionString("172.24.162.45", 1521, "educ", "educ", "XE");	// 306
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);	// 예외처리(콘솔)
		}
	}
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(정적함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ReadSawon()		: 오라클 데이터베이스에서 사원정보 읽기
	 * @param Sabun		: 사번(조건용)
	 * @param sawonDTO	: 사원정보 DTO(결과 반환용)
	 * @return boolean	: 사원정보 검색 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadHeaderData(HealthDTO healthDTO) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 사원정보 읽기
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_HEALTH_R(?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				oPaValue[0] = healthDTO.getHealth_date();
				oPaValue[1] = healthDTO.getUser_id();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
				{
					if (this.DBMgr.Rs.next())
					{
						healthDTO.setGoal_water(this.DBMgr.Rs.getString("GOAL_WATER"));
						healthDTO.setAchieved_water(this.DBMgr.Rs.getString("ACHIEVED_WATER"));
						healthDTO.setType_exercise(this.DBMgr.Rs.getString("TYPE_EXERCISE"));
						healthDTO.setGoal_exercise(this.DBMgr.Rs.getString("GOAL_EXERCISE"));
						healthDTO.setAchieved_exercise(this.DBMgr.Rs.getString("ACHIEVED_EXERCISE"));
						healthDTO.setBedtime(this.DBMgr.Rs.getString("BEDTIME"));
						healthDTO.setWaketime(this.DBMgr.Rs.getString("WAKETIME"));
					}
					bResult = true;
				}
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
	 * saveHealthRecord()	: 오라클 데이터베이스에 건강기록 저장
	 * @param HealthDTO		: 건강기록 DTO(저장용)
	 * @return boolean		: 사원정보 저장 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean saveHealthRecord(HealthDTO healthDTO) throws Exception {
	    String sSql = null; // DML 문장
	    Object[] oPaValue = null; // DML 문장에 필요한 파라미터 객체
	    boolean bResult = false;

	    try {
	        // ----------------------------------------------------------------------
	        // DB 연결 및 SQL 실행 준비
	        // ----------------------------------------------------------------------
	        if (this.DBMgr.DbConnect()) {
	            sSql = "BEGIN SP_HEALTH_CUD(?,?,?,?,?,?,?,?,?,?); END;";

	            // 디버깅: HealthDTO 객체의 필드 확인
	            System.out.println("DAO에 전달된 health_date: " + healthDTO.getHealth_date());
	            System.out.println("DAO에 전달된 user_id: " + healthDTO.getUser_id());
	            System.out.println("DAO에 전달된 goal_water: " + healthDTO.getGoal_water());
	            System.out.println("DAO에 전달된 achieved_water: " + healthDTO.getAchieved_water());
	            System.out.println("DAO에 전달된 type_exercise: " + healthDTO.getType_exercise());
	            System.out.println("DAO에 전달된 goal_exercise: " + healthDTO.getGoal_exercise());
	            System.out.println("DAO에 전달된 achieved_exercise: " + healthDTO.getAchieved_exercise());
	            System.out.println("DAO에 전달된 bedtime: " + healthDTO.getBedtime());
	            System.out.println("DAO에 전달된 waketime: " + healthDTO.getWaketime());

	            // IN 파라미터 설정
	            oPaValue = new Object[10];
	            oPaValue[0] = healthDTO.getJobstatus();
	            oPaValue[1] = healthDTO.getHealth_date();
	            oPaValue[2] = healthDTO.getUser_id();
	            oPaValue[3] = healthDTO.getGoal_water() != null ? healthDTO.getGoal_water() : "";
	            oPaValue[4] = healthDTO.getAchieved_water() != null ? healthDTO.getAchieved_water() : "";
	            oPaValue[5] = healthDTO.getType_exercise() != null ? healthDTO.getType_exercise() : "";
	            oPaValue[6] = healthDTO.getGoal_exercise() != null ? healthDTO.getGoal_exercise() : "";
	            oPaValue[7] = healthDTO.getAchieved_exercise() != null ? healthDTO.getAchieved_exercise() : "";
	            oPaValue[8] = healthDTO.getBedtime() != null ? healthDTO.getBedtime() : "";
	            oPaValue[9] = healthDTO.getWaketime() != null ? healthDTO.getWaketime() : "";

	            // 디버깅: 파라미터 출력
	            System.out.println("SQL 파라미터: " + java.util.Arrays.toString(oPaValue));

	            // SQL 실행
	            if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false)) {
	                this.DBMgr.DbCommit();
	                bResult = true;
	            } else {
	                System.out.println("쿼리 실행 실패");
	            }
	        } else {
	            System.out.println("DB 연결 실패");
	        }
	    } catch (Exception e) {
	        System.out.println("saveHealthRecord 메서드 예외 발생: " + e.getMessage());
	        e.printStackTrace(); // 예외 상세 로그 출력
	    } finally {
	        this.DBMgr.DbDisConnect();
	    }

	    return bResult;
	}
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
