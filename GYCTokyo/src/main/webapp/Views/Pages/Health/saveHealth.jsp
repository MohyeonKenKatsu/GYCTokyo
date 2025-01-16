<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHealth.HealthDTO, BeansHealth.HealthDAO" %>
<%
    request.setCharacterEncoding("UTF-8"); // 요청 데이터 인코딩 설정
    response.setCharacterEncoding("UTF-8"); // 응답 데이터 인코딩 설정
%>

<%
	    boolean isSuccess = false;
	
	    try {
	        // 데이터 수신
	        String type = request.getParameter("type");
	        String jobstatus = request.getParameter("jobstatus");
	        String textdate = request.getParameter("textdate");
	        Integer textuserid = Integer.valueOf(request.getParameter("textuserid"));
	        String goalWater = request.getParameter("goal_water");
	        String achievedWater = request.getParameter("achieved_water");
	        String typeExercise = request.getParameter("type_exercise"); // 추가
	        String goalExercise = request.getParameter("goal_exercise"); // 추가
	        String achievedExercise = request.getParameter("achieved_exercise"); // 추가
	        String bedtime = request.getParameter("bedtime"); // 추가
	        String waketime = request.getParameter("waketime"); // 추가
	
	        // DTO 설정
	        HealthDTO healthDTO = new HealthDTO();
	        
	        healthDTO.setJobstatus(jobstatus);
	        healthDTO.setHealth_date(textdate);
	        healthDTO.setUser_id(textuserid); // 사용자 ID
	        healthDTO.setGoal_water(goalWater);
	        healthDTO.setAchieved_water(achievedWater);
	        healthDTO.setType_exercise(typeExercise); // 설정
	        healthDTO.setGoal_exercise(goalExercise); // 설정
	        healthDTO.setAchieved_exercise(achievedExercise); // 설정
	        healthDTO.setBedtime(bedtime); // 설정
	        healthDTO.setWaketime(waketime); // 설정
	
	        // DAO 호출
	        HealthDAO healthDAO = new HealthDAO();
	        isSuccess = healthDAO.saveHealthRecord(healthDTO);
	
	    } catch (Exception e) {
	        System.out.println("JSP 처리 중 예외 발생: " + e.getMessage());
	        e.printStackTrace();
	    }
	
	    // 응답 반환
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	
	    if (isSuccess) {
	        out.print("{\"success\": true}");
	    } else {
	        out.print("{\"success\": false}");
	    }
%>


<%
    System.out.println("saveHealth.jsp가 호출되었습니다.");

    // 파라미터 확인
    System.out.println("goal_water: " + request.getParameter("goal_water"));
    System.out.println("achieved_water: " + request.getParameter("achieved_water"));
    System.out.println("type: " + request.getParameter("type"));
    
    System.out.println("goal_exercise: " + request.getParameter("goalExercise"));
    System.out.println("achieved_exercise: " + request.getParameter("achievedExercise"));
%>
