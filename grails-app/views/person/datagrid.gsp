
<%@ page import="com.sec.Person" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="head"/>
<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<script>
    var user = true

    var editrow = 1;
    var url = null;
    $(function(){

        $('#datagrid').datagrid({
            title:"管理人员",
            url:"${resource()}/person/datajson",
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

                {title:'<g:message code="person.enabled.label" default="Enabled" />',field:'enabled',width:100,sortable:true},

                {title:'<g:message code="person.authority.label" default="所属权限" />',field:'authority',width:80,sortable:true}


            ]],

            fitColumns:true,

            toolbar:[{
                text:"增加",
                iconCls:"icon-add",
                handler:function(){

                    $('#create').dialog("open")
                    $("input[name='username']").attr('onblur','users()')
                    $("input[name='username']").removeAttr("readonly")
                    $("input[name='password']").removeAttr('required')
                    $("#enabled").attr("checked",true)
                    $('#save').form('clear');
                    $('#authority').combotree({
                        url:'${createLink(controller: 'person', action: 'authoritytree')}',
                        multiple:true
                    });
                    url = '${resource()}/person/save'
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
                                    url : '${resource()}/person/delete',
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
                        url = '${resource()}/person/update'
                    } else{
                        alert("请选择您要修改的数据")
                        return false;
                    }

                }
            }],onDblClickRow:function(rowIndex,rowData){
                editdata(rowIndex,rowData)
                url = '${resource()}/systemManager/update'
            }
        })

        $('#create').dialog({
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){
                    var result = true;
                    if(url == "${resource()}/person/save"){
                        result= $("input[name='username']").validatebox("isValid")
                        result= $("input[name='password']").validatebox("isValid")
                        if(result && user)
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
                    }else{
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

            $("input[name='username']").removeAttr('onblur')
            $("input[name='username']").attr("readonly","readonly")

            $("input[name='password']").removeAttr('validType')
            $("input[name='password']").removeAttr('required')

            $('#authority').combotree({
                url:'${resource()}/person/authoritytree/'+rowData.id,
                multiple:true
            });

            $('#datagrid').datagrid('clearSelections')
            $('#create').dialog('open');
            if(rowData.enabled=="是")
                $("#enabled").attr("checked","checked")
            else
                $("#enabled").attr("checked",false)

            $('#save').form('load',{
                id:rowData.id,
                username:rowData.username,
//            password:rowData.password,
                authority:rowData.authority
            });
        }
    });
    function users(){
        $.get("${resource()}/person/checkUserName",{username:$("input[name='username']").val()},function(data){
            if(data=="false")
            {
                alert("用户名已被使用")
                user = false
                return;
            }
        });
    }
</script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="easyui-layout" fit="true" border="false">
    <div region="north" border="false" style="height: 40px;overflow: hidden;">

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

                <label for="username"><g:message code="person.username1.label" default="用户名：" /></label>

                <input class="easyui-validatebox" type="text" name="username" required="required" onblur="javascript:users();" validType="length[3,18]"/>


            </div>

            <div>

                <label for="password"><g:message code="person.password1.label" default="密　码：" /></label>

                <input class="easyui-validatebox" type="password" name="password"  required="true" validType="length[6,20]"/>


            </div>

            <div>

                <label for="enabled"><g:message code="person.enabled.label" default="Enabled" /></label>


                <input class="easyui-validatebox" type="checkbox" name="enabled" id="enabled" checked="true"/>

            </div>
            <div>

                <label for="authority"><g:message code="person.authority.label" default="所属权限" /></label>
                %{--<g:select name="authority" from="${authobj.authChinese}" style="width:155px;" value="${authobj.id}"></g:select>--}%
                <select id="authority" required="true"  name="authority" style="width:155px;"></select>

            </div>

        </form>
    </div>
</div>

</body>
</html>

