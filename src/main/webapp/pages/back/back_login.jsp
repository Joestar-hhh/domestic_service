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
    <title></title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>
</head>
<body background="<%=path%>/static/pear_layui/admin/images/background.svg">
<form class="layui-form" action="javascript:void(0);">
    <div class="layui-form-item">
        <img class="logo" src="admin/images/logo.png" />
        <div class="title">Pear Admin</div>
        <div class="desc">
            高 新 区 最 具 影 响 力 的 设 计 规 范 之 一
        </div>
    </div>
    <div class="layui-form-item">
        <input placeholder="账 户 : admin" hover class="layui-input" />
    </div>
    <div class="layui-form-item">
        <input placeholder="密 码 : 888888" hover class="layui-input" />
    </div>
    <div class="layui-form-item">
        <input placeholder="验证码" hover class="layui-input layui-input-inline" style="width: 50%;display: inline-block!important;"/>
        <img src="https://yun.reg.163.com/urscloud/captcha?type=captcha_pwd&1568683587149" style="border-radius:3px;border: 1px #e6e6e6 solid;height: 100%;width: 45%;display: inline-block!important;height: 42px;" />
    </div>
    <div class="layui-form-item">
        <input type="checkbox" name="" title="记住密码" lay-skin="primary" checked>
    </div>
    <div class="layui-form-item">
        <button class="pear-btn pear-btn-primary login">
            登 入
        </button>
    </div>
</form>
<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>
    layui.use(['form', 'element','jquery'], function() {
        var from = layui.form;
        var element = layui.element;
        var $ = layui.jquery;

        $("body").on("click",".login",function(){

            location.href="index.html"
        })
    })
</script>
</body>
</html>

