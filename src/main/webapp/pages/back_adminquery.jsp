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
    <title>adminquery</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<%--    <link rel="stylesheet" href="<%=path%>/pages/back/css/layui.css">--%>
<%--&lt;%&ndash;    <script type="text/javascript" src="<%=path%>/pages/back/js/jquery-3.4.js"></script>&ndash;%&gt;--%>
<%--    <script type="text/javascript" src="<%=path%>/pages/back/js/layui.js"></script>--%>

<%--    <link rel="stylesheet" href="<%=path%>/pages/back/css/back_adminquery.css">--%>
<%--    <script type="text/javascript" src="<%=path%>/pages/back/js/util.js"></script>--%>
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">

    <div class="layui-form-item" id="querydiv">
        <label class="querylabel">账号：</label>
            <input type="text" name="intput_account" id="intput_account" lay-verify="title" autocomplete="off" placeholder="请输入管理员账号" class="layui-input">
        <label class="querylabel">名字：</label>
            <input type="text" name="intput_name" id="intput_name" lay-verify="title" autocomplete="off" placeholder="请输入管理员名字" class="layui-input">
        <button class="layui-btn layui-btn-sm querybtn" id="querybtn" lay-event="querybtn" data-type="reload">查询</button>
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="getCheckData">获取选中行数据</button>
            <button class="layui-btn layui-btn-sm" lay-event="getCheckLength">获取选中数目</button>
            <button class="layui-btn layui-btn-sm" lay-event="isAll">验证是否全选</button>
            <button class="layui-btn layui-btn-sm" lay-event="insertadmin">添加</button>
            <button class="layui-btn layui-btn-sm" lay-event="deleteadmin">删除</button>
        </div>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
<%--    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
</script>


<%--<div id="insert_div" hidden>--%>
    <form class="layui-form" id="userinfoform" action="" style="display: none">
        <div class="layui-form-item" id="accountdiv">
            <label class="layui-form-label">账号：</label>
            <div class="layui-input-block" id="account_inputdiv">
                <input type="text" name="account" id="account" required lay-verify="required" placeholder="请输入账号" autocomplete="off" class="layui-input">
            </div>
            <%--            <div class="layui-form-mid layui-word-aux">辅助文字</div>--%>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">名字：</label>
            <div class="layui-input-block">
                <input type="text" name="adminname" id="adminname" required  lay-verify="required" placeholder="请输入管理员名字" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">角色：</label>
            <div class="layui-input-block">
                <select name="role" id="role" lay-verify="required">
                    <option value=""></option>
                    <option value="1">超级管理员</option>
                    <option value="2">用户管理员</option>
                    <option value="3">文档管理员</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别：</label>
            <div class="layui-input-block" id="sexdiv">
                <input type="radio" name="sex" value="男" title="男" checked>
                <input type="radio" name="sex" value="女" title="女">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn formbtn" id="insertconfirm" lay-submit lay-filter="insertconfirm">确定</button>
                <button type="reset" class="layui-btn layui-btn-primary formbtn">重置</button>
            </div>
        </div>
    </form>
