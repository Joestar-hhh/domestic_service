<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/9
  Time: 23:32
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
    <title>入住申请</title>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearForm.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/component/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/admin/css/pearButton.css"/>
    <link rel="stylesheet" href="<%=path%>/static/pear_layui/assets/login.css"/>

    <style>
        #uploadHead .layui-btn{
            margin: 30px 0 0 15px;
        }
    </style>
</head>

<body>


<form class="layui-form" action="javascript:void(0);">
    <div class="layui-form-item">
        <img class="logo" src="<%=path%>/upload/3.jpg"/>
        <div class="title">入驻申请</div>
    </div>

    <div class="layui-form-item">
        <div class="layui-upload" id="uploadHead">

                <label class="layui-form-label"><img class="layui-upload-img" id="demo1" style="width: 90px;height: 90px"></label>

                    <button type="button" class="layui-btn" id="test1" style="width: 150px;height: 40px">上传公司头像</button>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">区域：</label>
        <div class="layui-input-block">
            <select name="regionList" id="regionList" lay-filter="regionList" lay-verify="required"></select>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">详细地址：</label>
        <div class="layui-input-block">
            <input type="text" lay-verify="required" name="address" class="layui-input" id="address"></div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">公司描述：</label>
        <div class="layui-input-block">
            <input type="text" lay-verify="required" name="companyProfile" class="layui-input" id="companyProfile">
        </div>
    </div>

    <div class="layui-form-item" id="typeName">

    </div>

    <div class="layui-input-item">
        <button type="submit" class="layui-btn pear-btn-primary login" lay-submit="" lay-filter="formDemo">立即提交</button>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <input type="hidden" id="demoText" name="head" value="" lay-verify="required" lay-reqtext="请上传公司头像">
        </div>
    </div>

</form>
<script src="<%=path%>/static/pear_layui/component/layui/layui.js"></script>
<script>

    //监听提交


    layui.use(['form', 'element', 'jquery'], function () {
        var randomNum;
        var from = layui.form;
        var element = layui.element;
        var $ = layui.jquery;
        from.render();

        //获取地区
        $.ajax({
            url: '<%=path%>/companyController/queryregionList',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                // layer.msg(msg.msg);
                $("#regionList").html("<option value=''></option>")
                $.each(msg.data, function (i, item) {
                    $("#regionList").append("<option value='" + item.id + "'>" + item.region + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        });

        //获取公司类别
        $.ajax({
            url: '<%=path%>/serviceTypeContrller/queryServiceType',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                $.each(msg.data, function (i, item) {
                    $("#typeName").append('<input type="checkbox" name="typeName"  lay-skin="primary" title="' + item.typeName + '" value="' + item.id + '">')
                });
                layui.use('form', function () {
                    var form = layui.form;
                    form.render();
                })
            }
        })

        layui.use('upload', function () {
            var $ = layui.jquery
                , upload = layui.upload;
            //普通图片上传
            var uploadInst = upload.render({
                elem: '#test1'
                , url: '<%=path%>/skillTrainController/fileUpload' //改成您自己的上传接口
                , size: 1024 //限制文件大小，单位 KB
                , before: function (obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function (index, file, result) {
                        $('#demo1').attr('src', result); //图片链接（base64）

                    });

                }
                , done: function (res) {
                    //如果上传失败
                    if (res.code > 0) {
                        return layer.msg('上传失败');
                    }
                    //上传成功
                    $("#demoText").val(res.msg);
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


        from.on('submit(formDemo)', function (data) {
            var typridList = new Array();
            $("#typeName>input[type='checkbox']").each(function (i) {
                if ($(this).next().attr("class") == "layui-unselect layui-form-checkbox layui-form-checked") {
                    typridList.push($(this).attr('value'));
                }
            })
            if (typridList.length == 0) {
                layer.msg("请选择公司类别");
                return false;
            }

            $.ajax({
                url: '<%=path%>/serviceTypeContrller/addServiceContinuous',
                type: 'POST',
                dataType: 'JSON',
                data: {
                    regionId: $("#regionList").val(),
                    companyProfile: $("#companyProfile").val(),
                    typridList: JSON.stringify(typridList),
                    address: $("#address").val(),
                    head:$("#demoText").val()
                },
                success: function (msg) {
                    layer.msg(msg.msg);
                }
            })
        })
    });
</script>
</body>
</html>

