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
    <title>入驻审核</title>
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

<%--    <div class="layui-form-item" id="querydiv">--%>
<%--        <div class="layui-btn-container">--%>
<%--            <button class="layui-btn layui-btn-sm" lay-event="deleteannoucement">删除</button>--%>
<%--            <button class="layui-btn layui-btn-sm" lay-event="insertannoucement">添加</button>--%>
<%--        </div>--%>
<%--    </div>--%>
<div class="demoTable">
    搜索：
    <div class="layui-inline">
        <input class="layui-input" name="id" id="demoReload" autocomplete="off">
    </div>
    <button class="layui-btn layui-icon layui-icon-search" data-type="reload">搜索</button>
</div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="check">审核</a>
</script>

<form class="layui-form" id="detail" action="" style="display: none">

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
<%--            <input type="text" name="content" id="content" required  lay-verify="required" placeholder="请输入具体公告内容" autocomplete="off" class="layui-input">--%>
        </div>
    </div>

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
            ,url:'/companyManageController/queryCompany'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: [

            ]//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '平台管理端公告管理'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '公司ID'}
                ,{field:'companyName', title: '公司名称'}
                ,{field:'boss', title: '公司法人代表'}
                ,{field:'address', title: '公司地址'}
                ,{field:'phone', title: '公司电话'}
                ,{field:'typeName', title: '公司服务类别'}
                ,{field:'state', title: '状态'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });

        //头工具栏事件
        // table.on('toolbar(test)', function(obj){
        //     var checkStatus = table.checkStatus(obj.config.id);
        //     switch(obj.event){
        //         case 'deleteannoucement':
        //             var data = checkStatus.data;
        //             var idList = new Array();
        //             $.each(data, function (index,val) {
        //                 idList.push(val.id);
        //             })
        //
        //             layer.alert("删除id:"+JSON.stringify({idList:idList}))
        //             $.ajax({
        //                 type : "POST",
        //                 url : "/annoucementController/deleteAnnoucement",
        //                 dataType: 'JSON',
        //                 data : {idList:JSON.stringify(idList)},
        //                 error : function(request) {
        //                     layer.alert('操作失败', {
        //                         icon: 2,
        //                         title:"提示"
        //                     });
        //                 },
        //                 success : function(msg) {
        //                     alert(msg.msg);
        //                     window.parent.location.reload();//修改成功后刷新父界面
        //                 }
        //             });
        //
        //             break;
        //         case 'insertannoucement':
        //             var layerinsert = layer.open({
        //                 type: 1
        //                 ,title: '添加公告'
        //                 ,area: ['500px','400px']
        //                 ,shade: [0.8, '#314949'] //遮罩
        //                 ,resize: false //不可拉伸
        //                 ,content: $('#annoucementinfoform') //内容
        //                 ,btn: 0
        //                 ,cancel: function(index, layero){
        //                     if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
        //                         // $('#userinfoform').css("display","none");
        //                         $('#title').val("");
        //                         $("#content").val("");
        //                         layer.close(index);
        //                     }
        //                     return false;
        //                 }
        //                 //如果设定了yes回调，需进行手工关闭
        //             });
        //             layui.use('form', function(){
        //                 var form = layui.form;
        //                 form.render();
        //                 form.on('submit(insertconfirm)', function(data){
        //                     $.ajax({
        //                         type: 'POST',
        //                         url: '/annoucementController/insertAnnoucement',
        //                         dataType: 'JSON',
        //                         data: data.field,
        //                         success: function (msg) {
        //                             alert(msg.msg);
        //                             layer.close(layerinsert);
        //                             $('#title').val("");
        //                             $("#content").val("");
        //                             window.parent.location.reload();//修改成功后刷新父界面
        //                         }
        //                     })
        //                     return false;
        //                 });
        //             });
        //             break;
        //     };
        // });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            var companyId = tabdata.id;
            if(obj.event === 'check'){//审核
                //询问框
                layer.confirm('确定是否审核？', {
                    btn: ['确定','取消'] //按钮
                }, function(index){
                    $.ajax({
                        type: 'POST',
                        url: '/companyManageController/checkJoin',
                        dataType: 'JSON',
                        data: {id: companyId},
                        success: function (msg) {
                            layer.close(index);
                            layer.alert(msg.msg,{icon: 6},function () {
                                window.parent.location.reload();//审核成功后刷新父界面
                            });//审核成功提示

                        }
                    })
                }, function(index){
                    layer.close(index);
                });

            }
            // else if(obj.event === 'detail'){
            //     $('#title').val(tabdata.title);
            //     $("#content").val(tabdata.content);
            //     var annouceId = tabdata.id
            //     var layerupdate = layer.open({
            //         type: 1
            //         ,title: '修改公告'
            //         ,area: ['500px','400px']
            //         ,shade: [0.8, '#314949'] //遮罩
            //         ,resize: false //不可拉伸
            //         ,content: $('#annoucementinfoform') //内容
            //         ,btn: 0
            //         ,cancel: function(index, layero){
            //             if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
            //                 // $('#userinfoform').css("display","none");
            //                 $('#title').val("");
            //                 $("#content").val("");
            //                 layer.close(index);
            //             }
            //             return false;
            //         }
            //         //如果设定了yes回调，需进行手工关闭
            //     });
            //     layui.use('form', function(){
            //         var form = layui.form;
            //         form.render();
            //         form.on('submit(insertconfirm)', function(data){
            //             data.field.id = annouceId;
            //             $.ajax({
            //                 type: 'POST',
            //                 url: '/annoucementController/updateAnnouncement',
            //                 dataType: 'JSON',
            //                 data: data.field,
            //                 success: function (msg) {
            //                     layer.alert(msg.msg);
            //                     layer.close(layerupdate);
            //                     $('#title').val("");
            //                     $("#content").val("");
            //                     window.parent.location.reload();//修改成功后刷新父界面
            //                 }
            //             })
            //             return false;
            //         });
            //     });
            // }
        });

    });
</script>
</body>
</html>