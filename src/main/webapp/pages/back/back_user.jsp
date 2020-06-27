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
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">

    <style>
        .layui-form-item {
            margin-bottom: 0;
        }
        #querydiv .layui-btn-container{
            display: inline-block;
        }
        #orderinfoform .layui-form-label {
            width: 114px;
        }
        #orderinfoform .layui-input-block {
            margin-left: 247px;
        }
        #orderinfoform .rightlabel{
            margin-bottom: 15px;
            text-align: left;
            line-height: 30px;
            background-color: #beffed;
        }
        #orderinfoform .address{
            margin-bottom: 15px;
            text-align: left;
            line-height: 30px;
            background-color: #beffed;
            width: 400px;
        }
    </style>

</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div class="demoTable">
        搜索：
        <div class="layui-inline">
            <select name="regionlist" id="regionlist" lay-verify="required">
            </select>
        </div>
        <button class="layui-btn layui-btn-radius " data-type="reload" lay-event="queryRegion">
            <i class="layui-icon layui-icon-search"></i> 搜索
        </button>
    </div>

</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="enable">
        <i class="layui-icon layui-icon-ok-circle"></i>启用</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="disable">
        <i class="layui-icon layui-icon-close-fill"></i>禁用</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="check">
        <i class="layui-icon layui-icon-list"></i> 查看详情</a>
</script>


<form class="layui-form" id="orderinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">姓名：</label>
        <label class="layui-form-label rightlabel" id="name"></label>
        <label class="layui-form-label">性别：</label>
        <label class="layui-form-label rightlabel" id="sex"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">年龄：</label>
        <label class="layui-form-label rightlabel" id="age"></label>
        <label class="layui-form-label">电话：</label>
        <label class="layui-form-label rightlabel" id="phone"></label>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态：</label>
        <label class="layui-form-label rightlabel" id="status"></label>
        <label class="layui-form-label">注册时间：</label>
        <label class="layui-form-label rightlabel" id="createTime"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">家庭地址：</label>
        <label class="layui-form-label address" id="address"></label>

    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
        </div>
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
            url: "<%=path%>/staffController/regionList",
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
            , url: "<%=path%>/staffController/queryUser"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户管理表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号'}
                , {field: 'name', title: '姓名'}
                , {field: 'sex', title: '性别'}
                , {field: 'age', title: '年龄'}
                , {field: 'phone', title: '电话'}
                , {field: 'region', title: '所在地'}
                , {field: 'status', title: '状态'}
                , {field: 'createTime', title: '注册时间'}
                , {field: 'detailAddress', title: '默认地址' ,hide:true}
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
                        url: "<%=path%>/staffController/queryUser"
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
                        url: "<%=path%>/staffController/regionList",
                        dataType: 'JSON',
                        success: function (msg) {
                            $("#regionlist").html("<option value=''></option>");
                            $.each(msg.data, function (i, item) {
                                $("#regionlist").append("<option value='" + item.id + "'>" + item.region + "</option>");
                                region = "";
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
                        url: "<%=path%>/staffController/enableUser",
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            layer.close(index);
                            layer.alert(msg.msg,{icon: 6},function () {
                                window.location.reload();//启用成功后刷新界面
                            });//启用成功提示
                        }
                    })
                });
            } else if (obj.event === 'disable') {
                layer.confirm('确定要禁用吗?', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: "<%=path%>/staffController/disableUser",
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            layer.close(index);
                            layer.alert(msg.msg,{icon: 6},function () {
                                window.location.reload();//禁用成功后刷新界面
                            });//禁用成功提示
                        }
                    })
                });
            }
            else if(obj.event === 'check'){
                $('#name').html(tabdata.name);
                $('#sex').html(tabdata.sex);
                $('#age').html(tabdata.age);
                $('#phone').html(tabdata.phone);
                $('#status').html(tabdata.status);
                $('#createTime').html(tabdata.createTime);
                $('#address').html(tabdata.detailAddress);
                var layerupdate = layer.open({
                    type: 1
                    ,title: '查看用户详情'
                    ,area: ['640px','580px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#orderinfoform') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function(){
                    var form = layui.form;
                    form.render();
                    form.on('submit(insertconfirm)', function(data){
                        layer.close(layerupdate);
                        return false;
                    });
                });
            }

        });
    });

</script>
</body>
</html>