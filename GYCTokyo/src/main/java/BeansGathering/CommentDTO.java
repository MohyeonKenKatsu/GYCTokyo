package BeansGathering;

import java.sql.Timestamp;

public class CommentDTO {
    private int commentId; // 댓글 ID
    private int groupId;   // 모임 ID
    private int userId;    // 사용자 ID
    private String content; // 댓글 내용
    private Timestamp createdAt; // 작성 시간
    private String nickname; // 작성 시간

    // 기본 생성자
    public CommentDTO() {}

    // 생성자
    public CommentDTO(int commentId, int groupId, int userId, String content, Timestamp createdAt) {
        this.commentId = commentId;
        this.groupId = groupId;
        this.userId = userId;
        this.content = content;
        this.createdAt = createdAt;
    }

    // Getter and Setter methods
    public int getCommentId() {
        return commentId;
    }
    public String getNickname() {
        return nickname;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
