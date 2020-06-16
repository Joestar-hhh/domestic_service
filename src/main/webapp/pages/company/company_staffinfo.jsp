<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/14
  Time: 0:39
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

<script type="text/html" id="toolbarDemo">
    <%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="insertstaff">
                <i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
        </div>
        <input type="text" name="intput_staff" id="intput_staff" lay-verify="title" autocomplete="off" placeholder="请输入公司名字" class="layui-input">
        <button class="layui-btn layui-btn-sm querybtn" id="querybtn" lay-event="querybtn" data-type="reload">
            <i class="layui-icon layui-icon-search"></i> 查询</button>
    </div>

</script>

<script type="text/html" id="tablebtn">


    <button class="layui-btn layui-btn-xs" lay-dropdown="{align:'right',
     menus: [
     {layIcon:'layui-icon layui-icon-list',txt: '查看详情', event:'showinfo'},
     {layIcon:'layui-icon-upload-drag',txt: '上传资料详情', event:'upload'},
     {layIcon:'layui-icon-edit',txt: '修改员工信息', event:'edit'},
     {layIcon:'layui-icon-edit',txt: '修改状态', event:'updatestate'},
     {layIcon: 'layui-icon-delete',txt: '删除', event:'delete'}]}">
        <span>操作</span>
        <i class="layui-icon layui-icon-triangle-d"></i>
    </button>
</script>

<form class="layui-form" id="staffInfo" action="" style="display: none">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名：</label>
        <div class="layui-input-block">
            <input type="text" name="userName" id="userName" required  lay-verify="truename" placeholder="请输入员工真实姓名" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">性别：</label>
        <div class="layui-input-block">
            <input type="radio" name="sex" value="男" title="男" checked>
            <input type="radio" name="sex" value="女" title="女">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">出生日期：</label>
        <div class="layui-inline">
            <div class="layui-input-inline">
                <input type="text" class="layui-input" required  lay-verify="required" name="birthDate" id="birthDate" placeholder="yyyy-MM-dd">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">工龄：</label>
        <div class="layui-input-block">
            <input type="text" name="workage" id="workage" required  lay-verify="required|ages" placeholder="请输入员工工龄" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">籍贯：</label>
        <div class="layui-input-block">
            <input type="text" name="nativeplace" id="nativeplace" required  lay-verify="required" placeholder="请输入员工籍贯地址" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">婚姻状况：</label>
        <div class="layui-input-block">
            <input type="radio" name="marriage" value="已婚" title="已婚" checked>
            <input type="radio" name="marriage" value="未婚" title="未婚">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">学历：</label>
        <div class="layui-input-block">
            <select name="education" id="education" lay-verify="required">
                <option value=""></option>
                <option value="小学">小学</option>
                <option value="初中">初中</option>
                <option value="高中">高中</option>
                <option value="大专">大专</option>
                <option value="本科">本科</option>
            </select>
        </div>
    </div>
    <div class="layui-form-item idcardhide">
        <label class="layui-form-label">身份证号：</label>
        <div class="layui-input-block">
            <input type="text" name="idcard" id="idcard" required  lay-verify="required|identity|isidcard" placeholder="请输入身份证号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item phonehide">
        <label class="layui-form-label">联系方式：</label>
        <div class="layui-input-block">
            <input type="text" name="phone" id="phone" required  lay-verify="required|phone|isphone" placeholder="请输入11位手机号" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
