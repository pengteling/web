var webroot="/";
function loadcart() {
    $.ajax({
        type: "post",
        cache: !1,
        url: webroot + "cart.asp?act=loadcart",
        success: function(a) {
            $("#cartlist").html(a)
        }
    })
}
function editcard(a, b) {
    var c = $(a).attr("value"),
    d = $(a).attr("productid"),
    e = /^\+?[0-9][0-9]*$/;
    return e.test(c) ? 0 == c ? (delcart(d), !1) : (editnum(d, c), void 0) : ($(a).val(b), $.message({
        type: "warn",
        content: "\u8bf7\u6b63\u786e\u8f93\u5165\u5546\u54c1\u6570\u91cf"
    }), !1)
}
function editnum(a, b) {
    $.ajax({
        type: "post",
        cache: !1,
        url: webroot + "cart.asp?act=editcart&id=" + a + "&shopnum=" + b,
        success: function(a) {
            1 == a && (loadcart(), get_cartnum())
        }
    })
}
function delcart(a) {
    confirm("\u60a8\u8981\u4ece\u8d2d\u7269\u8f66\u4e2d\u79fb\u9664\u6b64\u5546\u54c1\u5417\uff1f") && $.ajax({
        type: "post",
        cache: !1,
        url: webroot + "cart.asp?act=delcart&id=" + a,
        success: function(a) {
            1 == a && (loadcart(), get_cartnum())
        }
    })
}
$(function() {
    $("#cartlist").length > 0 && loadcart(),
    $("#cartlist .min").live("click",
    function() {
        var a = $(this).attr("old"),
        b = $(this).attr("productid");
        return a--,
        0 == a ? (delcart(b), !1) : (editnum(b, a), void 0)
    }),
    $("#cartlist .max").live("click",
    function() {
        var a = $(this).attr("old"),
        b = $(this).attr("productid");
        a++,
        a >= 999 && (a = 999),
        editnum(b, a)
    })
});