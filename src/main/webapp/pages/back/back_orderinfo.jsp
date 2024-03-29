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
    <title>back_orderInfo</title>
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
        .querybtn {
            margin: 10px 5px 10px 20px;
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
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
<%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn  layui-btn-danger layui-btn-sm" lay-event="deleteorder">
                <i class="layui-icon layui-icon-delete"></i>删除</button>
        </div>
        <input type="text" name="intput_company" id="intput_company" lay-verify="title" autocomplete="off" placeholder="请输入公司名字" class="layui-input">
        <button class="layui-btn layui-btn-sm querybtn" id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询</button>
    </div>

</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="showinfo">
        <i class="layui-icon layui-icon-list"></i>查看详情</a>
</script>



<form class="layui-form" id="orderinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">订单号：</label>
        <label class="layui-form-label rightlabel" id="orderNumber"></label>
        <label class="layui-form-label">用户名：</label>
        <label class="layui-form-label rightlabel" id="userName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务人员：</label>
        <label class="layui-form-label rightlabel" id="staffName"></label>
        <label class="layui-form-label">服务：</label>
        <label class="layui-form-label rightlabel" id="typeName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">描述：</label>
        <label class="layui-form-label rightlabel" id="description"></label>

    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">开始时间：</label>
        <label class="layui-form-label rightlabel" id="startTime"></label>
        <label class="layui-form-label">结束时间：</label>
        <label class="layui-form-label rightlabel" id="endTime"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">公司名：</label>
        <label class="layui-form-label rightlabel" id="comName"></label>
        <label class="layui-form-label">订单状态：</label>
        <label class="layui-form-label rightlabel" id="stateComName"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">频次：</label>
        <label class="layui-form-label rightlabel" id="frequency"></label>
        <label class="layui-form-label">用户联系电话：</label>
        <label class="layui-form-label rightlabel" id="phone"></label>
<%--        <label class="layui-form-label">订单状态：</label>--%>
<%--        <label class="layui-form-label" id="stateComName"></label>--%>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
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
            ,url:'<%=path%>/orderController/queryOrder'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '序号'}
                ,{field:'orderNumber', title: '订单号'}
                // ,{field:'pulishTime', title: '下单时间'}
                ,{field:'userName', title: '用户'}
                ,{field:'staffName', title: '服务人员'}
                ,{field:'typeName', title: '服务'}
                ,{field:'frequency', title: '频次'}
                ,{field:'startTime', title: '开始时间'}
                ,{field:'endTime', title: '结束时间'}
                ,{field:'comName', title: '所属公司'}
                ,{field:'stateComName', title: '订单状态'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });


        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'deleteorder':
                    layer.confirm('真的删除行么', function(index){
                        var data = checkStatus.data;
                        var idList = new Array();
                        $.each(data, function (index,val) {
                            idList.push(val.id);
                        })
                        $.ajax({
                            type : "post",
                            url : "<%=path%>/orderController/deleteOrder",
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
                                    window.location.reload();//修改成功后刷新
                                });
                            }
                        });
                        layer.close(index);
                    });

                    break;
                case 'querybtn':
                    var inputname = $('#intput_company').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/orderController/queryOrder'
                        // ,methods:"post"
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            companyName: inputname
                        }
                    });
                    $('#intput_company').val(inputname);
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
            } else if(obj.event === 'showinfo'){
                $('#orderNumber').html(tabdata.orderNumber);
                $('#userName').html(tabdata.userName);
                $('#staffName').html(tabdata.staffName);
                $('#typeName').html(tabdata.typeName);
                $('#comName').html(tabdata.comName);
                $('#stateComName').html(tabdata.stateComName);
                $('#phone').html(tabdata.phone);
                $('#description').html(tabdata.description);
                $('#frequency').html(tabdata.frequency);
                $('#startTime').html(tabdata.startTime);
                $('#endTime').html(tabdata.endTime);
                var layerupdate = layer.open({
                    type: 1
                    ,title: '查看订单信息'
                    ,area: ['640px','580px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#orderinfoform') //内容
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