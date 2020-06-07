<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/30
  Time: 10:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:forward page="/getEmps"></jsp:forward>
<html>
<head>
        <meta http-equiv="content-type" content="text/html"; charset="UTF-8">
    <title>Title</title>

    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- 引入jquery -->
    <script type="text/javaScript" src="static/js/jquery-1.12.4.min.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<button class="btn btn-success">按钮</button>
<label>ddd</label>
</body>
</html>
