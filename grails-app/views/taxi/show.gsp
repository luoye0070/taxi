
<%@ page import="taxi.Taxi" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'taxi.label', default: 'Taxi')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-taxi" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-taxi" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list taxi">
			
				<g:if test="${taxiInstance?.licence}">
				<li class="fieldcontain">
					<span id="licence-label" class="property-label"><g:message code="taxi.licence.label" default="Licence" /></span>
					
						<span class="property-value" aria-labelledby="licence-label"><g:fieldValue bean="${taxiInstance}" field="licence"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiInstance?.password}">
				<li class="fieldcontain">
					<span id="password-label" class="property-label"><g:message code="taxi.password.label" default="Password" /></span>
					
						<span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${taxiInstance}" field="password"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiInstance?.taxiPhone}">
				<li class="fieldcontain">
					<span id="taxiPhone-label" class="property-label"><g:message code="taxi.taxiPhone.label" default="Taxi Phone" /></span>
					
						<span class="property-value" aria-labelledby="taxiPhone-label"><g:fieldValue bean="${taxiInstance}" field="taxiPhone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="taxi.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${taxiInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="taxi.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:formatDate date="${taxiInstance?.time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${taxiInstance?.id}" />
					<g:link class="edit" action="edit" id="${taxiInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
