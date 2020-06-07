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
            <h1>YC-SSM-CRUD</h1>
        </div>
    </div>
        <%--添加和删除按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8" >
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_all_btn">删除</button>
        </div>
    </div>
        <%--表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th><input type="checkbox" class="checkbox" id="check_all"/></th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody >

                </tbody>
            </table>
        </div>
    </div>
        <%--分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<%--新增员工信息 模态框--%>
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@163.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_add_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--修改员工信息 模态框--%>
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" >修改员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@163.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="男" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="女"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">department</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>






<script type="text/javascript">
    var totalRecord,currentPage;
    $(function () {
        to_page(1);
    });
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/getEmps",
            type:"GET",
            data:"pn="+pn,
            success:function (data) {
                // console.log(data);
                //1.解析并显示员工信息
                build_emp_table(data);
                //2.解析并显示分页信息
                build_page_info(data);
                build_page_nav(data)
            }
        });
    }

    //员工信息
    function build_emp_table(data) {
        $("#emps_table tbody").empty();
        var emps = data.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkbox=$("<td><input type=\"checkbox\" class=\"item_check\"/></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender);
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.department.deptName);
        // <th>
        //     <button class="btn btn-primary btn-sm">
        //         <span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>
        //     编辑</button>
        //     <button class="btn btn-danger btn-sm">
        //         <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
        //     删除</button>
        //     </th>
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit_id",item.empId);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delBtn.attr("del_id",item.empId);
            var btn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(empIdTd).append(empNameTd).append(genderTd)
                .append(emailTd).append(deptNameTd).append(btn)
                .appendTo("#emps_table tbody");
        })
    }

    //分页记录信息
    function build_page_info(data) {

        $("#page_info_area").empty();
        var pageInfo=data.extend.pageInfo;
        $("#page_info_area").append("当前是第"+pageInfo.pageNum+"页 共"+pageInfo.pages+
        "页 总记录"+pageInfo.total+"条");
        totalRecord=pageInfo.total;
        currentPage=pageInfo.pageNum;
    }
    // <nav aria-label="Page navigation">
    //     <ul class="pagination">
    //     <li>
    //     <a href="#" aria-label="Previous">
    //     <span aria-hidden="true">&laquo;</span>
    // </a>
    // </li>
    // <li><a href="#">1</a></li>
    // <li><a href="#">2</a></li>
    // <li><a href="#">3</a></li>
    // <li><a href="#">4</a></li>
    // <li><a href="#">5</a></li>
    // <li>
    // <a href="#" aria-label="Next">
    //     <span aria-hidden="true">&raquo;</span>
    // </a>
    // </li>
    // </ul>
    // </nav>
    //分页导航信息
    function build_page_nav(data) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        var firstPage= $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));

        var forwardPage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
        if (data.extend.pageInfo.hasPreviousPage==false){
            firstPage.addClass("disabled");
            forwardPage.addClass("disabled");
        }else {
            firstPage.click(function () {
            to_page(1);
        });
            forwardPage.click(function () {
                to_page(data.extend.pageInfo.pageNum-1)
            });
        }

        ul.append(firstPage).append(forwardPage);
        $.each( data.extend.pageInfo.navigatepageNums,function navigatepageNums(index,item) {
            var li= $("<li></li>").append($("<a></a>").append(item));
            if(data.extend.pageInfo.pageNum==item){
               li.addClass("active");
           }
            li.click(function () {
                to_page(item);
            });
           ul.append(li);
        });
        var backPage=$("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
        var lastPage= $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

        if(data.extend.pageInfo.hasNextPage==false){
            backPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else {
            lastPage.click(function () {
            to_page(data.extend.pageInfo.pages);
        });
            backPage.click(function () {
                to_page(data.extend.pageInfo.pageNum+1)
            });
        }

        ul.append(backPage).append(lastPage);
        var nav =$("<nav></nav>").append(ul);
        nav.appendTo("#page_nav_area");
    }
//    情况表单样式及内容
function reset_form(ele){
    //防止反复提交数据 将表单数据重置
        $(ele)[0].reset();
    //将表单中的样式重置
        $(ele).find("*").removeClass("has-error has-success");
        //找到.help-block的 并将文本清空
        $(ele).find(".help-block").text("");

}
    //    新增员工信息 点击新增弹出模态框
    $("#emp_add_modal_btn").click( function emp_add() {
        //防止反复提交数据 将表单数据重置
        // $("#empAddModal form")[0].reset();
        reset_form("#empAddModal form");
        //发送ajax请求 查询部门信息并显示在下拉列表中
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"

        });
    });
    // 查询部门信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                // console.log(result)
                // {code: 100, msg: "成功", extend: {…}}
                // extend:
                //     depts: Array(2)
                // 0: {deptId: 1, deptName: "研发部"}
                // 1: {deptId: 2, deptName: "测试部"}
                var depts = result.extend.depts;
                // $.each(depts,function (index,item) {
                //     var opt=$("<option></option>").append(item.deptName).attr("value",item.deptId);
                //     $("#dept_add_select").append(opt);
                // })
                $.each(depts,function () {
                    var opt=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    $(ele).append(opt);
                })
            }
        });
    }
    //校验表单数据
    function validate_add_form(){

        //校验empname
        var empName=$("#empName_add_input").val();

        var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        // alert(regName.test(empName));
        if (!regName.test(empName)){
            // alert("请输入2-5中文或6-16位英文或字母的组合");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("请输入2-5中文或6-16位英文或字母的组合");
            validate_status("#empName_add_input","has-error","请输入2-5中文或6-16位英文或字母的组合");
            return false;
        }else {
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
            validate_status("#empName_add_input","has-success","");
        }
        //校验email
        var email=$("#email_add_input").val();
        var regEmail=/^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        // alert(regEmail.test(email));
        if (!regEmail.test(email)){
            // alert("邮箱格式不正确！");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确！");
            validate_status("#email_add_input","has-error","邮箱格式不正确！");
            return false;
        }else {
            // $("#email_add_input").parent().addClass("");
            // $("#email_add_input").next("span").text("");
            validate_status("#email_add_input","has-success","");
        }
        return true;
    }
    //显示校验信息
    function validate_status(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        $(ele).parent().addClass(status);
        $(ele).next("span").text(msg);
    }
    //校验用户名是否相同
    $("#empName_add_input").change(function () {
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            type:"POST",
            data:"empName="+empName,
            success:function (data) {
                if (data.code==100){
                    validate_status("#empName_add_input","has-success","用户名可用");
                    $("#save_add_btn").attr("ajax_va","has-success");
                }else {
                    validate_status("#empName_add_input","has-error",data.extend.va_msg);
                    $("#save_add_btn").attr("ajax_va","has-error");
                }
            }
        });
    });

