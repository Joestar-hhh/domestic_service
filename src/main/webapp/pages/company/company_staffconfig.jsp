<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/16
  Time: 0:01
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
    <title>company_staffInfo</title>
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
        #staffInfo .layui-input, .layui-textarea {
            margin-bottom: 15px;
        }
        #staffInfo .layui-form-radio {
            margin: 6px 10px 15px 0;
        }
        #staffInfo .layui-form-select dl {
            min-width: 75%;
        }
        #staffInfo{
            padding-left: 30px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>


<script type="text/html" id="tablebtn">

    <a class="layui-btn  layui-btn-xs" lay-event="configservice">
        <i class="layui-icon layui-icon-edit"></i>分配服务</a>
</script>

<form class="layui-form" id="config" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">服务类别：</label>
        <div class="layui-input-block">
            <select name="serviceType" id="serviceType" lay-filter="serviceType" lay-verify="required">

            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">服务：</label>
        <div class="layui-input-block" id="serviceCheck">
            <%--            <input type="checkbox" name="like[write]" title="写作">--%>
            <%--            <input type="checkbox" name="like[read]" title="阅读" checked>--%>
            <%--            <input type="checkbox" name="like[dai]" title="发呆">--%>
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-input-block btnhide">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>

<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>

    // layui.use(['table','dropdown'], function(){

    layui.use(['table','form'], function() {
        var form = layui.form;
        var table = layui.table;
        var layedit = layui.layedit;
        var $ = layui.jquery;

        //查询公司服务类型
        $.ajax({
            url: '<%=path%>/serviceTypeContrller/queryComServiceType',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                alert(JSON.stringify(msg))
                $("#serviceType").html("<option value=''></option>");
                $.each(msg, function (i, item) {
                    $("#serviceType").append("<option value='" + item.id + "'>" + item.typeName + "</option>")
                });
                form.render();
            }
        });

        form.on('select(serviceType)', function (data) {
            form.render('select');
            alert("选中的值:"+JSON.stringify(data));//得到被选中的值
            //获取次一级地区
            $.ajax({
                url: '<%=path%>/serviceTypeContrller/queryServiceTypeService',
                type: 'POST',
                dataType: 'JSON',
                data: {stId: data.value},
                success: function (msg) {
                    alert(JSON.stringify(msg))
                    $("#serviceCheck").html("");
                    $.each(msg.data, function (j, item) {
                        $("#serviceCheck").append("<input type='checkbox' name='"+item.sName+"' value='"+item.id+"' title='"+item.sName+"'>")
                    });
                    form.render();
                }
            })
            form.render();
        });

        table.render({
            elem: '#test'
            ,url:'<%=path%>/staffController/queryCompanyStaffInfo'
            // ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'id', title: '员工编号'}
                ,{field:'userName', title: '人员姓名'}
                ,{field:'skill', title: '职业技能'}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#tablebtn'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}

            ]]
            ,page: {limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],} //每页条数的选择项
            , done: function (res) {
                // 在表格渲染完成后进行下拉框渲染。
                $("[data-field='skill']").children().each(function () {
                    if ($(this).text() == '') {
                        $(this).text("暂无")
                    }
                });
            }

        });

        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            //console.log(obj)s
            if(obj.event === 'configservice'){
                var staffId = tabdata.id;


                var layerinsert = layer.open({
                    type: 1
                    ,title: '添加员工'
                    ,area: ['540px','540px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#config') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $('#config')[0].reset();//重置表单
                            form.render();
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                form.render();
                form.on('submit(insertconfirm)', function(data){

                    $.ajax({
                        type: 'POST',
                        url: '<%=path%>/staffController/',
                        dataType: 'JSON',
                        data: data.field,
                        success: function (msg) {
                            // alert(msg.msg);
                            $('#config')[0].reset(); //重置表单
                            form.render();
                            layer.close(layerinsert);

                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    })
                    return false;
                });
            }
        });
    });

</script>
</body>
</html>
