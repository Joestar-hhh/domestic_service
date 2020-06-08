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
    <title>员工管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">

    <style>
        .layui-input-block {
            margin-left: 10px;
        }

        #seldiv .layui-input-block {
            width: 25%;
        }

        #seldiv .layui-form-select dl {

            min-width: 75%;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div id="seldiv">
        <div class="layui-form-item">
            <div class="layui-input-block">
                <select name="regionlist" id="regionlist" lay-verify="required">
                </select>
            </div>
        </div>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="queryRegion">查询</a>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="enable">启用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disable">禁用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="check">查看详情</a>
</script>


<form class="layui-form" id="userInformation" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名：</label>
        <input type="text" id="username" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别：</label>
        <input type="text" id="sex" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">籍贯：</label>
        <input type="text" id="nativeplace" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">婚姻状况：</label>
        <input type="text" id="marriage" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">学历：</label>
        <input type="text" id="education" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">身份证号：</label>
        <input type="text" id="idcard" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系方式：</label>
        <input type="text" id="phone" readonly="readonly">
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所在地：</label>
        <input type="text" id="address" readonly="readonly">
    </div>
</form>

<script>
    var region;

    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;

        // 下拉框列表
        $.ajax({
            type: 'POST',
            url: '/staffController/regionList',
            dataType: 'JSON',
            success: function (msg) {
                $("#regionlist").html("<option value=''></option>");
                $.each(msg.data, function (i, item) {
                    $("#regionlist").append("<option value='" + item.id + "'>" + item.region + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                    form.render();
                });
            }
        });

        table.render({
            elem: '#test'
            , url: '/staffController/queryStaff'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '顾问管理表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号'}
                , {field: 'userName', title: '姓名'}
                , {field: 'sex', title: '性别'}
                , {field: 'workage', title: '工龄'}
                , {field: 'skill', title: '技能'}
                , {field: 'state', title: '状态'}
                , {field: 'region', title: '所在地'}
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

            // 获取下拉框的值
            $(".layui-anim-upbit>dd").each(function () {
                if ($(this).attr('class') == "layui-this") {
                    region = $(this).html();
                }
            })

            switch (obj.event) {
                case 'queryRegion':
                    table.reload('test', {
                        url: '/staffController/queryStaff'
                        // ,methods:"post"
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            region: region
                        }
                    });
                    //查询完以后将下拉框的数据再次获取一次
                    $.ajax({
                        type: 'POST',
                        url: '/staffController/regionList',
                        dataType: 'JSON',
                        success: function (msg) {
                            $("#regionlist").html("<option value=''></option>");
                            $.each(msg.data, function (i, item) {
                                $("#regionlist").append("<option value='" + item.id + "'>" + item.region + "</option>")
                            });
                            layui.use('form', function () {
                                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                form.render();
                            });
                        }
                    });
                    break;
            }
            ;
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            //console.log(obj)s
            if (obj.event === 'enable') {
                layer.confirm('确定要启用吗?', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: '/staffController/enableState',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            if (msg.code == 0) {
                                alert("修改失败，请重试");
                            } else {
                                alert("修改成功");
                                window.parent.location.reload();
                            }
                        }
                    })
                    layer.close(index);
                });
            } else if (obj.event === 'disable') {
                layer.confirm('确定要禁用吗?', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: '/staffController/disableState',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            if (msg.code == "0") {
                                alert("修改失败，请重试");
                            } else {
                                alert("修改成功");
                                window.parent.location.reload();
                            }
                        }
                    })
                    layer.close(index);
                });
            } else if (obj.event === 'check') {
                var layercheck = layer.open({
                    type: 1
                    , title: '查看详情'
                    , area: ['500px', '600px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userInformation') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            $('#username').val("");
                            $("#sex").val("");
                            $("#nativeplace").val("");
                            $("#marriage").val("");
                            $("#education").val("");
                            $("#idcard").val("");
                            $("#phone").val("");
                            $("#address").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function () {
                    var form = layui.form;
                    $.ajax({
                        type: 'POST',
                        url: '/staffController/checkStaff',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            $("#username").val(msg[0].userName);
                            $("#sex").val(msg[0].sex);
                            $("#marriage").val(msg[0].marriage);
                            $("#nativeplace").val(msg[0].nativeplace);
                            $("#education").val(msg[0].education);
                            $("#idcard").val(msg[0].idcard);
                            $("#phone").val(msg[0].phone);
                            $("#address").val(msg[0].address);
                        }
                    });
                });
            }
        });
    });

</script>
</body>
</html>