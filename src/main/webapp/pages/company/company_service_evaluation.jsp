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
    <title>评价反馈管理</title>
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
            <button class="layui-btn layui-btn-sm" lay-event="query">
                <i class="layui-icon layui-icon-add-circle-fine"></i>查询
            </button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="reply">
        <i class="layui-icon layui-icon-edit"></i>回复</a>
    <a class="layui-btn layui-btn-xs" lay-event="check">
        <i class="layui-icon layui-icon-edit"></i>查看回复</a>
</script>
<div id="test2"></div>

<form class="layui-form" id="userinfoform" action="" style="display: none">

    <%--    <div class="layui-form-item">--%>
    <%--        <label class="layui-form-label">顾问职位：</label>--%>
    <%--        <div class="layui-input-block">--%>
    <%--            <input type="text" name="position" id="position" required lay-verify="required" placeholder="请输入顾问职位"--%>
    <%--                   autocomplete="off" class="layui-input">--%>
    <%--        </div>--%>
    <%--    </div>--%>
</form>

<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;

        table.render({
            elem: '#test'
            , url: "<%=path%>/serviceEvaluationController/queryServiceEvaluationList"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '顾问管理表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号', width: 60}
                , {field: 'userName', title: '用户名', width: 200}
                , {field: 'time', title: '评价时间', width: 220}
                , {field: 'evaluationLevel', title: '评价星级', width: 100}
                , {field: 'evaluationContent', title: '评价内容'}
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
                case 'insertCounselor':
                    var layerinsert = layer.open({
                        type: 1
                        , title: '新增顾问'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#userinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                $('#position').val("");
                                $("#duties").val("");
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
                                url: "<%=path%>/counselorController/insertCounselor",
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    layer.close(layerinsert);
                                    layer.alert(msg.msg, {icon: 6}, function () {
                                        window.location.reload();//成功后刷新父界面
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
            //console.log(obj)s
            if (obj.event === 'delete') {
                layer.confirm('真的要删除此行数据么?', function (index) {
                    $.ajax({
                        url: "<%=path%>/counselorController/deleteCounselor",
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
            } else if (obj.event === 'update') {
                $('#position').val(tabdata.position);
                $("#duties").val(tabdata.duties);
                var cid = tabdata.id
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
                            $('#position').val("");
                            $("#duties").val("");
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
                        data.field.id = cid;
                        $.ajax({
                            type: 'POST',
                            url: "<%=path%>/counselorController/updateCounselor",
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                layer.close(layerupdate);
                                layer.alert(msg.msg, {icon: 1}, function () {
                                    window.location.reload();//成功后刷新父界面..
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