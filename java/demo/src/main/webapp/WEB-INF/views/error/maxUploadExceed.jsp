<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>error - 上传文件出错</title>
	<%@include file="/WEB-INF/views/include/head.jsp" %>
</head>
<body>
	<div class="container-fluid">
    <div style="text-align:center; margin-top:200px;">
		<h1><img src="${ctxStatic}/images/403.jpg" />对不起，上传文件不能超过2M。</h1>
		<div style="margin-top:20px;"><a href="javascript:" onclick="history.go(-1);" class="btn">返回上一页</a></div>
		<script>try{top.$.jBox.closeTip();}catch(e){}</script>
	</div>
    </div>
</body>
</html>