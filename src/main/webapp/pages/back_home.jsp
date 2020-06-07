<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/5/13
  Time: 22:03
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
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>layout 后台大布局 - Layui</title>
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
<%--    <link rel="stylesheet" href="<%=path%>/pages/back/css/back_adminquery.css">--%>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">layui 后台布局</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <li class="layui-nav-item"><a href="">控制台</a></li>
            <li class="layui-nav-item"><a href="">用户</a></li>
            <li class="layui-nav-item">
                <a href="javascript:;">其它系统</a>
                <dl class="layui-nav-child">
                    <dd><a href="">邮件管理</a></dd>
                    <dd><a href="">消息管理</a></dd>
                    <dd><a href="">授权管理</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
<%--                    <img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
<%--                    ${sessionScope.admin.name}--%>
                    admin
                </a>
                <dl class="layui-nav-child">
                    <dd><a href="">基本资料</a></dd>
                    <dd><a href="">安全设置</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">退出</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                    <li class="layui-nav-item">
                        <a class="" href="javascript:;">用户管理</a>
                        <dl class="layui-nav-child">
                            <dd><a href="" target="menu_iframe">用户信息</a></dd>
                        </dl>
                    </li>
            </ul>
            <%--                <c:forEach items="${menuMap}" begin="0" var="i" step="1">--%>
            <%--                    <li class="layui-nav-item">--%>
            <%--                        <a class="" href="javascript:;">${i.key}</a>--%>
            <%--                        <dl class="layui-nav-child">--%>
            <%--                            <c:forEach  items="${i.value}" begin="0" var="j" step="1">--%>
            <%--                                <dd><a href="<%=path%>${j.menuPath}" target="menu_iframe">${j.menuName}</a></dd>--%>
            <%--                            </c:forEach>--%>
            <%--                        </dl>--%>
            <%--                    </li>--%>
            <%--                </c:forEach>--%>

        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <iframe src="" class="menu_iframe" name="menu_iframe" style="width: 100%;height: 96%;border: 0;"></iframe>
    </div>

    <div class="layui-footer">

    </div>
</div>
<script src="<%=path%>/pages/back/js/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
    });
</script>
</body>
</html>
