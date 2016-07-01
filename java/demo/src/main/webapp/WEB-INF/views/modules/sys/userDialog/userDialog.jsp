<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/ligerui.jsp" %>
<html>
<head>
    <title>用户选择</title>
    <meta name="decorator" content="default"/>
    <link href="${ctxStatic}/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"/>
    <script src="${ctxStatic}/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/ligerUI/js/plugins/ligerMessageBox.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#defLayout").ligerLayout({ leftWidth: 190, rightWidth: 170, allowRightResize: false, allowLeftResize: false, allowTopResize: false, allowBottomResize: false, height: '90%', minLeftWidth: 170});
            $("#userFrame").attr("src", "${ctx}/sys/user/selector?isSingle=${isSingle}");
            initData();
        });

        //初始化父级窗口传进来的数据
        function initData() {
            var obj = window.dialogArguments;
            if (obj && obj.length > 0) {
                for (var i = 0, c; c = obj[i++];) {
                    var data = c.id + '#' + c.name;
                    if (c.name != undefined && c.name != "undefined" && c.name != null && c.name != "") {
                        add(data);
                    }
                }
            }
        }
        ;

        function add(data) {
            var aryTmp = data.split("#");
            var userId = aryTmp[0];

            var len = $("#user_" + userId).length;
            if (len > 0) return;
            var userTemplate = $("#userTemplate").val();

            var html = userTemplate.replace("#userId", userId)
                    .replace("#data", data)
                    .replace("#name", aryTmp[1]);
            $("#userList").append(html);
        }
        ;

        function selectMulti(obj) {
            if ($(obj).attr("checked") == "checked") {
                var data = $(obj).val();
                add(data);
            }
        }
        ;

        function dellAll() {
            $("#userList").empty();
        }
        ;
        function del(obj) {
            var tr = $(obj).closest("tr");
            $(tr).remove();
        }
        ;
        //清空角色
        function clearRole() {
            window.returnValue = {userId: '', userName: ''};
            window.close();
        }

        function selectUser() {
            var isSingle =${isSingle};
            var pleaseSelect = "请选择用户!";
            //单选
            if (isSingle == true) {
                var chIds = $('#userFrame').contents().find("input[name='id']:checked");
                if (chIds.length == 0) {
                    alert("请选择");
                    return;
                }
                var data = chIds.val();
                var aryRole = data.split("#");
                var obj = {};
                obj.userId = aryRole[0];
                obj.userName = aryRole[1];
                obj.area = aryRole[2];
                obj.areaId = aryRole[3];
                window.returnValue = obj;

            }
            //复选
            else {
                var aryRoles = $("input[name='user']", $("#userList"));
                if (aryRoles.length == 0) {
                    alert(pleaseSelect);
                    return;
                }
                var aryId = [];
                var aryName = [];
                var aryArea = [];
                var aryAreaId = [];
                var json = [];
                aryRoles.each(function () {
                    var data = $(this).val();
                    var aryRole = data.split("#");
                    aryId.push(aryRole[0]);
                    aryName.push(aryRole[1]);
                    aryArea.push(aryRole[2]);
                    aryAreaId.push(aryRole[3]);
                    json.push({id: aryRole[0], name: aryRole[1],area:aryRole[2],areaId:aryRole[3]});
                });
                var userIds = aryId.join(",");
                var userNames = aryName.join(",");
                var userAreas = aryArea.join(",");
                var userAreaIds = aryAreaId.join(",");
                var obj = {};
                obj.userId = userIds;
                obj.userName = userNames;
                obj.area = userAreas;
                obj.areaId = userAreaIds;
                obj.userJson = json;
                window.returnValue = obj;
            }

            window.close();
        }
    </script>
</head>
<body>
<div id="defLayout">
    <div position="center">
        <iframe id="userFrame" name="userFrame" height="100%" width="100%" frameborder="0" ></iframe>
    </div>
    <c:if test="${isSingle=='false' }">
        <div position="right"
             title="<span><a onclick='javascript:dellAll();' class='link del'>清空</a><input type='text' class='quick-find' title='查找'/></span>"
             style="overflow: auto;height:95%;width:170px;">
            <table width="145" class="table table-striped table-bordered table-condensed table-center" cellpadding="1"
                   cellspacing="1">
                <tbody id="userList">
                <tr class="hidden"></tr>
                </tbody>
            </table>
        </div>
    </c:if>

</div>
<div position="bottom" class="bottom" style="margin-top:10px;">
    <a href="#" class="btn btn-primary" onClick="selectUser()" style="margin-right:10px;"><span
            class="icon ok"></span><span
            class="chosen">选择</span></a>
    <a href="#" class="btn  action-delete" onClick="window.close()" style="margin-left:10px;"><span
            class="icon cancel"></span><span
            class="chosen">取消</span></a>

</div>
<textarea id="userTemplate" style="display: none;">
    <tr id="user_#userId">
        <td>
            <input type="hidden" name="user" value="#data"><span>#name</span>
        </td>
        <td style="width: 30px;" nowrap="nowrap"><a onClick="javascript:del(this);" class="link del" title="删除">
            &nbsp;</a></td>
    </tr>
</textarea>
</body>
</body>
</html>