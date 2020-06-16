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
    <title>我的地址</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <link rel="stylesheet" href="<%=path%>/static/css/back_page.css">


    <style>
        .layui-form-label {
            float: left;
            display: block;
            padding: 6px 78px;
            width: 359px;
            font-weight: 400;
            line-height: 19px;
            text-align: right;
        }

        .layui-input, .layui-textarea {
            width: 41%;
        }

        .formbtn {
            margin: 17px 567px;
        }

        blockquote, body, button, dd, div, dl, dt, form, h1, h2, h3, h4, h5, h6, input, li, ol, p, pre, td, textarea, th, ul {
            margin-top: 39px;
            padding: 0;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        }

        body {
            background-color: #00feff;
        }
    </style>
</head>
<body>


<style>
    .layui-form-select dl {
        /*display: none;*/
        position: absolute;
        left: 404px;
        top: 42px;
        padding: 5px 0;
        z-index: 899;
        min-width: 42%;
        border: 1px solid #d2d2d2;
        max-height: 300px;
        overflow-y: auto;
        background-color: #fff;
        border-radius: 2px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, .12);
        box-sizing: border-box;
    }

    .layui-form-select .layui-edge {
        right: 31%;
    }

    .layui-form-select dl dd, .layui-form-select dl dt {
        padding: -4px 8px;
        line-height: 18px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>

<form class="layui-form" id="userinfoform" action="">
    <div class="layui-form-item" id="accountdiv1">
        <label class="layui-form-label">账号名：</label>
        <div class="layui-input-block" id="account_name">
            <input type="text" name="account" id="account" required lay-verify="required" autocomplete="off"
                   class="layui-input" readonly="readonly">
        </div>
    </div>
    <div class="layui-form-item" id="accountdiv2">
        <label class="layui-form-label">公司名称：</label>
        <div class="layui-input-block" id="company_name">
            <input type="text" name="companyName" id="companyName" required lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">市级：</label>
        <div class="layui-input-block">
            <select name="City_level" id="City_level" lay-filter="City_level" lay-verify="required">
            </select>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">县级：</label>
        <div class="layui-input-block">
            <select name="County_level" id="County_level" lay-filter="County_level" lay-verify="required">
            </select>
        </div>
    </div>

    <div class="layui-form-item" id="accountdiv3">
        <label class="layui-form-label">公司地址：</label>
        <div class="layui-input-block" id="company_address">
            <input type="text" name="address" id="address" required lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" id="accountdiv4">
        <label class="layui-form-label">公司法人代表：</label>
        <div class="layui-input-block" id="company_boss">
            <input type="text" name="boss" id="boss" required lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>
    <div class="layui-form-item" id="accountdiv5">
        <label class="layui-form-label">公司电话：</label>
        <div class="layui-input-block" id="company_phone">
            <input type="text" name="phone" id="phone" required lay-verify="required" autocomplete="off"
                   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">公司类别:</label>
        <div class="layui-input-block" id="account_inputdiv">

        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">保存</button>
        </div>
    </div>
</form>

<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>


    layui.use(['form', 'layer', 'laydate'], function () {
        var $ = layui.jquery;
        var form = layui.form;
//页面一加载就发送ajax
        $(function () {
            //查询公司市级
            $.ajax({
                type: 'POST',
                url: "<%=path%>/mapController/queryfirstLevelRegion",
                dataType: 'JSON',
                success: function (msg) {
                    $("#City_level").html("<option value=''></option>");
                    $.each(msg.data, function (i, item) {
                        $("#City_level").append("<option value='" + item.id + "'>" + item.firstLevelRegion + "</option>")
                    });
                    layui.use('form', function () {
                        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                        // form.render();
                    });
                }
            });
            //市级选择后发的查询县级
            layui.use('form', function () {
                var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                //select 监听事件
                layui.use('form', function () {
                    var form = layui.form;
                    form.on('select(City_level)', function (data) {
                        form.render('select');
                        // alert("选中的值:"+data.value);//得到被选中的值
                        //获取次一级地区
                        $.ajax({
                            url: '<%=path%>/mapController/querySecondaryZone',
                            type: 'POST',
                            dataType: 'JSON',
                            data: {id: data.value},
                            success: function (msg) {
                                $("#County_level").html("<option value=''></option>");
                                $.each(msg.data, function (j, item) {
                                    $("#County_level").append("<option value='" + item.id + "'>" + item.secondaryZone + "</option>")
                                });
                                // form.render();
                                form.render('select');
                            }
                        })
                    });
                });
                form.render();
            });

            //获取公司服务类别
            var checkList = [];
            $.ajax({
                url: '<%=path%>/serviceTypeContrller/queryServiceType',
                type: 'POST',
                dataType: 'JSON',
                // async: false,
                success: function (msg) {
                    $.each(msg.data, function (i, item) {
                        $("#account_inputdiv").append('<input type="checkbox" name="account_inputdiv"  lay-skin="primary" title="' + item.typeName + '" value="' + item.id + '" disabled="true">')
                    });
                    $.ajax({
                        url: '<%=path%>/myCompanyContrller/selectMyCompany',
                        type: 'POST',
                        dataType: 'JSON',
                        async: false,
                        success: function (msg) {

                            $("#account").val(msg.data[0].account);
                            $("#companyName").val(msg.data[0].companyName);
                            $("#address").val(msg.data[0].region + msg.data[0].address);
                            $("#boss").val(msg.data[0].boss);
                            $("#phone").val(msg.data[0].phone);
                            // alert(JSON.stringify(msg.data))
                            checkList = msg.data;
                            form.render();
                        }
                    });

                }
            });
            setTimeout(function () {
                $.each(checkList, function (i, item) {
                    $("#account_inputdiv>input").each(function () {
                        // alert("item.typeNme:"+item.typeName+"    this:"+$(this).attr('title'));
                        if (item.typeName == $(this).attr('title')) {
                            $(this).next().attr('class', 'layui-unselect layui-form-checkbox layui-form-checked');
                        }
                    });
                });
            }, 300);





            form.on('submit(insertconfirm)', function (data) {
                <%--$.ajax({--%>
                <%--    url: '<%=path%>/myCompanyContrller/updateMycompany',--%>
                <%--    type: 'POST',--%>
                <%--    dataType: 'JSON',--%>
                <%--    async: false,--%>
                <%--    data: {--%>
                <%--        companyName: $("#companyName").val(),--%>
                <%--        address: $("#address").val(),--%>
                <%--        boss: $("#boss").val(),--%>
                <%--        phone: $("#phone").val(),--%>
                <%--    },--%>
                <%--    success: function (msg) {--%>
                <%--    }--%>
                <%--});--%>

                var serviceTypeList = [];
                $("#account_inputdiv>input").each(function () {
                    // alert("item.typeNme:"+item.typeName+"    this:"+$(this).attr('title'));
                    if ($(this).next().attr('class') == 'layui-unselect layui-form-checkbox layui-form-checked') {
                        serviceTypeList.push($(this).val());
                        // alert("id:"+$(this).val()+"    text:" + $(this).attr('title'))
                    }
                });
                data.field.serviceTypeList = JSON.stringify(serviceTypeList);
                data.field.CityLevel = $("#City_level").find("option:selected").text();
                data.field.CountyLevel = $("#County_level").find("option:selected").text();

                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/myCompanyContrller/updateMycompany',
                    dataType: 'JSON',
                    data: data.field,
                    success: function (msg) {
                        layer.alert(msg.msg,function () {
                            window.location.reload();//修改成功后刷新父界面
                        })

                    }
                })
                return false;
            });


            <%--    var typridList = new Array();--%>
            <%--    $("#account_inputdiv>input[type='checkbox']").each(function (i) {--%>
            <%--        if ($(this).next().attr("class") == "layui-unselect layui-form-checkbox layui-form-checked") {--%>
            <%--            // alert("你选了有："+$(this).attr('title')+"    "+$(this).attr('value'));--%>
            <%--            typridList.push($(this).attr('value'));--%>
            <%--        }--%>
            <%--    })--%>

            <%--    if(typridList.length==0){--%>
            <%--        layer.msg("请选择公司类别");--%>
            <%--        return false;--%>
            <%--    }--%>
            <%--    //修改公司服务信息--%>
            <%--    $.ajax({--%>
            <%--        url: '<%=path%>/myCompanyContrller/addCompanycollection',--%>
            <%--        type: 'POST',--%>
            <%--        dataType: 'JSON',--%>
            <%--        data: {--%>
            <%--            typridList: JSON.stringify(typridList),--%>
            <%--        },--%>
            <%--        success: function (msg) {--%>
            <%--            layer.msg(msg.msg);--%>
            <%--        }--%>
            <%--    })--%>


        })
    });


</script>
</body>
</html>