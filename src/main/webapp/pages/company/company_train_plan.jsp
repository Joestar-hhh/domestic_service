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

    <style>
        .layui-form-item .layui-input-inline {
            float: left;
            width: 350px;
            margin-right: 10px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="update">
        <i class="layui-icon layui-icon-edit"></i> 查看详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="delete">
        <i class="layui-icon layui-icon-delete"></i>报名</a>
</script>


<form class="layui-form" id="userinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">培训标题：</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="title" required lay-verify="required" placeholder="请输入培训标题"
                   autocomplete="off" class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">培训内容：</label>
        <div class="layui-input-block">
            <input type="text" name="content" id="content" required lay-verify="required" placeholder="请输入培训内容"
                   autocomplete="off" class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">培训人数：</label>
        <div class="layui-input-block">
            <input type="text" name="peopleNum" id="peopleNum" required lay-verify="required" placeholder="请输入培训人数"
                   autocomplete="off" class="layui-input" disabled="disabled">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始时间：</label>

        <div class="layui-inline">
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="startTime" id="startTime" placeholder="yyyy-MM-dd-hh"
                       required lay-verify="required" disabled="disabled">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">结束时间：</label>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input type="text" class="layui-input" name="endTime" id="endTime" placeholder="yyyy-MM-dd-hh" required
                       lay-verify="required" disabled="disabled">
            </div>
        </div>
    </div>

</form>

<form class="layui-form" id="trainplan" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">剩余名额：</label>
        <label class="layui-form-label rightlabel" id="trainCount"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">员工</label>
        <div class="layui-input-block">
            <select name="userName" id="userName" lay-filter="City_level" lay-verify="required"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">报名</button>
        </div>
    </div>
    <script>

        layui.use('table', function () {
            var table = layui.table;
            var $ = layui.jquery;
            //打印表格数据
            table.render({
                elem: '#test'
                , url: "<%=path%>/trainPlanController/queryTrainPlanList"
                , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
                , title: '用户数据表'
                , cols: [[
                    // {type: 'checkbox', fixed: 'left'}
                    {field: 'id', title: '序号', hide: true}
                    , {field: 'startTime', title: '开始时间'}
                    , {field: 'endTime', title: '结束时间'}
                    , {field: 'title', title: '培训标题'}
                    , {field: 'peopleNum', title: '培训人数', hide: true}
                    , {field: 'content', title: '培训内容'}
                    , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
                    // ,{field:'downloadDiscount', title: '下载文档积分比例'}
                ]]
                , page: {
                    limit: 10,//指定每页显示的条数
                    limits: [ 10, 15, 20,
                        25, 30, 35, 40, 45, 50],
                } //每页条数的选择项

            });
            //监听行工具事件
            table.on('tool(test)', function (obj) {
                var tabdata = obj.data;
                var peopleNum = parseInt(tabdata.peopleNum);
                var id = tabdata.id;


                //删除计划
                if (obj.event === 'delete') {
                    //当前时间
                    var d2 = new Date();
                    //结束时间
                    var yourtime = tabdata.endTime;
                    var d1 = Date.parse(yourtime)
                    //判断时间是否结束
                    if (d1 > d2) {
                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/trainPlanController/queryStaffTrain',
                            dataType: 'JSON',
                            asyn: false,
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                // alert(msg.count)
                                $("#trainCount").html(peopleNum - parseInt(msg.count))
                                $("#userName").html("<option value=''></option>");
                                $.each(msg.data, function (i, item) {
                                    $("#userName").append("<option value='" + item.id + "'>" + item.userName + "</option>")
                                });
                                layui.use('form', function () {
                                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                    form.render();
                                });
                            }
                        });

                        var layerinsert = layer.open({
                            type: 1
                            , title: '培训计划'
                            , area: ['500px', '400px']
                            , shade: [0.8, '#314949'] //遮罩
                            , resize: false //不可拉伸
                            , content: $('#trainplan') //内容
                            , btn: 0
                            , cancel: function (index, layero) {
                                if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                    // $('#userinfoform').css("display","none")
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
                                if ($("#trainCount").text() != '0') {
                                    $.ajax({
                                        url: '<%=path%>/trainPlanController/insertStaffTrain',
                                        type: 'POST',
                                        dataType: 'JSON',
                                        data: {
                                            id: id,
                                            staffId: $("#userName").val()
                                        },
                                        success: function (data) {
                                            layer.alert(data.msg, {icon: 6}, function () {
                                                window.location.reload();//成功后刷新父界面
                                            });//成功提示
                                        }
                                    })
                                } else {
                                    layer.alert("培训名额已满", {icon: 6}, function () {
                                        window.location.reload();//成功后刷新父界面
                                    });//成功提示
                                }

                                return false;
                            });
                        });
                    } else {
                        layer.msg("培训时间已经结束")
                    }


                }
                //修改计划
                else if (obj.event === 'update') {
                    $('#title').val(tabdata.title);
                    $("#content").val(tabdata.content);
                    $("#startTime").val(tabdata.startTime);
                    $("#endTime").val(tabdata.endTime);
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
                                url: "<%=path%>/trainPlanController/updatePlan",
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
</form>
</body>
</html>