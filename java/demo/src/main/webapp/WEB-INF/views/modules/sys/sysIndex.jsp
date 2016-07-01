<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
	<head>
	<title>${fns:getConfig('productName')}</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<style type="text/css">
#main { padding:0; margin:0; }
#main .container-fluid { padding:0 7px 0 0px; }
#header { margin:0 0 5px; position:static; height:90px; background-image: url(${ctxStatic}/images/head_bg.jpg); background-repeat: no-repeat; background-position: center center; }
#header li { font-size:14px; _font-size:12px; line-height:40px; }
#header .brand { font-family:Helvetica, Georgia, Arial, sans-serif, 黑体; font-size:26px; padding-left:33px; }
#footer { margin:8px 0 0 0; padding:3px 0 0 0; font-size:11px; text-align:center; border-top:2px solid #0663A2; }
#footer, #footer a { color:#999; }
.navbar-inner .brand { height:90px; width:460px; padding-top:0; padding-bottom:0; }
.navbar-inner .brand img { height:90px; }
#menu { position:absolute; top:50px; right:20px;  float:right; left:auto!important; }
.pull-right { position:absolute; top:10px; left:480px; float:left!important; }
.navbar-inner { background:none; filter:none\9!important; }
.navbar .nav > li > a.dropdown-toggle { color:#fdff91; text-shadow:none; padding:0 15px; }
.exit { background-image: url(${ctxStatic}/images/exit.png); background-position: left center; padding-left:25px!important; background-repeat: no-repeat; color: #FFF!important; text-decoration: underline!important; text-shadow:none; }
.address { line-height: 34px; height: 34px; padding-top: 8px; padding-bottom: 8px; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: #b6b6b6; color: #868686; font-size: 14px; padding-left: 30px; margin-bottom:10px; font-weight: bold; }
.address .place { color: #d10020; }
.navbar .nav > li > a { text-shadow:none!important; color:#f6ff94; padding:0; }
.breadcrumb { background:none!important; background-color:#FFF!important; }
.container-fluid { border-top-width: 5px; border-top-style: solid; border-top-color: #0f55b5; }
.nav li { _width:auto; float:left; }
.nav li a { _padding:10 15px; color:#fff; }
.nav .active  a { color:#032473; }
.navbar .nav .dropdown-toggle .caret {margin-top:18px;}
.dropdown-menu li a {color:#333333!important;}
#left { border-right-width: 1px; border-right-style: solid; border-right-color: #ddd; }
    </style>
	<script type="text/javascript"> 
		$(document).ready(function() {
			$("#menu a.menu").click(function(){
				$("#menu li.menu").removeClass("active");
				$(this).parent().parent().addClass("active");
				if(!$("#openClose").hasClass("close")){
					$("#openClose").click();
				}
			});
			$(".dropdown").hover(function(){
				$(this).children(".dropdown-menu").show();
			},function(){
				$(this).children(".dropdown-menu").hide();
				});
		});
	</script>
	</head>
	<body>
<div id="main">
      <div id="header" class="navbar navbar-fixed-top">
    <div class="navbar-inner">
          <div class="brand"><div style="padding-top: 30px;">${fns:getConfig('productName')}</div></div>
          <ul id="menu" class="nav">
        <c:set var="firstMenu" value="true"/>
        <c:forEach items="${fns:getMenuList()}" var="menu" varStatus="idxStatus">
              <c:if test="${menu.parent.id eq 1&&menu.isShow eq 1}">
            <li class="menu ${firstMenu?' active':''}">
                  <div class="nav-left"></div>
                  <div class="nav-middle"><a class="menu" href="${ctx}/sys/menu/tree?parentId=${menu.id}" target="menuFrame" >${menu.name}</a></div>
                  <div class="nav-right"></div>
                </li>
            <c:if test="${firstMenu}">
                  <c:set var="firstMenuId" value="${menu.id}"/>
                </c:if>
            <c:set var="firstMenu" value="false"/>
          </c:if>
            </c:forEach>
        <!--<shiro:hasPermission name="cms:site:select">
              <li class="dropdown"> <a class="dropdown-toggle" data-toggle="dropdown" href="#">${fnc:getSite(fnc:getCurrentSiteId()).name}<b class="caret"></b></a>
            <ul class="dropdown-menu">
                  <c:forEach items="${fnc:getSiteList()}" var="site">
                <li><a href="${ctx}/cms/site/select?id=${site.id}&flag=1">${site.name}</a></li>
              </c:forEach>
                </ul>
          </li>
            </shiro:hasPermission>-->
      </ul>
          <ul class="nav pull-right">
        <!--<li id="themeSwitch" class="dropdown">
			       	<a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
				    <ul class="dropdown-menu">
				      <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onClick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
				    </ul>
				    [if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]
			     </li>-->
        <li class="dropdown"> <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="个人信息">您好,
          <shiro:principal property="name"/>
          </a>
              <ul class="dropdown-menu">
            <li><a href="${ctx}/sys/user/info" target="mainFrame"><i class="icon-user"></i>&nbsp; 个人信息</a></li>
            <li><a href="${ctx}/sys/user/modifyPwd" target="mainFrame"><i class="icon-lock"></i>&nbsp;  修改密码</a></li>
          </ul>
            </li>
        <li><a href="${ctx}/logout" title="退出登录" class="exit">退出</a></li>
        <li>&nbsp;</li>
      </ul>
        </div>
    <!--/.nav-collapse --> 
    
  </div>
      <div class="container-fluid">
    <div id="content" class="row-fluid">
          <div id="left">
        <iframe id="menuFrame" name="menuFrame" src="${ctx}/sys/menu/tree?parentId=${firstMenuId}" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
      </div>
          <div id="openClose" class="close">&nbsp;</div>
          <div id="right">
        <iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;"
						scrolling="yes" frameborder="no" width="100%" height="650"></iframe>
      </div>
        </div>
    <div id="footer" class="row-fluid"> Copyright &copy; ${fns:getConfig('copyrightYear')} ${fns:getConfig('productName')} - <a href="" target="_blank">demo</a> ${fns:getConfig('version')} </div>
  </div>
    </div>
<script type="text/javascript"> 
		var leftWidth = "170"; // 左侧窗口大小
		function wSize(){
			var minHeight = 500, minWidth = 980;
			var strs=getWindowSize().toString().split(",");
			$("#menuFrame, #mainFrame, #openClose").height((strs[0]<minHeight?minHeight:strs[0])-$("#header").height()-$("#footer").height()-32);
			$("#openClose").height($("#openClose").height()-5);
			if(strs[1]<minWidth){
				$("#main").css("width",minWidth-10);
				$("html,body").css({"overflow":"auto","overflow-x":"auto","overflow-y":"auto"});
			}else{
				$("#main").css("width","auto");
				$("html,body").css({"overflow":"hidden","overflow-x":"hidden","overflow-y":"hidden"});
			}
			$("#right").width($("#content").width()-$("#left").width()-$("#openClose").width()-5);
		}
	</script> 
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>