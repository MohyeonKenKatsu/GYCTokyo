//#################################################################################################
//CalendarDAO.java - 캘린 DAO 모듈
//#################################################################################################
package BeansCalendar;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import Common.ComMgr;
import Common.ExceptionMgr;

public class CalendarDAO {
    public DAO.DBOracleMgr DBMgr = null;

    public CalendarDAO() {
        try {
            ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
            this.DBMgr = new DAO.DBOracleMgr();
            this.DBMgr.SetConnectionStringFromProperties("db.properties");
        } catch (Exception Ex) {
            ExceptionMgr.DisplayException(Ex);
        }
    }

    public boolean addEvent(CalendarDTO calendarDTO) throws Exception {
        String sSql = null;
        Object[] oPaValue = null;
        boolean bResult = false;

        try {
            if (this.DBMgr.DbConnect() == true) {
                sSql = "BEGIN SP_CALENDAR_CUD(?, ?, ?, ?, ?, ?, ?); END;";
                oPaValue = new Object[7];
                oPaValue[0] = calendarDTO.getJobstatus();
                oPaValue[1] = calendarDTO.getCalendar_id();
                oPaValue[2] = calendarDTO.getUser_id();
                oPaValue[3] = calendarDTO.getPlan();
                oPaValue[4] = calendarDTO.getCalendar_date();
                oPaValue[5] = calendarDTO.getCategory();
                oPaValue[6] = calendarDTO.getMemo();

                if (this.DBMgr.RunQuery(sSql, oPaValue, 0, false) == true) {
                    this.DBMgr.DbCommit();
                    bResult = true;
                }
            }
        } catch (Exception Ex) {
            Common.ExceptionMgr.DisplayException(Ex);
        } finally {
            this.DBMgr.DbDisConnect();
        }

        return bResult;
    }

 // 사용자의 이벤트 가져오기
    public List<CalendarDTO> getUserEvents(int userId) throws Exception {
        List<CalendarDTO> eventList = new ArrayList<>();
        String sSql = "SELECT CALENDAR_ID, USER_ID, PLAN, CALENDAR_DATE, CATEGORY, MEMO " +
                      "FROM TB_CALENDAR WHERE USER_ID = ?";
        try {
            if (this.DBMgr.DbConnect() == true) {
                Object[] params = { userId };
                if (this.DBMgr.RunQuery(sSql, params, 0, true)) {
                    while (this.DBMgr.Rs.next()) {
                        CalendarDTO dto = new CalendarDTO();
                        dto.setCalendar_id(this.DBMgr.Rs.getInt("CALENDAR_ID"));
                        dto.setUser_id(this.DBMgr.Rs.getInt("USER_ID"));
                        dto.setPlan(this.DBMgr.Rs.getString("PLAN"));
                        dto.setCalendar_date(this.DBMgr.Rs.getString("CALENDAR_DATE"));
                        dto.setCategory(this.DBMgr.Rs.getString("CATEGORY"));
                        dto.setMemo(this.DBMgr.Rs.getString("MEMO"));
                        eventList.add(dto);
                    }
                }
            }
        } finally {
            this.DBMgr.DbDisConnect();
        }
     // 디버깅 로그 추가
        System.out.println("Fetched Events: " + eventList);
        return eventList;
    }
}
//#################################################################################################
//<END>
//#################################################################################################
