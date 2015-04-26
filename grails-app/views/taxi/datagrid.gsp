
<%@ page import="taxi.Taxi" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="head"/>
<g:set var="entityName" value="${message(code: 'taxi.label', default: 'Taxi')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
<script>


    var editrow = 1;
    var url = null;
    var taxiPhoneResult = true
    var licenceResult = true

    $(function(){
        $('#datagrid').datagrid({
            title:"出租车司机信息",
            url:"${resource()}/taxi/datajson",
            rownumbers:true,
            collapsible:true,//是否可折叠的
            fit: false,//自动大小
            pagination:true,
            nowrap:false,
            pageSize:10,
            pageList:[10,20,30,40,50],
            idField:'id',
            columns:[[

                {title:'<g:message code="taxi.licence.label" default="Licence" />',field:'licence',width:100,sortable:true},

                {title:'<g:message code="taxi.password.label" default="Password" />',field:'password',width:100,sortable:true},

                {title:'<g:message code="taxi.taxiPhone.label" default="Taxi Phone" />',field:'taxiPhone',width:100,sortable:true},

                {title:'<g:message code="taxi.name.label" default="Name" />',field:'name',width:100,sortable:true},
                {title:'<g:message code="taxi.name1.label" default="在线状态" />',field:'state',width:100,sortable:true},

                {title:'<g:message code="taxi.name1.label" default="管理人员" />',field:'personId',width:100,sortable:true},

                {title:'<g:message code="taxi.time.label" default="Time" />',field:'time',width:100,sortable:true}

            ]],

            fitColumns:true,

            toolbar:[{
                text:"增加",
                iconCls:"icon-add",
                handler:function(){
                    $('#save').form('clear');
                    $('#create').dialog("open")

                    $("input[name='licence']").attr('onblur','checkLicence()')
                    $("input[name='taxiPhone']").attr('onblur','checkTaxiPhone()')

                    url = '${resource()}/taxi/save'
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
                                    url : '${resource()}/taxi/delete',
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
                    document.exportExcel.action = "${createLink(controller: 'taxi', action: 'daochu')}";
                    document.exportExcel.submit();
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
        $("#query1").click(function(){
            var querys= $("select[name='querys']").val()
            var queryValue= $("input[name='queryValue']").val()
            var querys1= $("select[name='querys1']").val()
            var queryValue1= $("input[name='queryValue1']").val()
            $("#datagrid").datagrid('load',{
                querys: querys,
                querys1: querys1,
                queryValue: queryValue,
                queryValue1: queryValue1
            });
        }) ;

        $('#create').dialog({
            buttons:[{
                text:'保存',
                iconCls:'icon-ok',
                handler:function(){

                    var result = true;
                    result= $("input[name='licence']").validatebox("isValid")
                    result= $("input[name='password']").validatebox("isValid")
                    result= $("input[name='taxiPhone']").validatebox("isValid")
                    result= $("input[name='name']").validatebox("isValid")
                    if(result && taxiPhoneResult && licenceResult){
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
            $("input[name='licence']").removeAttr('onblur')
            $("input[name='taxiPhone']").removeAttr('onblur')

            $('#datagrid').datagrid('clearSelections')
            $('#create').dialog('open');
            url = '${resource()}/taxi/update'
            $('#save').form('load',{
                id:rowData.id,

                licence:rowData.licence,

                password:rowData.password,

                taxiPhone:rowData.taxiPhone,

                name:rowData.name

            });
        }

    }) ;
    function checkLicence(){
        $.get("${resource()}/taxi/checkLicence",{licence:$("input[name='licence']").val()},function(data){
            if(data=="false")
            {
                alert("该车牌号已被使用")
                licenceResult = false
                return;
            }
        })
    }
    function checkTaxiPhone(){
        $.get("${resource()}/taxi/checkTaxiPhone",{taxiPhone:$("input[name='taxiPhone']").val()},function(data){
            if(data=="false")
            {
                alert("该电话号码已被使用")
                taxiPhoneResult = false
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
    <div region="north" border="false" title="查询" style="height: 100px;overflow: hidden;">
        <form action="${resource()}/taxi/datajson" name="exportExcel">
            <div style="width: 100%;height: 10px"></div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span>请选择您要查询的条件：</span>
            <select name="querys">
                <option value="1">按车号查找</option>
                <option value="2">按姓名查找</option>
                <option value="3">按联系电话查找</option>
                <option value="4">按管理人员查找</option>
            </select>
            &nbsp;&nbsp;&nbsp;&nbsp;<input type="type" name="queryValue"/>
            %{--<input type="BUTTON" value="查询" id="query"> <br/>--}%
            <br>
            <span>请选择您要查询的使用情况：</span>
            <select name="querys1" style="width:120px">
                <option>--请选择--</option>
                <option value="1">使用</option>
                <option value="2">未使用</option>
            </select>
            &nbsp;&nbsp;<span>请选择您要查询的时间：</span>
            <input id="dd" class="easyui-datebox"  name="queryValue1"/>
            <input type="BUTTON" value="查询" id="query1">
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

                <label for="licence"><g:message code="taxi.licence.label" default="Licence" /></label>

                <input class="easyui-validatebox" type="text" name="licence"  onblur="javascript:checkLicence();" required="required"  validType="length[2,50]"/>


            </div>

            <div>

                <label for="password"><g:message code="taxi.password.label" default="Password" /></label>

                <input class="easyui-validatebox" type="text" name="password" required="required" validType="length[6,20]"/>


            </div>

            <div>

                <label for="taxiPhone"><g:message code="taxi.taxiPhone.label" default="Taxi Phone" /></label>

                <input class="easyui-validatebox" type="text" name="taxiPhone" required="required" validType="length[11,11]" onblur="javascript:checkTaxiPhone();"/>


            </div>

            <div>

                <label for="name"><g:message code="taxi.name.label" default="Name" /></label>

                <input class="easyui-validatebox" type="text" name="name" required="required" validType="length[2,50]"/>


            </div>
        </form>
    </div>
</div>

</body>
</html>

