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
    <title>培训风采</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<%--<img src="<%=path%>/static/images/1578936572799.jpg" alt="">--%>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updaterole">查看详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">修改</a>
</script>
<style>
<%--    表格行高自适应--%>
    .layui-table-cell {
        height: inherit;
    }
    /*
    调整图片宽度
    */
    .layui-table img {
        max-width: 300px;
    }

</style>

<script>
    style="border-style:none"
    layui.use('table', function () {
        // var layer = layui.layer;
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '/skillTrainController/querySkillTrain'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户数据表'
            , cols: [[

                {field: 'id', title: '序号', width: 70}
                , {
                    title: '',
                    field: 'picturePath',
                    templet: '<div><img style="height:300px;width:300px;" src="{{d.picturePath}}"></div>'
                }
                , {field: 'trainProjectName', title: '培训项目名'}
                , {field: 'time', title: '培训时长'}
                ,{field:'upload',title:'头像',templet: function () {
                  return'<button class="layui-btn layui-btn-xs upload_btn">选择图片</button>'
                    }}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 2,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;

            //删除
            if (obj.event === 'del') {
                layer.confirm('真的删除行么', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: '/skillTrainController/deleteSkillTrain',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            if (msg.code == "0") {
                                alert(msg.msg);
                                obj.del();
                            } else {
                                alert(msg.msg);
                            }
                        }
                    })
                    layer.close(index);
                });
            }
            //修改
            else if (obj.event === 'updaterole') {
                var tabdata = obj.data;
                var id = tabdata.id
                $.ajax({
                    type: 'POST',
                    url: '/skillTrainController/queryqualification',
                    dataType: 'JSON',
                    data: {
                        id: tabdata.id
                    },
                    success: function (msg) {
                        //jsp界面赋值
                        $("#id").val(tabdata.id);
                        $("#trainProjectName").val(tabdata.trainProjectName);
                        $("#time").val(tabdata.time);
                        $("#qualificationId").html("<option value=''></option>");

                        $.each(msg.data, function (i, item) {
                            $("#qualificationId").append("<option value='" + item.id + "'>" + item.qualificationName + "</option>")
                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });
                //打开修改技能培训弹窗
                var updatediv = layer.open({
                    type: 1,
                    title: '修改技能培训项目',
                    area: ['540px', '400px'],
                    // shade: [0.8, '#314949'],//遮罩
                    resize: false,//不可拉伸
                    shadeClose: false, //点击遮罩关闭
                    content: $('#update_div'),
                    cancel: function (index, layero) {
                        if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $('#trainProjectName').val("");
                            $("#time").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                });
                //修改数据
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                    form.on('submit(updataskillTrain)', function (data) {
                        data.field.id = id;
                        $.ajax({
                            url: '/skillTrainController/updateSkillTrain',
                            type: 'POST',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (data) {
                                alert(data.msg);
                                layer.close(updatediv);
                                $('#trainProjectName').val("");
                                $("#time").val("");
                                window.parent.location.reload();//修改成功后刷新父界面
                            }
                        })
                        return false;
                    });
                });
            }
        });

        //添加数据
        layui.use('form', function () {
            var form = layui.form;
            form.render();
            $("#Item_Number").hide();
            form.on('submit(updataskillTrain)', function (data) {
                $.ajax({
                    type: 'POST',
                    url: '/skillTrainController/insertSkillTrain',
                    dataType: 'JSON',
                    data: data.field,
                    success: function (msg) {
                        layer.alert(msg.msg);
                        $('#trainProjectName').val("");
                        $("#time").val("");
                        layer.close(layerupdate);
                        window.parent.location.reload();//修改成功后刷新父界面
                    }
                })
                return false;
            });
        });
    });
</script>
<%--修改技能培训界面--%>
<div id="update_div" style="display:none;">
    <form class="layui-form" action="" id="add_submits">
        <%--        &lt;%&ndash;        <input type="hidden" id="skillid" value="">&ndash;%&gt;--%>
        <%--        <div class="layui-form-item" style="display:none" id="Item_Number">--%>
        <%--            <label class="layui-form-label">项目编号：</label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input type="text" name="id" id="id" required lay-verify="required"--%>
        <%--                       disabled="disabled" class="layui-input"  autocomplete="off">--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label">项目名：</label>
            <div class="layui-input-block">
                <input type="text" name="trainProjectName" id="trainProjectName" required lay-verify="required"
                       placeholder="请输入培训项目的名称"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">培训时长：</label>
            <div class="layui-input-block">
                <select name="time" id="time" lay-verify="required">
                    <option value=""></option>
                    <option value="一周">一周</option>
                    <option value="一个月">一个月</option>
                    <option value="两个月">两个月</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">认证证书：</label>
            <div class="layui-input-block">
                <select name="qualificationId" id="qualificationId" lay-verify="required">
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn formbtn" id="insertconfirm" lay-submit="add_submits"
                        lay-filter="updataskillTrain">确定
                </button>
                <%--                <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>--%>
            </div>
        </div>
    </form>
</div>

</body>
</html>