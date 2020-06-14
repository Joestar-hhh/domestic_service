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
    <title>区域列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
    <style>
        .layui-form-label {
            width: 100px;
        }
    </style>


</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="insertadmin">
                <i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
        </div>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="see_details">
        <i class="layui-icon layui-icon-list"></i> 查看详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">
        <i class="layui-icon layui-icon-delete"></i>删除</a>
</script>


<%--//添加dialog--%>
<form class="layui-form" id="userinfoform" action="" style="display: none">
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
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>

<%--查看详情--%>
<form class="layui-form" id="see_company" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">公司名称：</label>
        <label class="layui-form-label">创建时间：</label>
        <label class="layui-form-label">公司地址：</label>
        <label class="layui-form-label">公司电话：</label>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label rightlabel" id="company_name"></label>
        <label class="layui-form-label rightlabel" id="creation_time"></label>
        <label class="layui-form-label" id="company_address"></label>
        <label class="layui-form-label" id="company_phone"></label>
    </div>

</form>

<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/companyController/queryRegion'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '区域列表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'regionId', title: '序号'}
                , {field: 'region', title: '区域名称'}
                , {field: 'joinTime', title: '覆盖时间'}
                , {field: 'regioncount', title: '家政公司数'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 10,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });


        //-------------------------------------------
        //查询下拉框区域数据
        $.ajax({
            url: '<%=path%>/mapController/queryfirstLevelRegion',
            type: 'POST',
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

        //头工具栏事件  添加
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'deletetype':

                    break;
                case 'insertadmin':
                    var layerinsert = layer.open({
                        type: 1
                        , title: '添加区域'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#userinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none");
                                $('#roleName').val("");
                                $("#roleDescribe").val("");
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });

                    //dialog submit提交添加
                    layui.use('form', function () {
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function (data) {
                            $.ajax({
                                type: 'POST',
                                url: '<%=path%>/companyController/insertRegion',
                                dataType: 'JSON',
                                data: {
                                    firstLevelRegion: $("#City_level").find("option:selected").text(),
                                    secondaryZone: $("#County_level").find("option:selected").text()
                                },
                                success: function (msg) {

                                    layer.close(layerinsert);
                                    $('#City_level').val("");
                                    $("#County_level").val("");
                                    layer.alert(msg.msg, {icon: 6},function () {
                                        window.location.reload();//修改成功后刷新父界面
                                    });

                                }
                            })
                            return false;
                        });
                    });
                    break;
            }
            ;
        });



        //监听行工具事件 删除、查看详情
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            if (obj.event === 'del') {
                // alert(tabdata.regionId);
                if (tabdata.regioncount > 0) {
                    layer.confirm('不能删除有公司的区域')
                } else {
                    layer.confirm('<i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #1E9FFF;"></i> 真的要删除这个区域码么', function (index) {
                        $.ajax({
                            url: '<%=path%>/companyController/deleteRegion',
                            type: 'POST',
                            dataType: 'JSON',
                            data: {
                                region: tabdata.region
                            },
                            success: function (msg) {
                                layer.msg(msg.msg)
                                obj.del();
                                layer.close(index);
                            }
                        })
                    });
                }
            } else if (obj.event === 'see_details') {
                if(tabdata.regioncount==0){
                    layer.alert("该区域目前暂无公司");
                }else{
                    $.ajax({
                        url: '<%=path%>/companyController/queryRegionCompany',
                        type: 'POST',
                        dataType: 'JSON',
                        data: {
                            regionId: tabdata.regionId
                        },
                        success: function (msg) {
                            // alert(msg.data.companyName);
                            $.each(msg.data, function (j, item) {
                                $("#company_name").append(item.companyName+"<br><br><br>");
                                $("#creation_time").append(item.joinTime+"<br><br>");
                                $("#company_address").append(item.address+"<br><br>");
                                $("#company_phone").append(item.phone+"<br><br><br>");
                            });
                        }
                    })
                    var see = layer.open({
                        type: 1
                        , title: '查看详情'
                        , area: ['600px', '480px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#see_company') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                layer.close(index);
                                $("#company_name").text("");
                                $("#creation_time").text("");
                                $("#company_address").text("");
                                $("#company_phone").text("");
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                }
            }
        });
    });

</script>
</body>
</html>