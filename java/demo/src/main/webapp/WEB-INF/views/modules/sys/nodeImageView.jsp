<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<%@ include file="/WEB-INF/views/include/ligerui.jsp"%>
<%@ include file="/WEB-INF/views/include/dialog.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<title>流程图</title>
<script type="text/javascript">
var obj=null;
$(function(){
	 
	  var menu = null;
	$.post(
			"${ctx}/sys/workflow/flowInfo?deploymentId=${defId}",
			function(data, textStatus) {
				var myobj = eval(data);
				$("<div style='position:absolute;z-index:2'>红色表示可配置</br>绿色表示不可配置</div>").insertAfter("#dd");
				for ( var i = 0; i < myobj.length; i++) {
					var X = $('#myimg').offset().top + myobj[i].x;
					var Y = $('#myimg').offset().left + myobj[i].y;
					var act_id = myobj[i].vars.id;
					var act_type = myobj[i].vars.type;
					var act_doc = myobj[i].vars.documentation;
					var act_multi =  myobj[i].vars.multi;
					var infodiv_id = 'infodiv'+i;
					var oNewp;
					if(act_multi)
					{
						oNewp = $("<div  style='filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5;background: green;width:"+myobj[i].width+"px;height:"+myobj[i].height+"px;left:"+X+"px; top:"
								+Y+"px;position:absolute;z-index:2' class='roundInfo' id='"+act_id+"'></div>");
						oNewp.insertAfter("#dd");;
					}
					else if(act_type == "userTask" && !act_multi)
				    {
						oNewp = $("<div  style='filter:alpha(opacity=50);-moz-opacity:0.5;-khtml-opacity: 0.5;opacity: 0.5;background: red;width:"+myobj[i].width+"px;height:"+myobj[i].height+"px;left:"+X+"px; top:"
								+Y+"px;position:absolute;z-index:2' class='roundInfo' id='"+act_id+"'></div>");
						oNewp.insertAfter("#dd");;
				    }
					else{//其他节点
						//oNewp = $("<div id='div"+i+"' style='filter:alpha(opacity=30);width:"+myobj[i].width+"px;height:"+myobj[i].height+"px;left:"+X+"px; top:"+Y+"px;position:absolute;z-index:2' class='roundinfo'></div>");
						oNewp = $("<div  style='width:"+myobj[i].width+"px;height:"+myobj[i].height+"px;left:"+X+"px; top:"
								+Y+"px;position:absolute;z-index:2' class='roundInfo' id='"+act_id+"'></div>");
						oNewp.insertAfter("#dd");;
					}
					if(act_type == "userTask" && !act_multi)
					{
						 oNewp.bind("contextmenu",function(e){
						 if(menu !=null)
						 {
							 menu.hide();
						 }
						 obj = $(this);
				   		 menu = $.ligerMenu({ top: 100, left: 100, width: 140, items: [{id:'userSet', text: '设置节点人员',click:nodeSet,icon:'${ctx}/css/img/icons/16/user_add.png' }]});
				   		 menu.show({ top: e.pageY, left: e.pageX  }); 
				   		return false;
					   	});
					}
				}
				$('#myimg').attr("src",
						"${ctx}/sys/workflow/loadByResource?deploymentId=${defId}");
			});

    function nodeSet(){
        var nodeId = obj.attr("id");
        var deploymentId = '${defId}';
        menu.hide();
        new NodeSet({
            nodeId:nodeId,
            deploymentId:deploymentId
        });
        return false;
    }
});




</script>
</head>
<body>
<div id="dd" style="position:absolute;z-index:1;">
	<img id="myimg" src="" />
</div>
</body>
</html>
