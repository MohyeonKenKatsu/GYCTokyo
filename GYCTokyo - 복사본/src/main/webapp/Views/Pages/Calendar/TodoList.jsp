<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>투두 리스트</title>
    <!-- CSS 파일 연결 -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/TodoList.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Views/Pages/Calendar/TodoModal.css">
</head>
<body>
    <section class="todoList">
        <h1>투두 리스트</h1>
        <p>2024-12-16 ~ 2024-12-22</p>
        <table>
            <thead>
                <tr>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th>토</th>
                    <th>일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <input type="checkbox"> 박서연 놀리기
                        <br>
                        <button class="todoAddButton">+</button>
                    </td>
                    <td><button class="todoAddButton">+</button></td>
                    <td><button class="todoAddButton">+</button></td>
                    <td><button class="todoAddButton">+</button></td>
                    <td><button class="todoAddButton">+</button></td>
                    <td><button class="todoAddButton">+</button></td>
                    <td><button class="todoAddButton">+</button></td>
                </tr>
            </tbody>
        </table>
    </section>

    <!-- Include TodoModal.jsp -->
    <jsp:include page="TodoModal.jsp" />

    <!-- JavaScript 파일 연결 -->
    <script src="<%= request.getContextPath() %>/Views/Pages/Calendar/Todo.js" defer></script>
</body>
</html>
