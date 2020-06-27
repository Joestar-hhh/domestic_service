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
    <title>服务</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<form class="layui-form" id="servicePrice" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">价格：</label>
        <div class="layui-input-block">
            <input type="text" name="price" id="price" required lay-verify="required|number" placeholder="请输入价格"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">单位：</label>
        <div class="layui-input-block">
            <select name="unit" id="unit" lay-verify="required">
                <option value=""></option>
                <option value="次">次</option>
                <option value="小时">小时</option>
                <option value="天">天</option>
                <option value="月">月</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="price">设定价格</a>
</script>

<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/serviceListContrller/queryServiceTypeName'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '服务表'
            , cols: [[
                {field: 'id', title: '序号', hide: true}
                , {field: 'typeName', title: '服务名'}
                , {field: 'serviceTypeName', title: '服务类别名'}
                , {field: 'updateTime', title: '时间'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            if (obj.event === 'price') {
                layer.confirm('确认要设定价格吗?', function (index) {
                    var layerinsert = layer.open({
                        type: 1
                        , title: '设定价格'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#servicePrice') //内容
                        , btn: 0
                        , cancel: function (index) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                $('#price').val("");
                                $('#unit').val();
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    layui.use('form', function () {
                        var form = layui.form;
                        var serviceId = tabdata.id;
                        form.render();
                        form.on('submit(insertconfirm)', function (data) {
                            data.field.serviceId = serviceId;
                            $.ajax({
                                type: 'POST',
                                url: "<%=path%>/serviceListContrller/updateServicePrice",
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
                });
            }
        });
    });

</script>
</body>
</html>