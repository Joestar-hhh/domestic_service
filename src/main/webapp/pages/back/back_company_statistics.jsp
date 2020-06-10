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
            height:400px;
            margin: 10px auto;
            margin-bottom: 0;
        }
        #querydiv{
            display: inline-block;
            padding: 20px 20% 0 16%;
        }
        #querydiv .layui-btn{
            height: 50px;
            width: 200px;
            margin-left: 60px;
        }
        #querydiv .layui-form{
            display: inline-block;
            margin: 30px 0 0 200px;
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
        <button class="layui-btn layui-btn-sm" id="dateStatistics">
            按周期统计
        </button>
    </div>
    <div class="layui-form">
        <div class="layui-form-item" id="dateChoose">
            <div class="layui-inline">
                <label class="layui-form-label">日期范围</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test6" placeholder=" - ">
                </div>
            </div>
        </div>
    </div>

</div>
<div style="" id="chartmain"></div>


<script>
    layui.use('table',function () {
        var $ = layui.jquery;

        $(function () {
            var startDate;
            var end_Date;
            //日期范围
            layui.use('laydate', function() {
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#test6'
                    ,range: true
                    ,max: getNowFormatDate() //设置最大为当前时间
                    ,range: '~' //或 range: '~' 来自定义分割字符
                    ,done: function(value, date, endDate){
                        startDate = value.trim().split('~')[0];
                        end_Date = value.trim().split('~')[1];
                        // alert("选中时间startDate："+startDate+"    选中结束时间："+endDate.year+"-"+endDate.month+"-"+endDate.date)
                        statisitcs(statisticsType,startDate,end_Date);
                    }
                });
            });


            var statisticsType = 1;
            $("#typeStatistics").click(function () {
                statisticsType = "1";
                $("#dateChoose").css("display","none");
                statisitcs(statisticsType,null,null);
            });
            $("#regionStatistics").click(function () {
                statisticsType = "2";
                $("#dateChoose").css("display","none");
                statisitcs(statisticsType,null,null);
            });
            $("#dateStatistics").click(function () {
                statisticsType = "3";
                $("#dateChoose").css("display", "block");
            });
            $("#dateChoose").css("display","none");
            statisitcs(statisticsType);
        });

        function statisitcs(statisticsType,startDate,endDate) {
            $.ajax({
                type : "post",
                url : "<%=path%>/companyController/serviceStatistics",
                dataType: 'JSON',
                data : {
                    statisticsType:statisticsType,
                    startDate:startDate,
                    endDate:endDate
                },
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
                        }else if (statisticsType==="2"){
                            rowList.push(item.region);
                        }else {
                            rowList.push(item.joinDay);
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
                                rotate:40
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





        //获取当前时间
        function getNowFormatDate() {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = date.getFullYear() + seperator1 + month + seperator1 + strDate
                + " " + date.getHours() + seperator2 + date.getMinutes()
                + seperator2 + date.getSeconds();
            return currentdate;
        }

    });


</script>
</body>
</html>