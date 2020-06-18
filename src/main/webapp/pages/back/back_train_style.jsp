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

    <style>
        <%--    表格行高自适应--%>
        .layui-table-cell {
            height: inherit;
        }

        /*
        调整图片宽度
        */
        .layui-table img {
            max-width: 200px;
        }

        #img-follow img {
            margin-left: 17px;
            min-height: 36px;
            width: 240px;
            height: 200px;
            overflow: hidden;
        }


        .layui-table td, .layui-table th, .layui-table-col-set, .layui-table-fixed-r, .layui-table-grid-down, .layui-table-header, .layui-table-page, .layui-table-tips-main, .layui-table-tool, .layui-table-total, .layui-table-view, .layui-table[lay-skin="line"], .layui-table[lay-skin="row"] {
            border-width: 0px;
            border-style: solid;
            border-color: rgb(230, 230, 230);
        }
        .layui-table-tool{
            display: none;
        }
        /*.layui-table-box{*/
        /*    display: none;*/
        /*}*/
        .layui-table-header{
            display: none;
        }

    </style>

</head>
<body>

<%--<img src="<%=path%>/static/images/1578936572799.jpg" alt="">--%>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="updatestyle">查看详情</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="File_Upload"><i class="layui-icon"></i>上传</a>
</script>


<%--上传弹出框--%>
<form class="layui-form" id="upload_video" action="" style="display: none">
    <div class="layui-upload"  style="text-align:center">
        <button type="button" class="layui-btn" id="test1" >上传图片</button>
        <div class="layui-upload-list">
            <img class="layui-upload-img" id="demo1">
            <p id="demoText"></p>
        </div>
    </div>
</form>


<%--修改技能培训界面--%>
<div id="update_div" style="display:none;">
    <form class="layui-form" action="" id="add_submits">
        <div class="layui-form-item">
            <label class="layui-form-label">项目名：</label>
            <div class="layui-input-block">
                <%--                <label id="trainProjectName"></label>--%>
                <label class="layui-form-label rightlabel" id="trainProjectName"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">培训时长：</label>
            <div class="layui-input-block">
                <label class="layui-form-label rightlabel" id="time"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">认证证书：</label>
            <div class="layui-input-block">
                <label class="layui-form-label rightlabel" id="qualificationId"></label>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" id="img-follow">
                <%--                <img src=""  alt="上海鲜花港郁金香"  />--%>
                <%--                /upload/2020-06-10\\261443c7-de8d-492d-b8f1-ddbe8d499a71.jpg--%>
            </div>
        </div>

    </form>
</div>

<script>
    style = "border-style:none"
    layui.use('table', function () {
        // var layer = layui.layer;
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            id:"id",
            elem: '#test'
            , url: '<%=path%>/skillTrainController/querySkillTrain'
            , toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            , defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            , title: '用户数据表'
            , cols: [[
                // {field: 'id', title: '序号', width: 70}
                 {
                    title: '',
                    width: 300,
                    field: 'picturePath',
                    templet: '<div><img style="height:200px;width:200px;" src="{{d.picturePath}}"></div>'
                }
                // , {title: '认证证书', field: 'qualification', emplet: '<div>{{d.qualification.qualificationName}}</div>'}
                , {field: 'trainProjectName', title: '培训项目名'}
                // , {field: 'time', title: '培训时长'}
                , {fixed: 'right', title: '操作', width: 250, toolbar: '#barDemo'}
            ]]
            , page: {
                limit: 10,//指定每页显示的条数
                limits: [10, 15, 20],
            } //每页条数的选择项

        });
        //监听行工具事件
        table.on('tool(test)', function (obj) {
            var tabdata = obj.data;

            if (obj.event === 'updatestyle') {
                var tabdata = obj.data;
                // var id = tabdata.id
                var i = tabdata.qualification.qualificationName
                // tabdata.trainProjectName;
                $("#id").html(tabdata.id);
                $("#qualificationId").html(i);
                $("#time").html(tabdata.time);
                $("#trainProjectName").html(tabdata.trainProjectName)

                $("#img-follow").html("");
                //查找培训风采所有图片
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/skillTrainController/querySkillStyle',
                    dataType: 'JSON',
                    data: {
                        id: tabdata.id
                    },
                    success: function (msg) {
                        $.each(msg.data, function (i, item) {
                            $("#img-follow").append("<img src="+<%=path%>item.path + "  alt='上海鲜花港 - 郁金香'/>")
                        });
                        layui.use('form', function () {
                            var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                            form.render();
                        });
                    }
                });
                var updatediv = layer.open({
                    type: 1,
                    title: '培训风采',
                    area: ['700px', '600px'],
                    // shade: [0.8, '#314949'],//遮罩
                    resize: true,//不可拉伸
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

                //上传
            } else if (obj.event === 'File_Upload') {
                var path = tabdata.path;
                var id = tabdata.id
                $("#id").val(id);
                if (path === undefined) {
                    var layerupdate = layer.open({
                        type: 1,
                        title: '资源上传',
                        area: ['500px', '400px'],
                        shade: [0.8, '#314949'],//遮罩,
                        resize: false,//不可拉伸,
                        content: $("#upload_video"),
                        btn: 0,
                        cancel: function (index, layero) {
                            if (confirm('确定要关闭么')) { //只有当点击confirm框的确定时，该层才会关闭
                                layer.closeAll();
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    // 上传
                    layui.use('upload', function () {
                        var $ = layui.jquery
                            , upload = layui.upload;
                        //普通图片上传
                        var uploadInst = upload.render({
                            elem: '#test1'
                            , url: '<%=path%>/skillTrainController/fileUpload' //改成您自己的上传接口
                            , before: function (obj) {
                                //预读本地文件示例，不支持ie8
                                obj.preview(function (index, file, result) {
                                    $('#demo1').attr('src', result); //图片链接（base64）
                                    $('#demo1').attr('style', 'width:200px;height:200px;'); //图片链接（base64）
                                    // $('#demo1').val()
                                });
                            }
                            , done: function (res) {
                                //如果上传失败
                                if (res.code > 0) {
                                    return layer.msg('上传失败');
                                }
                                //上传成功
                                // alert(id)
                                // alert(res.msg)
                                $.ajax({
                                    type: 'POST',
                                    url: '<%=path%>/skillTrainController/insertSkillStyle',
                                    dataType: 'JSON',
                                    data: {
                                        id: id,
                                        path: res.msg
                                    },
                                    success: function (msg) {
                                        alert(msg.msg);
                                        window.location.reload();
                                    }
                                })
                            }
                            , error: function () {
                                //演示失败状态，并实现重传
                                var demoText = $('#demoText');
                                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                                demoText.find('.demo-reload').on('click', function () {
                                    uploadInst.upload();
                                });
                            }
                        });
                    })

                } else {
                    alert("视频已上传")
                }
            }
        });


    });
</script>

</body>
</html>