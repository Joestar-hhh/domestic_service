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
    <%--    registered--%>
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
        <input type="text" placeholder="手 机 号 码 : phone" hover class="layui-input" id="phone" name="phone"
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
        <input type="password" name="pwd" lay-verify="required" placeholder="请输入密码" lay-verify="required"
               lay-reqtext="密码是必填项，岂能为空？"
               class="layui-input" autocomplete="off" id="pwd">
    </div>
    <div class="layui-form-item">
        <%--        <input type="password" placeholder="密 码 : 888888" hover class="layui-input" id="pwd" lay-verify="pass"/>--%>
        <input type="password" lay-verify="required" placeholder="再 次 输 入 密 码  : 888888" lay-verify="required"
               lay-reqtext="密码是必填项，岂能为空？"
               class="layui-input" autocomplete="off" id="pwd2">
    </div>
    <div class="layui-input-item">
        <button type="submit" class="layui-btn pear-btn-primary login" lay-submit="" lay-filter="formDemo">立即提交</button>

        <a href="<%=path%>/pages/back/back_login.jsp/">
           <input type="button" value="返回">
        </a>
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

        from.on('submit(formDemo)', function (data) {
            if ($("#checkcode").val() != randomNum) {
                layer.msg("验证码错误");
                return false;
            }
            if ($("#pwd").val() != $("#pwd2").val()) {
                layer.msg("密码不一致");
                return false;
            }
            if ($("#pwd").val().length <= 5) {
                alert("您的密码长度小于6！");
                return false
            }
            // layer.msg(JSON.stringify(data.field));//此处显示输入内容
            $.ajax({
                url: '<%=path%>/companyController/phone_update_pwd',
                type: 'POST',
                dataType: 'JSON',
                data: data.field,
                success: function (msg) {
                    layer.msg(msg.msg);
                }
            })
            return false;

        });

        var $ = layui.jquery;
        var countdown = 60;
        //判断手机号码是否争取，发送验证吗
        $(function () {
            $("#vcodebtn").click(function () {
                if ($("#phone").val() == '') {
                    layer.msg("请输入手机号码");
                } else if (checkPhone() == false) {
                    layer.msg("手机号码有误，请重填");
                } else {
                    randomNum = ('000000' + Math.floor(Math.random() * 999999)).slice(-6);
                    $.ajax({
                        url: '<%=path%>/smsController/smsSend',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            phone: $("#phone").val(),
                            checkcode: randomNum
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

        //验证码倒计时
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

        //判断是否是手机号码
        function checkPhone() {
            var phone = document.getElementById('phone').value;
            if (!(/^1[3456789]\d{9}$/.test(phone))) {
                return false;
            }
        }
    })
</script>
</body>
</html>