//    保存单击事件
    $("#save_add_btn").click(function () {
         //先对要提交给服务器的数据进行校验
        if(!validate_add_form()){
            return false;
        }
        if ( $(this).attr("ajax_va")=="has-error"){
            return false;
        }
         // alert($("#empAddModal form").serialize());
        //保存员工信息
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (data) {
                 // alert(data.msg);
                if (data.code==100){
                    //关闭模态框
                    $("#empAddModal").modal('hide');
                    //    显示保存的数据
                    to_page(totalRecord);
                }else {
                    //有那个字段错误信息就显示哪个字段的错误信息
                    // console.log(data);
                    if (undefined!=data.extend.errorFields.email){
                        //显示邮箱错误信息
                        validate_status("#email_add_input","has-error",data.extend.errorFields.email);
                    } if (undefined!=data.extend.errorFields.empName){
                        validate_status("#empName_add_input","has-error",data.extend.errorFields.empName);
                    }
                }
            }
        });
    });

    //更新员工信息
    // 按钮创建之前就已经绑定了click，所以绑不上
    //绑定点击使用live(),但是JQuery新版本没有live，使用on来替代
    // $(".edit_btn").click(function () {
    //})；
    $(document).on("click",".edit_btn",function () {
       // alert("edit");

       // 查询员工信息并显示
        getEmp($(this).attr("edit_id"));

        $("#save_update_btn").attr("edit_id",$(this).attr("edit_id"));
        //查询部门信息并显示在下拉列表中
        getDepts("#dept_update_select");
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    })
    // 查询员工信息
function getEmp(id) {
    $.ajax({
        url:"${APP_PATH}/emp/"+id,
        type:"GET",
        success:function (data) {
        // console.log(data)
        var empData=data.extend.emp;
        $("#empName_update_static").text(empData.empName);
        $("#email_update_input").val(empData.email);
        $("#empUpdateModal input[name=gender]").val([empData.gender]);
        $("#empUpdateModal select").val([empData.dId]);

        }
    });
}

    // 点击更新按钮 更新员工信息
$("#save_update_btn").click(function () {

    //校验email
    var email=$("#email_update_input").val();
    var regEmail=/^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
    if (!regEmail.test(email)){
        validate_status("#email_update_input","has-error","邮箱格式不正确！");
        return false;
    }else {
        validate_status("#email_update_input","has-success","");
    }

    $.ajax({
        url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
        type:"PUT",
          // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
        //<!--支持发送PUT之类的请求，并将请求体中的数据解析进行封装成map
//    request被重新包装，request.getParameter()被重新重写
//    在web.xml中配置上HttpPutFormContentFilter
         data:$("#empUpdateModal form").serialize(),
        success:function(data) {
            // console.log(data);
            // 关闭更新模态框
            $("#empUpdateModal").modal('hide');
            to_page(currentPage);
        }
    });


});
    // 点击删除按钮 删除单个员工信息
    $(document).on("click",".delete_btn",function () {
      var empName= $(this).parents("tr").find("td:eq(2)").text();
      var empId=$(this).parents("tr").find("td:eq(1)").text();
        // var empId=$(this).attr("del_btn");
        if (confirm("确认删除"+empName+"吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (data) {
                    alert(data.msg);
                    to_page(currentPage);
                }
            });
        }

    });
    // 点击复选框 全选或全不选
    $("#check_all").click(function () {
        // alert($(this).attr("checked"));为undefined
        // alert($(this).prop("checked")); true or false
        $(".item_check").prop("checked",$(this).prop("checked"));

    });
    
    $(document).on("click",$(".item_check"),function () {
        // alert($(".item_check:checked").length);
        var flag= $(".item_check:checked").length==$(".item_check").length;
        $("#check_all").prop("checked",flag);
    })
    // 点击删除按钮 批量删除员工信息
    $("#emp_del_all_btn").click(function () {
        var empNames="";
        var empIds="";
        $.each($(".item_check:checked"),function () {
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            empIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames=empNames.substring(0,empNames.length-1);
        empIds=empIds.substring(0,empIds.length-1);
        if(confirm("确认删除【"+empNames+"】吗?")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empIds,
                type:"DELETE",
                success:function (data) {
                    alert(data.msg);
                    to_page(currentPage);
                }
            });
        }
    });

</script>

</body>
</html>
