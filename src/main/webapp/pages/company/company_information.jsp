<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/9
  Time: 23:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>入住申请</title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>

</head>

<body>


<form class="layui-form" action="javascript:void(0);">
    <div class="layui-form-item">
        <img class="logo" src="<%=path%>/upload/3.jpg"/>
        <div class="title">入驻申请</div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">区域：</label>
        <div class="layui-input-block">
            <select name="regionList" id="regionList" lay-filter="regionList" lay-verify="required"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公司描述：</label>
        <div class="layui-input-block">
            <input type="text" lay-verify="required" name="companyProfile" class="layui-input" id="companyProfile">
        </div>
    </div>

    <div class="layui-form-item" id="typeName">
        <%--        <input type="checkbox" name="like1[write]" lay-skin="primary" title="写作" checked="" >--%>
        <%--        <input type="checkbox" name="typeName" lay-skin="primary" title="擦玻璃" checked="">--%>
        <%--        <input type="checkbox" name="typeName" lay-skin="primary" title="写作" checked="">--%>
    </div>

    <div class="layui-input-item">
        <button type="submit" class="layui-btn pear-btn-primary login" lay-submit="" lay-filter="formDemo">立即提交</button>
    </div>

</form>
<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>

    //监听提交


    layui.use(['form', 'element', 'jquery'], function () {
        var randomNum;
        var from = layui.form;
        var element = layui.element;
        var $ = layui.jquery;
        from.render();

        //获取地区
        $.ajax({
            url: '<%=path%>/companyController/queryregionList',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                // layer.msg(msg.msg);
                $("#regionList").html("<option value=''></option>")
                $.each(msg.data, function (i, item) {
                    $("#regionList").append("<option value='" + item.id + "'>" + item.region + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        });

        //获取公司类别
        $.ajax({
            url: '<%=path%>/serviceTypeContrller/queryServiceType',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                $.each(msg.data, function (i, item) {
                    $("#typeName").append('<input type="checkbox" name="typeName"  lay-skin="primary" title="' + item.typeName + '" value="' + item.id + '">')
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        })


        from.on('submit(formDemo)', function (data) {
            // alert($("#regionList").val() + "=地区id>>>");

            var typridList = new Array();
            $("#typeName>input[type='checkbox']").each(function (i) {
                if ($(this).next().attr("class") == "layui-unselect layui-form-checkbox layui-form-checked") {
                    // alert("你选了有："+$(this).attr('title')+"    "+$(this).attr('value'));
                    typridList.push($(this).attr('value'));
                }
            })


            if(typridList.length==0){
                layer.msg("请选择公司类别");
                return false;
            }

            $.ajax({
                url: '<%=path%>/serviceTypeContrller/addServiceContinuous',
                type: 'POST',
                dataType: 'JSON',
                data: {
                    regionId: $("#regionList").val(),
                    companyProfile: $("#companyProfile").val(),
                    typridList: JSON.stringify(typridList)
                },
                success: function (msg) {
                    layer.msg(msg.msg);
                }
            })
            // alert(typridList==》选择类别id);
        })
    });
</script>
</body>
</html>

