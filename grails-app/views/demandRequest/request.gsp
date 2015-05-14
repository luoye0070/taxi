<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-5-15
  Time: 上午1:24
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title></title>
</head>
<body>
<g:render template="/layouts/msgs_and_errors"></g:render>
     <form action="${createLink(controller: "customer",action: "apply")}" method="POST">
         <input type="hidden" name="latitude" value="89"/>
         <input type="hidden" name="longitude" value="189"/>
         <input type="hidden" name="nickName" value="jkjljjlj"/>
         <input type="hidden" name="filePath" value="eefdsfs"/>

         <label for="phoneNum">
             <g:message code="demand.phoneNum.label" default="Phone Num" />
         </label>
         <g:textField name="phoneNum" maxlength="11" value="${demandInstance?.phoneNum}"/>

         <br/>

         <label for="hike">
             <g:message code="demand.hike.label" default="Hike" />
         </label>
         <g:textField name="hike" value="${demandInstance?.hike}"/>

         <br/>

         <label for="route">
             <g:message code="demand.route.label" default="Route" />
         </label>
         <g:select id="route" name="routeId" from="${taxi.Route.list()}" optionKey="id" optionValue="name" value="${demandInstance?.route?.id}" class="many-to-one" />

         <br/>

         <g:submitButton name="submit" value="用车"></g:submitButton>
     </form>
</body>
</html>