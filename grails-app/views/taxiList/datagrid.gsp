
<%@ page import="taxi.TaxiList" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'taxiList.label', default: 'TaxiList')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>


        var editrow = 1;
        var url = null;
        $(function(){
            $('#datagrid').datagrid({
                title:"已接订单",
                url:"${resource()}/taxiList/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[

                    {title:'<g:message code="taxiList.taxiPhone.label" default="Taxi Phone" />',field:'taxiPhone',width:80,sortable:true},

                    {title:'<g:message code="taxiList.phoneNum.label" default="Phone Num" />',field:'phoneNum',width:80,sortable:true},

                    {title:'<g:message code="taxiList.state.label" default="State" />',field:'state',width:100,sortable:true},

                    {title:'<g:message code="taxiList.taxiState.label" default="Taxi State" />',field:'taxiState',width:100,sortable:true},

                    {title:'<g:message code="taxiList.evaluation.label" default="Evaluation" />',field:'evaluation',width:80,sortable:true},

                    {title:'<g:message code="taxiList.status.label" default="Status" />',field:'status',width:80,sortable:true},

                    {title:'<g:message code="taxiList.taxiStatus.label" default="Taxi Status" />',field:'taxiStatus',width:100,sortable:true},

                    {title:'<g:message code="taxiList.licence.label" default="Licence" />',field:'licence',width:80,sortable:true},

                    {title:'<g:message code="taxiList.taxiTime.label" default="Taxi Time" />',field:'taxiTime',width:100,sortable:true},

                    {title:'<g:message code="taxiList.time.label" default="Time" />',field:'time',width:100,sortable:true}

                ]],

                fitColumns:true,
                toolbar:[{
                    text:"导出",
                    iconCls:"icon-redo",
                    handler:function(){
                        document.exportExcel.action = "${createLink(controller: 'taxiList', action: 'exportExcel')}";
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
        <form action="${resource()}/taxiList/datajson" name="exportExcel">
            <div style="width: 100%;height: 10px"></div>
            <span>请选择您要查询的条件：</span>
            <select name="querys">
                <option value="1">按司机电话查找</option>
                <option value="2">按乘客电话查找</option>
                <option value="3">按乘客评价状态查找</option>
                <option value="4">按司机评价状态查找</option>
                <option value="5">按服务情况查找</option>
                <option value="6">按司机是否接人查找</option>
                <option value="7">按是否诚信打车查找</option>
                <option value="8">按司机车牌号查找</option>
            </select>
            <input type="type" name="queryValue"/>
            <input type="BUTTON" value="查询" id="query">
        </form>
    </div>
    <div region="center" border="false">
        <table id="datagrid"></table>
    </div>
</div>


<div id="create" icon="icon-save" closed="true" style="padding:5px;width:500px;height:450px;"></div>

</body>
</html>

