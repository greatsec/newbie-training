<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/javascript">
$(document).ready(function() {
    //自动完成填写
    $( "#sampleSource" ).autocomplete({
		source:"${ctx}/biz/orders/getSampleSource",
		select: function( event, ui ) {
		    $("#sampleSourceId").val(ui.item.values);
		}
    });
    // 提交校验
	$("#inputForm").validate({
		rules: {           //定义验证规则,其中属性名为表单的name属性  
			ptSex:{required:true },
            ptEmail:{email:true }, 
            drEmail:{email:true },
            cEmail:{email:true },
            ptId:{card:true},
            testFee:{number:true,min:0,max:1000000000}
		},
		submitHandler: function(form){
			if($("#sampleList").find("tr").length<=0){
				var submit = function (v, h, f) {
					if (v == 'ok'){
						loading('正在提交，请稍等...');
						form.submit(); 
					}
					return true; 
				};
				$.jBox.confirm("确定不添加样本吗？", "提示", submit);
			}else{
				/* 在提交form表单之前 换掉名字,并重新排序,这样后台就不需过滤空 对象 */
	            var i = 0;
				$("#sampleList").find("tr").each(function()
	            {
					$(this).find("input[name$='id']").attr("name", $.format('samples[{0}].id', i));
	                $(this).find("input[name$='label']").attr("name", $.format('samples[{0}].label', i));
	                $(this).find("input[name$='expType']").attr("name", $.format('samples[{0}].expType', i));
	                $(this).find("input[name$='taker']").attr("name", $.format('samples[{0}].taker', i));
	                $(this).find("input[name$='takeDate']").attr("name", $.format('samples[{0}].takeDate', i));
	                $(this).find("input[name$='testItem']").attr("name", $.format('samples[{0}].testItem', i));
	                $(this).find("input[name$='type']").attr("name", $.format('samples[{0}].type', i));
	                $(this).find("input[name$='testType']").attr("name", $.format('samples[{0}].testType', i));
	                $(this).find("input[name$='typeText']").attr("name", $.format('samples[{0}].typeText', i));
	                $(this).find("input[name$='testTypeText']").attr("name", $.format('samples[{0}].testTypeText', i));
	                i++;
	            });
				loading('正在提交，请稍等...');
				form.submit(); 
			}
		},
		errorContainer: "#messageBox",
		errorPlacement: function(error, element) {
			$("#messageBox").text("输入有误，请先更正。");
			if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
				error.appendTo(element.parent().parent());
			} else {
				error.insertAfter(element);
			}
		}
	});
	// 选择销售人员
	$("#saleByBtn").click(function() {
		 new UserDialog({
             isSingle:true,
             callback:function(id,name,area,areaId) {
            	 $("#saleName").val(name);
                 $("#saleById").val(id);
                 $("#saleAreaName").text(area);
                 $("#saleAreaId").val(areaId);
             }
         });
    });
	// 根据小写金额显示大写金额
	$("#testFee").change(function(){
		$("#uppercase").text($.convertCurrency($(this).val()));
	});
	// 加载显示金额大写
	$("#testFee").trigger('change');  
	// 删除样本信息
	$("a#delete").live("click",function(){
		var object = $(this).parent().parent();
		var submit = function (v, h, f) {
			if (v == 'ok')
				object.remove();;
			return true; 
		};
		$.jBox.confirm("确定要删除吗？", "提示", submit);
	});
	// 添加样本信息
	var addIndex = 0;
	var root;
	var submit = function (v, h, f) {
		if(!$("#sampleForm").valid()) return false;
		if(!f.type || !f.testType ){
			top.$.jBox.tip("请选择采样类型 和检测类型" );
			return false;
		}
		var newObj = $("tbody#template tr").clone(true);
		newObj.find("td:eq(0)").text(f.label);
		newObj.find("td:eq(2)").text(f.taker);
		newObj.find("td:eq(3)").text(f.takeDate);
		newObj.find("td:eq(5)").text(f.testItem);
		newObj.find("td:eq(6)").text($("#expType option[value='"+(f.expType)+"']",h).html());
        if($.trim(f.typeText)!="")
			newObj.find("td:eq(1)").text(f.typeText);
		else
			newObj.find("td:eq(1)").text($("input[name='type'][value='"+(f.type)+"']",h).next("label").text());
		// 检测类型
	    var str = "";
		var testTypeV = (f.testType+"").split(",");
		for(var i=0;i<testTypeV.length;i++){
			str+=$("input[name='testType'][value='"+testTypeV[i]+"']",h).next("label").text()+";";
		}
        newObj.find("td:eq(4)").text(str.substring(0,str.length-1)+$.trim(f.testTypeText));
           	
        var hideTd = newObj.find("td:eq(7)");
        hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].id").attr("value", f.sampleId));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].label").attr("value", f.label));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].taker").attr("value", f.taker));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].takeDate").attr("value", f.takeDate));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].type").attr("value", f.type));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].typeText").attr("value", f.typeText));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].testType").attr("value", f.testType));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].testTypeText").attr("value", f.testTypeText));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].testItem").attr("value", f.testItem));
		hideTd.append($("<input type='hidden'/>").attr("name", "samples["+addIndex+"].expType").attr("value", f.expType));
		if(f.sampleId==null || f.sampleId==''){
			hideTd.append("  <a id='delete' href='javascript:;'>删除</a> ");
        }
		if(root)
			root.replaceWith(newObj);
		else
			$("tbody#sampleList").append(newObj);
		root=null;
	    addIndex++;
	    return true;
	};
	$("#sampleBtn").click(function(){
		$.jBox("get:${ctx}/biz/sample/form2", { title: "样本信息",width: 800,
		    height: 450, submit: submit }); 
	});
	// 修改样本信息
	$("a#update").live("click",function(){
		root = $(this).parent().parent();
		var sample = {
			id:root.find("input[name$='id']").val(),
			label:root.find("input[name$='label']").val(),
			expType:root.find("input[name$='expType']").val(),
			taker:root.find("input[name$='taker']").val(),
			takeDate:root.find("input[name$='takeDate']").val().substring(0,10),
			testItem:root.find("input[name$='testItem']").val(),
			type:root.find("input[name$='type']").val(),
			testType:root.find("input[name$='testType']").val(),
			typeText:root.find("input[name$='typeText']").val(),
			testTypeText:root.find("input[name$='testTypeText']").val()
		};
		var loaded=function(a){
			$("#sampleId",a).val(sample.id);
			$("#label",a).val(sample.label);
			$("#expType option[value='"+(sample.expType)+"']",a).attr("selected", "selected");
			$("#taker",a).val(sample.taker);
			$("#takeDate",a).val(sample.takeDate);
			$("#testItem",a).val(sample.testItem);
			$("#typeText",a).val(sample.typeText);
			$("#testTypeText",a).val(sample.testTypeText);
			$("input[name='type'][value='"+(sample.type)+"']",a).attr("checked", true);
			var testType = $("input[name='testType']",a);
            var testTypeV = (sample.testType).split(",") 
            for(var i=0;i<testTypeV.length;i++){
            	$("input[name='testType'][value='"+testTypeV[i]+"']",a).attr("checked", true);
            }
		}
        $.jBox("get:${ctx}/biz/sample/form2", { title: "样本信息",width: 800,
		    height: 450, loaded:loaded,submit: submit }); 
	});
	// 废弃订单
	$("#btnAbandon").click(function(){
		var root = $(this).parent().parent();
		var submit = function (v, h, f) {
		    if (v == 'ok'){
		    	$("#isAbandon").val('1');
		    	$("form#inputForm").submit();
		    }
		    return true; 
		};
		$.jBox.confirm("确定废弃订单吗？", "提示", submit);
	});
});
</script>