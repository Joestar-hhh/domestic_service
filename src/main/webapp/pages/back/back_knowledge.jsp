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
    <title>育婴知识</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">
    <style>
        #img-follow{
            margin: 50px 90px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<%--添加育婴知识标题弹出款--%>
<form class="layui-form" id="knowledgeinfoform" action="" style="display: none">

    <div class="layui-form-item">
        <label class="layui-form-label">标题：</label>
        <div class="layui-input-block">
            <input type="text" name="title" id="title" required lay-verify="required" placeholder="请输入标题"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">育婴知识描述：</label>
        <div class="layui-input-block">
            <input type="text" name="type" id="type" required lay-verify="required" placeholder="育婴知识描述"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
        </div>
    </div>
</form>

<div id="style_div" style="display: none">
    <div class="layui-input-block" id="img-follow">
    </div>
</div>

<%--上传弹出框--%>
<form class="layui-form" id="upload_video" action="" style="display: none">
    <div class="layui-form-item" style="text-align: center">
        <button type="button" class="layui-btn" id="test3"><i class="layui-icon"></i>上传视频</button>
    </div>
</form>

<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container" style="display: inline-block">
            <button class="layui-btn layui-btn-danger " lay-event="deleterole">
                <i class="layui-icon layui-icon-delete"></i>删除
            </button>
            <button class="layui-btn " lay-event="insertknowledge">
                <i class="layui-icon layui-icon-add-circle-fine"></i>添加育婴知识
            </button>
        </div>
        <input type="text" name="intput_company" id="intput_company" lay-verify="title" autocomplete="off"
               placeholder="请输入标题名字" class="layui-input">
        <button class="layui-btn layui-btn-warm" id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询
        </button>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="see_details"><i class="layui-icon layui-icon-edit"></i>查看详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="File_Upload"><i class="layui-icon"></i>上传</a>
</script>


<script>
    layui.use('table', function () {
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            , url: '<%=path%>/knowledgeController/queryKnowledeg'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '育婴知识表'
            , cols: [[
                {type: 'checkbox', fixed: 'left'}
                , {field: 'id', title: '序号', hide: true}
                , {field: 'title', title: '标题'}
                , {field: 'time', title: '时间'}
                , {field: 'knowledgePath', title: '路径',hide:true}
                // , hide: true
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 10,//指定每页显示的条数
                limits: [10, 15, 20,
                    25, 30, 35, 40, 45, 50],
            } //每页条数的选择项

        });

        //头工具栏事件
        table.on('toolbar(test)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                //删除
                case 'deleterole':
                    var data = checkStatus.data;
                    var idList = new Array();
                    $.each(data, function (index, val) {
                        idList.push(val.id);
                    })
                    $.ajax({
                        type: "post",
                        url: "<%=path%>/knowledgeController/deleteKnowledeg",
                        dataType: 'JSON',
                        data: {idList: JSON.stringify(idList)},
                        error: function (request) {
                            layer.alert('操作失败', {
                                icon: 2,
                                title: "提示"
                            });
                        },
                        success: function (msg) {
                            layer.alert(msg.msg, function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    });
                    break;

                //模糊查询标题
                case'querybtn':
                    //查询
                    var title = $("#intput_company").val();
                    var inputname = $('#intput_company').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/knowledgeController/queryKnowledeg'
                        // ,methods:"post"
                        , page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        , where: {
                            title: inputname
                        }
                    });
                    $('#intput_company').val(inputname);
                    break;

                /*头栏添加育婴知识*/
                case 'insertknowledge':
                    var layerinsert = layer.open({
                        type: 1
                        , title: '添加育婴知识'
                        , area: ['500px', '400px']
                        , shade: [0.8, '#314949'] //遮罩
                        , resize: false //不可拉伸
                        , content: $('#knowledgeinfoform') //内容
                        , btn: 0
                        , cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    layui.use('form', function () {
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function (data) {
                            $.ajax({
                                type: 'POST',
                                url: '<%=path%>/knowledgeController/addKnowledeg',
                                dataType: 'JSON',
                                data: data.field,
                                success: function (msg) {
                                    // alert(msg.msg);
                                    layer.close(layerinsert);
                                    layer.alert(msg.msg, function () {
                                        window.location.reload();//修改成功后刷新父界面
                                    });
                                }
                            })
                            return false;
                        });
                    });
                    break;

            }
            ;
        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;
            //查看详情
            if (obj.event === 'see_details') {
                var path = tabdata.path;
                if(path==undefined){
                alert("请先上传教育视频")
                }else{
                    var layerupload = layer.open({
                        type: 1,
                        title: '查看详情',
                        area: ['300px', '250px'],
                        shade: [0.8, '#314949'],
                        resize: false,
                        content: $("#style_div"),
                        btn: 0,
                        cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                layer.closeAll();
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    $("#img-follow").html("");
                    $.ajax({
                        type: 'POST',
                        url: '<%=path%>/knowledgeController/queryKnowledegStyle',
                        dataType: 'JSON',
                        data: {
                            id: tabdata.id
                        },
                        success: function (msg) {
                            $.each(msg.data, function (i, item) {
                                $("#img-follow").append("<a href=" + <%=path%>item.knowledgePath + " target=_blank >" + item.type + "</a>");
                            })
                            layui.use('form', function () {
                                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                                form.render();
                            });
                        }
                    })
                }

            } else if (obj.event === 'File_Upload') {
                var path = tabdata.knowledgePath;
                var id = tabdata.id
                $("#id").val(id);
                // alert(path)
                if (path == undefined) {
                    var layerupdate = layer.open({
                        type: 1,
                        title: '资源上传',
                        area: ['300px', '150px'],
                        shade: [0.8, '#314949'],
                        resize: false,
                        content: $("#upload_video"),
                        btn: 0,
                        cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                // layer.close(index);
                                layer.closeAll();
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    layui.use('upload', function () {
                        var $ = layui.jquery
                            , upload = layui.upload;
                        var uploadInst = upload.render({
                            elem: '#test3'
                            , url: '<%=path%>/skillTrainController/fileUpload' //改成您自己的上传接口
                            , accept: 'video' //视频
                            // , size: 1889356 //限制文件大小，单位 KB
                            , done: function (res) {
                                $.ajax({
                                    type: 'POST',
                                    url: '<%=path%>/knowledgeController/updateknowledeg',
                                    dataType: 'JSON',
                                    data: {
                                        knowledgePath: res.msg,
                                        id: id
                                    },
                                    success: function (msg) {
                                        // alert(msg.msg)
                                        layer.alert(msg.msg, function () {
                                            window.location.reload();//修改成功后刷新父界面
                                        });
                                        layer.close(layerupload);
                                    }
                                })
                                console.log(res)
                            }
                        });
                    });
                } else {
                    alert("视频已上传")
                }
            }
        });
    });
</script>


</body>
</html>