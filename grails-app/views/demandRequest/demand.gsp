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
<div id="show-demand" class="content scaffold-show" role="main">
    <g:render template="/layouts/msgs_and_errors"></g:render>
    <ol class="property-list demand">

        <g:if test="${demandInstance?.nickName}">
            <li class="fieldcontain">
                <span id="nickName-label" class="property-label"><g:message code="demand.nickName.label" default="Nick Name" /></span>

                <span class="property-value" aria-labelledby="nickName-label"><g:fieldValue bean="${demandInstance}" field="nickName"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.phoneNum}">
            <li class="fieldcontain">
                <span id="phoneNum-label" class="property-label"><g:message code="demand.phoneNum.label" default="Phone Num" /></span>

                <span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue bean="${demandInstance}" field="phoneNum"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.state}">
            <li class="fieldcontain">
                <span id="state-label" class="property-label"><g:message code="demand.state.label" default="State" /></span>

                <span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${demandInstance}" field="state"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.filePath}">
            <li class="fieldcontain">
                <span id="filePath-label" class="property-label"><g:message code="demand.filePath.label" default="File Path" /></span>

                <span class="property-value" aria-labelledby="filePath-label"><g:fieldValue bean="${demandInstance}" field="filePath"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.latitude}">
            <li class="fieldcontain">
                <span id="latitude-label" class="property-label"><g:message code="demand.latitude.label" default="Latitude" /></span>

                <span class="property-value" aria-labelledby="latitude-label"><g:fieldValue bean="${demandInstance}" field="latitude"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.longitude}">
            <li class="fieldcontain">
                <span id="longitude-label" class="property-label"><g:message code="demand.longitude.label" default="Longitude" /></span>

                <span class="property-value" aria-labelledby="longitude-label"><g:fieldValue bean="${demandInstance}" field="longitude"/></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.serverTime}">
            <li class="fieldcontain">
                <span id="serverTime-label" class="property-label"><g:message code="demand.serverTime.label" default="Server Time" /></span>

                <span class="property-value" aria-labelledby="serverTime-label"><g:formatDate date="${demandInstance?.serverTime}" /></span>

            </li>
        </g:if>

        <g:if test="${demandInstance?.time}">
            <li class="fieldcontain">
                <span id="time-label" class="property-label"><g:message code="demand.time.label" default="Time" /></span>

                <span class="property-value" aria-labelledby="time-label"><g:formatDate date="${demandInstance?.time}" /></span>

            </li>
        </g:if>

    </ol>
    <g:form action="cancel">
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${demandInstance?.id}" />
            <g:actionSubmit class="delete" value="${message(code: 'default.button.delete.label', default: 'Cancel')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </fieldset>
    </g:form>
</div>
</body>
</html>