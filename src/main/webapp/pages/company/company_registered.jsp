<%@ page import="com.cykj.domestic.entity.Company" %><%--
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
    <title>家政公司账号注册</title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>

</head>

<body background="<%=path%>/static/pear_layui/admin/images/background.svg">


<form class="layui-form" action="javascript:void(0);">
    <div class="layui-form-item">
        <img class="logo" src="<%=path%>/static/pear_layui/admin/images/logo.png"/>
        <div class="title">家政公司账号注册</div>
    </div>
    <input type="text" placeholder="公 司 名称" hover class="layui-input" id="companyName" name="companyName"
           lay-verify="required"/>
    </div>
    <div class="layui-form-item">
        <input type="text" placeholder="法 人 代 表" hover class="layui-input" id="boss" name="boss"
               lay-verify="required"/>
    </div>
    <div class="layui-form-item">
        <%--        <input type="password" placeholder="密 码 : 888888" hover class="layui-input" id="pwd" lay-verify="pass"/>--%>
        <input type="password" name="pwd" lay-verify="required" placeholder="请 输 入 密 码" lay-verify="required"
               lay-reqtext="密码是必填项，岂能为空？"
               class="layui-input" autocomplete="off" id="pwd">
    </div>
    <div class="layui-form-item">
        <%--        <input type="password" placeholder="密 码 : 888888" hover class="layui-input" id="pwd" lay-verify="pass"/>--%>
        <input type="password" lay-verify="required" placeholder="再 次 输 入 密 码 " lay-verify="required"
               lay-reqtext="密码是必填项，岂能为空？"
               class="layui-input" autocomplete="off" id="pwd2">
    </div>
    <div class="layui-form-item">
        <input type="text" placeholder="手 机 号 码 : phone" hover class="layui-input" id="phone" name="phone"
               lay-verify="required|phone"/>
    </div>
    <div class="layui-form-item">
        <input type="text" value="" placeholder="请 输 入 验 证 码" class="layui-input layui-input-inline"
               lay-verify="required"
               lay-reqtext="验证码是必填项，岂能为空？"
               style="width: 50%;display: inline-block!important;" id="checkcode"/>
        <input type="button" value="获取验证码" id="vcodebtn"
               style="border-radius:3px;border: 1px #e6e6e6 solid;height: 100%;width: 45%;display: inline-block!important;height: 42px"/>
    </div>


    <%--    ---------------------%>
    <div class="layui-form-item">
        <a href="<%=path%>/pages/company/company_login.jsp">登入</a>
    </div>

    <div class="layui-input-item">
        <button type="submit" class="layui-btn pear-btn-primary login" lay-submit="" lay-filter="formDemo"
                οnsubmit="return false">立即提交
        </button>
    </div>

</form>
<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>

    //监听提交
    layui.use(['form', 'element', 'jquery'], function () {
        var randomNum;//验证码
        var from = layui.form;
        var element = layui.element;
        var $ = layui.jquery;
        from.render();
        from.on('submit(formDemo)', function (data) {

            if ($("#companyName").val().length > 15) {
                layer.msg("您的公司名称不能大于15位！");
                return false
            }
            if ($("#checkcode").val() != randomNum) {
                layer.msg("验证码错误");
                return false;
            }
            if ($("#pwd").val().length < 6) {
                layer.msg("密码不能少于6位！");
                return false
            }
            if ($("#pwd").val() != $("#pwd2").val()) {
                layer.msg("密码不一致");
                return false;
            }
            // 单击之后提交按钮不可选,防止重复提交
            var DISABLED = 'layui-btn-disabled';
            // 增加样式
            $('.layui-btn').addClass(DISABLED);
            // 增加属性
            $('.layui-btn').attr('disabled', 'disabled');
            $.ajax({
                url: '<%=path%>/companyController/insertCompany',
                type: 'POST',
                dataType: 'JSON',
                data: data.field,
                success: function (msg) {
                    if (msg.code == '0') {
                        layer.alert(msg.msg, function () {
                            $('.layui-btn').removeClass(DISABLED);
                            $('.layui-btn').removeAttr('disabled');
                            location.href = "<%=path%>/pages/company/company_login.jsp"
                        })
                    } else {
                        layer.msg(msg.msg);
                        $('.layui-btn').removeClass(DISABLED);
                        $('.layui-btn').removeAttr('disabled');
                    }
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

