<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/5/13
  Time: 23:22
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
    <title>申请售后审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <style>
        .layui-input, .layui-textarea {
            display: block;
            width: 27%;
            padding-left: 10px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-form-item" id="querydiv">
        <input type="text" name="orderNumber" id="orderNumber" lay-verify="title" autocomplete="off"
               placeholder="请输入订单号" class="layui-input"><br>
        <button class="layui-btn layui-btn-radius " id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询
        </button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="passCheck">过审</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="nopassCheck">不过审</a>
</script>


<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/afterSalesApplicationController/queryAfterSalesApplication'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '申请售后审核表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号'}
                , {field: 'name', title: '用户姓名'}
                , {field: 'orderNumber', title: '订单号'}
                , {field: 'reason', title: '申请售后原因'}
                , {field: 'applyTime', title: '申请时间'}
                , {field: 'checkState', title: '状态'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });

        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                /*模糊查询*/
                case 'querybtn':
                    //查询
                    var orderNumber = $('#orderNumber').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/afterSalesApplicationController/queryAfterSalesApplication'
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            orderNumber: orderNumber
                        }
                    });
                    orderNumber='';
                    break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            if (obj.event === 'passCheck') {
                layer.confirm('确认通过审核吗?', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: "<%=path%>/afterSalesApplicationController/passCheck",
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            layer.close(index);
                            layer.alert(msg.msg, {icon: 6}, function () {
                                window.location.reload();//启用成功后刷新界面
                            });//启用成功提示
                        }
                    });
                });
            } else if (obj.event === 'nopassCheck') {
                layer.confirm('确定不通过审核吗?', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: "<%=path%>/afterSalesApplicationController/nopassCheck",
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            layer.close(index);
                            layer.alert(msg.msg, {icon: 6}, function () {
                                window.location.reload();//启用成功后刷新界面
                            });//启用成功提示
                        }
                    });
                });
            }

        });


    });

</script>
</body>
</html>