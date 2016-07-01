<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/include/dialog.jsp" %>
<style>
#jbox-content{ height:140px!important; padding-top:10px;}
#taskName { margin-left:20px!important; }
.jbox-icon.jbox-icon-question { top:60px!important; }
</style>
<script type="text/javascript">
    function agreeTask(taskId, status) {
    	$.jBox.confirm("你确定同意吗?","系统提示",function(v,h,f){
			if(v=="ok"){
				 completeTask(taskId, status);
    		}
		});
    }
    function rejectTask(taskId, status) {
        $.jBox.confirm("你确定${empty abandon?'反对':'废弃'}吗?","系统提示",function(v,h,f){
			if(v=="ok"){
				$(".required").removeAttr("class");
				completeTask(taskId, status);
    		}
		});
    }

    function endTask(taskId, status) {
        $.jBox.confirm("你确定完成后直接结束本流程吗?","系统提示",function(v,h,f){
            if(v=="ok"){
                $(".required").removeAttr("class");
                completeTask(taskId, status);
            }
        });
    }

    function refuseTask(taskId, status) {
        var task = '${task.taskDefinitionKey}';
        if (task == "usertask1") {
            $.jBox.error("您没有可驳回的路径","信息提示");
        }else{
            <c:if test="${not empty curTask }">
            $.jBox($("#taskTemp").html(),{title:'请选择驳回路径',submit: function(v, h, f){
                if (v=="ok") {
                    $("#taskName").val(f.taskName);
                    if($("#taskName").val() == "") {
                        $.jBox.alert('系统提示', '请选择要跳转的路径');
                        return;
                    }
                    $.jBox.confirm("你确定驳回吗?","系统提示",function(v,h,f){
                        if(v=="ok"){
                            $(".required").removeAttr("class");
                            completeTask(taskId, status);
                        }
                    });
                }
            }});
            </c:if>
            <c:if test="${empty curTask}">
                $.jBox.confirm("你确定驳回吗?","系统提示",function(v,h,f){
                if(v=="ok"){
                    $(".required").removeAttr("class");
                    completeTask(taskId, status);
                }
            });
            </c:if>


        }
    }
    /**
     * 完成任务
     */
    function completeTask(taskId, status) {
        $("#agreeStatus").val(status);
        var content = $("#agreeContent").val();
        if (content.length > 200) {
            $.jBox.alert('系统提示', '审核意见不能超过200字!');
            return;
        }
        $("#inputForm").submit();
    }

    $(function () {
        $("#remark").change(function() {
        	$("#agreeContent").val($(this).find("option:selected").val());
        });

        <c:if test="${not empty curTask}">
                $("#btnRefuse").hide();
         </c:if>
        $("#taskTemp").hide();
        var task = '${task.taskDefinitionKey}';
        var processDefinitionId ='${task.processDefinitionId}';
        if(task != "usertask1"){
            var seq = task.substring(task.indexOf("usertask")+8,task.length);
            var select = $("#taskName");
            select.append("<option value=''></option> ")
            for (var i=1;i<seq;i++) {
                var value = "usertask"+i;
                $.ajax({
                    url:'${ctx}/sys/workflow/getNodeName',
                    async:false,
                    data:{
                        nodeId:value,
                        actId:processDefinitionId
                    },
                    success:function(msg) {
                        select.append("<option value='usertask"+i+"'>" +msg+"</option>")
                    }
                })
            }
        }
    });
</script>

<div class="form-actions pad-l20">
    <input id="btnAgree" class="btn btn-primary" type="button" value="同 意" onclick="agreeTask('${task.id}',1)"/>
    <input id="btnReject" class="btn" type="button" value="驳 回" onclick="refuseTask('${task.id}',3)"/>
    <input id="btnRefuse" class="btn" type="button" value="${empty abandon?'反对':'废弃'}" onclick="rejectTask('${task.id}',2)"/>
    <c:if test="${formType eq 2 }"><input id="btnEnd" class="btn" type="button" value="结束" onclick="endTask('${task.id}',4)"/></c:if>


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
    <div id="taskTemp" >
        <select name="taskName" id="taskName" style="margin-left:40px"></select>
    </div>
</div>

