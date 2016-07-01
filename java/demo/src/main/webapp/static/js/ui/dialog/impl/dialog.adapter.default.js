(function($)
{
    var DialogAdapter = function(opts)
    {
        // 打开对话框前先进行权限验证
        $.get(_ctx + "/verifyAuthority.do?url=" + opts.url, {}, function(result)
        {
            if (result == true)
            {
                var features = "dialogWidth=" + opts.width + "px;dialogHeight=" + opts.height
                        + "px;help=0;status=0;scroll=0;center=1;";
                window.showModalDialog(_ctx + "/dialog.do", opts, features);
            } else
            {
                window.location = _ctx + "/login_input.do";
            }
        });

    };

    $.DialogAdapter = function(o)
    {
        return new DialogAdapter(o);
    };
})(jQuery);