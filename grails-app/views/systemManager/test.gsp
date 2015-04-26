
<%@ page import="com.sec.Requestmap" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="head"/>
    <g:set var="entityName" value="${message(code: 'requestmap.label', default: 'Requestmap')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <script>
           $(function(){
               $('#btn').click(function(){
                   $.ajax({
                       url :"${resource()}/systemManager/clearCache",
                       data : Math.random(),
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
                               $.messager.alert('提示', "调用方法失败", 'error');
                           }
                       }
                   });
               })



               $('#cookadd').click(function(){
                   $.cookie('caiping',"caiping628",{expires: 7});
                   $.cookie('name',Math.random(),{expires: 7});
               })

               $('#cooktest').click(function(){

                   var test = $.cookie('caiping');
                   alert (test);
               })
           })
    </script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>

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
        <span>
            <a href="#" id="btn" class="easyui-linkbutton" iconCls="icon-reload">清除缓存</a>
            <a href="#" id="cookadd" class="easyui-linkbutton" iconCls="icon-reload">添加cookie</a>
            <a href="#" id="cooktest" class="easyui-linkbutton" iconCls="icon-reload">cookie测试</a>
    </span>
</div>
</body>
</html>

