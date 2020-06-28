<%@ page import="com.cykj.domestic.entity.Company" %><%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/9
  Time: 23:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<% Company company= (Company) request.getSession().getAttribute("company");%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearTab.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearTheme.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearLoad.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearFrame.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearAdmin.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearNotice.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearSocial.css" />
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearMenu.css" />
    <style id="pearone-bg-color"></style>
    <style>
        #content .layui-tab-content{
            padding: 8px 15px;
        }
    </style>
</head>
<body class="layui-layout-body pear-admin">

<!-- 布局框架 -->
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <ul class="layui-nav layui-layout-left">
            <li class="collaspe layui-nav-item layui-hide-xs"><a href="#" class="layui-icon layui-icon-shrink-right"></a></li>
            <li class="refresh layui-nav-item"><a href="#" class="layui-icon layui-icon-refresh-1"></a></li>
        </ul>
        <div id="control" class="layui-layout-control"></div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide-xs"><a href="#" class="fullScreen layui-icon layui-icon-screen-full"></a></li>
            <li class="layui-nav-item layui-hide-xs"><a href="#" class="layui-icon layui-icon-website"></a></li>
            <li class="layui-nav-item layui-hide-xs" id="headerNotice"></li>
            <li class="layui-nav-item" lay-unselect="">
                <a href="javascript:;" id="name"><img src="<%=path%><%=company.getHead()%>" class="layui-nav-img">
                    <%=company.getCompanyName()%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" class="pearson">个人信息</a></dd>
                    <dd><a href="javascript:;">安全配置</a></dd>
                    <dd><a href="javascript:;">打开百度</a></dd>
                    <dd><a href="javascript:;" id="quit">注销登陆</a></dd>
                </dl>
            </li>
            <li class="setting layui-nav-item"><a href="#" class="layui-icon layui-icon-more-vertical"></a></li>
        </ul>
    </div>
    <div class="layui-side layui-bg-black">
        <div class="layui-logo">
            <img class="logo" src="<%=path%>/static/pear_layui/admin/images/logo.png" />
            <span class="title">公司管理</span>
        </div>
        <div class="layui-side-scroll">
            <div id="sideMenu"></div>
        </div>
    </div>
    <div class="layui-body">
        <div id="content"></div>
    </div>
</div>

<!-- 移动端 遮盖层 -->
<div class="pear-cover"></div>

<!-- 初始加载 动画-->
<div class="loader-main">
    <div class="loader"></div>
</div>


<!-- <div class="loader"></div> -->

<!-- 移动端 的 收缩适配 -->
<div class="collaspe pe-collaspe layui-hide-sm">
    <i class="layui-icon layui-icon-shrink-right"></i>
</div>

<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>

    layui.use(['pearAdmin', 'jquery', 'layer', 'pearTab', 'pearNotice'], function() {
        var pearAdmin = layui.pearAdmin;
        var $ = layui.jquery;
        var pearTab = layui.pearTab;
        var pearNotice = layui.pearNotice;
        var layer = layui.layer;

        var config = {
            keepLoad: 2000, // 主 页 加 载 过 度 时 长 可为 false
            muiltTab: true, // 是 否 开 启 多 标 签 页 true 开启 false 关闭
            control: false, // 是 否 开 启 多 系 统 菜 单 true 开启 false 关闭
            theme: "dark-theme", // 默 认 主 题 样 式 dark-theme 默认主题 light-theme 亮主题
            index: '<%=path%>/static/pear_layui/view/console/console1.html', // 默 认 加 载 主 页
            // data: 'admin/data/menu.json', // 菜 单 数 据 加 载 地 址
            data: '<%=path%>/menuController/queryMenu', // 菜 单 数 据 加 载 地 址
        };

        var option = {
            elem: 'headerNotice',
            url: '<%=path%>/static/pear_layui/admin/data/notice.json',
            height: '250px',
            click: function(id, title) {
                layer.alert("点击消息 : " + id);
            }
        }
        pearAdmin.render(config);
        pearNotice.render(option);
        $("#quit").click(function () {
            layer.confirm('<i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #1E9FFF;"></i> 真的要退出么', function (index) {
                $.ajax({
                    url: '<%=path%>/companyController/quit',
                    type: 'POST',
                    dataType: 'JSON',
                    success: function (msg) {
                        layer.msg(msg.msg);
                        layer.close(index);
                    }
                });
                layer.close(index);
                window.location.href="<%=path%>/pages/company/company_login.jsp";
            },function(index){
                //停止运作
                layer.close(index);
            });
        })
        $("#content .layui-tab-title").children(':first').attr("lay-id","60");
    })

</script>

</body>
</html>

