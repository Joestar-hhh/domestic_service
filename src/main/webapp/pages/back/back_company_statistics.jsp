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
    <title>back_company_statistics</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <script type="text/javascript" src="<%=path%>/static/js/echarts.min.js"></script>
    <%--    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">--%>
</head>
<body>

<%--<table class="layui-hide" id="test" lay-filter="test"></table>--%>

<div style="border:2px solid #666;width:49%;height:450px;float:left" id="chartmain"></div>
<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleterole">
                <i class="layui-icon layui-icon-delete"></i>删除
            </button>
            <button class="layui-btn layui-btn-sm" lay-event="insertrole">
                <i class="layui-icon layui-icon-add-circle-fine"></i>添加
            </button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="updaterole">
        <i class="layui-icon layui-icon-edit"></i>修改</a>
    <%--    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
</script>


<script>
    layui.use('table',function () {
        var $ = layui.jquery;

        $(function () {
            option = {
                xAxis: {
                    type: 'category',
                    data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: [120, 200, 150, 80, 70, 110, 130],
                    type: 'bar',
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(220, 220, 220, 0.8)'
                    }
                }]
            };
            alert(123);
            //获取要赋值的DOM控件
            var myChart = echarts.init(document.getElementById('chartmain'));
            //赋值
            myChart.setOption(option);
        });
        <%--$.ajax({--%>
        <%--    type : "post",--%>
        <%--    url : "<%=path%>/",--%>
        <%--    dataType: 'JSON',--%>
        <%--    data : '',--%>
        <%--    error : function(request) {--%>
        <%--        layer.alert('操作失败', {--%>
        <%--            icon: 2,--%>
        <%--            title:"提示"--%>
        <%--        });--%>
        <%--    },--%>
        <%--    success : function(msg) {--%>
        <%--        layer.alert(msg.msg,function () {--%>
        <%--            window.location.reload();//修改成功后刷新父界面--%>
        <%--        });--%>
        <%--    }--%>
        <%--});--%>



        // var form = layui.form;
        // form.render('select');
        // form.on('select(selecttest)', function (data) {
        //     alert("选中：" + JSON.stringify(data));
        // });
    });
</script>
</body>
</html>