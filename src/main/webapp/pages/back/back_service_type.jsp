<%--
  Created by IntelliJ IDEA.
  User: 肖祯
  Date: 2020/6/2
  Time: 15:57
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
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <style>
        .layui-form-item {
            margin-bottom: 0;
        }
        #serviceListView .layui-form-label {
            float: left;
            display: block;
            padding: 9px 15px;
            width: 114px;
            font-weight: 400;
            line-height: 31px;
            text-align: right;
            /*background-color:lightgreen;*/
            margin-left: 50px;
        }
        #serviceListView .layui-input-block {
            margin-left: 247px;
        }
        #serviceListView .rightlabel{
            margin-bottom: 15px;
            text-align: left;
            line-height: 30px;
            width: 170px;
            background-color: #beffed;

        }
    </style>
</head>
<body>
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="insert">
            <i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
        <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="viewDetails">
        <i class="layui-icon layui-icon-list"></i>查看详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        <i class="layui-icon layui-icon-edit"></i> 修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">
        <i class="layui-icon layui-icon-delete"></i>删除</a>
</script>




<form class="layui-form" id="userinfoform" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">服务类别名：</label>
        <div class="layui-input-block">
            <input type="text" name="typeName" id="typeName" required lay-verify="required" placeholder="请输入服务类别名" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">服务类型描述：</label>
        <div class="layui-input-block">
            <input type="text" name="description" id="description" required  lay-verify="required" placeholder="请输入服务类型描述" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>

<%--服务类型查看详情--%>
<form class="layui-form" id="serviceListView" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">服务类别名：</label>
        <label class="layui-form-label rightlabel" id="seeTypeName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务类别描述：</label>
        <label class="layui-form-label rightlabel" id="seeDescription"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">更新时间：</label>
        <label class="layui-form-label rightlabel" id="seeUpdateTime"></label>
    </div>
</form>

<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'<%=path%>/serviceTypeContrller/selectServiceType'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'typeName', title:'服务类别名'}
                ,{field:'description', title:'服务类型描述'}
                ,{field:'updateTime', title:'更新时间',sort: true}
                // ,{field:'city', title:'城市', width:100}
                // ,{field:'sign', title:'签名'}
                // ,{field:'experience', title:'积分', width:80, sort: true}
                // ,{field:'ip', title:'IP', width:120}
                // ,{field:'logins', title:'登入次数', width:100, sort: true}
                // ,{field:'joinTime', title:'加入时间', width:120}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:250}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;
                case 'insert':
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加角色'
                        ,area: ['500px','400px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#userinfoform') //内容
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
                    layui.use('form', function() {
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function (data) {
                            $.ajax({
                                type: 'POST',
                                url: "<%=path%>/serviceTypeContrller/addServiceType",
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    if (msg.code == "0") {
                                        alert(msg.msg);
                                        layer.close(layerinsert);
                                        $('#typeName').val("");
                                        $("#description").val("");
                                        window.parent.location.reload();//修改成功后刷新父界面
                                    } else {
                                       alert(msg.msg);
                                    }
                                }
                            });

                            return false;
                        });
                    });
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //查看详情
            if(obj.event === 'viewDetails'){

                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/serviceTypeContrller/serviceTypeView",
                    dataType: 'JSON',
                    data: data,
                    success: function (msg) {
                        $("#seeTypeName").html(msg.data[0].typeName);
                        $("#seeDescription").html(msg.data[0].description);
                        $("#seeUpdateTime").html(msg.data[0].updateTime);
                    }
                });

                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '查看详情'
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


            }
            //删除服务类型
           else if(obj.event === 'del'){
                layer.alert("data"+data);
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    $.ajax({
                        url:"<%=path%>/serviceTypeContrller/deleteServiceType",
                        type: "POST",
                        dataType: 'JSON',
                        data: data,
                        error: function (msg) {
                           alert("服务器繁忙");
                        },
                        success: function (msg) {
                           alert(msg.msg);
                           window.parent.location.reload();//修改成功后刷新父界面
                        }
                    });

                    return false;
                });
            }
           //修改服务类型
           else if(obj.event === 'edit'){
                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '修改人员'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#userinfoform') //内容
                    ,btn: 0
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function(){
                    var form = layui.form;
                    form.render();
                    form.on('submit(insertconfirm)', function(data){
                        // layer.alert("ssssssss:"+adminId)
                        data.field.id = adminId;
                        $.ajax({
                            url:"<%=path%>/serviceTypeContrller/updateServiceType",
                            type: "POST",
                            dataType: 'JSON',
                            data: data.field,
                            error: function (msg) {
                               alert("服务器繁忙");
                            },
                            success: function (msg) {
                               alert(msg.msg);
                                layer.close(layerinsert);
                                window.parent.location.reload();//修改成功后刷新父界面
                            }
                        });
                        return false;
                    });
                });
            }
        });
    });
</script>
</body>
</html>
