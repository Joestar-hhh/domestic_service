<%--
  Created by IntelliJ IDEA.
  User: ALL BLUE
  Date: 2020/6/11
  Time: 12:04
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
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=path%>/static/layui/css/layui.css">
    <script type="text/javascript" src="<%=path%>/static/layui/layui.js"></script>

    <style>
        #treediv{
            display: inline-block;
            width: 250px;
            /*height: 400px;*/
            margin: 20px 25%;
            border: 1px solid #857b7a;
            padding: 30px 20px;
        }
        #querydiv{
            display: inline-block;
            margin: 20px 25%;
        }
        #save{
            margin-left: 30px;
        }
    </style>
</head>
<body>
<div class="layui-btn-container">
<%--    <button type="button" class="layui-btn layui-btn-sm" lay-demo="getChecked">获取选中节点数据</button>--%>
<%--    <button type="button" class="layui-btn layui-btn-sm" lay-demo="setChecked">勾选指定节点</button>--%>
<%--    <button type="button" class="layui-btn layui-btn-sm" lay-demo="reload">重载实例</button>--%>
</div>
<div class="layui-form-item" id="querydiv">
    <div class="layui-form">
        <div class="layui-inline">
            <select name="roleSelect" id="roleSelect" lay-filter="roleSelect" lay-verify="required">
            </select>
        </div>
        <button class="layui-btn layui-btn-sm" id="save" lay-demo="save">
            保存更改
        </button>
    </div>

</div>

<div id="treediv">
    <div id="test12" class="demo-tree-more"></div>
</div>

<script>
    layui.use(['tree', 'util'], function(){
        var tree = layui.tree
            ,layer = layui.layer
            ,util = layui.util
            ,$ = layui.jquery

        $.ajax({
            type : "post",
            url : "<%=path%>/roleController/queryAllRole",
            dataType: 'JSON',
            data : {
                roleId:'0'
            },
            error : function(msg) {
                layer.alert('操作失败', {
                    icon: 2,
                    title:"提示"
                });
            },
            success : function(msg) {
                $("#roleSelect").html("<option value=''></option>");

                $.each(msg.data, function (i, item) {
                    $("#roleSelect").append("<option value='" + item.id + "'>" + item.roleName + "</option>")
                });
                layui.use('form', function () {
                    var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功
                    form.render();
                });
            }
        })

        var menuData;
        $.ajax({
            type : "post",
            url : "<%=path%>/menuController/permissions",
            dataType: 'JSON',
            data : {
                roleId:null
            },
            error : function(msg) {
                layer.alert('操作失败', {
                    icon: 2,
                    title:"提示"
                });
            },
            success : function(msg) {
                menuData = msg
                tree.render({
                    elem: '#test12'
                    ,data: menuData
                    ,showCheckbox: true  //是否显示复选框
                    ,id: 'demoId1'
                    ,isJump: false //是否允许点击节点时弹出新窗口跳转
                    ,click: function(obj){
                        var data = obj.data;  //获取当前点击的节点数据
                        layer.msg('状态：'+ obj.state + '<br>节点数据：' + JSON.stringify(data));
                    }
                });
            }
        });



        var selectId = "";
        layui.use('form', function() {
            var form = layui.form;
            form.render('select');
            form.on('select(roleSelect)', function(data){
                selectId = data.value;
                $.each(menuData,function (i,item) {
                    item.checked = ''
                })
                $.ajax({
                    type : "post",
                    url : "<%=path%>/menuController/permissions",
                    dataType: 'JSON',
                    data : {
                        roleId:data.value
                    },
                    error : function(msg) {
                        layer.alert('操作失败', {icon: 2, title:"提示"});
                    },
                    success : function(msg) {

                        // $.each(menuData,function (i,item) {
                        //
                        //     selectChild(msg,item)
                        //     // $.each(msg,function (j,msgItem){
                        //     //     // alert("item.id:"+item.id+"    msg.id:"+msgItem.id)
                        //     //     if(msg.children==null || msg.children===''){
                        //     //         if (item.id == msgItem.id){
                        //     //             item.checked = 'true'
                        //     //         }
                        //     //     }else{
                        //     //         if (item.children == msgItem.id){
                        //     //             item.checked = 'true'
                        //     //         }
                        //     //     }
                        //     //
                        //     // })
                        // })
                        tree.reload('demoId1',{
                            data: menuData
                        });
                    }
                });
            });
        });

        //按钮事件
        util.event('lay-demo', {
            save: function () {
                var checkedData = tree.getChecked('demoId1'); //获取选中节点的数据

                layer.alert(JSON.stringify(checkedData), {shade:0});

                var rolemenuList = [];
                $.each(checkedData,function (i,item) {
                    var roleMenu = {
                        roleId:'',
                        menuId:''
                    }
                    roleMenu.roleId = selectId;
                    roleMenu.menuId = item.id;
                    rolemenuList.push(roleMenu);
                    $.each(item.children,function (j,child) {
                        var roleMenu = {roleId:'', menuId:''}
                        roleMenu.roleId = selectId;
                        roleMenu.menuId = child.id;
                        rolemenuList.push(roleMenu);
                    })
                })

                //  layer.alert("menuIdList:"+menuIdList);
                if(selectId===""){
                    layer.alert("请选择角色")
                }else {
                    $.ajax({
                        type : "post",
                        url : "<%=path%>/menuController/roleMenuUpdate",
                        dataType: 'JSON',
                        data : {
                            rolemenuList:JSON.stringify(rolemenuList),
                            roleId:selectId
                        },
                        error : function(msg) {
                            layer.alert('操作失败', {icon: 2, title:"提示"});
                        },
                        success : function(msg) {
                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            })
                        }
                    });
                }
            }
        });

        function selectChild(msg,item) {
            $.each(msg,function (j,msgItem){
                alert("msg:"+JSON.stringify(msg.children))
                if (msg.children!=null && msg.children!==''){
                    alert("msg:"+JSON.stringify(msg.children))
                    selectChild(msg.children,item.children)
                } else {
                    if (item.id == msgItem.id){
                        item.checked = 'true'
                    }
                }
                // if(msg.children==null || msg.children===''){
                //     if (item.id == msgItem.id){
                //         item.checked = 'true'
                //     }
                // }else{
                //     if (item.children == msgItem.id){
                //         item.checked = 'true'
                //     }
                // }

            })
        }

    });
</script>

</body>
</html>
