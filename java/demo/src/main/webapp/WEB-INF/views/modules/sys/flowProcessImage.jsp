<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var __ctx = '${ctx}';
    </script>
    <script src="${ctxStatic}/js/sysDialog.js" type="text/javascript"></script>
    <style>
        .ui-corner-all-12, .ui-corner-top-12, .ui-corner-left-12, .ui-corner-tl-12 {
            -moz-border-radius-topleft: 12px;
            -webkit-border-top-left-radius: 12px;
            -khtml-border-top-left-radius: 12px;
            border-top-left-radius: 12px;
        }

        .ui-corner-all-12, .ui-corner-top-12, .ui-corner-right-12, .ui-corner-tr-12 {
            -moz-border-radius-topright: 12px;
            -webkit-border-top-right-radius: 12px;
            -khtml-border-top-right-radius: 12px;
            border-top-right-radius: 12px;
        }

        .ui-corner-all-12, .ui-corner-bottom-12, .ui-corner-left-12, .ui-corner-bl-12 {
            -moz-border-radius-bottomleft: 12px;
            -webkit-border-bottom-left-radius: 12px;
            -khtml-border-bottom-left-radius: 12px;
            border-bottom-left-radius: 12px;
        }

        .ui-corner-all-12, .ui-corner-bottom-12, .ui-corner-right-12, .ui-corner-br-12 {
            -moz-border-radius-bottomright: 12px;
            -webkit-border-bottom-right-radius: 12px;
            -khtml-border-bottom-right-radius: 12px;
            border-bottom-right-radius: 12px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            // 获取图片资源
            var imageUrl = "${ctx}/sys/workflow/process-instance?pid=" + ${pid} +"&deploymentId=${deploymentId}" + "&type=image&time=" + new Date().getTime();
            $.ajax(
                    {url: '${ctx}/sys/workflow/trace?pid=${pid}&time=' + new Date().getTime(),
                        async: false,
                        success: function (infos) {
                            var info = infos;/*eval("(" + infos + ")")*/;
                            var positionHtml = "";
                            // 生成图片
                            var varsArray = new Array();
                            $.each(info, function (i, v) {
                                var $positionDiv = $('<div/>', {
                                    'class': 'activiyAttr'
                                }).css({
                                            position: 'absolute',
                                            left: (v.x - 1),
                                            top: (v.y - 1),
                                            width: (v.width - 2),
                                            height: (v.height - 2)
                                        }).attr("name", v.vars.type);
                                if (v.currentActiviti != undefined && v.currentActiviti) {
                                    $positionDiv.addClass('ui-corner-all-12').css({
                                        border: '2px solid red'
                                    });
                                }
                                positionHtml += $positionDiv[0].outerHTML;
                                varsArray[varsArray.length] = v.vars;

                            });
                            if ($('#workflowTraceDialog').length == 0) {
                                var a = $('<div/>', {
                                    id: 'workflowTraceDialog',
                                    html: "<div><img src='" + imageUrl + "' style='position:absolute; left:0px; top:0px;' />" +
                                            "<div id='processImageBorder'>" +
                                            positionHtml +
                                            "</div>" +
                                            "</div>"
                                }).appendTo('#d');
                            } else {
                                $('#workflowTraceDialog img').attr('src', imageUrl);
                                $('#workflowTraceDialog #processImageBorder').html(positionHtml);
                            }
                        }});

        });
    </script>

    <title>流程图显示</title>
</head>

<body>
<div id="d"></div>
</body>
</html>
