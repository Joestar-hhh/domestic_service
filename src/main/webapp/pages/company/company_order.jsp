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
    <title>家政订单管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
    <style>
        .layui-form-item {
            margin-bottom: 0;
        }
        #querydiv .layui-btn-container{
            display: inline-block;
        }
        #orderinfoform .layui-form-label {
            width: 114px;
        }
        #orderinfoform .layui-input-block {
            margin-left: 247px;
        }
        #orderinfoform .rightlabel{
            margin-bottom: 15px;
            text-align: left;
            line-height: 30px;
            background-color: #beffed;
        }
        #orderinfoform .companyProfile{
            margin-bottom: 15px;
            text-align: left;
            line-height: 30px;
            background-color: #beffed;
            width: 400px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div class="demoTable">
        搜索：
        <div class="layui-inline">
            <select  lay-verify="" id="stateOrder">
                <option value="">根据订单状态查询</option>
                <option value="待处理">待处理</option>
                <option value="已处理">已处理</option>
                <option value="服务中">服务中</option>
                <option value="已服务">已服务</option>
            </select>
        </div>
        <button class="layui-btn layui-btn-radius " data-type="reload" lay-event="queryState">
            <i class="layui-icon layui-icon-search"></i>  搜索
        </button>
    </div>

</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="showinfo">
        <i class="layui-icon layui-icon-list"></i> 详情</a>
    <a class="layui-btn layui-btn-xs" lay-event="orders">
        <i class="layui-icon layui-icon-auz"></i> 接单</a>
</script>


<form class="layui-form" id="orderinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">订单号ID：</label>
        <label class="layui-form-label rightlabel" id="orderNumber"></label>
        <label class="layui-form-label">服务人员：</label>
        <label class="layui-form-label rightlabel" id="staffName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">订单时间：</label>
        <label class="layui-form-label rightlabel" id="pulishTime"></label>
        <label class="layui-form-label">服务时间：</label>
        <label class="layui-form-label rightlabel" id="startTime"></label>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">费用：</label>
        <label class="layui-form-label rightlabel" id="fee"></label>
        <label class="layui-form-label">订单状态：</label>
        <label class="layui-form-label rightlabel" id="stateComName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">售后电话：</label>
        <label class="layui-form-label rightlabel" id="phone"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务内容：</label>
        <label class="layui-form-label companyProfile" id="description"></label>

    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
        </div>
    </div>
</form>

<script>
    var orderState;
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;


        table.render({
            elem: '#test'
            ,url:'<%=path%>/orderController/companyOrderList'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: [

            ]//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '家政公司订单管理'
            ,cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field:'orderNumber', title: '订单号'}
                ,{field:'staffName', title: '服务人员'}
                ,{field:'comName', title: '所属家政公司'}
                ,{field:'pulishTime', title: '订单时间'}
                ,{field:'startTime', title: '服务时间'}
                ,{field:'fee', title: '费用'}
                ,{field:'stateComName', title: '公司订单状态'}
                // ,{field:'orderStateName', title: '用户订单状态'}
                ,{field:'userName', title: '服务对象'}
                ,{field:'phone', title: '电话',hide:true}
                ,{field:'id', title: '订单ID',hide:true}
                ,{field:'description', title: '服务内容',hide:true}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });

        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);

            // 获取下拉框的值
            $(".layui-anim-upbit>dd").each(function () {
                if ($(this).attr('class') == "layui-this") {
                    orderState = $(this).html();
                }
            })

            switch (obj.event) {
                case 'queryState':
                    // alert("下拉框的值：---"+orderState)
                    table.reload('test', {
                        url: '<%=path%>/orderController/companyOrderList'
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            stateComName: orderState
                        }
                    });
                    orderState="";
                    break;
            }
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            var orderId = tabdata.id;
            var stateName=tabdata.stateComName;
            if(obj.event === 'orders'){//审核
                //询问框
                if(stateName==="待处理"
            ){
                    layer.confirm('确定是否接单？', {
                        btn: ['确定','取消'] //按钮
                    }, function(index){
                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/orderController/orders',
                            dataType: 'JSON',
                            data: {id: orderId},
                            success: function (msg) {
                                layer.close(index);
                                layer.alert(msg.msg,{icon: 6},function () {
                                    window.location.reload();//接单成功后刷新界面
                                });//接单成功提示
                            }
                        })
                    }, function(index){
                        layer.close(index);
                    });

                }
                else {
                    layer.msg("此订单已接单！");
                }

            }
            else if(obj.event === 'showinfo'){
                $('#orderNumber').html(tabdata.orderNumber);
                $('#staffName').html(tabdata.staffName);
                $('#pulishTime').html(tabdata.pulishTime);
                $('#startTime').html(tabdata.startTime);
                $('#phone').html(tabdata.phone);
                $('#stateComName').html(tabdata.stateComName);
                $('#userName').html(tabdata.userName);
                $('#description').html(tabdata.description);
                var layerupdate = layer.open({
                    type: 1
                    ,title: '查看订单详情'
                    ,area: ['640px','580px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#orderinfoform') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
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
                        layer.close(layerupdate);
                        return false;
                    });
                });
            }
        });

    });
</script>
</body>
</html>