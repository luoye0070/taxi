
<%@ page import="springsec.Image" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'image.label', default: 'Image')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-image" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-image" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list image">
			
				<g:if test="${imageInstance?.minurl}">
				<li class="fieldcontain">
					<span id="minurl-label" class="property-label"><g:message code="image.minurl.label" default="Minurl" /></span>
					
						<span class="property-value" aria-labelledby="minurl-label"><g:fieldValue bean="${imageInstance}" field="minurl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.midurl}">
				<li class="fieldcontain">
					<span id="midurl-label" class="property-label"><g:message code="image.midurl.label" default="Midurl" /></span>
					
						<span class="property-value" aria-labelledby="midurl-label"><g:fieldValue bean="${imageInstance}" field="midurl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.maxurl}">
				<li class="fieldcontain">
					<span id="maxurl-label" class="property-label"><g:message code="image.maxurl.label" default="Maxurl" /></span>
					
						<span class="property-value" aria-labelledby="maxurl-label"><g:fieldValue bean="${imageInstance}" field="maxurl"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imageInstance?.gread}">
				<li class="fieldcontain">
					<span id="gread-label" class="property-label"><g:message code="image.gread.label" default="Gread" /></span>
					
						<span class="property-value" aria-labelledby="gread-label"><g:fieldValue bean="${imageInstance}" field="gread"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${imageInstance?.id}" />
					<g:link class="edit" action="edit" id="${imageInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
