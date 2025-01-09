<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    // 요청 데이터 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // JSON 응답 생성을 위한 변수
    String jsonResponse = "";
    
    try {
        // 요청 파라미터 받기
        String type = request.getParameter("type");
        
        // 타입별로 다른 파라미터 처리
        switch(type) {
            case "음수량":
                String waterAmount = request.getParameter("waterAmount");
                // 여기에 데이터베이스 저장 로직 구현
                break;
            case "운동기록":
                String exerciseType = request.getParameter("exerciseType");
                String exerciseTime = request.getParameter("exerciseTime");
                // 여기에 데이터베이스 저장 로직 구현
                break;
            case "수면기록":
                String sleepTime = request.getParameter("sleepTime");
                String wakeTime = request.getParameter("wakeTime");
                // 여기에 데이터베이스 저장 로직 구현
                break;
            case "영양제":
                String vitaminName = request.getParameter("vitaminName");
                String vitaminAmount = request.getParameter("vitaminAmount");
                // 여기에 데이터베이스 저장 로직 구현
                break;
        }
        
        jsonResponse = "{\"success\": true, \"message\": \"저장되었습니다.\"}";
        
    } catch(Exception e) {
        jsonResponse = "{\"success\": false, \"message\": \"저장에 실패했습니다.\"}";
        e.printStackTrace();
    }
    
    // JSON 응답 출력
    out.print(jsonResponse);
%> 