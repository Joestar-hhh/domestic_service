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
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
<%--    skill_train--%>
    <div class="layui-form-item" id="querydiv">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="deleterole">
                <i class="layui-icon layui-icon-delete"></i>删除</button>
            <button class="layui-btn layui-btn-sm" lay-event="insertrole">
                <i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>
        </div>
    </div>
</script>


<script type="text/html" id="barDemo">
    <a class="layui-btn  layui-btn-xs" lay-event="see_details">
        <i class="layui-icon layui-icon-edit"></i>查看详情</a>
<%--    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
</script>



<form class="layui-form" id="userinfoform" action="" style="display: none">
    '<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop"><source src="/upload/baby1.mp4" type="video/mp4"></source></video>'
</form>


<%--<script src="<%=path%>/back/js/layui.js" charset="utf-8"></script>--%>
<script>
    layui.use('table', function(){
        var table = layui.table;
        var $ = layui.jquery;
        table.render({
            elem: '#test'
            ,url:'/knowledgeController/queryKnowledeg'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,defaultToolbar: []//自定义头部工具栏右侧图标。如无需自定义，去除该参数即可
            ,title: '育婴知识表'
            ,cols: [[
                {type: 'checkbox',fixed: 'left'}
                ,{field:'id', title: '序号'}
                ,{field:'title', title: '标题'}
                ,{field:'type', title: '知识类别'}
                ,{field:'time', title: '时间'}
                ,{field:'path',title:'路径',hide: true}
                ,{fixed: 'right',title:'操作', width: 250, toolbar: '#barDemo'}
                // ,{field:'downloadDiscount', title: '下载文档积分比例'}
            ]]
            ,page: {limit: 5,//指定每页显示的条数
            limits: [5, 10, 15, 20,
            25, 30, 35, 40, 45, 50],} //每页条数的选择项

        });


        layui.use('form', function() {
            var form = layui.form;
            form.render('select');
            form.on('select(selecttest)', function(data){
                alert("选中："+JSON.stringify(data));
            });
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'deleterole':
                    var data = checkStatus.data;
                    var idList = new Array();
                    $.each(data, function (index,val) {
                        idList.push(val.id);
                    })
                    $.ajax({
                        type : "post",
                        url : "/knowledgeController/deleteKnowledeg",
                        dataType: 'JSON',
                        data : {idList:JSON.stringify(idList)},
                        error : function(request) {
                            layer.alert('操作失败', {
                                icon: 2,
                                title:"提示"
                            });
                        },
                        success : function(msg) {
                            layer.alert(msg.msg,function () {
                                window.location.reload();//修改成功后刷新父界面
                            });
                        }
                    });
                    break;

            };
        });


        //监听行工具事件
        table.on('tool(test)', function(obj) {
            var tabdata = obj.data;
            //console.log(obj)s
            if (obj.event === 'see_details') {
                var path =tabdata.path;
                var layerupdate = layer.open({
                    type: 1
                    ,title: '播放视频'
                    ,area: ['500px','400px']
                    ,shade: [0.8, '#314949'] //遮罩
                    ,resize: false//不可拉伸
                    ,content: '<a href=path></a>'//内容
                    ,content:'<video width="100%" height="100%"  controls="controls" autobuffer="autobuffer"  autoplay="autoplay" loop="loop"><source src='+path+' type="video/mp4"></source></video>'
                    ,btn: 0
                    ,cancel: function(index, layero){
                        if(confirm('确定要关闭么')){ //只有当点击confirm框的确定时，该层才会关闭
                            // layer.close(index);
                            layer.closeAll();
                        }
                        return false;
                    }
                    //如果设定了yes回调，需进行手工关闭
                });
            }
        });
    });

</script>
</body>
</html>