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
</head>
<body>
<table class="layui-hide" id="test" lay-filter="test"></table>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
<%--        <button class="layui-btn layui-btn-sm" lay-event="insert">添加</button>--%>
        <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">

    </div>
</script>


<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'<%=path%>/hotServiceContrller/hotServiceQuery'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'typeName', title:'服务名'}
                ,{field:'description', title:'服务描述'}
                ,{field:'stypeName', title:'所属服务类别'}
                ,{field:'orderNum', title:'服务单数'}

                // ,{field:'city', title:'城市', width:100}
                // ,{field:'sign', title:'签名'}
                // ,{field:'experience', title:'积分', width:80, sort: true}
                // ,{field:'ip', title:'IP', width:120}
                // ,{field:'logins', title:'登入次数', width:100, sort: true}
                // ,{field:'joinTime', title:'加入时间', width:120}
                // ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:250}
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
                        $("#seeTypeName").val(msg.data[0].typeName);
                        $("#seeDescription").val(msg.data[0].description);
                        $("#seeUpdateTime").val(msg.data[0].updateTime);
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
