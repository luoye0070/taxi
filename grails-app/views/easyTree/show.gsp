
<%@ page import="com.sec.EasyTree" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'easyTree.label', default: 'EasyTree')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-easyTree" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-easyTree" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list easyTree">
			
				<g:if test="${easyTreeInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="easyTree.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${easyTreeInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${easyTreeInstance?.attributes}">
				<li class="fieldcontain">
					<span id="attributes-label" class="property-label"><g:message code="easyTree.attributes.label" default="Attributes" /></span>
					
						<span class="property-value" aria-labelledby="attributes-label"><g:fieldValue bean="${easyTreeInstance}" field="attributes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${easyTreeInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="easyTree.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${easyTreeInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${easyTreeInstance?.pid}">
				<li class="fieldcontain">
					<span id="pid-label" class="property-label"><g:message code="easyTree.pid.label" default="Pid" /></span>
					
						<span class="property-value" aria-labelledby="pid-label"><g:fieldValue bean="${easyTreeInstance}" field="pid"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${easyTreeInstance?.id}" />
					<g:link class="edit" action="edit" id="${easyTreeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
