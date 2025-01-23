<%@page import="java.net.URLEncoder"%>
<%@page import="BeansGathering.CommentDTO"%>
<%@page import="BeansGathering.GatheringDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8"); // UTF-8로 인코딩

    String action = request.getParameter("action");
    GatheringDAO gatheringDAO = new GatheringDAO();

    try {
        if ("insert".equals(action)) {
            // 파라미터 유효성 검사
            String groupIdParam = request.getParameter("group_id");
            String userIdParam = request.getParameter("user_id");
            String content = request.getParameter("content");

            if (groupIdParam != null && userIdParam != null && content != null && !content.trim().isEmpty()) {
                int groupId = Integer.parseInt(groupIdParam);
                int userId = Integer.parseInt(userIdParam);

                // 댓글 DTO 생성
                CommentDTO comment = new CommentDTO();
                comment.setGroupId(groupId);
                comment.setUserId(userId);
                comment.setContent(content);

                // 댓글 삽입
                boolean success = gatheringDAO.insertComment(comment);
                if (success) {
                    String redirectUrl = "ViewGatheringModal.jsp?GROUP_ID=" + URLEncoder.encode(String.valueOf(groupId), "UTF-8");
                    response.sendRedirect(redirectUrl);
                } else {
                    out.print("댓글 등록 실패: DB 처리 오류");
                }
            } else {
                out.print("댓글 등록 실패: 유효하지 않은 입력값");
            }
        } else if ("delete".equals(action)) {
            // 파라미터 유효성 검사
            String commentIdParam = request.getParameter("comment_id");
            String groupIdParam = request.getParameter("group_id");

            if (commentIdParam != null && groupIdParam != null) {
                int commentId = Integer.parseInt(commentIdParam);
                int groupId = Integer.parseInt(groupIdParam);

                // 댓글 삭제
                boolean success = gatheringDAO.deleteComment(commentId);
                if (success) {
                    String redirectUrl = "ViewGatheringModal.jsp?GROUP_ID=" + URLEncoder.encode(String.valueOf(groupId), "UTF-8");
                    response.sendRedirect(redirectUrl);
                } else {
                    out.print("댓글 삭제 실패: DB 처리 오류");
                }
            } else {
                out.print("댓글 삭제 실패: 유효하지 않은 입력값");
            }
        } else {
            out.print("알 수 없는 요청입니다.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.print("오류 발생: " + e.getMessage());
    }
%>
