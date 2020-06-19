<%--
  Created by IntelliJ IDEA.
  User: 肖祯
  Date: 2020/6/2
  Time: 15:57
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
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <style>
from{
    margin-left: 100px;
}
    </style>
</head>
<body>

<%--服务列表查看详情--%>
<form class="layui-form" id="serviceListView" action="" style="display: inline-block">
    <div class="layui-form-item">
        <label class="layui-form-label">账户类型：</label>

                <input type="text" id="account" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">账户余额：</label>
                <input type="text" id="money" readonly="readonly">
    </div>
</form>
<br>
资金明细-------------------------------------------------------------------------------------------------------------
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container" style="display: inline-block">
        <button class="layui-btn layui-btn-sm" lay-event="query">查询</button>
    </div>
    <input type="text" name="origin" id="origin">
</script>

<table class="layui-hide" id="test2" lay-filter="test2"></table>
<script>





        //人员资料
        layui.use('table', function(){

            var table = layui.table;
            var $ = layui.jquery;


$(function () {
    $.ajax({
        type: 'POST',
        url: "<%=path%>/companyAccountContrller/selectbalance",
        dataType: 'JSON',
        success: function (msg) {
            alert(JSON.toString(msg));
            $("#money").val(msg.data[0].balance);
        }
    });
})

            table.render({
                elem: '#test2'
                ,url:'<%=path%>/companyAccountContrller/selectList'
                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                ,defaultToolbar: []
                ,title: '公司资料表'
                ,cols: [[
                    {type: 'checkbox', fixed: 'left'}
                    ,{field:'id', title:'ID',sort: true}
                    ,{field:'time', title:'发生时间'}
                    ,{field:'origin', title:'资金来源', sort: true}
                    ,{field:'amountMoney', title:'余额', sort: true}
                    ,{field:'optionType', title:'操作类型', sort: true}
                ]]
                ,page: true
            });



            //头工具栏事件
            table.on('toolbar(test2)', function(obj){
                var checkStatus = table.checkStatus(obj.config.id);
                switch(obj.event){
                    case 'getCheckData':
                        var data = checkStatus.data;
                        layer.alert(JSON.stringify(data));
                        break;
                    case 'getCheckLength':
                        var data = checkStatus.data;
                        layer.msg('选中了：'+ data.length + ' 个');
                        break;
                    case 'isAll':
                        layer.msg(checkStatus.isAll ? '全选': '未全选');
                        break;
                    //根据时间查询服务信息表
                    case 'query':
                        //查询时间段
                        //执行重载
                        var origin=$("#origin").val();
                        //执行重载
                        table.reload('test2', {
                            url: '<%=path%>/companyAccountContrller/selectList'
                            ,page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            ,where: {
                                origin:origin
                            }
                        });
                        $('#origin').val(origin);
                        break;
                }
            });

        });
</script>
</body>
</html>
