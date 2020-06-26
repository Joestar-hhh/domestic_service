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
    <title>需求大厅</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <input type="text" name="orderNumber" id="orderNumber" lay-verify="title" autocomplete="off" placeholder="查询订单号"
               class="layui-input">
        <input type="text" name="title" id="title" lay-verify="title" autocomplete="off" placeholder="查询标题"
               class="layui-input">

        <button class="layui-btn layui-btn-sm querybtn" id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询
        </button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="input_Orders">
        <i class="layui-icon layui-icon-edit"></i>接单</a>
</script>

<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/userOrderController/queryUserdemand'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '需求大厅'
            , cols: [[
                {field: 'id', title: '序号', hide: true}
                , {field: 'orderNumber', title: '订单号'}
                , {field: 'pulishTime', title: '订单时间'}
                , {field: 'title', title: '标题'}
                , {field: 'description', title: '要求描述'}
                , {field: 'money', title: '佣金'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
                limits: [10, 15, 20,
                    25, 30, 35, 40, 45, 50],} //每页条数的选择项
        });


        //头工具栏事件查询
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                /*模糊查询*/
                case 'querybtn':
                    //查询
                    var orderNumber = $('#orderNumber').val();
                    var title = $('#title').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/userOrderController/queryUserdemand'
                        // ,methods:"post"
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            title: title,
                            orderNumber: orderNumber
                        }
                    });
                    $('#orderNumber').val(orderNumber);
                    $('#title').val(title);
                    break;
            };
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            //console.log(obj)s
            if (obj.event === 'input_Orders') {
                layer.confirm('接单', function (index) {
                    $.ajax({
                        url: '<%=path%>/userOrderController/updateUserDemend',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        }
                        , success: function (msg) {
                            layer.msg(msg.msg);
                            window.location.reload();
                        }
                    })
                });
            }
        });
    });
</script>
</body>
</html>