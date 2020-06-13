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
    <div class="layui-btn-container" style="display: inline-block">
        <button class="layui-btn layui-btn-sm" lay-event="query">查询</button>
    </div>

       <input type="button" value="时间段:" style="background-color:transparent;border:0">

    <div class="layui-form" style="display: inline-block">
        <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
<%--                <label class="layui-form-label">中文版</label>--%>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="display: inline-block">
            <div class="layui-inline">
                <%--                <label class="layui-form-label">中文版</label>--%>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test2" placeholder="yyyy-MM-dd">
                </div>
            </div>
        </div>
    </div>
<%--    <div class="layui-form-item">--%>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="viewDetails">查看详情</a>
</script>

<%--服务信息查询                --%>
<form class="layui-form" id="serviceListView" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">发布时间：</label>
        <label class="layui-form-label rightlabel" id="pulishTime"></label>
<%--        <input type="text" id="seeTypeName" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">用户名：</label>
        <label class="layui-form-label rightlabel" id="name"></label>
<%--        <input type="text" id="seeDescription" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务名：</label>
        <label class="layui-form-label rightlabel" id="title"></label>
<%--        <input type="text" id="seeServiceTypeId" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属服务描述：</label>
        <label class="layui-form-label rightlabel" id="typeName"></label>
<%--        <input type="text" id="seeUpdateTime" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务频次：</label>
        <label class="layui-form-label rightlabel" id="frequency"></label>
<%--        <input type="text" id="seePath" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务时间：</label>
        <label class="layui-form-label rightlabel" id="startTime"></label>
<%--        <input type="text" id="seeOrderNum" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务家政公司：</label>
        <label class="layui-form-label rightlabel" id="companyName"></label>
<%--        <input type="text" id="seeUnitPrice" readonly="readonly">--%>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">状态：</label>
        <label class="layui-form-label rightlabel" id="orderStateName"></label>
        <%--        <input type="text" id="seeUnitPrice" readonly="readonly">--%>
    </div>
</form>


<script>


    var startTime;
    var endTime;
    //时间选择器
    layui.use('laydate', function() {

        var laydate = layui.laydate;

        laydate.render({
            elem: '#test1'
            ,type:'datetime'
            ,done: function(value, date, endDate){
                startTime=value;
                // alert("开始时间"+startTime); //得到日期生成的值，如：2017-08-18
            }
        });
        laydate.render({
            elem: '#test2'
            ,type:'datetime'
            ,done: function(value, date, endDate){
                endTime=value;
                // alert("停止时间"+stopTime); //得到日期生成的值，如：2017-08-18
            }
        });
    });

    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'<%=path%>/serviceInformationContrller/selectInformationList'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID',sort: true}
                ,{field:'pulishTime', title:'发布时间'}
                ,{field:'name', title:'用户名',}
                ,{field:'title', title:'服务名',}
                ,{field:'typeName', title:'所属服务描述', sort: true}
                ,{field:'frequency', title:'服务频次',}
                ,{field:'startTime', title:'服务时间',}
                ,{field:'companyName', title:'服务家政公司',}
                ,{field:'orderStateName', title:'状态',}
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
                    //根据时间查询服务信息表
                case 'query':
                    //查询时间段
                    //执行重载
                    table.reload('test', {
                        url:'<%=path%>/serviceInformationContrller/selectInformationList'
                        // ,methods:"post"
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            startTime:startTime,
                            endTime:endTime,
                        }
                    });
                    // $('#test1').val(startTime);
                    // $('#test2').val(endTime);
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //查看详情
            if(obj.event === 'viewDetails'){

                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/serviceInformationContrller/selectInformationListView",
                    dataType: 'JSON',
                    data: data,
                    success: function (msg) {
                        $("#pulishTime").html(msg.data[0].pulishTime);
                        $("#name").html(msg.data[0].name);
                        $("#title").html(msg.data[0].title);
                        $("#typeName").html(msg.data[0].typeName);
                        $("#frequency").html(msg.data[0].frequency);
                        $("#startTime").html(msg.data[0].startTime);
                        $("#companyName").html(msg.data[0].companyName);
                        $("#orderStateName").html(msg.data[0].orderStateName);
                    }
                });

                var adminId = data.id;
                var layerinsert = layer.open({
                    type: 1
                    ,title: '查看详情'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#serviceListView') //内容
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
        });
    });
</script>
</body>
</html>
