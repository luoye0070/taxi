
<%@ page import="taxi.Reserved" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reserved.label', default: 'Reserved')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-reserved" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-reserved" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list reserved">
			
				<g:if test="${reservedInstance?.taxiPhone}">
				<li class="fieldcontain">
					<span id="taxiPhone-label" class="property-label"><g:message code="reserved.taxiPhone.label" default="Taxi Phone" /></span>
					
						<span class="property-value" aria-labelledby="taxiPhone-label"><g:fieldValue bean="${reservedInstance}" field="taxiPhone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.nickName}">
				<li class="fieldcontain">
					<span id="nickName-label" class="property-label"><g:message code="reserved.nickName.label" default="Nick Name" /></span>
					
						<span class="property-value" aria-labelledby="nickName-label"><g:fieldValue bean="${reservedInstance}" field="nickName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.phoneNum}">
				<li class="fieldcontain">
					<span id="phoneNum-label" class="property-label"><g:message code="reserved.phoneNum.label" default="Phone Num" /></span>
					
						<span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue bean="${reservedInstance}" field="phoneNum"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.start}">
				<li class="fieldcontain">
					<span id="start-label" class="property-label"><g:message code="reserved.start.label" default="Start" /></span>
					
						<span class="property-value" aria-labelledby="start-label"><g:fieldValue bean="${reservedInstance}" field="start"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="reserved.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:fieldValue bean="${reservedInstance}" field="destination"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.licence}">
				<li class="fieldcontain">
					<span id="licence-label" class="property-label"><g:message code="reserved.licence.label" default="Licence" /></span>
					
						<span class="property-value" aria-labelledby="licence-label"><g:fieldValue bean="${reservedInstance}" field="licence"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reservedInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="reserved.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:formatDate date="${reservedInstance?.time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${reservedInstance?.id}" />
					<g:link class="edit" action="edit" id="${reservedInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
