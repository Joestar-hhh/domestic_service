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
    </div>
</script>

<script type="text/html" id="barDemo">
    {{#  if(d.userAddressId === 0){ }}
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="defultAddress">
        <i class="layui-icon layui-icon-list"></i>默认地址</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        <i class="layui-icon layui-icon-edit"></i> 修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">
        <i class="layui-icon layui-icon-delete"></i>删除</a>
    {{# }if(d.userAddressId !== 0) { }}
    <a class="layui-btn layui-btn-xs" lay-event="edit">
        <i class="layui-icon layui-icon-edit"></i> 修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">
        <i class="layui-icon layui-icon-delete"></i>删除</a>
    {{#  } }}
</script>


<form class="layui-form" id="userinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">姓名：</label>
        <div class="layui-input-block">
            <input type="text" name="name" id="name" required lay-verify="required" placeholder="请输入姓名" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">市级：</label>
        <div class="layui-input-block">
            <select name="City_level" id="City_level" lay-filter="City_level" lay-verify="required"></select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">县级：</label>
        <div class="layui-input-block">
            <select name="County_level" id="County_level" lay-filter="County_level" lay-verify="required">
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">详细地址：</label>
        <div class="layui-input-block">
            <input type="text" name="detailAddress" id="detailAddress" required  lay-verify="required" placeholder="请输入详细地址" autocomplete="off" class="layui-input">
            </select>
        </div>
    </div>


    <div class="layui-form-item">
        <label class="layui-form-label">手机号：</label>
        <div class="layui-input-block">
            <input type="text" name="phone" id="phone" required lay-verify="required" placeholder="请输入手机号" autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
        </div>
    </div>
</form>

<%--需求信息--%>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'<%=path%>/myAddressContrller/selectAddress'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '我的地址'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'name', title:'姓名'}
                ,{field:'region', title:'所在地区',}
                ,{field:'detailAddress', title:'详细地址',}
                ,{field:'phone', title:'手机号', sort: true}
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
                    $.ajax({
                        type: 'POST',
                        url: "<%=path%>/mapController/queryfirstLevelRegion",
                        dataType: 'JSON',
                        success: function (msg) {
                            $("#City_level").html("<option value=''></option>");
                            $.each(msg.data, function (i, item) {
                                $("#City_level").append("<option value='" + item.id + "'>" + item.firstLevelRegion + "</option>")
                            });
                            layui.use('form', function () {
                                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                form.render();
                            });
                        }
                    });
                    //市级选择后发的查询县级
                    layui.use('form', function () {
                        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                        //select 监听事件
                        layui.use('form', function () {
                            var form = layui.form;
                            form.on('select(City_level)', function (data) {
                                form.render('select');
                                // alert("选中的值:"+data.value);//得到被选中的值
                                //获取次一级地区
                                $.ajax({
                                    url: '<%=path%>/mapController/querySecondaryZone',
                                    type: 'POST',
                                    dataType: 'JSON',
                                    data: {id: data.value},
                                    success: function (msg) {
                                        $("#County_level").html("<option value=''></option>");
                                        $.each(msg.data, function (j, item) {
                                            $("#County_level").append("<option value='" + item.id + "'>" + item.secondaryZone + "</option>")
                                        });
                                        form.render();
                                        form.render('select');
                                    }
                                })
                            });
                        });
                        form.render();
                    });
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加我的地址'
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
                    layui.use('form', function(){
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function(data){
                            $.ajax({
                                url:"<%=path%>/myAddressContrller/addAddress",
                                type: "POST",
                                dataType: 'JSON',
                               data:{
                                   id:6,
                                   firstLevelRegion: $("#City_level").find("option:selected").text(),
                                   secondaryZone: $("#County_level").find("option:selected").text(),
                                   detailAddress: $("input[name='detailAddress']").val(),
                                   name: $("input[name='name']").val(),
                                   phone: $("input[name='phone']").val(),
                               },
                                success: function (msg) {
                                    if (msg.code == "0") {
                                        alert(msg.msg);
                                        layer.close(layerinsert);
                                        // $('#detailAddress').val("");
                                        window.location.reload();//修改成功后刷新父界面
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
            //默认地址
            if(obj.event === 'defultAddress'){

                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/myAddressContrller/updateDefultAddress",
                    dataType:'JSON',
                    data:{
                        id:data.id
                    },
                    success: function (msg) {
                        alert(msg.msg);
                        window.location.reload();//修改成功后刷新父界面
                    }
                });

            }
            //删除服务类型
           else if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    $.ajax({
                        url:"<%=path%>/myAddressContrller/deleteAddress",
                        type: "POST",
                        dataType: 'JSON',
                        data:data,
                        error: function (msg) {
                            alert("服务器繁忙");
                        },
                        success: function (msg) {
                            alert(msg.msg);
                            window.location.reload();//修改成功后刷新父界面
                        }
                    });
                    return false;
                });
            }
           //修改服务类型
           else if(obj.event === 'edit'){

                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/mapController/queryfirstLevelRegion",
                    dataType: 'JSON',
                    success: function (msg) {
                        $("#City_level").html("<option value=''></option>");
                        $.each(msg.data, function (i, item) {
                            $("#City_level").append("<option value='" + item.id + "'>" + item.firstLevelRegion + "</option>")
                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });
//市级选择后发的查询县级
                layui.use('form', function () {
                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                    //select 监听事件
                    layui.use('form', function () {
                        var form = layui.form;
                        form.on('select(City_level)', function (data) {
                            form.render('select');
                            // alert("选中的值:"+data.value);//得到被选中的值
                            //获取次一级地区
                            $.ajax({
                                url: '<%=path%>/mapController/querySecondaryZone',
                                type: 'POST',
                                dataType: 'JSON',
                                data: {id: data.value},
                                success: function (msg) {
                                    $("#County_level").html("<option value=''></option>");
                                    $.each(msg.data, function (j, item) {
                                        $("#County_level").append("<option value='" + item.id + "'>" + item.secondaryZone + "</option>")
                                    });
                                    form.render();
                                    form.render('select');
                                }
                            })
                        });
                    });
                    form.render();
                });
                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '修改地址'
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
                        data.field.id = adminId;
                        //修改用户的信息
                        $.ajax({
                            url:"<%=path%>/myAddressContrller/updateAddress",
                            type: "POST",
                            dataType: 'JSON',
                            data:{
                                id: data.field.id,
                                firstLevelRegion: $("#City_level").find("option:selected").text(),
                                secondaryZone: $("#County_level").find("option:selected").text(),
                                detailAddress: $("input[name='detailAddress']").val(),
                                name: $("input[name='name']").val(),
                                phone: $("input[name='phone']").val(),
                            },
                            error: function (msg) {
                                alert("服务器繁忙");
                            },
                            success: function (msg) {
                                alert(msg.msg);
                                layer.close(layerinsert);
                                window.location.reload();//修改成功后刷新父界面
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
