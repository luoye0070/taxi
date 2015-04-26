
<%@ page import="com.sec.Person" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>


        var editrow = 1;
        var url = null;
        $(function(){







//            $('#authority').combotree('setValue',['ROLE_ADMIN'])

            %{--$("#authority").click(function(){--}%
                %{--$('#authority').combotree({--}%
                    %{--url:'${resource()}/systemManager/authoritytree',--}%
                    %{--onLoadSuccess:function(node, data){--}%
                        %{--alert(node+":"+data)--}%
                    %{--}--}%
            %{--})--}%


//                ,
//                onShowPanel:function()
//                {
//
//                    var s = $(this).combotree('getText')
//
//                    var textlist = sy.getList(s)
//                      console.info(textlist)
//                    $.each(textlist, function(i, n){
//                        console.info($(this).combotree('find',1))
//                    });

                //}
//            });

            $('#datagrid').datagrid({
                title:"person",
                url:"${resource()}/systemManager/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[

                    {title:'<g:message code="person.username.label" default="Username" />',field:'username',width:100,sortable:true},

                    {title:'<g:message code="person.password.label" default="Password" />',field:'password',width:100,sortable:true},

                    {title:'<g:message code="person.accountExpired.label" default="Account Expired" />',field:'accountExpired',width:100,sortable:true},

                    {title:'<g:message code="person.accountLocked.label" default="Account Locked" />',field:'accountLocked',width:100,sortable:true},

                    {title:'<g:message code="person.enabled.label" default="Enabled" />',field:'enabled',width:100,sortable:true},

                    {title:'<g:message code="person.passwordExpired.label" default="Password Expired" />',field:'passwordExpired',width:100,sortable:true},

                    {title:'<g:message code="person.authority.label" default="authority" />',field:'authority',width:100,sortable:true}
                ]],

                fitColumns:true,

                toolbar:[{
                    text:"增加",
                    iconCls:"icon-add",
                    handler:function(){
                        $('#create').dialog("open")
                        $('#save').form("clear")
                        url = '${resource()}/systemManager/save'
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
                                        url : '${resource()}/systemManager/delete',
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
                    console.info(rowData)
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

                $('#authority').combotree({
                    url:'${resource()}/systemManager/authoritytree/'+rowData.id,
                    multiple:true
                });

                $('#datagrid').datagrid('clearSelections')
                $('#create').dialog('open');
                url = '${resource()}/systemManager/update'
                $('#save').form('load',{
                    id:rowData.id,

                    username:rowData.username,

                    password:rowData.password,

                    accountExpired:rowData.accountExpired,

                    accountLocked:rowData.accountLocked,

                    enabled:rowData.enabled,

                    passwordExpired:rowData.passwordExpired,

                    authority:rowData.authority
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
            选择年月：<input id="dd" class="easyui-datebox" required="true" value=""></input>
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

                <label for="username"><g:message code="person.username.label" default="Username" /></label>

                <input class="easyui-validatebox" type="text" name="username"></input>


            </div>

            <div>

                <label for="password"><g:message code="person.password.label" default="Password" /></label>

                <input class="easyui-validatebox" type="text" name="password"></input>


            </div>

            <div>

                <label for="accountExpired"><g:message code="person.accountExpired.label" default="Account Expired" /></label>


                <input class="easyui-validatebox" type="checkbox" name="accountExpired"></input>

            </div>

            <div>

                <label for="accountLocked"><g:message code="person.accountLocked.label" default="Account Locked" /></label>


                <input class="easyui-validatebox" type="checkbox" name="accountLocked"></input>

            </div>

            <div>

                <label for="enabled"><g:message code="person.enabled.label" default="Enabled" /></label>


                <input class="easyui-validatebox" type="checkbox" name="enabled"></input>

            </div>

            <div>

                <label for="passwordExpired"><g:message code="person.passwordExpired.label" default="Password Expired" /></label>


                <input class="easyui-validatebox" type="checkbox" name="passwordExpired"></input>

            </div>

            <div>

                <label for="authority"><g:message code="person.authority.label" default="authority" /></label>

                <select id="authority"  name="authority" style="width:200px;"></select>

            </div>


        </form>
    </div>
</div>

</body>
</html>

