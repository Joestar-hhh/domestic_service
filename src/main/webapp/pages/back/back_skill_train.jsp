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
<html>
<head>
    <meta charset="utf-8">
    <title>技能培训</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="insert_Skill_train">添加</button>
        </div>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updaterole">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '/skillTrainController/querySkillTrain'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户数据表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号', width: 70}
                , {field: 'trainProjectName', title: '培训项目名', width: 200}
                , {field: 'time', title: '培训时长'}
                , {title: '认证证书', templet: '<div>{{d.qualification.qualificationName}}</div>'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
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
                case 'deletetype':
                    break;
                case 'insert_Skill_train':
                    $.ajax({
                        type: 'POST',
                        url: '/skillTrainController/queryqualification',
                        dataType: 'JSON',
                        success: function (msg) {
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
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加角色'
                        ,area: ['500px','400px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#update_div') //内容
                        ,btn: 0
                        ,cancel: function(index, layero){
                            if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none");
                                $('#roleName').val("");
                                $("#roleDescribe").val("");
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
            };
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
                    content: $('#update_div')
                });
                //修改
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                    form.on('submit(updataskillTrain)', function (data) {
                        // alert( "trainProjectName=" + $("#trainProject_name").val() + "time=" + $("#Train_time").val() + "qualificationId=" + $("#qualification").val())
                        $.ajax({
                            url: '/skillTrainController/updateSkillTrain',
                            type: 'POST',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (data) {
                                if (data.code == "0") {
                                    alert(data.msg);
                                    layer.close(updatediv);
                                    window.parent.location.reload();//修改成功后刷新父界面
                                } else {
                                    alert(data.msg);
                                }
                            }
                        })
                        return false;
                    });
                });
            }
        });

        //添加数据
        layui.use('form', function(){
            var form = layui.form;
            form.render();
            $("#Item_Number").hide();
            form.on('submit(update_div)', function(data){
                data.field.id = roleId;
                $.ajax({
                    type: 'POST',
                    url: '/roleController/updateRole',
                    dataType: 'JSON',
                    data: data.field,
                    success: function (msg) {
                        if (msg.code == "0") {
                            layer.alert(msg.msg);
                        } else {
                            layer.alert(msg.msg);
                        }
                    }
                })
                layer.close(layerupdate);
                $('#roleName').val("");
                $("#roleDescribe").val("");
                window.parent.location.reload();//修改成功后刷新父界面
                return false;
            });
        });


    });
</script>
<%--修改技能培训界面--%>
<div id="update_div" style="display:none;">
    <form class="layui-form" action="" id="add_submits">
        <%--        <input type="hidden" id="skillid" value="">--%>
        <div class="layui-form-item" style="display:none" id="Item_Number">
            <label class="layui-form-label">项目编号：</label>
            <div class="layui-input-block">
                <input type="text" name="id" id="id" required lay-verify="required"
                       disabled="disabled" class="layui-input">
            </div>
        </div>
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