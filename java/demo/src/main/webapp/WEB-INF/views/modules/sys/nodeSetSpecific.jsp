<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/dialog.jsp" %>
<%@ include file="/WEB-INF/views/include/ligerui.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
    <script src="${ctxStatic}/jquery-validation/lib/jquery.form.js" type="text/javascript"></script>
    <title>节点配置</title>
    <script type="text/javascript">
        var _ctx = '${ctx}';

        function clearUser()
        {
            $("#usernames").val("");
            $("#userIds").val("");
        }

        $(function () {
            $("#assignType").change(function(){
                clearUser();
                var val = parseInt($(this).val());
                switch (val) {
                    case 0:
                        $("#user").hide();
                        break;
                    case 1:
                        $("#user").show();
                        break;
                    case 2:
                        $("#user").show();
                        break;
                }
            });

            $("#choose").click(function() {
                var url = "";
                var type = $("#assignType").val();
                if (type == "" || type ==0) {
                    return;
                }else if(type==1) {
                    new UserDialog({
                        isSingle:false,
                        callback:function(id,name) {
                            $("#usernames").val(name);
                            $("#userIds").val(id);
                        }
                    });
                }else if(type ==2) {
                    new RoleDialog({
                        isSingle:false,
                        callback:function(id,name) {
                            $("#usernames").val(name);
                            $("#userIds").val(id);
                        }
                    });
                }
            });
            $("#btnSubmit").click(function () {
                var assignType = $("#assignType").val()
                if (assignType == "") {
                    $.jBox.error("请选择类型","节点配置");
                    return false;
                }
                if(assignType != 0) {
                    var usernames = $("#usernames").val();
                    if ($.trim(usernames) == "" ) {
                        $.jBox.error("请配置用户","节点配置");
                        return;
                    }
                }
                $.post($("#form").attr('action'), $("#form").serialize(), function(result)
                {
                    var r = eval("(" + result + ")");
                    if (r.success)
                    {
                        alert("操作成功");
                        window.close();
                    } else
                    {

                    }
                });

            });
        })

    </script>
</head>
<body>
<form:form action="${ctx}/sys/workflow/userSet" method="post" id="form" modelAttribute="user">
    <table id="contentTable" class="table table-striped table-bordered table-condensed table-center">
        <thead>
        <tr>
        <th>序号</th>
        <th>节点名称</th>
        <th>用户类型</th>
        <th>用户</th>
        <th>操作</th>
        </thead>
        <tr>
            <td>1</td>
            <td>${user.nodeName}</td>
            <td>
                <form:hidden path="id" />
                <form:select path="assignType" id="assignType" itemValue="${user.assignType}">
                    <form:option value="" label="请选择" />
                    <form:options items="${fns:getDictList('flow_assign_type')}" itemLabel="label" itemValue="value"
                                  htmlEscape="false"/>
                </form:select>
            </td>
            <td>
                <i id="user">
                <form:textarea path="usernames" id="usernames" readonly="true"></form:textarea>
                <form:hidden path="userIds" id="userIds"></form:hidden>
                <a id="choose" href="javascript:" class="btn" style="_padding-top:6px;">&nbsp;<i class="icon-search"></i>&nbsp;</a>
                </i>
            </td>
            <td>
                <input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/>
            </td>

        </tr>
        <tbody>
    </table>
</form:form>
</body>
</html>