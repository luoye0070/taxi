
<%@ page import="taxi.Reserved" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'reserved.label', default: 'Reserved')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>


        var editrow = 1;
        var url = null;
        $(function(){
            $('#datagrid').datagrid({
                title:"已接预约订单",
                url:"${resource()}/reserved/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[

                    {title:'<g:message code="reserved.taxiPhone.label" default="Taxi Phone" />',field:'taxiPhone',width:100,sortable:true},

                    {title:'<g:message code="reserved.nickName.label" default="Nick Name" />',field:'nickName',width:100,sortable:true},

                    {title:'<g:message code="reserved.phoneNum.label" default="Phone Num" />',field:'phoneNum',width:100,sortable:true},

                    {title:'<g:message code="reserved.start.label" default="Start" />',field:'start',width:100,sortable:true},

                    {title:'<g:message code="reserved.destination.label" default="Destination" />',field:'destination',width:100,sortable:true},

                    {title:'<g:message code="reserved.licence.label" default="Licence" />',field:'licence',width:100,sortable:true},

                    {title:'<g:message code="reserved.time.label" default="Time" />',field:'time',width:100,sortable:true}

                ]],

                fitColumns:true,
                toolbar:[{
                    text:"导出",
                    iconCls:"icon-redo",
                    handler:function(){
                        document.exportExcel.action = "${createLink(controller: 'reserved', action: 'exportExcel')}";
                        document.exportExcel.submit();
                    }
                }]
            });
            //通过查询条件返回数据
            $("#query").click(function(){
                var querys= $("select[name='querys']").val()
                var queryValue= $("input[name='queryValue']").val()
                $("#datagrid").datagrid('load',{
                    querys: querys,
                    queryValue: queryValue
                });
            }) ;
        });
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="easyui-layout" fit="true" border="false">
    <div region="north" border="false" title="查询" style="height: 70px;overflow: hidden;">
        <form action="${resource()}/reserve/datajson" name="exportExcel">
            <div style="width: 100%;height: 10px"></div>
            <span>请选择您要查询的条件：</span>
            <select name="querys">
                <option value="1">按乘客昵称查找</option>
                <option value="2">按乘客电话查找</option>
                <option value="3">按起点查找</option>
                <option value="4">按终点查找</option>
                <option value="5">按司机电话查找</option>
                <option value="6">按车牌号查找</option>
            </select>
            <input type="type" name="queryValue"/>
            <input type="BUTTON" value="查询" id="query">
        </form>
    </div>
    <div region="center" border="false">
        <table id="datagrid"></table>
    </div>
</div>


<div id="create" icon="icon-save" closed="true" style="padding:5px;width:500px;height:500px;"></div>

</body>
</html>

