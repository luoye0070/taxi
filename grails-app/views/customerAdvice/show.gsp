
<%@ page import="taxi.CustomerAdvice" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'customerAdvice.label', default: 'CustomerAdvice')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-customerAdvice" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-customerAdvice" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list customerAdvice">
			
				<g:if test="${customerAdviceInstance?.phoneNum}">
				<li class="fieldcontain">
					<span id="phoneNum-label" class="property-label"><g:message code="customerAdvice.phoneNum.label" default="Phone Num" /></span>
					
						<span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue bean="${customerAdviceInstance}" field="phoneNum"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerAdviceInstance?.advice}">
				<li class="fieldcontain">
					<span id="advice-label" class="property-label"><g:message code="customerAdvice.advice.label" default="Advice" /></span>
					
						<span class="property-value" aria-labelledby="advice-label"><g:fieldValue bean="${customerAdviceInstance}" field="advice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${customerAdviceInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="customerAdvice.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:formatDate date="${customerAdviceInstance?.time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${customerAdviceInstance?.id}" />
					<g:link class="edit" action="edit" id="${customerAdviceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
