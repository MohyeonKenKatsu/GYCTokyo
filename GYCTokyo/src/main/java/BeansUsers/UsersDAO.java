//#################################################################################################
// UsersDAO.java - 사용자(Users) 테이블 접근 DAO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansUsers;

import Common.ComMgr;
import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* UsersDAO		: 사용자(Users) 테이블 접근 BEAN DAO 클래스<br>
* Inheritance	: None
***********************************************************************/
public class UsersDAO
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
	 * UsersDAO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public UsersDAO()
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
	 * Login()			: 오라클 데이터베이스에 로그인 시도
	 * @param EMAIL		: 아이디(조건용)
	 * @param PASSWORD	: 비밀번호(조건용)
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean Login(UsersDTO usersDTO, Integer[] USER_ID_DATA) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_LOGIN(?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				
				oPaValue[0] = usersDTO.getEmail();
				oPaValue[1] = usersDTO.getPassword();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
				{
					if (this.DBMgr.Rs.next() == true) {
						USER_ID_DATA[0] = this.DBMgr.Rs.getInt("USER_ID");
						bResult = true;
					}
					else {
						bResult = false;
					}
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
	 * Signup()			: 오라클 데이터베이스에서 회원정보 저장(회원가입)
	 * @param usersdto	: 회원 정보 저장용 DTO 객체
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean Signup(UsersDTO usersdto) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_CUD(?,?,?,?,?,?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[8];
				
				oPaValue[0] = "INSERT";
				oPaValue[1] = 0;//usersdto.getUser_id();
				oPaValue[2] = usersdto.getEmail();
				oPaValue[3] = usersdto.getPassword();
				oPaValue[4] = usersdto.getNickname();
				oPaValue[5] = usersdto.getBirthday();
				oPaValue[6] = usersdto.getTel();
				oPaValue[7] = usersdto.getCourse();
				
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
		
		return bResult;
	}
	/***********************************************************************
	 * ReadHeaderData()	: 오라클 데이터베이스에서 헤더에 필요한 정보 불러오기
	 * @param sUserID	: 사용자 아이디
	 * @param usersDTO	: 회원정보 DTO(결과 반환용)
	 * @return boolean	: 사원정보 검색 처리 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadHeaderData(Integer iUSERID, UsersDTO usersDTO) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 사원정보 읽기
	    	// -----------------------------------------------------------------------------
			if (iUSERID != null)
			{
				if (this.DBMgr.DbConnect() == true)
				{
					// 사원정보 읽기
					sSql = "BEGIN SP_USERS_HEADERDATA(?,?); END;";
					
					// IN 파라미터 만큼만 할당
					oPaValue = new Object[1];
					oPaValue[0] = iUSERID;
					
					if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
					{
						while(this.DBMgr.Rs.next() == true)
						{
							usersDTO.setNickname(this.DBMgr.Rs.getString("NICKNAME"));
							usersDTO.setCourse(this.DBMgr.Rs.getInt("COURSE"));
						}
						
						bResult = true;
					}
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
	 * ReadMyPageData()	: 오라클 데이터베이스에서 마이페이지 회원정보 조회
	 * @param iUSERID	: 회원 정보 조회를 위한 사용자 아이디
	 * @param usersdto	: 회원 정보 저장용 DTO 객체
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadMyPageData(Integer iUSERID, UsersDTO usersDTO) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
	    	// -----------------------------------------------------------------------------
			// 사원정보 읽기
	    	// -----------------------------------------------------------------------------
			if (iUSERID != null)
			{
				if (this.DBMgr.DbConnect() == true)
				{
					// 사원정보 읽기
					sSql = "BEGIN SP_USERS_MYPAGEDATA(?,?); END;";
					
					// IN 파라미터 만큼만 할당
					oPaValue = new Object[1];
					oPaValue[0] = iUSERID;
					
					if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
					{
						while(this.DBMgr.Rs.next() == true)
						{
							usersDTO.setNickname(this.DBMgr.Rs.getString("NICKNAME"));
							usersDTO.setCourse(this.DBMgr.Rs.getInt("COURSE"));
							usersDTO.setTel(this.DBMgr.Rs.getString("TEL"));
							usersDTO.setPassword(this.DBMgr.Rs.getString("PASSWORD"));
						}
						
						bResult = true;
					}
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
	 * EditUserData()	: 오라클 데이터베이스에서 회원정보 수정(마이페이지)
	 * @param usersdto	: 회원 정보 저장용 DTO 객체
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean EditUserData(UsersDTO usersdto) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_CUD(?,?,?,?,?,?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[8];
				
				oPaValue[0] = "UPDATE";
				oPaValue[1] = usersdto.getUser_id();
				oPaValue[2] = "";//usersdto.getEmail();
				oPaValue[3] = usersdto.getPassword();
				oPaValue[4] = usersdto.getNickname();
				oPaValue[5] = "";//usersdto.getBirthday();
				oPaValue[6] = usersdto.getTel();
				oPaValue[7] = usersdto.getCourse();
				
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
		
		return bResult;
	}
	/***********************************************************************
	 * SearchEmail()	: 오라클 데이터베이스에서 아이디(이메일) 찾기
	 * @param usersdto	: 회원 정보 저장용 DTO 객체
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean SearchEmail(UsersDTO usersdto) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_SEARCH(?,?,?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[4];
				
				oPaValue[0] = "EMAIL";
				oPaValue[1] = "";//usersdto.getUser_id();
				oPaValue[2] = usersdto.getBirthday();
				oPaValue[3] = usersdto.getTel();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 5, true) == true)
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
	 * DuplicateEmail()	: 오라클 데이터베이스에서 중복되는 아이디(이메일)값이 있는지 확인
	 * @param usersdto	: 회원 정보 저장용 DTO 객체
	 * @return boolean	: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean DuplicateEmail(UsersDTO usersdto) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_DUPLICATE(?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				
				oPaValue[0] = "EMAIL";
				oPaValue[1] = usersdto.getEmail();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
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
	 * DuplicateNickname()	: 오라클 데이터베이스에서 중복되는 닉네임 값이 있는지 확인
	 * @param usersdto		: 회원 정보 저장용 DTO 객체
	 * @return boolean		: 로그인 성공 여부(true | false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean DuplicateNickname(UsersDTO usersdto) throws Exception
	{
		String sSql = null;						// DML 문장
		Object[] oPaValue = null;				// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 사원정보 읽기
				sSql = "BEGIN SP_USERS_DUPLICATE(?,?,?); END;";
				
				// IN 파라미터 만큼만 할당
				oPaValue = new Object[2];
				
				oPaValue[0] = "NICKNAME";
				oPaValue[1] = usersdto.getNickname();
				
				if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
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
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################
