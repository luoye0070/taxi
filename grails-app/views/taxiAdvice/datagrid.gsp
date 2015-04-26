
<%@ page import="taxi.TaxiAdvice" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'taxiAdvice.label', default: 'TaxiAdvice')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>
        

        var editrow = 1;
        var url = null;
        $(function(){
            $('#datagrid').datagrid({
                title:"司机建议",
                url:"${resource()}/taxiAdvice/datajson",
                rownumbers:true,
                collapsible:true,//是否可折叠的
                fit: false,//自动大小
                pagination:true,
                nowrap:false,
                pageSize:10,
                pageList:[10,20,30,40,50],
                idField:'id',
                columns:[[
                    
                    {title:'<g:message code="taxiAdvice.taxiPhone.label" default="Taxi Phone" />',field:'taxiPhone',width:100,sortable:true},
                    
                    {title:'<g:message code="taxiAdvice.advice.label" default="Advice" />',field:'advice',width:100,sortable:true},
                    
                    {title:'<g:message code="taxiAdvice.time.label" default="Time" />',field:'time',width:100,sortable:true}
                    
                ]],
                fitColumns:true,
                toolbar:[{
                    text:"导出",
                    iconCls:"icon-redo",
                    handler:function(){
                        document.exportExcel.action = "${createLink(controller: 'taxiAdvice', action: 'exportExcel')}";
                        document.exportExcel.submit();
                    }
                }]
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
        })
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

<div class="easyui-layout" fit="true" border="false">
    <div region="north" border="false" title="查询" style="height: 70px;overflow: hidden;">
        <form action="${resource()}/taxiAdvice/datajson" name="exportExcel">
            <div style="width: 100%;height: 10px"></div>
            <span>请选择您要查询的条件：</span>
            <select name="querys">
                <option value="1">按司机电话查找</option>
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

