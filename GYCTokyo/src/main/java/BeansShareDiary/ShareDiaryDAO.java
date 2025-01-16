//#################################################################################################
//SawonDAO.java - 사원검색 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansShareDiary;

import java.util.ArrayList;

import Common.ComMgr;
import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ShareDiaryDAO	: 그룹 내 공유일기 Bean DAO 클래스<br>
* Inheritance	: None
***********************************************************************/
public class ShareDiaryDAO
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
	 * ShareDiaryDAO()	: 생성자
	 * @param void		: None
	 ***********************************************************************/
	public ShareDiaryDAO()
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
	 * ReadShareDiaryGroupList()	: 오라클 데이터베이스에서 내가 속한 그룹 리스트 읽기
	 * @param Sabun					: 사번(조건용)
	 * @param sawonDTO	: 사원정보 DTO(결과 반환용)
	 * @return boolean	: 사원정보 검색 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadShareDiaryGroupList(ShareDiaryDTO shareDiaryDTO) throws Exception
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
				// 공유일기 리스트 읽기
				sSql = "BEGIN SP_SHAREGROUP_R(?,?); END;";
				// sSql = "{call SP_MAN_R(?,?,?,?,?,?)}";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[1];
				
				oPaValue[0] = shareDiaryDTO.getUserId();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
				{
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
	 * ReadShareDiaryInGroupList()	: 오라클 데이터베이스에서 공유일기 읽기
	 * @param ShareDiaryDTO	: 공유일기 DTO(조건용)
	 * @return boolean	: 공유일기 리스트 검색 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadShareDiaryInGroupList(ShareDiaryDTO shareDiaryDTO) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 공유일기 리스트 읽기
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				// 공유일기 리스트 읽기
				sSql = "BEGIN SP_SHAREDAIRY_R(?,?,?,?); END;";
				// sSql = "{call SP_MAN_R(?,?,?,?,?,?)}";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[3];
				
				oPaValue[0] = shareDiaryDTO.getDate();
				oPaValue[1] = shareDiaryDTO.getGroupId();
				oPaValue[2] = -1;
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 4, true) == true)
				{
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
	 * ReadSawonList()	: 오라클 데이터베이스에서 사원정보 읽기
	 * @param sawonDTO	: 사원정보 DTO(조건용)
	 * @param Sawons	: 사원정보 DTO(결과 반환용)
	 * @return boolean	: 사원정보 검색 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
/*	public boolean ReadSawonList(SawonDTO sawonDTO, ArrayList<SawonDTO> Sawons) throws Exception
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
				sSql = "BEGIN SP_MAN_R(?,?,?,?,?,?); END;";
				// sSql = "{call SP_MAN_R(?,?,?,?,?,?)}";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[5];
				
				oPaValue[0] = 0;
				oPaValue[1] = "-1";
				oPaValue[2] = sawonDTO.getAge();
				oPaValue[3] = sawonDTO.getGender();
				oPaValue[4] = sawonDTO.getDept();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 6, true) == true)
				{
					while(this.DBMgr.Rs.next() == true)
					{
						SawonDTO Sawon = new SawonDTO();
						
						Sawon.setSabun(this.DBMgr.Rs.getInt("Sabun"));
						Sawon.setName(ComMgr.IsNull(this.DBMgr.Rs.getString("Name"), "").trim());
						Sawon.setAge(this.DBMgr.Rs.getInt("Age"));
						Sawon.setGender(ComMgr.IsNull(this.DBMgr.Rs.getString("Gender"), "").trim());
						Sawon.setTel(ComMgr.IsNull(this.DBMgr.Rs.getString("Tel"), "").trim());
						Sawon.setDept(ComMgr.IsNull(this.DBMgr.Rs.getString("Dept"), "").trim());
						Sawon.setDeptname(ComMgr.IsNull(this.DBMgr.Rs.getString("DeptName"), "").trim());
						Sawon.setStcd(ComMgr.IsNull(this.DBMgr.Rs.getString("StCd"), "").trim());
						Sawon.setStcdname(ComMgr.IsNull(this.DBMgr.Rs.getString("StCdName"), "").trim());
						Sawon.setBdate(ComMgr.IsNull(this.DBMgr.Rs.getString("BDate"), "").trim());
						Sawon.setAddress(ComMgr.IsNull(this.DBMgr.Rs.getString("Address"), "").trim());
						
						Sawons.add(Sawon);
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
	}*/
	/***********************************************************************
	 * SaveShareDiaryNewGroup()	: 오라클 데이터베이스에 새 그룹명 저장
	 * @param shareDiaryDTO		: 공유일기 DTO(저장용)
	 * @return boolean		: 사원정보 저장 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean SaveShareDiaryNewGroup(ShareDiaryDTO shareDiaryDTO) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 사원정보 저장(JobStatus : INSERT)
	    	// -----------------------------------------------------------------------------
			if (this.DBMgr.DbConnect() == true)
			{
				sSql = "BEGIN SP_SHAREGROUP_C(?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				
				oPaValue[0] = shareDiaryDTO.getGroupname();
				oPaValue[1] = shareDiaryDTO.getUserId();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true)
				{
					this.DBMgr.DbCommit();
					
					bResult = true;
				}
			}
	    	// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			Common.ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		finally
		{
			this.DBMgr.DbDisConnect();
		}
		
		return bResult;
	}
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
