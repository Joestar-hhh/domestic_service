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
    <title>培训统计</title>
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
        #querydiv .layui-btn{
            height: 50px;
            width: 200px;
            margin-right: 40px;
        }
    </style>
</head>
<body>

    <div class="layui-form-item" id="querydiv">

    <div class="layui-btn-container" style="display: inline-block">
        <button class="layui-btn layui-btn-radius" lay-event="query" id="query">
            <i class="layui-icon layui-icon-search"></i> 查询</button>
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
    </div>
    <div style="" id="chartmain"></div>

<script>
    var startDate;
    var endDate;
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


    layui.use('table',function () {
        var $ = layui.jquery;

        $(function () {
            $("#query").click(function () {
                $.ajax({
                    type : "post",
                    url : "<%=path%>/trainPlanController/planStatistics",
                    dataType: 'JSON',
                    data : {startDate:startTime,
                            endDate:endTime
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
                        var peoList = [];
                        $.each(msg['colList'],function (i,item) {
                            colList.push(item.countNum);

                        })
                        $.each(msg['peoList'],function (i,item) {
                            rowList.push(item.oneDay);

                            peoList.push(item.peoNum);
                        })
                        var title;
                        title="培训统计";
                        option = {
                            title: {
                                text: title
                            },
                            color: [ '#4cabce', '#e5323e'],
                            tooltip: {
                                trigger: 'axis',
                                axisPointer: {
                                    type: 'shadow'
                                }
                            },
                            legend: {
                                data:['培训次数','培训人数']
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
                                name: '培训次数',
                                type: 'bar',
                                data: colList,
                            },
                                {
                                    name: '培训人数',
                                    type: 'bar',
                                    data: peoList,
                                }
                            ]
                        };
                        //获取要赋值的DOM控件
                        var myChart = echarts.init(document.getElementById('chartmain'));
                        //赋值
                        myChart.setOption(option);
                    }
                });
            });
        })


    });


</script>
</body>
</html>