<%--</div>--%>
<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function(){
        var table = layui.table;

        table.render({
            elem: '#test'
            ,url:'/DocShare0508/adminControl/adminPage'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '用户数据表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '序号', sort: true}
                ,{field:'account', title: '账号'}
                ,{field:'name', title: '名字'}
                // ,{field:'rolename', title: '角色', templet: '<div>{{d.role.name}}</div>'}
                ,{field:'state', title: '状态'}
                ,{field:'createDate', title: '注册时间', sort: true}
                ,{field:'roleId', title: 'roleId', hide: true}
                ,{fixed: 'right',title:'操作', toolbar: '#barDemo'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],},//每页条数的选择项
        });

        // $('#querybtn').on('click', function(){
        //     layer.alert("1")
        //
        // });


        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'deleteadmin':
                    var data = checkStatus.data;
                    // layer.alert(data.id);
                    var adminIdList = new Array();
                    $.each(data, function (index,val) {
                        adminIdList.push(val.id);
                    })

                    layer.alert("删除id:"+JSON.stringify({adminIdList:adminIdList}))
                    $.ajax({
                        type : "post",
                        url : "/DocShare0508/adminControl/deleteAdmin",
                        data : {adminIdList:JSON.stringify(adminIdList)},
                        error : function(request) {
                            // layer.alert('操作失败', {
                            //     icon: 2,
                            //     title:"提示"
                            // });
                        },
                        success : function(ret) {
                            layer.alert("删除成功");
                            window.location.reload();
                        }
                    });
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;
                case 'insertadmin':
                    var layerinsert = layer.open({
                        type: 1
                        ,title: '添加人员'
                        ,area: ['500px','400px']
                        ,shade: [0.8, '#314949'] //遮罩
                        ,resize: false //不可拉伸
                        ,content: $('#userinfoform') //内容
                        ,btn: 0
                        ,cancel: function(index, layero){
                            if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                                // $('#userinfoform').css("display","none");
                                $('#adminname').val("");
                                $('#account_inputdiv').attr("style","display:block");
                                $("#role").val("");
                                layer.close(index);
                            }
                            return false;
                        }
                        //如果设定了yes回调，需进行手工关闭
                    });
                    layui.use('form', function(){
                        var form = layui.form;
                        form.render();
                        form.on('submit(insertconfirm)', function(data){
                            // data.field.dealtype = "insertadmin"
                            // layer.alert("角色id:"+data.field.roleId)
                            // data.field.roleId = ""
                            myajax("/DocShare0508/adminControl/addadmin",data.field,function (msg) {
                                layer.alert("添加成功");
                                layer.close(layerinsert);

                                $('#adminname').val("");
                                $("#role").val("");
                                $('#account_inputdiv').attr("style","display:block");
                            });
                            return false;
                        });
                    });
                    break;
                case 'querybtn':
                    var inputacc = $('#intput_account').val();
                    var inputname = $('#intput_name').val();
                    //执行重载
                    layer.alert("inputacc:"+inputacc+"     inputname:"+inputname);
                    table.reload('test', {
                        url: '/DocShare0508/adminControl/adminPage'
                        // ,methods:"post"
                        ,page: {
                            curr: 1 //重新从第 1 页开始
                        }
                        ,where: {
                            account: inputacc,
                            name: inputname
                        }
                    });
                    $('#intput_account').val(inputacc);
                    $('#intput_name').val(inputname);
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)s
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();

                    // $.ajax({
                    //     type : "post",
                    //     url : "/DocShare0508/adminControl/deleteAdmin",
                    //     data : data,
                    //     error : function(request) {
                    //         layer.alert('操作失败', {
                    //             icon: 2,
                    //             title:"提示"
                    //         });
                    //     },
                    //     success : function(ret) {
                    //         layer.alert("修改成功");
                    //         layer.close(layerupdate);
                    //         window.location.reload();
                    //     }
                    // });

                    layer.close(index);
                });
            } else if(obj.event === 'edit'){

                var updateid = data.id;
                $('#adminname').val(data.name);
                $('#account').val(data.account);
                $('#account_inputdiv').attr("style","display:none");
                $("#accountdiv").append("<label class=\"layui-form-label\">"+data.account+"</label>")
                $("#role>option").each(function(i){
                    if ($(this).attr("value")==data.roleId){
                        $(this).attr("selected",true);
                    }
                });

                var layerupdate = layer.open({
                    type: 1
                    ,title: '修改人员信息'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false //不可拉伸
                    ,content: $('#userinfoform')//内容
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            $('#adminname').val("");
                            $('#account_inputdiv').attr("style","display:block");
                            $("#role").val("");
                            layer.close(index);
                        }
                        return false;
                    }
                    ,success:function(layero, index){
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
                layui.use('form', function(){
                    var form = layui.form;
                    form.render();
                    form.on('submit(insertconfirm)', function(data){
                        data.field.id = updateid;
                        data.field.name = data.field.adminname;
                        data.field.roleId = data.field.role
                        layer.alert("data.field:"+JSON.stringify(data.field))
                        $.ajax({
                            type : "post",
                            url : "/DocShare0508/adminControl/updateAdmin",
                            data : data.field,
                            error : function(request) {
                                layer.alert('操作失败', {
                                    icon: 2,
                                    title:"提示"
                                });
                            },
                            success : function(ret) {
                                layer.alert("修改成功");
                                layer.close(layerupdate);
                                window.location.reload();
                            }
                        });
                        return false;
                    });
                });

            }
        });



    });

</script>
</body>
</html>