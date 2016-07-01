var CreatedOKLodop=CreatedOKLodop7766=null;

function getLodop(oOBJECT,oEMBED,ctxStatic){
/**************************
  本函数根据浏览器类型决定采用哪个页面元素作为Lodop对象：
  IE系列、IE内核系列的浏览器采用oOBJECT，
  其它浏览器(Firefox系列、Chrome系列、Opera系列、Safari系列等)采用oEMBED,
  如果页面没有相关对象元素，则自动建立一个,重复调用本函数会按上次那个。
  64位浏览器指向64位的安装程序install_lodop64.exe。
**************************/
        var strHtmInstall="<br/><font color='#FF0000'>打印控件未安装!点击这里<a href='"+ctxStatic+"/lodop/install_lodop32.zip' target='_self'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
        var strHtmUpdate="<br/><font color='#FF0000'>打印控件需要升级!点击这里<a href='"+ctxStatic+"/lodop/install_lodop32.zip' target='_self'>执行升级</a>,升级后请重新进入。</font>";
        var strHtm64_Install="<br/><font color='#FF0000'>打印控件未安装!点击这里<a href='"+ctxStatic+"/lodop/install_lodop64.zip' target='_self'>执行安装</a>,安装后请刷新页面或重新进入。</font>";
        var strHtm64_Update="<br/><font color='#FF0000'>打印控件需要升级!点击这里<a href='"+ctxStatic+"/lodop/install_lodop64.zip' target='_self'>执行升级</a>,升级后请重新进入。</font>";
        var strHtmFireFox="<br/><font color='#FF0000'>注意：如曾安装过Lodop旧版附件npActiveXPLugin,请在【工具】->【附加组件】->【扩展】中先卸它。</font><br/>";
        var LODOP;		
	try{	
	     //=====判断浏览器类型:===============
	     var isIE	 =  (navigator.userAgent.indexOf('MSIE')>=0) || (navigator.userAgent.indexOf('Trident')>=0);
	     var is64IE  = isIE && (navigator.userAgent.indexOf('x64')>=0);
	     //=====如果页面有Lodop就直接使用，没有则新建或使用上次的:==========
	     if (oOBJECT!=undefined || oEMBED!=undefined) { 
                 if (isIE) LODOP=oOBJECT; 
		 else LODOP=oEMBED;
	     } else { 
		 if (CreatedOKLodop==null || CreatedOKLodop7766==null || CreatedOKLodop!=CreatedOKLodop7766){
          	     LODOP=document.createElement("object"); 
		     LODOP.setAttribute("width",0); 
                     LODOP.setAttribute("height",0); 
		     LODOP.setAttribute("style","position:absolute;left:0px;top:-100px;");  
		     if (isIE) LODOP.setAttribute("classid","clsid:2105C259-1E0C-4534-8141-A753534CB4CA");
		     else LODOP.setAttribute("type","application/x-print-lodop"); 		
		     document.getElementById("error").appendChild(LODOP); 
	             CreatedOKLodop=CreatedOKLodop7766=LODOP;		     
 	         } else LODOP=CreatedOKLodop;
	     };
	     //=====判断Lodop插件是否安装过，没有安装或版本过低就提示下载安装:==========
	     if ((LODOP==null)||(typeof(LODOP.VERSION)=="undefined")) {
		 if (navigator.userAgent.indexOf('Firefox')>=0)
  	         	     {document.getElementById("error").innerHTML=strHtmFireFox+document.getElementById("error").innerHTML;};
		 if (is64IE) {document.write(strHtm64_Install);} else		 
	 	 if (isIE)   {document.write(strHtmInstall);   } else 
  	                     {document.getElementById("error").innerHTML=strHtmInstall+document.getElementById("error").innerHTML;};	 
		 return LODOP; 
	     } else 
	     if (LODOP.VERSION<"6.1.6.6") {
		if (is64IE){document.write(strHtm64_Update);} else
		if (isIE)  {document.write(strHtmUpdate);    } else
		           {document.getElementById("error").innerHTML=strHtmUpdate+document.getElementById("error").innerHTML; };
		return LODOP;
	     }
	     //=====如下空白位置适合调用统一功能(如注册码、语言选择等):====	     
		LODOP.SET_LICENSES("江苏华生恒业科技有限公司","339DD1938EE17DE8296B454CA683CAE1","",""); 

	     //============================================================	     
	     return LODOP; 
	}catch(err){
		if (is64IE)	
		document.getElementById("error").innerHTML="Error:"+strHtm64_Install+document.getElementById("error").innerHTML;else
		document.getElementById("error").innerHTML="Error:"+strHtmInstall+document.getElementById("error").innerHTML;
	     return LODOP; 
	}
}
