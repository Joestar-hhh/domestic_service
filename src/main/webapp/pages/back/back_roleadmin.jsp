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
    <title>back_roleadmin</title>
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
<%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="deleterole">删除</button>
            <button class="layui-btn layui-btn-sm" lay-event="insertrole">添加</button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updaterole">修改</a>
<%--    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
</script>



<form class="layui-form" id="userinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">角色名：</label>
        <div class="layui-input-block">
            <input type="text" name="roleName" id="roleName" required  lay-verify="required" placeholder="请输入角色名字" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">职责：</label>
        <div class="layui-input-block">
            <input type="text" name="roleDescribe" id="roleDescribe" required  lay-verify="required" placeholder="请输入职责描述" autocomplete="off" class="layui-input">
        </div>
    </div>

<%--    <div class="layui-form-item">--%>
<%--        <label class="layui-form-label">角色：</label>--%>
<%--        <div class="layui-input-block">--%>
<%--            <select name="selecttest" id="selecttest" lay-filter="selecttest" lay-verify="required">--%>
<%--                <option value=""></option>--%>
<%--                <option value="超级管理员">超级管理员</option>--%>
<%--                <option value="用户管理员">用户管理员</option>--%>
<%--                <option value="文档管理员">文档管理员</option>--%>
<%--            </select>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>


<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'/roleController/queryRole'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '序号'}
                ,{field:'roleName', title: '角色名'}
                ,{field:'roleDescribe', title: '角色描述'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });


        layui.use('form', function() {
            var form = layui.form;
            form.render('select');
            form.on('select(selecttest)', function(data){
                alert("选中："+JSON.stringify(data));
            });
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'deleterole':
                    var data = checkStatus.data;
                    var idList = new Array();
                    $.each(data, function (index,val) {
                        idList.push(val.id);
                    })
                    $.ajax({
                        type : "post",
                        url : "/roleController/deleteRole",
                        dataType: 'JSON',
                        data : {idList:JSON.stringify(idList)},
                        error : function(request) {
                            layer.alert('操作失败', {
                                icon: 2,
                                title:"提示"
                            });
                        },
                        success : function(msg) {
                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    });

                    break;
                case 'insertrole':
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
                                $('#roleName').val("");
                                $("#roleDescribe").val("");
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
                            $.ajax({
                                type: 'POST',
                                url: '/roleController/insertRole',
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    // alert(msg.msg);
                                    layer.close(layerinsert);
                                    $('#roleName').val("");
                                    $("#roleDescribe").val("");
                                    layer.alert(msg.msg,function () {
                                        window.location.reload();//修改成功后刷新父界面
                                    });
                                }
                            })
                            return false;
                        });
                    });
                    break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            //console.log(obj)s
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'updaterole'){
                $('#roleName').val(tabdata.roleName);
                $("#roleDescribe").val(tabdata.roleDescribe);
                var roleId = tabdata.id
                var layerupdate = layer.open({
                    type: 1
                    ,title: '修改角色'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#userinfoform') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $('#roleName').val("");
                            $("#roleDescribe").val("");
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
                        data.field.id = roleId;
                        $.ajax({
                            type: 'POST',
                            url: '/roleController/updateRole',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                layer.close(layerupdate);
                                $('#roleName').val("");
                                $("#roleDescribe").val("");
                                layer.alert(msg.msg,function () {
                                    window.location.reload();//修改成功后刷新父界面
                                });
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