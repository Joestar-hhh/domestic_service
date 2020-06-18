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
    <title>安排售后</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <style>
        .layui-input, .layui-textarea {
            display: block;
            width: 27%;
            padding-left: 10px;
        }
        #staffInfo .layui-input, .layui-textarea {
            margin-bottom: 15px;
        }
        #staffInfo .layui-form-radio {
            margin: 6px 10px 15px 0;
        }
        #staffInfo .layui-form-select dl {
            min-width: 75%;
        }
        #staffInfo {
            padding-left: 30px;
            padding-top: 20px;
        }
        .layui-form-select .layui-edge{
            right: 297px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-form-item" id="querydiv">
        <input type="text" name="orderNumber" id="orderNumber" lay-verify="title" autocomplete="off"
               placeholder="请输入订单号" class="layui-input"><br>
        <button class="layui-btn layui-btn-radius " id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询
        </button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="passCheck">安排售后</a>
</script>


<form class="layui-form" id="staffInfo" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">安排员工：</label>
        <div class="layui-input-block">
            <select name="userName" id="staffList" lay-verify="required">
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
        </div>
    </div>
</form>



<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function () {
        var table = layui.table;
        var form = layui.form;
        var $ = layui.jquery;
        var staffId;

        table.render({
            elem: '#test'
            , url: '<%=path%>/afterSalesApplicationController/queryArrangeAfterSales'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '安排售后表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号'}
                , {field: 'name', title: '用户姓名'}
                , {field: 'orderNumber', title: '订单号'}
                , {field: 'reason', title: '申请售后原因'}
                , {field: 'applyTime', title: '申请时间'}
                , {field: 'checkState', title: '状态'}
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
                /*模糊查询*/
                case 'querybtn':
                    //查询
                    var orderNumber = $('#orderNumber').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/afterSalesApplicationController/queryArrangeAfterSales'
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            orderNumber: orderNumber
                        }
                    });
                    orderNumber = '';
                    break;
            }
            ;
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            if (obj.event === 'passCheck') {
                layer.confirm('确认安排售后吗?', function (index) {
                    //查询下拉框员工姓名数据
                    $.ajax({
                        type: 'POST',
                        dataType: 'JSON',
                        url: '<%=path%>/afterSalesApplicationController/queryStaffName',
                        success: function (msg) {
                            $("#staffList").html("<option value=''></option>");
                            $.each(msg.data, function (i, item) {
                                $("#staffList").append("<option value='" + item.id + "'>" + item.userName + "</option>")
                            });
                            layui.use('form', function () {
                                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                form.render();
                            });
                        }
                    });
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '安排售后'
                        ,area: ['540px','340px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#staffInfo') //内容
                        ,btn: 0
                        ,cancel: function(index, layero){
                            if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                                $('#staffInfo')[0].reset();//重置表单
                                form.render();
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    form.render();

                    form.on('submit(insertconfirm)', function(data){
                        // // 获取下拉框的值
                        // $(".layui-anim-upbit>dd").each(function () {
                        //     if ($(this).attr('class') == "layui-this") {
                        //         staffId = $(this).html();
                        //     }
                        // });
                        var staffId = $.trim($("#staffList").val());
                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/afterSalesApplicationController/arrangeStaff',
                            dataType: 'JSON',
                            data: {
                                staffId:staffId,
                                id:tabdata.id
                            },
                            success: function (msg) {
                                $('#staffInfo')[0].reset(); //重置表单
                                form.render();
                                layer.close(layerinsert);
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