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
    <title>发布需求统计</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <script type="text/javascript" src="<%=path%>/static/js/echarts.min.js"></script>

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
    </style>
</head>
<body>

    <div class="layui-form-item" id="querydiv">

    <div class="layui-btn-container" style="display: inline-block">
        <button class="layui-btn  layui-btn-radius" lay-event="query" id="query">
            <i class="layui-icon layui-icon-search"></i> 查询</button>
    </div>
        <div class="layui-form-item" id="dateChoose">
            <div class="layui-inline">
                <label class="layui-form-label">日期范围</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test6" placeholder=" - ">
                </div>
            </div>
        </div>

    </div>
    <div style="" id="chartmain"></div>

<script>
    var startDate;
    var end_Date;

    layui.use('table',function () {
        var $ = layui.jquery;

        $(function () {
            $("#query").click(function () {
                $.ajax({
                    type : "post",
                    url : "<%=path%>/orderController/requireStatistics",
                    dataType: 'JSON',
                    data : {startDate:startDate,
                            endDate:end_Date
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
                            rowList.push(item.oneDay);
                            colList.push(item.countNum);

                        })
                        var title;
                        title="发布需求统计";
                        option = {
                            title: {
                                text: title
                            },
                            color: [ '#e5323e'],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: {
                                data:['发布需求次数']
                            },

                            xAxis: {
                                data: rowList,
                                axisLabel: {
                                    interval: 0,
                                    rotate:40,
                                },
                            },
                            yAxis: {},
                            series: [
                                {
                                name: '发布需求次数',
                                type: 'bar',
                                data: colList,
                            },

                            ]
                        };
                        //获取要赋值的DOM控件
                        var myChart = echarts.init(document.getElementById('chartmain'));
                        //赋值
                        myChart.setOption(option);
                    }
                });
            });

            //日期范围
            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#test6'
                    , range: true
                    , max: getNowFormatDate() //设置最大为当前时间
                    , range: '~' //或 range: '~' 来自定义分割字符
                    , done: function (value, date, endDate) {
                        startDate = value.trim().split('~')[0];
                        end_Date = value.trim().split('~')[1];
                        // 获取下拉框的值
                        $(".layui-anim-upbit>dd").each(function () {
                            if ($(this).attr('class') == "layui-this") {
                                companyName = $(this).html();
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