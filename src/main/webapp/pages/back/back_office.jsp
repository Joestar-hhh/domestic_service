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
    <title>职位</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">

    <style>
        input.layui-input.layui-unselect {
            width: 58%;
        }
        .layui-form-select .layui-edge {
           right: 23%;
       }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="insertOffice">
                <i class="layui-icon layui-icon-add-circle"></i> 添加
            </button>
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
        <label class="layui-form-label">顾问姓名：</label>
        <div class="layui-input-block">
            <input type="text" name="userName" id="userName" required lay-verify="required" placeholder="请输入姓名"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">职位：</label>
        <select name="counselorId" id="counselorList" lay-verify="required">
        </select>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">身份证：</label>
        <div class="layui-input-block">
            <input type="text" name="idcard" id="idcard" required lay-verify="required" placeholder="请输入身份证"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">顾问电话：</label>
        <div class="layui-input-block">
            <input type="text" name="phone" id="phone" required lay-verify="required" placeholder="请输入电话号码"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别：</label>
        <div class="layui-input-block">
            <input type="text" name="sex" id="sex" required lay-verify="required" placeholder="请输入性别"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">顾问工龄：</label>
        <div class="layui-input-block">
            <input type="text" name="workage" id="workage" required lay-verify="required" placeholder="请输入工龄"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">顾问籍贯：</label>
        <div class="layui-input-block">
            <input type="text" name="nativeplace" id="nativeplace" required lay-verify="required" placeholder="请输入籍贯"
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
            , url: "<%=path%>/officeController/queryOfficeList"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '职位表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号', width: 100}
                , {field: 'userName', title: '顾问姓名'}
                , {field: 'idcard', title: '身份证', width: 200}
                , {field: 'phone', title: '电话号码'}
                , {field: 'sex', title: '性别'}
                , {field: 'position', title: '职位'}
                , {field: 'workage', title: '工龄'}
                , {field: 'nativeplace', title: '籍贯'}
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
                case 'insertOffice':

                    // 下拉框列表
                    $.ajax({
                        type: 'POST',
                        url: "<%=path%>/officeController/counselorList",
                        dataType: 'JSON',
                        success: function (msg) {
                            $("#counselorList").html("<option value=''></option>");
                            $.each(msg.data, function (i, item) {
                                $("#counselorList").append("<option value='" + item.id + "'>" + item.position + "</option>")
                            });
                            layui.use('form', function () {
                                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                form.render();
                            });
                        }
                    });

                    var layerinsert = layer.open({
                        type: 1
                        , title: '增加职位'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#userinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                $('#userName').val("");
                                $('#idcard').val("");
                                $('#phone').val("");
                                $('#sex').val("");
                                $('#workage').val("");
                                $('#nativeplace').val("");
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
                                url: "<%=path%>/officeController/insertOffice",
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

            //删除计划
            if (obj.event === 'delete') {
                layer.confirm('真的要删除此行数据么?', function (index) {
                    $.ajax({
                        url: "<%=path%>/officeController/deleteOffice",
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
                $('#userName').val(tabdata.userName);
                $('#idcard').val(tabdata.idcard);
                $('#phone').val(tabdata.phone);
                $('#sex').val(tabdata.sex);
                $('#workage').val(tabdata.workage);
                $('#nativeplace').val(tabdata.nativeplace);

                // 下拉框列表
                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/officeController/counselorList",
                    dataType: 'JSON',
                    success: function (msg) {
                        $("#counselorList").html("<option value=''></option>");
                        $.each(msg.data, function (i, item) {
                            $("#counselorList").append("<option value='" + item.id + "'>" + item.position + "</option>")
                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });

                var officeid = tabdata.id;

                var layerupdate = layer.open({
                    type: 1
                    , title: '修改职位'
                    , area: ['500px', '400px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userinfoform') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            $('#userName').val("");
                            $('#idcard').val("");
                            $('#phone').val("");
                            $('#sex').val("");
                            $('#workage').val("");
                            $('#nativeplace').val("");
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
                        data.field.id = officeid;
                        $.ajax({
                            type: 'POST',
                            url: "<%=path%>/officeController/updateOffice",
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                layer.close(layerupdate);
                                layer.alert(msg.msg, {icon: 1}, function () {
                                    window.location.reload();//成功后刷新父界面
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