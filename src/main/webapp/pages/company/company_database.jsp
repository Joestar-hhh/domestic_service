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
公司资料-------------------------------------------------------------------------------------------------------------
<table class="layui-hide" id="test" lay-filter="test"></table>

员工资料-------------------------------------------------------------------------------------------------------------
<table class="layui-hide" id="test2" lay-filter="test2"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="viewDetails">
        <i class="layui-icon layui-icon-list"></i>查看详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="insert">
        <i class="layui-icon layui-icon-edit"></i> 增加</a>
</script>


<script type="text/html" id="barDemo2">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="straffviewDetails">
        <i class="layui-icon layui-icon-list"></i>查看详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="straffinsert">
        <i class="layui-icon layui-icon-edit"></i> 增加</a>
</script>
<%--//上传公司凭证dialog--%>
<form class="layui-form" id="userinfoform" action="" style="display: none">
    <div class="layui-upload">
        <button type="button" class="layui-btn" id="test1">上传图片</button>
        <div class="layui-upload-list">
            <img class="layui-upload-img" id="demo1">
            <p id="demoText"></p>
        </div>
    </div>
</form>



<form class="layui-form" id="userinfoform3" action="" style="display: none">
    <div class="layui-upload">
        <button type="button" class="layui-btn" id="test3">上传图片</button>
        <div class="layui-upload-list">
            <img class="layui-upload-img" id="demo3">
            <p id="demoText3"></p>
        </div>
    </div>
</form>




<div id="update_div" style="display:none;">
    <form class="layui-form" action="" id="add_submits">
        <div class="layui-form-item">
            <div class="layui-input-block" id="img-follow">
                <%--                <img src=""  alt="上海鲜花港郁金香"  />--%>
                <%--                /upload/2020-06-10\\261443c7-de8d-492d-b8f1-ddbe8d499a71.jpg--%>
            </div>
        </div>
    </form>
    </div>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;





        table.render({
            elem: '#test'
            ,url:'<%=path%>/dataBaseContrller/selectServiceList'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '公司资料表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'materialName', title:'材料名'}
                ,{field:'num', title:'份数', sort: true}
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

                    break;
            }
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //查看详情
            if(obj.event === 'viewDetails'){

                $("#img-follow").html("");
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/dataBaseContrller/serviceListView',
                    dataType: 'JSON',
                    data: {
                        materialId:data.id
                    },
                    success: function (msg) {
                        $.each(msg.data, function (i, item) {
                            // alert("))))))))))))))))))))))"+item.licenseAddress);
                            $("#img-follow").append("<img src=" + item.licenseAddress + "  alt='公司电子凭证图片'/>")

                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });

                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '查看详情'
                    ,area: ['700px','500px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#update_div') //内容
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

           //添加公司凭证
           else if(obj.event === 'insert') {
                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    , title: '添加公司凭证'
                    , area: ['450px', '300px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userinfoform') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            // $('#roleName').val("");
                            // $("#roleDescribe").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
//上传凭证
                layui.use('upload', function () {
                    var $ = layui.jquery
                        , upload = layui.upload;

                    //普通图片上传
                    var uploadInst = upload.render({
                        elem: '#test1'
                        , url: '<%=path%>/dataBaseContrller/uploadvoucher'//改成您自己的上传接口
                        , before: function (obj) {
                            //预读本地文件示例，不支持ie8
                            obj.preview(function (index, file, result) {
                                $('#demo1').attr('src', result); //图片链接（base64）
                            });
                        }
                        , done: function (res) {
                            //如果上传失败
                            if (res.code > 0) {
                                return layer.msg('上传失败');
                            }
                            //上传成功
                            alert(res.msg)

                            // layui.use('form', function(){
                            //     var form = layui.form;
                            //     form.render();
                            //     form.on('submit(insertconfirm)', function(data){
                            //         data.field.id = adminId;
                            $.ajax({
                                url: "<%=path%>/dataBaseContrller/addServiceList",
                                type: "POST",
                                dataType: 'JSON',
                                data: {
                                    licenseAddress: res.msg,
                                    materialId: data.id
                                },
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
                        }
                        , error: function () {
                            //演示失败状态，并实现重传
                            var demoText = $('#demoText');
                            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                            demoText.find('.demo-reload').on('click', function () {
                                uploadInst.upload();
                            });
                        }
                    });

                });

            }
        });
    });





    //人员资料
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test2'
            ,url:'<%=path%>/dataBaseContrller/selectStaffList'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '公司资料表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'materialName', title:'资料名'}
                ,{field:'num', title:'份数', sort: true}
                // ,{field:'city', title:'城市', width:100}
                // ,{field:'sign', title:'签名'}
                // ,{field:'experience', title:'积分', width:80, sort: true}
                // ,{field:'ip', title:'IP', width:120}
                // ,{field:'logins', title:'登入次数', width:100, sort: true}
                // ,{field:'joinTime', title:'加入时间', width:120}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo2', width:250}
            ]]
            ,page: true
        });
        //头工具栏事件
        table.on('toolbar(test2)', function(obj){
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

                    break;
            }
        });
        //监听行工具事件
        table.on('tool(test2)', function(obj){
            var data = obj.data;
            //查看详情
            if(obj.event === 'straffviewDetails'){

                $("#img-follow").html("");
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/dataBaseContrller/staffListView',
                    dataType: 'JSON',
                    data: {
                        materialId:data.id
                    },
                    success: function (msg) {
                        $.each(msg.data, function (i, item) {
                            // alert("))))))))))))))))))))))"+item.userdataAddress);
                            $("#img-follow").append("<img src=" + item.licenseAddress + "  alt='员工资料照片'/>")

                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });

                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '查看详情'
                    ,area: ['700px','500px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#update_div') //内容
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

            //添加公司凭证
            else if(obj.event ==='straffinsert') {
                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    , title: '添加员工资料'
                    , area: ['450px', '300px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userinfoform3') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            // $('#roleName').val("");
                            // $("#roleDescribe").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
//上传凭证
                layui.use('upload', function () {
                    var $ = layui.jquery
                        , upload = layui.upload;

                    //普通图片上传
                    var uploadInst = upload.render({
                        elem: '#test3'
                        , url: '<%=path%>/dataBaseContrller/uploadstaff'//改成您自己的上传接口
                        , before: function (obj) {
                            //预读本地文件示例，不支持ie8
                            obj.preview(function (index, file, result) {
                                $('#demo3').attr('src', result); //图片链接（base64）
                            });
                        }
                        , done: function (res) {
                            //如果上传失败
                            if (res.code > 0) {
                                return layer.msg('上传失败');
                            }
                            //上传成功
                            alert(res.msg)

                            // layui.use('form', function(){
                            //     var form = layui.form;
                            //     form.render();
                            //     form.on('submit(insertconfirm)', function(data){
                            //         data.field.id = adminId;
                            $.ajax({
                                url: "<%=path%>/dataBaseContrller/addStaffList",
                                type: "POST",
                                dataType: 'JSON',
                                data: {
                                    licenseAddress: res.msg,
                                    materialId: data.id
                                },
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
                        }
                        , error: function () {
                            //演示失败状态，并实现重传
                            var demoText = $('#demoText3');
                            demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                            demoText.find('.demo-reload').on('click', function () {
                                uploadInst.upload();
                            });
                        }
                    });

                });

            }
        });
    });
</script>
</body>
</html>
