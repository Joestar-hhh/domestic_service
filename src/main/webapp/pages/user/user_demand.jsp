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
    <title>发布需求</title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>

    <style>
        .layui-form {
            width: 330px;
            margin: auto;
            margin-top: 100px;
        }
    </style>
</head>

<body>
<form class="layui-form" action="javascript:void(0);">

    <div class="layui-form-item">
        <label class="layui-form-label">详细地址：</label>
        <div class="layui-input-block">
            <input type="text" lay-verify="required" name="detailAddress" class="layui-input" id="detailAddress">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务类别：</label>
        <div class="layui-input-block">
            <select name="serviceId" id="serviceId" lay-filter="regionList" lay-verify="required"></select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">服务频次：</label>
        <div class="layui-input-block">
            <select name="frequency" id="frequency" lay-filter="regionList" lay-verify="required">
<%--                <option value=''></option>--%>
                <option value='单次'>单次</option>
                <option value='一月'>一月</option>
                <option value='半年'>半年</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input type="text" lay-verify="required" name="title" class="layui-input" id="title">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">要求描述：</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" class="layui-textarea" lay-verify="required" name="description" id="description"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系方式：</label>
        <div class="layui-input-block">
            <input type="text" name="phone" class="layui-input" id="phone" lay-verify="required|phone">
        </div>
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

        //获取用户默认地址
        $.ajax({
            url: '<%=path%>/userController/queryUserAddress',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {

                $.each(msg.data, function (i, item) {
                    $("#detailAddress").val(item.detailAddress);
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        })


        //获取公司服务类别
        $.ajax({
            url: '<%=path%>/serviceTypeContrller/selectSerice',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                $("#serviceId").html("<option value=''></option>")
                $.each(msg.data, function (i, item) {
                    $("#serviceId").append("<option value='" + item.id + "'>" + item.typeName + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        })
        from.on('submit(formDemo)', function (data) {
            // alert($("#serviceId").val()+"==>服务id");
          $.ajax({
              url:'<%=path%>/userOrderController/insertUserOrder',
              type:'POST',
              dataType: 'JSON',
              data:data.field,
              success:function (msg) {
                  layer.msg(msg.msg)
              }
          })
        })
    });
</script>
</body>
</html>

