<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/5/30
  Time: 22:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- 引入jquery -->
    <script type="text/javaScript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <!-- 引入样式 -->
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
        <%--添加和删除按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8" >
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
        <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                <c:forEach items="${pageInfo.list}" var="emp">
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
                                编辑</button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除</button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
        <%--分页信息--%>
    <div class="row">
        <div class="col-md-6">
            当前是第${pageInfo.pageNum}页 共${pageInfo.pages}页 总记录数${pageInfo.total}条
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH}/getEmps?pn=1">首页</a></li>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH}/getEmps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num!=pageInfo.pageNum}">
                            <li><a href="${APP_PATH}/getEmps?pn=${page_Num}">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                    <li>
                        <a href="${APP_PATH}/getEmps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li><a href="${APP_PATH}/getEmps?pn=${pageInfo.pages}">尾页</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>

</body>
</html>
