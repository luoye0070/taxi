
<%@ page import="taxi.Customer" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>


        var editrow = 1;
        var url = null;
        var phoneResult = true

        $(function(){
            $('#datagrid').datagrid({
                title:"乘客信息",
                url:"${resource()}/customer/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[

                    {title:'<g:message code="customer.nickName.label" default="Nick Name" />',field:'nickName',width:100,sortable:true},

                    {title:'<g:message code="customer.phoneNum.label" default="Phone Num" />',field:'phoneNum',width:100,sortable:true},

                    {title:'<g:message code="customer.password.label" default="Password" />',field:'password',width:100,sortable:true},

                    {title:'<g:message code="customer.dateCreated1.label" default="注册时间" />',field:'dateCreated',width:100,sortable:true}

                ]],

                fitColumns:true,

                toolbar:[{
                    text:"增加",
                    iconCls:"icon-add",
                    handler:function(){
                        $('#save').form('clear');
                        $('#create').dialog("open")

                        $("input[name='phoneNum']").attr('onblur','checkPhone()')

                        url = '${resource()}/customer/save'
                    }
                },'-',{
                    text:'删除',
                    iconCls:'icon-remove',
                    handler:function(){
                        var row = $('#datagrid').datagrid('getSelected');
                        if (row){
                            $.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
                                if(r)
                                {
                                    $.ajax({
                                        url : '${resource()}/customer/delete',
                                        data : {id:row.id},
                                        cache : false,
                                        dataType : "json",
                                        type : "POST",
                                        success : function(response){
                                            $('#datagrid').datagrid('reload')
                                            if(response.success)
                                            {
                                                var index = $('#datagrid').datagrid('getRowIndex', row);
                                                $('#datagrid').datagrid('deleteRow', index);
                                                $.messager.show({
                                                    title : '提示',
                                                    msg : response.msg
                                                });

                                            }
                                            else{
                                                $.messager.show({
                                                    title : '提示',
                                                    msg : response.msg
                                                });
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    }
                },'-',{
                    text:"修改",
                    iconCls:"icon-edit",
                    handler:function(){
                        var rowData = $('#datagrid').datagrid('getSelected');
                        if(rowData){
                            var rowIndex =$('#datagrid').datagrid('getRows');
                            editdata(rowIndex,rowData)
                        }else{
                            alert("请选择您要修改的数据！")
                        }

                    }
                },'-',{
                    text:"导出",
                    iconCls:"icon-redo",
                    handler:function(){
                        document.daochu.action = "${createLink(controller: 'excel', action: 'daochu')}";
                        document.daochu.submit();
                    }
                }],onDblClickRow:function(rowIndex,rowData){
                    editdata(rowIndex,rowData)
                }
            })

            //通过查询条件返回数据
            $("#query").click(function(){
                var querys= $("select[name='querys']").val()
                var queryValue= $("input[name='queryValue']").val()
                $("#datagrid").datagrid('load',{
                    querys: querys,
                    queryValue: queryValue
                });
            }) ;

            $('#create').dialog({
                buttons:[{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){

                        var result = true;
                        result= $("input[name='nickName']").validatebox("isValid")
                        result= $("input[name='password']").validatebox("isValid")
                        result= $("input[name='phoneNum']").validatebox("isValid")
                        if(result && phoneResult)
                        {
                            $.ajax({
                                url : url,
                                data : $("#save").serialize(),
                                cache : false,
                                dataType : "json",
                                type : "POST",
                                success : function(response) {
                                    if (response.result) {
                                        $.messager.show({
                                            title : '提示',
                                            msg : response.msg
                                        });
                                        $('#datagrid').datagrid('reload')
                                        $("#save").form('clear')
                                        $('#create').dialog('close');
                                    } else {
                                        $.messager.alert('提示', response.msg, 'error');
                                    }
                                }
                            });
                        }
                    }
                },{
                    text:'取消',
                    handler:function(){
                        $('#create').dialog('close');
                    }
                }]
            });

            function editdata(rowIndex,rowData)
            {
                $("input[name='phoneNum']").removeAttr('onblur')
                $('#datagrid').datagrid('clearSelections')
                $('#create').dialog('open');
                url = '${resource()}/customer/update'
                $('#save').form('load',{
                    id:rowData.id,

                    nickName:rowData.nickName,

                    phoneNum:rowData.phoneNum,

                    password:rowData.password

                });
            }

        })

        function checkPhone(){
            $.get("${resource()}/customer/checkPhone",{phoneNum:$("input[name='phoneNum']").val()},function(data){
                if(data=="false")
                {
                    alert("该电话号码已被使用")
                    phoneResult = false
                    return;
                }
            })
        }
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="easyui-layout" fit="true" border="false">
    <div region="north" border="false" title="查询" style="height: 70px;overflow: hidden;">
        <form action="${resource()}/customer/datajson" name="daochu">
            <div style="width: 100%;height: 10px"></div>
            <span>请选择您要查询的条件：</span>
            <select name="querys">
                <option value="1">按乘客昵称查找</option>
                <option value="2">按乘客电话查找</option>
            </select>
            <input type="type" name="queryValue"/>
            <input type="BUTTON" value="查询" id="query">

        </form>
    </div>
    <div region="center" border="false">
        <table id="datagrid"></table>
    </div>
</div>


<div id="create" icon="icon-save" closed="true" style="padding:5px;width:500px;height:450px;">
    <div style="background:#fafafa;padding:10px;width:300px;height:300px;">
        <form id="save" method="post" novalidate>
            <input type="hidden" name="id"/>

            <div>

                <label for="nickName"><g:message code="customer.nickName.label" default="Nick Name" /></label>

                <input class="easyui-validatebox" type="text" name="nickName" required="true"/>


            </div>

            <div>

                <label for="phoneNum"><g:message code="customer.phoneNum.label" default="Phone Num" /></label>

                <input class="easyui-validatebox" type="text" name="phoneNum" onblur="javascript:checkPhone();" required="true" validType="length[11,11]"/>


            </div>

            <div>

                <label for="password"><g:message code="customer.password.label" default="Password"  /></label>

                <input class="easyui-validatebox" type="text" name="password" required="true" validType="length[6,20]"/>


            </div>


        </form>
    </div>

</div>
%{--<a href="${resource()}/Excel/daochu" id="dcsubmit" name="dcsubmit" ></a>--}%
</body>
</html>

