<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>角色列表</title>
    <link href="${ctxStatic}/modules/cms/front/themes/basic/common.css" type="text/css" rel="stylesheet">
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

        $(function () {
            var isSingle =${isSingle};
            $("#sysRoleItem>tbody").find("tr").bind('click', function () {
                if (isSingle == 'true') {
                    var rad = $(this).find('input:radio');
                    rad.attr("checked", "checked");
                } else {
                    var ch = $(this).find(":checkbox");
                    window.parent.selectMulti(ch);
                }
            });

            if (!isSingle) {
                $("#chkall").click(function () {
                    var checkAll = false;
                    if ($(this).attr("checked")) {
                        checkAll = true;
                    }
                    var checkboxs = $(":checkbox", $("#sysRoleItem>tbody"));
                    checkboxs.each(function () {
                        if (checkAll) {
                            $(this).attr("checked", true);
                            window.parent.selectMulti(this);
                        }else{
                            $(this).attr("checked", false);
                        }
                    })
                });
            }
        });
    </script>
</head>
<body>
<form:form id="searchForm" modelAttribute="role" action="${ctx}/sys/role/selector" method="post"
           class="breadcrumb form-search search-box">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <label>角色名称：</label><form:input path="name"></form:input>
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<table id="sysRoleItem" class="table table-striped table-bordered table-condensed table-center">
    <thead>
    <tr>
    <th>
        <c:if test="${isSingle==false}">
                <input type="checkbox" id="chkall"/>
        </c:if>
    </th>
    <th>角色名称</th>
    <th>归属机构</th>
    </thead>
    <c:forEach items="${page.list}" var="role">
    <tbody>
    <tr>
        <c:if test="${isSingle==false}">
            <td><input type="checkbox" class="pk" name="id" value="${role.id}#${role.name}"/>
            </td>
        </c:if>
        <c:if test="${isSingle==true}">
            <td><input type="radio" class="pk" name="id" value="${role.id}#${role.name}"></td>
        </c:if>
        <td>${role.name}</td>
        <td>${role.office.name}</td>
    </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>