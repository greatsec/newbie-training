(function($)
{
    $.UIAdapter = $.UIAdapter || {};

    var Dialog = function(opts)
    {
        this.adapter = $.DialogAdapter(opts);
    };

    var defaultOpts = {
        url : null,
        title : "",
        width : 800,
        height : 600,
        resizable : false,
        data:""
    };

    $.UIAdapter.Dialog = function(o)
    {
        this.opts = $.extend({}, defaultOpts, o);
        return new Dialog(this.opts);
    };
})(jQuery);