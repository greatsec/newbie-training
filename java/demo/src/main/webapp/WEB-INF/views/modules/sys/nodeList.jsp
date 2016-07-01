<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/ligerui.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<title>流程配置</title>
<script type="text/javascript" >
	var _ctx = '${ctx}';
</script>
<style>
.hide{
	display:none;
}
.show{
	display:block inline;
}

#navtab1 div.l-tab-content-item {
	border: 1px solid #bed5f3;
	border-top: none;
	width: auto;
}
</style>
<script type="text/javascript">
function selectUsers(t,deploymentId)
{

    var type = $(t).closest("tr").find("#assignType").val();
	switch(type)
	{
		case "0":
			break;
		case "1":
			UserDialog({
				isSingle:false,
				callback:function(userId,fullname){
					if(userId=='' || userId==null || userId==undefined) return;
					$(t).siblings("input[id='userIds']").val(userId);
					$(t).siblings("input[id='usernames']").val(fullname);
				}
			});
			break;
		case "2":
			PosDialog({
				callback:function(userId,fullname){
					if(userId=='' || userId==null || userId==undefined) return;
					$(t).siblings("input[id='userIds']").val(userId);
					$(t).siblings("input[id='usernames']").val(fullname);
				}
			});
			break;
		case "3":
			break;
		case "5":
			$.UIAdapter.Dialog({url: '${ctx}/adm/flow/def/nodeShow.do?deploymentId='+deploymentId,
				ok:function(win){
					var obj = win.selectSpc();
					$(t).siblings("input[id='userIds']").val(obj.nodeId);
					$(t).siblings("input[id='usernames']").val(obj.nodeName+"("+obj.nodeId+")");
				},width:600,height:450}); 
			return true;
			break;
	}
}

$(function(){
		$("#navtab1").ligerTab();
		$("#assignType").change(function(){
			var usernames = $(this).closest("tr").find("input[id='usernames']");
			var selectBtn = $(this).closest("tr").find("input[id='selectUser']");
			var userIds = $(this).closest("tr").find("input[id='userIds']");
			if($(this).val() == "0" || $(this).val()  == "3" || $(this).val() == "4")
			{
				usernames.hide();
				selectBtn.hide();
			}
			else
			{
				usernames.show();
				selectBtn.show();
			}
			usernames.val("");
			userIds.val("");
		});	
});
</script>
</head>
<body>


            <div id="navtab1" >
               <div tabid="home" title="人员设置" lselected="true"  style="height: auto" >
                  <%--  <form action="${ctx}/adm/flow/def/nodeUserSet.do" method="post" >
                    <div class="primary-container margin_10"> 
                                 <div class="head">
                                         <h3>人员设置</h3>
                                         <p class="tools"><input type="button" value="返回"    onclick="history.back(-1);" class="back-tool-btn" /> 
                            				<input type="submit" value="保存"   class="save-tool-btn"  onClick="addArchiveForm();">
                                         </p>
                                        </div>    
                                        <div class="body">
                    <table class="primary-tab">
                    <thead>
                        <tr>
                            <th>任务名称</th>
                            <th>用户类型</th>
                            <th>节点人员</th>
                        </tr>
                        </thead>
                        <#if list??>
                        <#list list as user>
                        <tr>
                            <td>
                                ${user.nodeName!}(${user.nodeId!});
                            </td>
                            <td>
                                <#assign type = user.assignType />
                                <input type="hidden" name="assignType" value="${user.assignType!}"/>
                                    <#if user.id??>
                                        <@m.select name="user[${user_index}].assignType" id="assignType" category="02"  entry="${user.assignType!}" /> 
                                    <#else>
                                        <@m.select name="user[${user_index}].assignType"  id="assignType" category="02" entry="1"  /> 
                                    </#if>
                            </td>
                            <td>
                                <input type="text"  <#if type==0 || type==3 || type==4> class="hide"<#else> class="show" </#if> name="user[${user_index}].usernames" value="${user.usernames!}" id="usernames"  readonly="readonly"/>
                                <input type="hidden" name="user[${user_index}].userIds"  value="${user.userIds!}" id="userIds"  readonly="readonly"/>
                                <input type="hidden" name="user[${user_index}].id"  value="${user.id!}" id="id"  readonly="readonly"/>
                                <input  type="button" <#if type==0 || type==3 || type==4>  class="hide choose-common-btn" <#else> class="show choose-common-btn" </#if> value="选择" id="selectUser" onclick="selectUsers(this,${user.defId});"  />
                            </td>
                        </tr>
                        </#list>
                        </#if>
                    </table>--%>
                    </div>
                <div tabid="flowImag" lselected="true" title="流程图" >
                    <iframe frameborder="0" width="100%" height="100%"  src="${ctx}/sys/workflow/nodeImageView?deploymentId=${defId}"></iframe>
                </div>
                </div>
</body>
</html>
