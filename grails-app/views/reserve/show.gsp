
<%@ page import="taxi.Reserve" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reserve.label', default: 'Reserve')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-reserve" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-reserve" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list reserve">
			
				<g:if test="${reserveInstance?.nickName}">
				<li class="fieldcontain">
					<span id="nickName-label" class="property-label"><g:message code="reserve.nickName.label" default="Nick Name" /></span>
					
						<span class="property-value" aria-labelledby="nickName-label"><g:fieldValue bean="${reserveInstance}" field="nickName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reserveInstance?.phoneNum}">
				<li class="fieldcontain">
					<span id="phoneNum-label" class="property-label"><g:message code="reserve.phoneNum.label" default="Phone Num" /></span>
					
						<span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue bean="${reserveInstance}" field="phoneNum"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reserveInstance?.start}">
				<li class="fieldcontain">
					<span id="start-label" class="property-label"><g:message code="reserve.start.label" default="Start" /></span>
					
						<span class="property-value" aria-labelledby="start-label"><g:fieldValue bean="${reserveInstance}" field="start"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reserveInstance?.destination}">
				<li class="fieldcontain">
					<span id="destination-label" class="property-label"><g:message code="reserve.destination.label" default="Destination" /></span>
					
						<span class="property-value" aria-labelledby="destination-label"><g:fieldValue bean="${reserveInstance}" field="destination"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reserveInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="reserve.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${reserveInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reserveInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="reserve.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:formatDate date="${reserveInstance?.time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${reserveInstance?.id}" />
					<g:link class="edit" action="edit" id="${reserveInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
