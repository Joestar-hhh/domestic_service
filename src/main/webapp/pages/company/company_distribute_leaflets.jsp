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
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <script src="<%=path%>/static/layui/lay/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
<style>
    .layui-btn-primary {
        border: 1px solid #C9C9C9;
        background-color: #ff5722;
        color: #558;
    }
</style>

</head>
<body>
<table class="layui-hide" id="test" lay-filter="test"></table>



<script type="text/html" id="barDemo">

    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="viewDetails">
        <i class="layui-icon layui-icon-list"></i>派单</a>

</script>

<%--员工下拉框--%>
<form class="layui-form" id="serviceListView" action="" style="display: none">
    <div class="layui-inline">
        <select name="regionlist" id="regionlist" lay-verify="required">
        </select>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertConfirm" lay-submit lay-filter="insertConfirm">确定</button>
        </div>
    </div>
</form>
<script>

    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#test'
            , url: "<%=path%>/distributeLeafletsController/queryServiceEvaluationList"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '评价反馈表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号',width: 50}
                , {field: 'name', title: '用户名',width:100}
                , {field: 'orderNumber', title: '订单号'}
                , {field: 'pulishTime', title: '发布时间'}
                , {field: 'startTime', title: '服务开始时间'}
                , {field: 'endTime', title: '服务结束时间'}
                , {field: 'title', title: '标题'}
                , {field: 'description', title: '描述'}
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
            var data = obj.data;
            var $ = layui.jquery;
            var oid = data.id;
            if(obj.event === 'viewDetails') {
                // 下拉框列表
                alert("点击了派单")
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/distributeLeafletsController/selectStaff',
                    dataType: 'JSON',
                    success: function (msg) {
                        $("#regionlist").html("<option value=''></option>");
                        $.each(msg.data, function (i, item) {
                            $("#regionlist").append("<option value='" + item.id + "'>" + item.userName + "</option>")
                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });
            }
            var adminId = data.id;
            var layerinsert = layer.open({
                type: 1
                ,title: '派单'
                ,area: ['500px','400px']
                ,shade: [0.8, '#314949'] //遮罩
                ,resize: false //不可拉伸
                ,content: $('#serviceListView') //内容
                ,btn: 0
                ,cancel: function(index, layero){
                    if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                        // $('#userinfoform').css("display","none");
                        // $('#roleName').val("");
                        // $("#roleDescribe").val("");
                        layer.close(index);
                    }
                    return false;
                }
                //如果设定了yes回调，需进行手工关闭
            });

            layui.use('form', function(){
                var form = layui.form;
                form.render();
                form.on('submit(insertConfirm)', function(data){
                    // alert("qqqq23232:-----"+oid)
                    // alert($("#regionlist").val());
                    $.ajax({
                        url:"<%=path%>/distributeLeafletsController/updatePaiDan",
                        type: "POST",
                        dataType: 'JSON',
                        // data: data.field,
                       data:{
                           id:oid,
                           userId:$("#regionlist").val(),
                       },
                        success: function (msg) {
                            if (msg.code == "0") {
                                alert(msg.msg);
                                window.location.reload();//修改成功后刷新父界面
                            }
                        }
                    });
                    return false;
                });
            });
        });
    });
</script>
</body>
</html>