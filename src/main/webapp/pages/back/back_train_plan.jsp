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
    <title>培训计划</title>
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
            <button class="layui-btn layui-btn-sm" lay-event="insertPlan">
                <i class="layui-icon layui-icon-add-circle"></i> 添加</button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="update">
        <i class="layui-icon layui-icon-edit"></i> 修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">
        <i class="layui-icon layui-icon-delete"></i>删除</a>
</script>


<form class="layui-form" id="userinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">培训标题：</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="title" required lay-verify="required" placeholder="请输入培训标题"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">培训内容：</label>
        <div class="layui-input-block">
            <input type="text" name="content" id="content" required lay-verify="required" placeholder="请输入培训内容"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">培训人数：</label>
        <div class="layui-input-block">
            <input type="text" name="peopleNum" id="peopleNum" required lay-verify="required" placeholder="请输入培训人数"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">培训时间：</label>
        <div class="layui-input-block">
            <input type="text" name="trainTime" id="trainTime" required lay-verify="required" placeholder="请输入培训时间"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>


<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;

        //打印表格数据
        table.render({
            elem: '#test'
            , url: '/trainPlanController/queryTrainPlanList'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号'}
                , {field: 'trainTime', title: '培训时间'}
                , {field: 'title', title: '培训标题'}
                , {field: 'content', title: '培训内容'}
                , {field: 'peopleNum', title: '培训人数'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}
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
                case 'insertPlan':
                    var layerinsert = layer.open({
                        type: 1
                        , title: '增加培训计划'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#userinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                $('#title').val("");
                                $("#content").val("");
                                $("#peopleNum").val("");
                                $("#trainTime").val("");
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    layui.use('form', function () {
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function (data) {
                            $.ajax({
                                type: 'POST',
                                url: '/trainPlanController/insertPlan',
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    layer.close(layerinsert);
                                    layer.alert(msg.msg, {icon: 6}, function () {
                                        window.parent.location.reload();//成功后刷新父界面
                                    });//成功提示
                                }
                            })
                            return false;
                        });
                    });
                    break;
            }
            ;
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;

            //删除计划
            if (obj.event === 'delete') {
                layer.confirm('真的要删除此行数据么?', function (index) {
                    $.ajax({
                        url: '/trainPlanController/deletePlan',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            layer.msg(msg.msg)
                            obj.del();
                            layer.close(index);
                        }
                    })
                });
            }
            //修改计划
            else if (obj.event === 'update') {
                $('#title').val(tabdata.title);
                $("#content").val(tabdata.content);
                $("#trainTime").val(tabdata.trainTime);
                $("#peopleNum").val(tabdata.peopleNum);
                var planid = tabdata.id
                var layerupdate = layer.open({
                    type: 1
                    , title: '修改计划'
                    , area: ['500px', '400px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userinfoform') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $('#title').val("");
                            $("#content").val("");
                            $("#trainTime").val("");
                            $("#peopleNum").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                    form.on('submit(insertconfirm)', function (data) {
                        data.field.id = planid;
                        $.ajax({
                            type: 'POST',
                            url: '/trainPlanController/updatePlan',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                layer.close(layerupdate);
                                layer.alert(msg.msg, {icon: 1}, function () {
                                    window.parent.location.reload();//成功后刷新父界面
                                });//成功提示
                            }
                        })
                        return false;
                    });
                });
            }
        });


    });

</script>
</body>
</html>