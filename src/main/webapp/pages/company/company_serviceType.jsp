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
    <title>服务类别</title>
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
            <button class="layui-btn layui-btn-sm" lay-event="inserttypeName">
                <i class="layui-icon layui-icon-add-circle-fine"></i>申请服务类别
            </button>
        </div>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="deleteServiceType">
        <i class="layui-icon layui-icon-auz"></i> 删除</a>
</script>

<%--//添加dialog--%>
<form class="layui-form" id="userinfoform" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">服务类别</label>
        <div class="layui-input-block">
            <select name="typeName" id="typeName" lay-filter="City_level" lay-verify="required"></select>
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
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/serviceTypeContrller/queryCompanyServiceType'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '公司端服务类别表'
            , cols: [[
                ,{field: 'id', title: 'id', align: 'center',hide:true}
                ,{field: 'typeName', title: '服务类别名', align: 'center'}
                , {field: 'description', title: '服务描述', align: 'center'}
                , {field: 'updateTime', title: '服务申请时间', align: 'center'}
                , {field: 'state', title: '状态', align: 'center'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });


        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'inserttypeName':
                    var layerinsert = layer.open({
                        type: 1
                        , title: '添加服务类别'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#userinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none")
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
                            // layer.msg($("#typeName").val())
                            $.ajax({
                                type: 'POST',
                                url: '<%=path%>/serviceTypeContrller/addServicerelstion',
                                dataType: 'JSON',
                                data: {
                                    // id: $("#typeName").find("option:selected").text(),
                                    id: $("#typeName").val()
                                },
                                success: function (msg) {
                                    layer.close(layerinsert);
                                    layer.alert(msg.msg, {icon: 6}, function () {
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

        //查询下拉框区域数据
        $.ajax({
            url: '<%=path%>/serviceTypeContrller/queryServiceNull',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                $("#typeName").html("<option value=''></option>");
                $.each(msg.data, function (i, item) {
                    $("#typeName").append("<option value='" + item.id + "'>" + item.typeName + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                    form.render();
                });
            }
        });

        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            if (obj.event === 'deleteServiceType') {
                if(tabdata.state=='审核通过'){
                    layer.msg("审核通过不能删除");
                }else{
                    layer.confirm('真的删除服务吗?', function (index) {
                       $.ajax({
                           url:'<%=path%>/serviceTypeContrller/deleteCompanyRelation',
                           type:'POST',
                           dataType:'JSON',
                           data:{
                               id:tabdata.id,
                           },
                           success:function (msg) {
                               if(msg.code==0){
                                   layer.msg(msg.msg);
                                   obj.del();
                               }else{
                                   layer.msg(msg.msg);
                               }

                               // window.location.reload();
                           }
                       });
                    })
                }
            }
        })


    });
</script>
</body>
</html>