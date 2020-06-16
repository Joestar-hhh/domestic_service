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
        <img class="logo" src="<%=path%>/static/pear_layui/admin/images/logo.png"/>
        <div class="title">传一家政用户平台</div>
        <div class="desc">
            福 建 省 最 具 影 响 力 的 家 政 公 司 之 一
        </div>
    </div>
    <div class="layui-form-item">
        <input type="text" placeholder="账 户 : user" hover class="layui-input" id="account" value="user1"/>
    </div>
    <div class="layui-form-item">
        <input type="password" placeholder="密 码 : 123456" hover class="layui-input" id="pwd" value="123456"/>
    </div>
    <div class="layui-form-item">
        <%--        <input placeholder="验证码" hover class="layui-input layui-input-inline" style="width: 50%;display: inline-block!important;"/>--%>
        <%--        <img src="https://yun.reg.163.com/urscloud/captcha?type=captcha_pwd&1568683587149" style="border-radius:3px;border: 1px #e6e6e6 solid;height: 100%;width: 45%;display: inline-block!important;height: 42px;" />--%>
        <input type="text" value="" placeholder="请输入验证码" class="layui-input layui-input-inline"
               style="width: 50%;display: inline-block!important;" id="checkcode">
        <canvas id="canvas" onclick="dj()"
                style="border-radius:3px;border: 1px #e6e6e6 solid;height: 100%;width: 45%;display: inline-block!important;height: 42px"
        ></canvas>
    </div>
    <div class="layui-form-item">
        <a href="<%=path%>/pages/company/company_updatepwd.jsp">忘记密码</a>
        &nbsp;&nbsp;&nbsp;
        <a href="<%=path%>/pages/company/company_registered.jsp">快速注册</a>
    </div>
    <div class="layui-form-item">
        <button class="pear-btn pear-btn-primary login">
            登 录
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
            var account = $("#account").val();
            var pwd = $("#pwd").val();
            var num = show_num.join("");
            $("#checkcode").val(num);
            var val = $("#checkcode").val();

            if (account == '') {
                layer.msg('账号不能为空');
                return false;
            }
            if (pwd == '') {
                layer.msg('密码不能为空');
                return false;
            }
            if (val == '') {
                layer.msg('请输入验证码！');
                return false;
            } else if (val.toLowerCase() == num.toLowerCase()) {
                $.ajax({
                    url: '<%=path%>/userController/userLogin',
                    type: 'POST',
                    dataType: 'JSON',
                    data: {
                        account: account,
                        pwd: pwd
                    },
                    success: function (msg) {
                        if (msg.code == '0') {
                            layer.msg(msg.msg)
                            <%--location.href = "<%=path%>/pages/back/back_adminhome.jsp"--%>
                        } else {
                            layer.msg(msg.msg);
                        }
                    }
                })
            } else {
                layer.msg('验证码错误！\n你输入的是:  ' + val + "\n正确的是:  " + num + '\n请重新输入！');
                document.getElementById("checkcode").value = '';
                draw(show_num);
                return false;
            }
        })
    })
</script>

<script>
    window.onload = function () {
        dj();
    }
    var show_num = [];
    draw(show_num);

    function dj() {
        draw(show_num);
    }

    function draw(show_num) {
        var canvas_width = document.getElementById('canvas').clientWidth;
        var canvas_height = document.getElementById('canvas').clientHeight;
        var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
        var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
        canvas.width = canvas_width;
        canvas.height = canvas_height;
        var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m";
        var aCode = sCode.split(",");
        var aLength = aCode.length;//获取到数组的长度

        for (var i = 0; i <= 3; i++) {
            var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
            var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
            var txt = aCode[j];//得到随机的一个内容
            show_num[i] = txt;
            var x = 10 + i * 20;//文字在canvas上的x坐标
            var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
            context.font = "bold 23px 微软雅黑";

            context.translate(x, y);
            context.rotate(deg);

            context.fillStyle = randomColor();
            context.fillText(txt, 0, 0);

            context.rotate(-deg);
            context.translate(-x, -y);
        }
        for (var i = 0; i <= 5; i++) { //验证码上显示线条
            context.strokeStyle = randomColor();
            context.beginPath();
            context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
            context.stroke();
        }
        for (var i = 0; i <= 30; i++) { //验证码上显示小点
            context.strokeStyle = randomColor();
            context.beginPath();
            var x = Math.random() * canvas_width;
            var y = Math.random() * canvas_height;
            context.moveTo(x, y);
            context.lineTo(x + 1, y + 1);
            context.stroke();
        }
    }

    function randomColor() {//得到随机的颜色值
        var r = Math.floor(Math.random() * 256);
        var g = Math.floor(Math.random() * 256);
        var b = Math.floor(Math.random() * 256);
        return "rgb(" + r + "," + g + "," + b + ")";
    }

    function showErrorMsg(msg) {
        alert(msg);
    }
</script>
</body>
</html>

