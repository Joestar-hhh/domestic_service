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
    <title>培训风采</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<%--<img src="<%=path%>/static/images/1578936572799.jpg" alt="">--%>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updatestyle">查看详情</a>

</script>
<style>
    <%--    表格行高自适应--%>
    .layui-table-cell {
        height: inherit;
    }

    /*
    调整图片宽度
    */
    .layui-table img {
        max-width: 200px;
    }

</style>


<%--修改技能培训界面--%>
<div id="update_div" style="display:none;">
    <form class="layui-form" action="" id="add_submits">
        <div class="layui-form-item">
            <label class="layui-form-label">项目名：</label>
            <div class="layui-input-block">
                <%--                <label id="trainProjectName"></label>--%>
                <label class="layui-form-label rightlabel" id="trainProjectName"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">培训时长：</label>
            <div class="layui-input-block">
                <label class="layui-form-label rightlabel" id="time"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">认证证书：</label>
            <div class="layui-input-block">
                <label class="layui-form-label rightlabel" id="qualificationId"></label>
            </div>
        </div>
    </form>
</div>

<script>
    style = "border-style:none"
    layui.use('table', function () {
        // var layer = layui.layer;
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/skillTrainController/querySkillTrain'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户数据表'
            , cols: [[
                {field: 'id', title: '序号', width: 70}
                , {
                    title: '',
                    field: 'picturePath',
                    templet: '<div><img style="height:200px;width:200px;" src="{{d.picturePath}}"></div>'
                }
                // , {title: '认证证书', field: 'qualification', emplet: '<div>{{d.qualification.qualificationName}}</div>'}
                , {field: 'trainProjectName', title: '培训项目名'}
                , {field: 'time', title: '培训时长'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 2,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;

            //删除
            if (obj.event === 'del') {

            }
            //修改
            else if (obj.event === 'updatestyle') {
                var tabdata = obj.data;
                // var id = tabdata.id
                var i = tabdata.qualification.qualificationName
                // tabdata.trainProjectName;
                $("#id").html(tabdata.id);
                $("#qualificationId").html(i);
                $("#time").html(tabdata.time);
                $("#trainProjectName").html(tabdata.trainProjectName)
                //打开修改技能培训弹窗
                var updatediv = layer.open({
                    type: 1,
                    title: '培训风采',
                    area: ['540px', '400px'],
                    // shade: [0.8, '#314949'],//遮罩
                    resize: false,//不可拉伸
                    shadeClose: false, //点击遮罩关闭
                    content: $('#update_div'),
                    cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $('#trainProjectName').val("");
                            $("#time").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                });

            }
        });

    });
</script>

</body>
</html>