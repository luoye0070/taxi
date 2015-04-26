<%@ page import="springsec.Online" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'online.label', default: 'Online')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<a href="#show-online" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                             default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]"/></g:link></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="show-online" class="content scaffold-show" role="main">
    <h1><g:message code="default.show.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <ol class="property-list online">

        <g:if test="${onlineInstance?.ip}">
            <li class="fieldcontain">
                <span id="ip-label" class="property-label"><g:message code="online.ip.label" default="Ip"/></span>

                <span class="property-value" aria-labelledby="ip-label"><g:fieldValue bean="${onlineInstance}"
                                                                                      field="ip"/></span>

            </li>
        </g:if>

        <g:if test="${onlineInstance?.userid}">
            <li class="fieldcontain">
                <span id="userid-label" class="property-label"><g:message code="online.userid.label"
                                                                          default="Userid"/></span>

                <span class="property-value" aria-labelledby="userid-label"><g:fieldValue bean="${onlineInstance}"
                                                                                          field="userid"/></span>

            </li>
        </g:if>

        <g:if test="${onlineInstance?.dateCreated}">
            <li class="fieldcontain">
                <span id="dateCreated-label" class="property-label"><g:message code="online.dateCreated.label"
                                                                               default="Date Created"/></span>

                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                        date="${onlineInstance?.dateCreated}"/></span>

            </li>
        </g:if>

        <g:if test="${onlineInstance?.dateLogout}">
            <li class="fieldcontain">
                <span id="dateLogout-label" class="property-label"><g:message code="online.dateLogout.label"
                                                                              default="Date Logout"/></span>

                <span class="property-value" aria-labelledby="dateLogout-label"><g:formatDate
                        date="${onlineInstance?.dateLogout}"/></span>

            </li>
        </g:if>

        <g:if test="${onlineInstance?.status}">
            <li class="fieldcontain">
                <span id="status-label" class="property-label"><g:message code="online.status.label"
                                                                          default="Status"/></span>

                <span class="property-value" aria-labelledby="status-label"><g:formatBoolean
                        boolean="${onlineInstance?.status}"/></span>

            </li>
        </g:if>

    </ol>
    <g:form>
        <fieldset class="buttons">
            <g:hiddenField name="id" value="${onlineInstance?.id}"/>
            <g:link class="edit" action="edit" id="${onlineInstance?.id}"><g:message code="default.button.edit.label"
                                                                                     default="Edit"/></g:link>
            <g:actionSubmit class="delete" action="delete"
                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
