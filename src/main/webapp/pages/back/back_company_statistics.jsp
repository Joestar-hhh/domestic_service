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

    <style>
        #chartmain{
            border:2px solid #666;
            width:49%;
            height:450px;
            margin: 30px auto;
            margin-bottom: 0;
        }
        #querydiv{
            display: inline-block;
            padding: 20px 30% 0 30%;
        }
        #querydiv .layui-btn{
            height: 50px;
            width: 200px;
            margin-right: 40px;
        }
    </style>
</head>
<body>

<%--<table class="layui-hide" id="test" lay-filter="test"></table>--%>
<div class="layui-form-item" id="querydiv">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" id="typeStatistics">
            按服务类型统计
        </button>
        <button class="layui-btn layui-btn-sm" id="regionStatistics">
            按区域统计
        </button>
    </div>
</div>
<div style="" id="chartmain"></div>

<script>
    layui.use('table',function () {
        var $ = layui.jquery;

        $(function () {

            var statisticsType = "2";
            $("#typeStatistics").click(function () {
                statisticsType = "1";
                statisitcs(statisticsType);
            });
            $("#regionStatistics").click(function () {
                statisticsType = "2";
                statisitcs(statisticsType);
            });
            statisitcs(statisticsType);
        });

        function statisitcs(statisticsType) {
            $.ajax({
                type : "post",
                url : "<%=path%>/companyController/serviceStatistics",
                dataType: 'JSON',
                data : {statisticsType:statisticsType},
                error : function(request) {
                    layer.alert('操作失败', {
                        icon: 2,
                        title:"提示"
                    });
                },
                success : function(msg) {

                    var rowList = [];
                    var colList = [];
                    $.each(msg,function (i,item) {
                        if (statisticsType==="1"){
                            rowList.push(item.typeName);
                        }else{
                            rowList.push(item.region);
                        }
                        colList.push(item.countNum);
                    })
                    var title;
                    if (statisticsType==="1"){
                        title="家政公司服务类别统计";
                    }else{
                        title="家政公司区域统计";
                    }
                    option = {
                        title: {
                            text: title
                        },
                        tooltip: {},
                        legend: {
                            data:['公司数量']
                        },
                        xAxis: {
                            data: rowList,
                            axisLabel: {
                                interval: 0,
                                rotate:40,
                                // formatter:function(value)
                                // {
                                //     return value.split("").join("\n");
                                // }
                            },
                        },
                        yAxis: {},
                        series: [{
                            name: '公司数量',
                            type: 'bar',
                            data: colList,
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(220, 220, 220, 0.8)'
                            }
                        }]
                    };
                    //获取要赋值的DOM控件
                    var myChart = echarts.init(document.getElementById('chartmain'));
                    //赋值
                    myChart.setOption(option);
                }
            });
        }

    });


</script>
</body>
</html>