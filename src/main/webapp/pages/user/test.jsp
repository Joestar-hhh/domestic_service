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
<body>
<form action="/payController/pay" method="POST">
    订单号：<input type="text" name="WIDout_trade_no" required><br/>
    订单名称：<input type="text" name="WIDsubject" required><br/>
    付款金额：<input type="text" name="WIDtotal_amount" required><br/>
    WIDbody：<input type="text" name="WIDbody"><br/>
    <input type="submit" value="下单" id="submit"> <input type="reset" value="重置">
</form>



</body>
</html>

