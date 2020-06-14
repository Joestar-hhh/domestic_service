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
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div class="layui-form-item" id="querydiv">
        <div class="layui-form" style="display: inline-block">
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="test1" placeholder="yyyy-MM-dd">
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="display: inline-block">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="test2" placeholder="yyyy-MM-dd">
                    </div>
                </div>
            </div>
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-sm" lay-event="query">
                    <i class="layui-icon layui-icon-add-circle-fine"></i>查询
                </button>
            </div>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="reply">
        <i class="layui-icon layui-icon-edit"></i>回复</a>
    <a class="layui-btn layui-btn-xs" lay-event="checkReply">
        <i class="layui-icon layui-icon-edit"></i>查看回复</a>
</script>

<form class="layui-form" id="userinfoform" action="" style="display: none">
    <div class="layui-form-item">
        <ul class="items"></ul>
        <textarea id="text" name="replyContext" cols="30" rows="10"></textarea>
        <br>
        <button class="layui-btn layui-btn-sm" id="insertconfirm" lay-submit lay-filter="insertconfirm">
            <i class="layui-icon"></i>回复
        </button>
    </div>
</form>

<form class="layui-form" id="orderinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">回复时间：</label>
        <label class="layui-form-label rightlabel" id="contentTime"></label>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">回复内容：</label>
        <label class="layui-form-label rightlabel" id="content"></label>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="confirm" lay-submit lay-filter="confirm">确定</button>
        </div>
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
            , url: "<%=path%>/serviceEvaluationController/queryServiceEvaluationList"
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '评价反馈表'
            , cols: [[
                // {type: 'checkbox',fixed: 'left'}
                {field: 'id', title: '序号', width: 60}
                , {field: 'name', title: '用户名', width: 100}
                , {field: 'time', title: '评价时间', width: 170}
                , {
                    field: 'evaluationLevel', title: '评价星级', width: 160, height: 100,
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
                            , theme: '#28FF28'     //颜色
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


        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);

            switch (obj.event) {
                case 'query':
                    table.reload('test', {
                        url: '<%=path%>/serviceEvaluationController/queryServiceEvaluationList'
                        // ,methods:"post"
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            startTime: startTime,
                            endTime: endTime,
                        }
                    });
                    break;
            }
        });


        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            var $ = layui.jquery;
            if (obj.event === 'reply') {
                var layerreply = layer.open({
                    type: 1
                    , title: '回复评价'
                    , area: ['500px', '320px']
                    , shade: [0.8, '#314949'] //遮罩
                    , resize: false //不可拉伸
                    , content: $('#userinfoform') //内容
                    , btn: 0
                    , cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            layer.close(index);
                        }
                        return false;
                    }
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                    form.on('submit(insertconfirm)', function (data) {
                        var content = $("#text").val();
                        $.ajax({
                            type: 'POST',
                            url: "<%=path%>/serviceEvaluationController/updateContent",
                            dataType: 'JSON',
                            data: {
                                id:tabdata.id,
                                content: content,
                            },
                            success: function (msg) {
                                layer.close(layerreply);
                                layer.alert(msg.msg, {icon: 1}, function (index) {
                                    layer.close(index);
                                });//成功提示
                            }
                        })
                        return false;
                    });
                });
            }
            else if (obj.event === 'checkReply'){
                $("#contentTime").html(tabdata.contentTime);
                $("#content").html(tabdata.content);
                var layercheck = layer.open({
                    type: 1
                    ,title: '查看回复'
                    ,area: ['640px','450px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#orderinfoform') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            $('#contentTime').val("");
                            $("#content").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function(){
                    var form = layui.form;
                    form.render();
                    form.on('submit(confirm)', function(data){
                        layer.close(layercheck);
                        return false;
                    });
                });
            }
        });
    });
</script>
</body>
</html>