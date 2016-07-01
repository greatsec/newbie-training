<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>
	<title>${fns:getConfig('productName')} 登录</title>
    <link href="${ctxStatic}/modules/cms/front/themes/basic/common.css" type="text/css" rel="stylesheet">
	<meta name="decorator" content="default"/>
	<style type="text/css">
/*html,body,table{background-color:#f5f5f5;width:100%;height:500px;text-align:center;}*/.form-signin-heading { font-size:36px; margin-bottom:20px; color:#0663a2; }
.form-signin { position:relative; text-align:left; width:398px; -webkit-border-radius:5px; -moz-border-radius:5px; border-radius:5px; -webkit-box-shadow:0 1px 2px rgba(0, 0, 0, .05); -moz-box-shadow:0 1px 2px rgba(0, 0, 0, .05); box-shadow:0 1px 2px rgba(0, 0, 0, .05); border-top-style: none; border-right-style: none; border-bottom-style: none; border-left-style: none; background-image: url(${ctxStatic}/images/login.png); background-repeat: no-repeat; height: 198px; height: 208px\9; padding-left:60px; padding-top:60px; padding-top:50px\9; padding-right:50px; margin-top: 6%; *margin-top:0; margin-right: auto; margin-bottom: auto; margin-left: auto; *top:100px;}
.form-signin .checkbox { margin-bottom:10px; color:#0663a2; }
@media screen and (-webkit-min-device-pixel-ratio:0) {.form-signin{margin-top: 8%;}}
.form-signin .input-label { font-size:16px; line-height:30px; color:#000; float: left; width: 100px; text-align: right; padding-right: 10px; font-family: "微软雅黑"; }
.form-signin .input-block-level { font-size:16px; *width:283px; *padding-bottom:0; _padding:7px 7px 9px 7px; width: 220px; line-height: 25px; height: 25px; clear: right; }
.form-signin .btn.btn-large { font-size:16px; }
.form-signin #themeSwitch { position:absolute; right:30px; bottom:30px; }
.form-signin div.validateCode { padding-bottom:15px; }
.mid { vertical-align:middle; }
.header { height:60px; padding-top:30px; }
.alert { position:relative; width:300px; ; margin:0 auto; *margin:0 0 0 78px; *padding-bottom:0px; *text-align:center;  }
label.error { background:none; padding:2px; font-weight:normal; color:inherit; margin:0; }
body { background-attachment: fixed; background-image: url(${ctxStatic}/images/login_bg.jpg); background-repeat: no-repeat; background-position: center center; }
.submit { margin-left: 50px; }
.dropdown-menu { margin-top: 2px; margin-right: -20px; margin-bottom: 0px; margin-left: -20px; min-width:100px; }
.logn { width:360px; height:100px; margin:20px auto auto auto; }
#messageBox { z-index:9999; position:absolute; top:15px; top:5px\9; left:80px; *left:0px; width:320px; text-align:center; *text-align:left; }
    </style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架中，则跳转刷新上级页面
		if(self.frameElement && self.frameElement.tagName=="IFRAME"){
			parent.location.reload();
		}
	</script>
	</head>
	<body>
<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]--> 

<!--<h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>-->
<div class="logn"><div style="font-size: 50px;margin-top: 60px;text-align: center;color: #006dcc;">${fns:getConfig('productName')}</div></div>

<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
<%String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);%>
		<div id="messageBox" class="alert alert-error <%=error==null?"hide":""%>"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error"><%=error==null?"":"CaptchaException".equals(error)?"验证码错误, 请重试.":"用户或密码错误, 请重试." %></label>
  </div>
    </div>
<label class="input-label" for="username">登录名</label>
      <input type="text" id="username" name="username" class="input-block-level required" value="${username}">
      <label class="input-label" for="password">密码</label>
      <input type="password" id="password" name="password" class="input-block-level required">
      <c:if test="${isValidateCodeLogin}">
    <div class="validateCode">
          <label class="input-label mid" for="validateCode">验证码</label>
          <tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
        </div>
  </c:if>
<div style="margin-left: 90px;">
	<input class="btn btn-large btn-primary submit" type="submit" value="登 录"/>
      &nbsp;&nbsp;
      <label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe"/>记住我</label>
</div> <%--   <div id="themeSwitch" class="dropdown"> <a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
    <ul class="dropdown-menu">
          <c:forEach items="${fns:getDictList('theme')}" var="dict">
        <li><a href="#" onClick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li>
      </c:forEach>
        </ul>
    <!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]--> 
  </div> --%>
    </form>

<!--<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
		<label class="input-label" for="username">登录名</label>
		<input type="text" id="username" name="username" class="input-block-level required" value="${username}">
		<label class="input-label" for="password">密码</label>
		<input type="password" id="password" name="password" class="input-block-level required">
		<c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode">验证码</label>
			<tags:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if>
		<input class="btn btn-large btn-primary" type="submit" value="登 录"/>&nbsp;&nbsp;
		<label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe" name="rememberMe"/> 记住我（公共场所慎用）</label>
		<div id="themeSwitch" class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onClick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
			<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]--> 
<!--</div>
	</form>-->
<div  style="text-align:center;height:30px; width:100%;
position:absolute;
bottom:20px; 
overflow:hidden;">Copyright &copy; ${fns:getConfig('copyrightYear')} <a href="${pageContext.request.contextPath}${fns:getFrontPath()}">${fns:getConfig('productName')}</a> - <a href="" target="_blank">demo</a> ${fns:getConfig('version')}</div>
</body>
</html>