
<%@ page import="com.sec.EasyTree" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="head"/>
<title><g:message code="default.list.label" args="[entityName]" /></title>
<link rel="stylesheet" type="text/css" href="${resource()}/js/jquery-easyui-1.2.6/demo/demo.css">
<script type="text/javascript" charset="utf-8">
    var editRow;
    var editType;/*add or edit or undefined*/
    var treegrid;
    $(function() {

        treegrid = $('#treegrid').treegrid({
            title:'TreeGrid',
            iconCls:'icon-ok',
            rownumbers: true,
            animate:true,
            collapsible:true,
            fitColumns:true,
            url:'${resource()}/easyuiLayout/ctrltree',
            idField:'id',
            treeField:'text',
            showFooter:true,
            columns:[[
                {title:'<g:message code="easytree.id.label" default="Enabled" />',field:'id',width:30},
                {title:'<g:message code="easytree.text.label" default="Enabled" />',field:'text',width:180},
                {field:'attributes',title:'<g:message code="easytree.attributes.label" default="Enabled" />',width:180},
                {field:'pid',title:'<g:message code="easytree.pid.label" default="Enabled" />',width:80},
                {field:'userRole',title:'<g:message code="easytree.userRole.label" default="Enabled" />',width:280}
            ]],
            toolbar : [ {
                text : '展开',
                iconCls : 'icon-redo',
                handler : function() {
                    var node = treegrid.treegrid('getSelected');
                    if (node) {
                        treegrid.treegrid('expandAll', node.id);
                    } else {
                        treegrid.treegrid('expandAll');
                    }
                }
            }, '-', {
                text : '折叠',
                iconCls : 'icon-undo',
                handler : function() {
                    var node = treegrid.treegrid('getSelected');
                    if (node) {
                        treegrid.treegrid('collapseAll', node.id);
                    } else {
                        treegrid.treegrid('collapseAll');
                    }
                }
            }, '-', {
                text : '刷新',
                iconCls : 'icon-reload',
                handler : function() {
                    editRow = undefined;
                    editType = undefined;
                    treegrid.treegrid('reload');
                }
            }, '-', {
                text : '增加',
                iconCls : 'icon-add',
                handler : function() {
                    $('#create').dialog("open")
                    $('#save').form("clear")

                    var rowData = $('#treegrid').treegrid('getSelected');
                    var rowIndex =$('#treegrid').treegrid('getRows');
                    $('#authority').combotree({
                        url:'${resource()}/easyuiLayout/authoritytree/',
                        multiple:true
                    });

                    url = '${resource()}/easyuiLayout/savetree'

                    $('#save').form('load',{
                        pid:rowData.id
                    });
                }
            }, '-', {
                text : '删除',
                iconCls : 'icon-remove',
                handler : function() {
                    remove();
                }
            }, '-', {
                text : '编辑',
                iconCls : 'icon-edit',
                handler : function() {
                    var rowData = $('#treegrid').treegrid('getSelected');
                    var rowIndex =$('#treegrid').treegrid('getRows');
                    editdata(rowIndex,rowData)
                }
            }, '-', {
                text : '保存',
                iconCls : 'icon-save',
                handler : function() {
                    if (editRow != undefined) {
                        treegrid.treegrid('endEdit', editRow.id);
                    }
                }
            }, '-', {
                text : '取消编辑',
                iconCls : 'icon-undo',
                handler : function() {
                    if (editRow) {
                        treegrid.treegrid('cancelEdit', editRow.id);
                        var p = treegrid.treegrid('getParent', editRow.id);
                        if (p) {
                            treegrid.treegrid('reload', p.id);
                        } else {
                            treegrid.treegrid('reload');
                        }
                        editRow = undefined;
                        editType = undefined;
                    }
                    else
                    {
                        editRow = undefined;
                        editType = undefined;
                        treegrid.treegrid('reload');
                    }
                }
            }, '-', {
                text : '取消选中',
                iconCls : 'icon-undo',
                handler : function() {
                    treegrid.treegrid('unselectAll');
                }
            }, '-' ],
            onDblClickRow : function() {
                var rowData = $('#treegrid').treegrid('getSelected');
                var rowIndex =$('#treegrid').treegrid('getRows');
                editdata(rowIndex,rowData)
            },
            onAfterEdit : function(row, changes) {
                if (editType == undefined) {
                    editRow = undefined;
                    treegrid.treegrid('unselectAll');
                    return;
                }

                var url = '';
                if (editType == 'add') {
                    url = '${resource()}/easyuiLayout/savetree';
                }
                if (editType == 'edit') {
                    url = '${resource()}/easyuiLayout/edittree';
                }

                $.ajax({
                    url : url,
                    data : row,
                    dataType : 'json',
                    success : function(data) {
                        if (data.result) {
                            treegrid.treegrid('reload');

                            $.messager.show({
                                msg : data.msg,
                                title : '成功'
                            });
                            editRow = undefined;
                            editType = undefined;
                        } else {
                            /*treegrid.treegrid('rejectChanges');*/
                            treegrid.treegrid('beginEdit', editRow.id);
                            $.messager.alert('错误', data.msg, 'error');
                        }
                        treegrid.treegrid('unselectAll');
                    }
                });

            },
            onContextMenu : function(e, row) {
                e.preventDefault();
                $(this).treegrid('unselectAll');
                $(this).treegrid('select', row.id);
                $('#menu').menu('show', {
                    left : e.pageX,
                    top : e.pageY
                });
            },
            onLoadSuccess : function(row, data) {
                treegrid.treegrid('expandAll');
            },
            onExpand : function(row) {
                treegrid.treegrid('unselectAll');
            },
            onCollapse : function(row) {
                treegrid.treegrid('unselectAll');
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
                                $('#treegrid').treegrid('reload')
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


    });

    function editdata(rowIndex,rowData)
    {
        $('#authority').combotree({
            url:'${resource()}/easyuiLayout/authoritytree/'+rowData.id,
            multiple:true
        });

        $('#treegrid').treegrid('clearSelections')
        $('#create').dialog('open');
        url = '${resource()}/easyuiLayout/edittree'

        $('#save').form('load',{
            id:rowData.id,
            text:rowData.text,
            attributes:rowData.attributes,
            pid:rowData.pid
        });
    }



    function remove() {
        var node = treegrid.treegrid('getSelected');
        if (node) {
            $.messager.confirm('询问', '您确定要删除【' + node.text + '】？', function(b) {
                if (b) {
                    $.ajax({
                        url : '${resource()}/easyuiLayout/deletetree',
                        data : {
                            id : node.id
                        },
                        cache : false,
                        dataType : "json",
                        success : function(data) {
                            if (data.result) {
                                treegrid.treegrid('remove', data.id);
                                $.messager.show({
                                    msg : data.msg,
                                    title : '提示'
                                });
                                editRow = undefined;
                            } else {
                                $.messager.show({
                                    msg : data.msg,
                                    title : '提示'
                                });
                            }
                        }
                    });
                }
            });
        }
    }
</script>
</head>
<body class="easyui-layout" fit="true">
<div region="center" border="false" style="overflow: hidden;">
    <table id="treegrid"></table>
</div>




<div id="menu" class="easyui-menu" style="width:120px;display: none;">
    <div onclick="append();" iconCls="icon-add">增加</div>
    <div onclick="remove();" iconCls="icon-remove">删除</div>
    <div onclick="edit();" iconCls="icon-edit">编辑</div>
</div>




<div id="create" icon="icon-save" closed="true" style="padding:5px;width:500px;height:500px;">
    <div style="background:#fafafa;padding:10px;width:300px;height:300px;">
        <form id="save" method="post" novalidate>
            <input type="hidden" name="id"></input>

            <div>

                <label for="username"><g:message code="easytree.text.label" default="text" /></label>

                <input class="easyui-validatebox" type="text" name="text"></input>


            </div>

            <div>

                <label for="password"><g:message code="easytree.attributes.label" default="Password" /></label>

                <input class="easyui-validatebox" type="text" name="attributes"></input>


            </div>

            <div>

                <label for="accountExpired"><g:message code="easytree.pid.label" default="Account Expired" /></label>


                <input class="easyui-validatebox" type="number" name="pid"></input>

            </div>

            <div>

                <label for="authority"><g:message code="easytree.userRole.label" default="authority" /></label>

                <select id="authority"  name="userRole" style="width:200px;"></select>

            </div>


        </form>
    </div>
</div>
</body>
</html>