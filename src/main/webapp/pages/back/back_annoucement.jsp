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
    <title>back_annoucement</title>
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

    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-danger  layui-btn-sm" lay-event="deleteannoucement">
                <i class="layui-icon layui-icon-delete"></i>删除</button>
            <button class="layui-btn layui-btn-sm" lay-event="insertannoucement">
                <i class="layui-icon layui-icon-add-circle"></i> 添加</button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="updateannoucement">
        <i class="layui-icon layui-icon-edit"></i> 修改</a>
</script>

<form class="layui-form" id="annoucementinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="title" required  lay-verify="required" placeholder="请输入标题内容" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">内容：</label>
        <div class="layui-input-block">
            <textarea rows="10" cols="39" name="content" id="content" required  lay-verify="required" placeholder="请输入具体公告内容"></textarea>
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
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'<%=path%>/annoucementController/queryAnnoucement'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '平台管理端公告管理'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'time', title: '发布时间'}
                ,{field:'title', title: '公告标题'}
                // ,{field:'content', title: '公告内容'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}

            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],}
            //每页条数的选择项

        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'deleteannoucement':
                    var data = checkStatus.data;
                    var idList = new Array();
                    $.each(data, function (index,val) {
                        idList.push(val.id);
                    })

                    $.ajax({
                        type : "POST",
                        url : "<%=path%>/annoucementController/deleteAnnoucement",
                        dataType: 'JSON',
                        data : {idList:JSON.stringify(idList)},
                        error : function(request) {
                            layer.alert('操作失败', {
                                icon: 2,
                                title:"提示"
                            });
                        },
                        success : function(msg) {
                            layer.alert(msg.msg,{icon: 2},function () {
                                window.location.reload();//审核成功后刷新父界面
                            });//删除成功提示
                        }
                    });

                    break;
                case 'insertannoucement':
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加公告'
                        ,area: ['500px','400px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#annoucementinfoform') //内容
                        ,btn: 0
                        ,cancel: function(index, layero){
                            if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none");
                                $('#title').val("");
                                $("#content").val("");
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
                                url: '<%=path%>/annoucementController/insertAnnoucement',
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    layer.close(layerinsert);
                                    $('#title').val("");
                                    $("#content").val("");
                                    layer.alert(msg.msg,{icon: 6},function () {
                                        window.location.reload();//添加成功后刷新父界面
                                    });//添加成功提示
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
                    // obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'updateannoucement'){
                $('#title').val(tabdata.title);
                $("#content").val(tabdata.content);
                var annouceId = tabdata.id
                var layerupdate = layer.open({
                    type: 1
                    ,title: '修改公告'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#annoucementinfoform') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            $('#title').val("");
                            $("#content").val("");
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
                        data.field.id = annouceId;
                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/annoucementController/updateAnnouncement',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                layer.close(layerupdate);
                                $('#title').val("");
                                $("#content").val("");
                                layer.alert(msg.msg,{icon: 6},function () {
                                    window.location.reload();//修改成功后刷新父界面
                                });//修改成功提示
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