
<%@ page import="taxi.CustomerAdvice" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'customerAdvice.label', default: 'CustomerAdvice')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>
        

        var lastIndex = -1;
        $(function(){
            $('#usertable').datagrid({
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                frozenColumns:[[
                    {field:'id',checkbox:true}
                ]],
                toolbar:[{
                    text:'添加',
                    iconCls:'icon-add',
                    handler:function(){
                        if (lastIndex > -1) {
                        $.messager.alert('提示', '您没有结束之前编辑的数据，请先保存或取消编辑！', 'error');
                        }
                        else
                        {
                        $('#usertable').datagrid('endEdit', lastIndex);
                    $('#usertable').datagrid('appendRow',{
                            
                            phoneNum:"",
                            
                            advice:"",
                            
                            time:""
                            
                        });
                        lastIndex = $('#usertable').datagrid('getRows').length-1;
                    $('#usertable').datagrid('selectRow', lastIndex);
                    $('#usertable').datagrid('beginEdit', lastIndex);
                    }
                }
            },'-',{
                text:'删除',
                iconCls:'icon-remove',
                handler:function(){
                    var row = $('#usertable').datagrid('getSelected');
                    if (row){
                    $.messager.confirm('请确认', '您要删除当前所选项目？', function(r) {
                            if(r)
                            {
                            $.ajax({
                                url : '${resource()}/customerAdvice/delete',
                                data : {id:row.id},
                                cache : false,
                                dataType : "json",
                                type : "POST",
                                success : function(response){
                                    $('#usertable').datagrid('reload')
                                    if(response.result)
                                    {
                                        var index = $('#usertable').datagrid('getRowIndex', row);
                                           $('#usertable').datagrid('deleteRow', index);
                                           $.messager.show({
                                        title : '提示',
                                        msg : response.msg
                                    });
                                    }
                                    else{
                                    $.messager.alert('提示', response.msg, 'error');
                                    }
                                }
                            });
                            }
                        });
                    }
                }
            },'-',{
                text:'保存',
                iconCls:'icon-save',
                handler:function(){
                    $('#usertable').datagrid('unselectAll');
                    if (lastIndex > -1) {
                    $('#usertable').datagrid('endEdit', lastIndex);
                        lastIndex = -1;
                    }
                }

            },'-',{
                text:'取消编辑',
                iconCls:'icon-undo',
                handler:function(){
                    $('#usertable').datagrid('unselectAll');
                    $('#usertable').datagrid('rejectChanges');
                    lastIndex = -1;
                }
            },'-',{
                text:'查询',
                iconCls:'icon-search',
                handler:function(){

                }
            }],
            onBeforeLoad:function(){
            $(this).datagrid('rejectChanges');
            },
            onClickRow:function(rowIndex){
                if (lastIndex > -1 && lastIndex != rowIndex){
                $.messager.alert('提示', '您没有结束之前编辑的数据，请先保存或取消编辑！', 'error');
                }
                else	if (lastIndex != rowIndex){
                $('#usertable').datagrid('endEdit', lastIndex);
                    $('#usertable').datagrid('beginEdit', rowIndex);
                    lastIndex = rowIndex;
                }
            },
            onAfterEdit : function(rowIndex, rowData, changes){
                if($('#usertable').datagrid('validateRow', rowIndex))
                {
                    var url = '${resource()}/customerAdvice/';
                    if (rowData.id)
                    {
                        url += 'update';
                    }
                    else
                    {
                        url += 'save';
                    }
                   $.ajax({
                    url : url,
                    data : rowData,
                    cache : false,
                    dataType : "json",
                    type : "POST",
                    success : function(response) {
                        if (response.result) {
                        $.messager.show({
                                title : '提示',
                                msg : response.msg
                            });
                        } else {
                        $.messager.alert('提示', response.msg, 'error');
                        }
                    }
                });
                }
            }

        });

        $('.datagrid-toolbar').append('<input id="searchRoleNameInput"/>');
        $('#searchRoleNameInput').searchbox({
            searcher : function(value, name) {
                if ($.trim(value) == '') {
                    value = '%';
                }
                    $('#usertable').datagrid('load', {
                    searchval : value
                });
            },
            prompt : '请输入要查找的角色名称',
            width : 170
        });
        })
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<table id="usertable" style="width:1100px;height:auto"
       title="customerAdvice" iconCls="icon-edit" singleSelect="true"
       idField="id" url="${resource()}/customerAdvice/datajson">
    <thead>
    <tr>
        
        <th field="phoneNum" width="100" align="right" editor="text"><g:message code="customerAdvice.phoneNum.label" default="Phone Num" /></th>
        
        <th field="advice" width="100" align="right" editor="text"><g:message code="customerAdvice.advice.label" default="Advice" /></th>
        
        <th field="time" width="100" align="right" editor="text"><g:message code="customerAdvice.time.label" default="Time" /></th>
        
    </tr>
    </thead>
</table>

</body>
</html>

