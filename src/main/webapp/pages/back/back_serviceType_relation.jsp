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
    <title>审核服务类别</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<form class="layui-form" id="examination_passed" action="" style="display: none">
    <div class="layui-form-item" style="text-align: center">
        <button type="button" class="layui-btn" id="test5"><i class="layui-icon"></i>是否审核通过</button>
        <input type="hidden" id="id" value="">
    </div>
</form>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">

        <input type="text" name="typeName" id="typeName" lay-verify="title" autocomplete="off"
               placeholder="请输入服务类别名" class="layui-input">
        <button class="layui-btn layui-btn-warm" id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询
        </button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updatestyle">审核</a>
</script>


<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '/serviceTypeContrller/querySericeTypeRelation'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '审批公司服务类别表'
            , cols: [[
                ,{field: 'id', title: '序号', align: 'center',hide:'true'}
                ,{field: 'typeName', title: '服务类别名', align: 'center'}
                , {field: 'description', title: '服务描述', align: 'center'}
                , {field: 'companyName', title: '申请公司', align: 'center'}
                , {field: 'updateTime', title: '服务申请时间', align: 'center'}
                , {field: 'state', title: '状态', align: 'center'}
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
                    var typeName = $('#typeName').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/serviceTypeContrller/querySericeTypeRelation'
                        // ,methods:"post"
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            typeName: typeName
                        }
                    });
                    $('#typeName').val(typeName);
                    break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
               var $=layui.jquery;
            //查看详情
            if (obj.event === 'updatestyle') {
                var state = tabdata.state;
                if(state==='审核通过'){
                    layer.msg("审核已通过，不能重复审核")
                }else {
                    layer.confirm('是否确定审核?', function (index) {
                        $.ajax({
                            url:'<%=path%>/serviceTypeContrller/updateSericeTypeRelation',
                            type:'POST',
                            dataType:'JSON',
                            data:{
                                id:tabdata.id,
                                state:'审核通过'
                            },
                            success:function (msg) {
                                layer.msg(msg.msg);
                                window.location.reload();
                                /*刷新界面*/
                            }
                        })
                        layer.close(index);
                    });
                }
                //如果设定了yes回调，需进行手工关闭
            }
        });
    });
</script>
</body>
</html>