<%--        <label class="layui-form-label">市级：</label>--%>
        <label class="layui-form-label regionhide">市级：</label>
        <div class="layui-input-block addrssel">
            <select name="CityLevel" id="City_level" lay-filter="City_level" lay-verify="required"></select>
        </div>
        <label class="layui-form-label regionhide">县级：</label>
        <div class="layui-input-block addrssel">
            <select name="CountyLevel" id="County_level" lay-filter="County_level" lay-verify="required">
            </select>
        </div>
        <label class="layui-form-label">详细地址：</label>
        <div class="layui-input-block">
            <input type="text" name="address" id="address" required  lay-verify="required" placeholder="请输入详细地址" autocomplete="off" class="layui-input">
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

    layui.config({
        base: '<%=path%>/static/layui/dropdown/' //配置 layui-dropdown 组件基础目录
    }).extend({
        dropdown: 'dropdown'
    }).use(['dropdown','table','laydate'], function() {
        var dropdown = layui.dropdown;
        var form = layui.form;
        var table = layui.table;
        var layedit = layui.layedit;
        var $ = layui.jquery;
        var laydate = layui.laydate;

        //查询下拉框区域数据
        $.ajax({
            url: '<%=path%>/mapController/queryfirstLevelRegion',
            type: 'POST',
            dataType: 'JSON',
            success: function (msg) {
                $("#City_level").html("<option value=''></option>");
                $.each(msg.data, function (i, item) {
                    $("#City_level").append("<option value='" + item.id + "'>" + item.firstLevelRegion + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                    form.render();
                });
            }
        });

        // 日期选择
        var ins22 = laydate.render({
            elem: '#birthDate'
            ,value: '2000-01-01'
            ,isInitValue: false //是否允许填充初始值，默认为 true
            ,max: '2020-01-01'
        });


        form.on('select(City_level)', function (data) {
            form.render('select');
            // alert("选中的值:"+JSON.stringify(data));//得到被选中的值
            //获取次一级地区
            $.ajax({
                url: '<%=path%>/mapController/querySecondaryZone',
                type: 'POST',
                dataType: 'JSON',
                data: {id: data.value},
                success: function (msg) {
                    $("#County_level").html("<option value=''></option>");
                    $.each(msg.data, function (j, item) {
                        $("#County_level").append("<option value='" + item.secondaryZone + "'>" + item.secondaryZone + "</option>")
                    });
                    form.render();
                    form.render('select');
                }
            })
            form.render();
        });

        table.render({
            elem: '#test'
            ,url:'<%=path%>/staffController/queryCompanyStaffInfo'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {field:'id', title: '员工编号'}
                ,{field:'userName', title: '人员姓名'}
                ,{field:'sex', title: '性别'}
                ,{field:'birthDate', title: '出生日期'}
                ,{field:'education', title: '学历'}
                ,{field:'skill', title: '职业技能'}
                ,{field:'jobState', title: '状态'}
                ,{field:'inductionTime', title: '入职时间'}
                ,{field:'address', title: '地址',hide:true}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#tablebtn'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}

            ]]
            ,page: {limit: 5,//指定每页显示的条数
                limits: [5, 10, 15, 20,
                    25, 30, 35, 40, 45, 50],} //每页条数的选择项
            , done: function (res) {
                // 在表格渲染完成后进行下拉框渲染。
                dropdown.suite();
                $("[data-field='skill']").children().each(function () {
                    if ($(this).text() == '') {
                        $(this).text("暂无")
                    }
                });
            }
        });


        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'delete':
                    layer.confirm('真的删除行么', function(index){
                        var data = checkStatus.data;
                        var idList = new Array();
                        $.each(data, function (index,val) {
                            idList.push(val.id);
                        })
                        $.ajax({
                            type : "post",
                            url : "<%=path%>/orderController/deleteOrder",
                            dataType: 'JSON',
                            data : {idList:JSON.stringify(idList)},
                            error : function(request) {
                                layer.alert('操作失败', {
                                    icon: 2,
                                    title:"提示"
                                });
                            },
                            success : function(msg) {
                                alert(msg.msg);
                                window.location.reload();//修改成功后刷新父界面
                            }
                        });
                        layer.close(index);
                    });
                    break;
                case 'querybtn':
                    var inputname = $('#intput_staff').val();
                    //执行重载
                    table.reload('test', {
                        url: '<%=path%>/staffController/queryCompanyStaffInfo'
                        // ,methods:"post"
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            userName: inputname
                        }
                    });
                    $('#intput_staff').val(inputname);
                    break;
                case 'insertstaff':
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加员工'
                        ,area: ['540px','540px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#staffInfo') //内容
                        ,btn: 0
                        ,cancel: function(index, layero){
                            if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none");
                                $('#staffInfo')[0].reset();//重置表单
                                form.render();
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });

                    form.render();
                    form.on('submit(insertconfirm)', function(data){

                        data.field.CityLevel = $("#City_level").find("option:selected").text();
                        data.field.CountyLevel = $("#County_level").find("option:selected").text();

                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/staffController/insertCompanyStaff',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                // alert(msg.msg);
                                $('#staffInfo')[0].reset(); //重置表单
                                form.render();
                                layer.close(layerinsert);

                                layer.alert(msg.msg,function () {
                                    window.location.reload();//修改成功后刷新父界面
                                });
                            }
                        })
                        return false;
                    });
                    break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var tabdata = obj.data;
            //console.log(obj)s
            if(obj.event === 'delete'){
                var staffId = tabdata.id;
                layer.confirm('确定要删除该员工吗？', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: '<%=path%>/staffController/deleteStaff',
                        dataType: 'JSON',
                        data: {
                            staffId:staffId,
                        },
                        success: function (msg) {
                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    })
                    obj.del();
                    layer.close(index);
                });

            } else if(obj.event === 'showinfo'){

                $("#userName").val(tabdata.userName);
                $("#sex").val(tabdata.sex);
                $("#birthDate").val(tabdata.birthDate);
                $("#workage").val(tabdata.workage);
                $("#nativeplace").val(tabdata.nativeplace);
                $("#marriage").val(tabdata.marriage);
                $("#idcard").val(tabdata.idcard);
                $("#phone").val(tabdata.phone);
                $("#address").val(tabdata.address);

                $(".regionhide").css("display","none");
                $(".addrssel").css("display","none");
                $(".btnhide").css("display","none");
                $("#education").val(tabdata.education);
                form.render();

                layer.open({
                    type: 1
                    ,title: '查看员工信息'
                    ,area: ['640px','580px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#staffInfo') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        $(".regionhide").css("display","block");
                        $(".addrssel").css("display","block");
                        $(".btnhide").css("display","block");
                        $('#staffInfo')[0].reset();//重置表单
                        form.render();
                        layer.close(index);
                        return false;
                    }
                });
            } else if (obj.event === 'edit'){
                //修改员工信息
                $("#userName").val(tabdata.userName);
                $("#sex").val(tabdata.sex);
                $("#birthDate").val(tabdata.birthDate);
                $("#workage").val(tabdata.workage);
                $("#nativeplace").val(tabdata.nativeplace);
                $("#marriage").val(tabdata.marriage);
                $("#education").val(tabdata.education);

                $(".phonehide").css("display","none");
                $(".phonehide input").attr("lay-verify","");
                $(".idcardhide").css("display","none");
                $(".idcardhide input").attr("lay-verify","");

                $("#idcard").val(tabdata.idcard);
                $("#phone").val(tabdata.phone);
                $("#address").val(tabdata.address);
                var staffId = tabdata.id;

                var layerinsert = layer.open({
                    type: 1
                    ,title: '修改员工信息'
                    ,area: ['540px','540px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#staffInfo') //内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            // $('#userinfoform').css("display","none");
                            $(".phonehide").css("display","block");
                            $(".phonehide input").attr("lay-verify","required|phone|isphone");
                            $(".idcardhide").css("display","block");
                            $(".idcardhide input").attr("lay-verify","required|phone|isphone");
                            $('#staffInfo')[0].reset();//重置表单
                            form.render();
                            layer.close(index);
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });

                form.render();
                form.on('submit(insertconfirm)', function(data){

                    layer.confirm('确定要修改该员工信息吗？', function(index){
                        data.field.id = staffId;
                        data.field.CityLevel = $("#City_level").find("option:selected").text();
                        data.field.CountyLevel = $("#County_level").find("option:selected").text();
                        $.ajax({
                            type: 'POST',
                            url: '<%=path%>/staffController/updateCompanyStaff',
                            dataType: 'JSON',
                            data: data.field,
                            success: function (msg) {
                                // alert(msg.msg);
                                $(".phonehide").css("display","block");
                                $(".phonehide input").attr("lay-verify","required|phone|isphone");
                                $(".idcardhide").css("display","block");
                                $(".idcardhide input").attr("lay-verify","required|phone|isphone");

                                $('#staffInfo')[0].reset(); //重置表单
                                form.render();
                                layer.close(layerinsert);

                                layer.alert(msg.msg,function () {
                                    window.location.reload();//修改成功后刷新父界面
                                });
                            }
                        })
                        layer.close(index);
                    });

                    return false;
                });
            } else if(obj.event === 'updatestate'){
                // alert("修改状态")
                var staffId = tabdata.id;
                var jobState = tabdata.jobState;
                var newState = "";
                if (jobState=="在职"){
                    newState = "离职";
                }else {
                    newState = "在职";
                }
                layer.confirm('确定要修改该员工的状态为'+newState+'吗？', function (index) {
                    $.ajax({
                        type: 'POST',
                        url: '<%=path%>/staffController/updateStaffJobState',
                        dataType: 'JSON',
                        data: {
                            staffId:staffId,
                            newState:newState
                        },
                        success: function (msg) {
                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    })
                    layer.close(index);
                });
            } else if (obj.event === 'dalete') {

            }
        });


        //创建一个编辑器
        // var editIndex = layedit.build('LAY_demo_editor');
        //自定义验证规则
        form.verify({
            title: function(value) {
                if(value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            },
            isphone:  function (value) {
                var msgtext = '';
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/staffController/queryStaffPhone',
                    dataType: 'JSON',
                    async : false,
                    data: {phone:value},
                    success: function (msg) {
                        if (msg.code==0){
                            msgtext = msg.msg;
                        }
                    }
                })
                return msgtext;
            },
            isidcard: function (value) {
                var msgtext = '';
                $.ajax({
                    type: 'POST',
                    url: '<%=path%>/staffController/queryStaffIdcard',
                    dataType: 'JSON',
                    async : false,
                    data: {idcard:value},
                    success: function (msg) {
                        if (msg.code==0){
                            msgtext = msg.msg;
                        }
                    }
                })
                return msgtext;
            },
            truename: [
                /^[\u4e00-\u9fa5]{2,4}$/, '您的输入有误，请输入2-4位中文'
            ],
            ages: [
                /^(0|[1-9][0-9]*)$/, '您的输入有误，请输入1-2位数字'
            ]
        });
        

    });

</script>
</body>
</html>
