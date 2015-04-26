
<%@ page import="com.sec.Authority" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>
        

        var editrow = 1;
        var url = null;
        $(function(){
            $('#datagrid').datagrid({
                title:"authority",
                url:"${resource()}/authority/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[
                    
                    {title:'<g:message code="authority.authority.label" default="Authority" />',field:'authority',width:100,sortable:true},
                    {title:'<g:message code="authority.authChinese.label" default="权限汉化" />',field:'authChinese',width:100,sortable:true}

                ]],
                
                fitColumns:true,
                
                toolbar:[{
                    text:"增加",
                    iconCls:"icon-add",
                    handler:function(){
                        $('#save').form('clear');
                        $('#create').dialog("open")
                        url = '${resource()}/authority/save'
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
                                    url : '${resource()}/authority/delete',
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
                        var rowIndex =$('#datagrid').datagrid('getRows');
                        editdata(rowIndex,rowData)
                    }
                }],onDblClickRow:function(rowIndex,rowData){
                    editdata(rowIndex,rowData)
                }
            })

            $('#create').dialog({
                buttons:[{
                    text:'保存',
                    iconCls:'icon-ok',
                    handler:function(){
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
        },{
            text:'取消',
                    handler:function(){
            $('#create').dialog('close');
            }
        }]
        });

        function editdata(rowIndex,rowData)
        {
        $('#datagrid').datagrid('clearSelections')
                        $('#create').dialog('open');
            url = '${resource()}/authority/update'
                        $('#save').form('load',{
            id:rowData.id,
        
            authority:rowData.authority ,
            authChinese:rowData.authChinese
        
        });
        }

        })
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="easyui-layout" fit="true" border="false">
    <div region="north" border="false" title="查询" style="height: 70px;overflow: hidden;">
        <select id="cc" class="easyui-combobox" name="state" panelHeight="80"  editable="false" style="width:100px;" required="true">
            <option value="yb">一般查询</option>
            <option value="jd">阶段查询</option>
            <option value="db">对比查询</option>
        </select>
        <span id="xzny">
            选择年月：<input id="dd" class="easyui-datebox" required="true" value=""/>
        </span>
        <span>
            间隔时间:<input  value=""></input>
        </span>
    </div>
    <div region="center" border="false">
        <table id="datagrid"></table>
    </div>
</div>


<div id="create" icon="icon-save" closed="true" style="padding:5px;width:500px;height:500px;"      >
    <div style="background:#fafafa;padding:10px;width:300px;height:300px;">
        <form id="save" method="post" novalidate>
            <input type="hidden" name="id"></input>
            
            <div>

                <label for="authority"><g:message code="authority.authority.label" default="Authority" /></label>
                
                <input class="easyui-validatebox" type="text" name="authority"></input>
                
                
            </div>

            <div>

                <label for="authChinese"><g:message code="authority.authChinese.label" default="Auth Chinese" /></label>

                <input class="easyui-validatebox" type="text" name="authChinese"></input>


            </div>
            
        </form>
    </div>
</div>

</body>
</html>

