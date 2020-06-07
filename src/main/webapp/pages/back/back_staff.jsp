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
    <title>back_counselor</title>
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

    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="deletetype">删除</button>
            <button class="layui-btn layui-btn-sm" lay-event="insertadmin">添加</button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="enable">启用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disable">禁用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="check">查看详情</a>
</script>


<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'/staffController/queryStaff'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '顾问管理表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '序号'}
                ,{field:'account', title: '用户名'}
                ,{field:'sex', title: '性别'}
                ,{field:'workage', title: '工龄'}
                ,{field:'skill', title: '技能'}
                ,{field:'state', title: '状态'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });


        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'deletetype':

                    break;
                //自定义头工具栏右侧图标 - 提示
                // case 'LAYTABLE_TIPS':
                //     layer.alert('这是工具栏右侧自定义的一个图标按钮');
                //     break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            //console.log(obj)s
            if(obj.event === 'enable'){
                layer.confirm('确定要启用吗?', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'disable'){
                layer.confirm('确定要禁用吗?', function(index){
                    obj.del();
                    layer.close(index);
                });
            }
        });


    });

</script>
</body>
</html>