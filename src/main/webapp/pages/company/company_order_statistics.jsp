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
    <title>back_order_statistics</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/echarts.min.js"></script>
    <style>
        #chartmain {
            border: 2px solid #666;
            width: 49%;
            height: 400px;
            margin: 10px auto;
            margin-bottom: 0;
        }

        #querydiv {
            display: inline-block;
            padding: 20px 20% 0 16%;
        }

        #querydiv .layui-btn {
            height: 50px;
            width: 200px;
            margin-left: 60px;
        }

        #querydiv .layui-form {
            display: inline-block;
            margin: 30px 0 0 200px;
        }

        .layui-form-label {
            float: left;
            display: block;
            padding: 37px 32px;
            width: 78px;
            font-weight: 400;
            line-height: 20px;
            text-align: right;
        }

        .layui-form-item .layui-input-inline {
            float: left;
            margin-top: 29px;
            width: 295px;
            margin-right: 10px;
        }

    </style>
</head>
<body>

<div class="layui-form-item" id="querydiv">
    <div class="layui-form">
        <div class="layui-form-item" id="dateChoose">
            <div class="layui-inline">
                <label class="layui-form-label">年统计</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test7" placeholder=" - ">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">月统计</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test8" placeholder=" - ">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">日期统计</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test6" placeholder=" - ">
                </div>
            </div>

        </div>
    </div>

</div>
<div style="" id="chartmain"></div>

<script>
    layui.use('table', function () {
        var $ = layui.jquery;


        $(function () {
            var startDate;
            var end_Date;

            //日期范围
            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#test6'
                    , range: true
                    // , max: getNowFormatDate() //设置最大为当前时间
                    , range: '~' //或 range: '~' 来自定义分割字符
                    , done: function (value, date, endDate) {
                        startDate = value.trim().split('~')[0];
                        end_Date = value.trim().split('~')[1];
                        $.ajax({
                            type: "post",
                            url: "<%=path%>/orderController/companyOrderStatistics",
                            dataType: 'JSON',
                            data: {
                                startDate: startDate,
                                endDate: end_Date,
                            },
                            error: function (request) {
                                layer.alert('操作失败', {
                                    icon: 2,
                                    title: "提示"
                                });
                            },
                            success: function (msg) {
                                var rowList = [];
                                var colList = [];
                                $.each(msg, function (i, item) {
                                    rowList.push(item.orderStateName);
                                    colList.push(item.countNum);
                                })
                                var title = "订单统计";
                                option = {
                                    title: {
                                        text: title
                                    },
                                    tooltip: {},
                                    legend: {
                                        data: ['订单数']
                                    },
                                    xAxis: {
                                        data: rowList,
                                        axisLabel: {
                                            interval: 0,
                                            rotate: 40
                                        },
                                    },
                                    yAxis: {},
                                    series: [{
                                        name: '订单数',
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
//年范围
                laydate.render({
                    elem: '#test7'
                    ,type: 'year'
                    ,range: true
                    , done: function (value, date, endDate) {
                        var yearstart;
                        var yearend;
                        yearstart = value.trim().split('-')[0];
                        yearend = value.trim().split('-')[1];
                        yearstart=yearstart.trim();
                        yearend=yearend.trim();
                        var startYear="-01-01";
                        var endYear="-12-31"
                        startDate=yearstart.concat(startYear);
                        end_Date=yearend.concat(endYear);
                        $.ajax({
                            type: "post",
                            url: "<%=path%>/orderController/companyOrderStatistics",
                            dataType: 'JSON',
                            data: {
                                startDate: startDate,
                                endDate: end_Date,
                            },
                            error: function (request) {
                                layer.alert('操作失败', {
                                    icon: 2,
                                    title: "提示"
                                });
                            },
                            success: function (msg) {
                                var rowList = [];
                                var colList = [];
                                $.each(msg, function (i, item) {
                                    rowList.push(item.orderStateName);
                                    colList.push(item.countNum);
                                })
                                var title = "年订单统计";
                                option = {
                                    title: {
                                        text: title
                                    },
                                    tooltip: {},
                                    legend: {
                                        data: ['订单数']
                                    },
                                    xAxis: {
                                        data: rowList,
                                        axisLabel: {
                                            interval: 0,
                                            rotate: 40
                                        },
                                    },
                                    yAxis: {},
                                    series: [{
                                        name: '订单数',
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

                //年月范围
                laydate.render({
                    elem: '#test8'
                    ,type: 'month'
                    ,range: true
                    , done: function (value, date, endDate) {
                        var mouthstart;
                        var mouthend;
                        mouthstart = value.trim().split(' - ')[0];
                        mouthend = value.trim().split(' - ')[1];
                        mouthstart=mouthstart.trim();
                        mouthend=mouthend.trim();
                        var startMouth="-01";
                        var endMouth="-31"
                        startDate=mouthstart.concat(startMouth);
                        end_Date=mouthend.concat(endMouth);
                        $.ajax({
                            type: "post",
                            url: "<%=path%>/orderController/companyOrderStatistics",
                            dataType: 'JSON',
                            data: {
                                startDate: startDate,
                                endDate: end_Date,
                            },
                            error: function (request) {
                                layer.alert('操作失败', {
                                    icon: 2,
                                    title: "提示"
                                });
                            },
                            success: function (msg) {
                                var rowList = [];
                                var colList = [];
                                $.each(msg, function (i, item) {
                                    rowList.push(item.orderStateName);
                                    colList.push(item.countNum);
                                })
                                var title = "月订单统计";
                                option = {
                                    title: {
                                        text: title
                                    },
                                    tooltip: {},
                                    legend: {
                                        data: ['订单数']
                                    },
                                    xAxis: {
                                        data: rowList,
                                        axisLabel: {
                                            interval: 0,
                                            rotate: 40
                                        },
                                    },
                                    yAxis: {},
                                    series: [{
                                        name: '订单数',
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
            });

        });

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