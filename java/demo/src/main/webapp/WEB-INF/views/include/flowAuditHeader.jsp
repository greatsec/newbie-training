<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/dialog.jsp" %>
<script type="text/javascript">
    function agreeTask(taskId, status) {
        $.jBox.confirm("你确定"+$("#btnAgree").val()+"吗?","系统提示",function(v,h,f){
			if(v=="ok"){
				 completeTask(taskId, status);
    		}
		});
    }
    function rejectTask(taskId, status) {
        $.jBox.confirm("你确定"+$("#btnRefuse").val()+"吗?","系统提示",function(v,h,f){
			if(v=="ok"){
				if(document.getElementById("receiptNo")!=null){
	        		$("#receiptNo").attr("class","");
	        	}
				completeTask(taskId, status);
    		}
		});
    }
    /**
     * 完成任务
     */
    function completeTask(taskId, status) {
        $("#agreeStatus").val(status);
        var content = $("#agreeContent").val();
        if (content.length > 200) {
            alert("审核意见不能超过200字!");
            return;
        }
        $("#inputForm").submit();
    }

    $(function () {
        $("#remark").change(function() {
            $("#agreeContent").val($(this).find("option:selected").val());
        });
        $("#jump").hide();
        $("#taskName").hide();
        $("#taskName").attr("disabled",true);
        var task = '${task.taskDefinitionKey}';
        var processDefinitionId ='${task.processDefinitionId}';
    });
</script>

<div class="form-actions pad-l20">
    <input id="btnAgree" class="btn btn-primary" type="button" value="审核通过" onclick="agreeTask('${task.id}',1)"/>
    <input id="btnRefuse" class="btn" type="button" value="审核不通过" onclick="rejectTask('${task.id}',2)"/>
</div>
<div class="control-group">
    <label class="control-label">快速意见：</label>

    <div class="controls">
        <form:select path="" class="" id="remark">
            <form:option value="" label="请选择"/>
            <c:forEach items="${fns:getDictList('quick_advice')}" var="dict">
	            <form:option value="${dict.label}" label="${dict.label}"/>
			</c:forEach>
        </form:select>
    </div>
</div>
<div class="control-group">
    <label class="control-label">审核意见：</label>

    <div class="controls">
        <textarea id="agreeContent" name="agreeContent" rows="5" cols="5"></textarea>
        <input name="taskId" id="taskId" type="hidden" value="${task.id}"/>
        <input name="agreeStatus" id="agreeStatus" type="hidden"/>
    </div>
</div>

