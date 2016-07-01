<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th width="40">序号</th>
        <th width="120">任务名称</th>
        <th width="150">执行开始时间</th>
        <th width="150">结束时间</th>
        <th width="130">持续时间</th>
        <th width="120">执行人名</th>
        <th>审批意见</th>
        <th width="120">审批状态</th>
    </tr>
    </thead>
    <c:forEach items="${taskOpinion}" var="taskOpinion" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${taskOpinion.taskName}</td>
                <td>
                    <fmt:formatDate value="${taskOpinion.startTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                </td>
                <td> 
                    <fmt:formatDate value="${taskOpinion.endTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                </td>
                <td>
                    ${fns:getTime(taskOpinion.durTime)}
                </td>
                <td>${taskOpinion.exeFullname}</td>
                <td class="text-l">${taskOpinion.opinion}</td>
                <td>
                    <c:choose>
                        <c:when test="${taskOpinion.status ==1}"><font color="green">已阅</font></c:when>
                        <c:when test="${taskOpinion.status ==2}"><font color="red">反对</font></c:when>
                        <c:when test="${taskOpinion.status ==3}"><font color="red">驳回</font></c:when>
                        <c:otherwise>尚未处理</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:forEach>
</table>