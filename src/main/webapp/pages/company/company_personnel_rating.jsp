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
    <title>评价反馈管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <script src="<%=path%>/static/layui/lay/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">

    <style>
        .layui-rate {
            padding: 0px 5px 10px 0;
            font-size: 0;
        }

        #querydiv .layui-input, #querydiv .layui-textare {
            width: 100%;
            display: inline-block;
            margin: 0 10px 10px 10px;
        }

        .layui-form-item {
            /*margin-bottom: 15px;*/
            /*margin-top: 10px;*/
            margin-left: 124px;
            clear: both;
        }

        .layui-btn-sm {
            height: 30px;
            line-height: 30px;
            padding: 0 10px;
            font-size: 12px;
            margin-left: 95px;
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
        #confirm {
            margin-left: -100px;
        }
        #orderinfoform .layui-form-label {
            width: 130px;
        }
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



<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="viewDetails">
        <i class="layui-icon layui-icon-edit"></i>查看详情</a>
</script>

<%--服务列表查看详情--%>
<form class="layui-form" id="serviceListView" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">人员姓名：</label>
        <label class="layui-form-label rightlabel" id="userName"></label>
        <%--        <input type="text" id="seeTypeName" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">评价内容：</label>
        <label class="layui-form-label rightlabel" id="evaluationContent"></label>
        <%--        <input type="text" id="seeDescription" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">所属公司：</label>
        <label class="layui-form-label rightlabel" id="companyName"></label>
        <%--        <input type="text" id="seeServiceTypeId" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">住址：</label>
        <label class="layui-form-label rightlabel" id="address"></label>
        <%--        <input type="text" id="seeUpdateTime" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">职位：</label>
        <label class="layui-form-label rightlabel" id="skill"></label>
        <%--        <input type="text" id="seePath" readonly="readonly">--%>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">就职状态：</label>
        <label class="layui-form-label rightlabel" id="jobState"></label>
        <%--        <input type="text" id="seeOrderNum" readonly="readonly">--%>
    </div>
</form>


<script>
    var startTime;
    var endTime;
    //时间选择器
    layui.use('laydate', function () {

        var laydate = layui.laydate;
        laydate.render({
            elem: '#test1'
            , type: 'datetime'
            , done: function (value, date, endDate) {
                startTime = value;
            }
        });
        laydate.render({
            elem: '#test2'
            , type: 'datetime'
            , done: function (value, date, endDate) {
                endTime = value;
            }
        });
    });

    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#test'
            , url: "<%=path%>/servicePersonnelratingController/queryServiceEvaluationList"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '评价反馈表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号'}
                , {field: 'userName', title: '人员姓名'}
                , {
                    field: 'evaluationLevel', title: '评价星级', width: 300, height: 100,
                    templet: function (d) {
                        return '<div id="star' + d.id + '"></div>'
                    }
                }
                , {field: 'evaluationContent', title: '评价内容'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , done: function (res) {
                var data = res.data;//返回的json中data数据
                //司机星级
                layui.use(['rate'], function () {
                    for (var item in data) {
                        var rate = layui.rate;
                        rate.render({
                            elem: '#star' + data[item].id + ''     //绑定元素
                            , length: 5            //星星个数
                            , value: data[item].evaluationLevel             //初始化值
                            , theme: '#FF1829'     //颜色
                            , half: false           //支持半颗星
                            , readonly: true      //只读
                        });
                    }
                });
            }
            , page: {
                limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项
        });

        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var data = obj.data;
            var $ = layui.jquery;
            if(obj.event === 'viewDetails') {

                $.ajax({
                    type: 'POST',
                    url: "<%=path%>/servicePersonnelratingController/serviceListView",
                    dataType: 'JSON',
                    data: data,
                    success: function (msg) {
                        $("#userName").html(msg.data[0].userName);
                        $("#evaluationContent").html(msg.data[0].evaluationContent);
                        $("#companyName").html(msg.data[0].companyName);
                        $("#address").html(msg.data[0].address);
                        $("#skill").html(msg.data[0].skill);
                        $("#jobState").html(msg.data[0].jobState);
                        $("#seeUnitPrice").html(msg.data[0].unitPrice);
                    }
                });
            }
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
        });
    });
</script>
</body>
</html>