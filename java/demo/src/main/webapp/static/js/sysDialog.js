function RoleDialog(h) {
    var e = 805;
    var l = 500;
    h = $.extend({}, {dialogWidth: e, dialogHeight: l, help: 0, status: 0, scroll: 0, center: 1}, h);
    var c = "dialogWidth=" + e + "px;dialogHeight=" + h.dialogHeight + "px;help=" + h.help + ";status=" + h.status + ";scroll=" + h.scroll + ";center=" + h.center;
    if (!h.isSingle) {
        h.isSingle = false;
    }
    var b = __ctx+ "/sys/role/dialog?isSingle=" + h.isSingle;
    b = b.getNewUrl();
    var g = new Array();
    if (h.ids && h.names) {
        var a = h.ids.split(",");
        var k = h.names.split(",");
        for (var f = 0; f < a.length; f++) {
            var d = {id: a[f], name: k[f]};
            g.push(d);
        }
    } else {
        if (h.arguments) {
            g = h.arguments;
        }
    }
    var j = window.showModalDialog(b, g, c);
    if (h.callback) {
        if (j != undefined) {
            h.callback.call(this, j.roleId, j.roleName);
        }
    }
}

function UserDialog(h) {
    var e = 805;
    var l = 500;
    h = $.extend({}, {dialogWidth: e, dialogHeight: l, help: 0, status: 0, scroll: 0, center: 1}, h);
    var c = "dialogWidth=" + e + "px;dialogHeight=" + h.dialogHeight + "px;help=" + h.help + ";status=" + h.status + ";scroll=" + h.scroll + ";center=" + h.center;
    if (!h.isSingle) {
        h.isSingle = false;
    }
    var b = __ctx+ "/sys/user/dialog?isSingle=" + h.isSingle;
    b = b.getNewUrl();
    var g = new Array();
    if (h.ids && h.names) {
        var a = h.ids.split(",");
        var k = h.names.split(",");
        for (var f = 0; f < a.length; f++) {
            var d = {id: a[f], name: k[f]};
            g.push(d);
        }
    } else {
        if (h.arguments) {
            g = h.arguments;
        }
    }
    var j = window.showModalDialog(b, g, c);
    if (h.callback) {
        if (j != undefined) {
            h.callback.call(this, j.userId, j.userName, j.area, j.areaId);
        }
    }
}

function NodeSet(h) {
    var e = 805;
    var l = 200;
    h = $.extend({}, {dialogWidth: e, dialogHeight: l, help: 0, status: 0, scroll: 0, center: 1}, h);
    var c = "dialogWidth=" + e + "px;dialogHeight=" + h.dialogHeight + "px;help=" + h.help + ";status=" + h.status + ";scroll=" + h.scroll + ";center=" + h.center;

    var b = __ctx+ "/sys/workflow/nodeSetSpecific?nodeId="+ h.nodeId+"&deploymentId="+ h.deploymentId ;
    b = b.getNewUrl();
    var g = new Array();
    var j = window.showModalDialog(b, g, c);

}

function flowImageDialog(pid,defId) {
    var conf = {};
    if (!conf)
        conf = {};
    var url = __ctx + "/sys/workflow/flowImage?pid="+pid+"&deploymentId="+defId;
    url =url.getNewUrl();
    var dialogWidth = 805;
    var dialogHeight = 500;
    conf = $.extend({}, {
        dialogWidth : dialogWidth,
        dialogHeight : dialogHeight,
        help : 0,
        status : 0,
        scroll : 1,
        center : 1,
        resize : 1
    }, conf);
    var winArgs = "dialogWidth=" + conf.dialogWidth + "px;dialogHeight="
        + conf.dialogHeight + "px;help=" + conf.help + ";status="
        + conf.status + ";scroll=" + conf.scroll + ";center=" + conf.center
        + ";resizable=" + conf.resize;
    window.showModalDialog(url, "", winArgs);
}