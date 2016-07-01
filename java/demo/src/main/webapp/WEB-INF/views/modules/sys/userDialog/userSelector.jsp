<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>

<head>
    <title>用户列表</title>
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
            $("#sysUserItem>tbody").find("tr").bind('click', function () {
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
                    var checkboxs = $(":checkbox", $("#sysUserItem>tbody"));
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
<form:form id="searchForm" modelAttribute="user" action="${ctx}/sys/user/selector" method="post"
           class="breadcrumb form-search search-box">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input name="isSingle" type="hidden" value="${isSingle}"/>
    <label>姓名：</label><form:input path="name"></form:input>
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
</form:form>
<table id="sysUserItem" class="table table-striped table-bordered table-condensed table-center">
    <thead>
    <tr>
    <th width="10%">
        <c:if test="${isSingle==false}">
                <input type="checkbox" id="chkall"/>
        </c:if>
    </th>
    <th width="20%">姓名</th>
    <th>归属机构</th>
    </thead>
    <c:forEach items="${page.list}" var="user">
    <tbody>
    <tr>
        <c:if test="${isSingle==false}">
            <td><input type="checkbox" class="pk" name="id" value="${user.id}#${user.name}#${user.office.area.name}#${user.office.area.id}"/>
            </td>
        </c:if>
        <c:if test="${isSingle==true}">
            <td><input type="radio" class="pk" name="id" value="${user.id}#${user.name}#${user.office.area.name}#${user.office.area.id}"></td>
        </c:if>
        <td>${user.name}</td>
        <td>${user.office.name}</td>
    </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>