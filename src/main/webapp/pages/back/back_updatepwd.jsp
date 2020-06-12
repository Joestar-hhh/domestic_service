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
    <title>忘记密码</title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>
</head>
<body background="<%=path%>/static/pear_layui/admin/images/background.svg">
<form class="layui-form" action="javascript:void(0);">
    <div class="layui-form-item">
        <img class="logo" src="<%=path%>/static/pear_layui/admin/images/logo.png"/>
        <div class="title">修改密码</div>
    </div>
    <div class="layui-form-item">
        <input type="text" placeholder="手 机 号 码 : phone" hover class="layui-input" id="phone"
               lay-verify="required|phone"/>
    </div>
    <div class="layui-form-item">
        <input type="text" value="" placeholder="请输入验证码" class="layui-input layui-input-inline" lay-verify="required"
               lay-reqtext="验证码是必填项，岂能为空？"
               style="width: 50%;display: inline-block!important;" id="checkcode"/>
        <input type="button" value="获取验证码" id="vcodebtn"
               style="border-radius:3px;border: 1px #e6e6e6 solid;height: 100%;width: 45%;display: inline-block!important;height: 42px"/>
    </div>

    <div class="layui-form-item">
        <%--        <input type="password" placeholder="密 码 : 888888" hover class="layui-input" id="pwd" lay-verify="pass"/>--%>
        <input type="password" name="password" lay-verify="required" placeholder="请输入密码" lay-verify="required"
               lay-reqtext="用户名是必填项，岂能为空？"
               class="layui-input" autocomplete="off">
    </div>
    <div class="layui-form-item">
        <input type="password" placeholder="再 次 输 入 密 码  : 888888" hover class="layui-input" id="pwd2"/>
    </div>
    <div class="layui-input-block">
        <button type="submit" class="layui-btn" lay-submit="" lay-filter="formDemo">立即提交</button>
        <%--        <button type="reset" class="layui-btn layui-btn-primary">重置</button>--%>
    </div>
    <div class="layui-form-item">
        <button class="pear-btn pear-btn-primary login">
            登 入
        </button>
    </div>
</form>
<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>

    layui.use(['form', 'element', 'jquery'], function () {
        var from = layui.form;
        var element = layui.element;
        var $ = layui.jquery;
        $("body").on("click", ".login", function () {
            var phone = $("#phone").val();
            var pwd = $("#pwd").val();
            alert(phone)
        })

        var $ = layui.jquery;
        var countdown = 5;
        $(function () {
            $("#vcodebtn").click(function () {
                if ($("#phone").val() == '') {
                    // alert
                    layer.msg("请输入手机号码");
                } else {
                    $.ajax({
                        url: '<%=path%>/smsController/smsSend',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            phone: $("#phone").val(),
                        },
                        success: function (msg) {
                            // alert(msg.msg)
                            layer.msg(msg.msg);
                        }
                    })
                    settime($(this));
                }
            });
        })

        function settime(val) {
            if (countdown == 0) {
                val.attr("disabled", false);
                val.val("免费获取验证码");
                countdown = 5;
                return false;
            } else {
                val.attr("disabled", true);
                val.val("重新发送(" + countdown + ")");
                countdown--;
            }
            setTimeout(function () {
                settime(val)
            }, 1000)


        }

    })

</script>
</body>
</html>

