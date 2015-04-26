
<%@ page import="taxi.TaxiList" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'taxiList.label', default: 'TaxiList')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-taxiList" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-taxiList" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list taxiList">
			
				<g:if test="${taxiListInstance?.taxiPhone}">
				<li class="fieldcontain">
					<span id="taxiPhone-label" class="property-label"><g:message code="taxiList.taxiPhone.label" default="Taxi Phone" /></span>
					
						<span class="property-value" aria-labelledby="taxiPhone-label"><g:fieldValue bean="${taxiListInstance}" field="taxiPhone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.phoneNum}">
				<li class="fieldcontain">
					<span id="phoneNum-label" class="property-label"><g:message code="taxiList.phoneNum.label" default="Phone Num" /></span>
					
						<span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue bean="${taxiListInstance}" field="phoneNum"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="taxiList.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${taxiListInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.taxiState}">
				<li class="fieldcontain">
					<span id="taxiState-label" class="property-label"><g:message code="taxiList.taxiState.label" default="Taxi State" /></span>
					
						<span class="property-value" aria-labelledby="taxiState-label"><g:fieldValue bean="${taxiListInstance}" field="taxiState"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.evaluation}">
				<li class="fieldcontain">
					<span id="evaluation-label" class="property-label"><g:message code="taxiList.evaluation.label" default="Evaluation" /></span>
					
						<span class="property-value" aria-labelledby="evaluation-label"><g:fieldValue bean="${taxiListInstance}" field="evaluation"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.status}">
				<li class="fieldcontain">
					<span id="status-label" class="property-label"><g:message code="taxiList.status.label" default="Status" /></span>
					
						<span class="property-value" aria-labelledby="status-label"><g:fieldValue bean="${taxiListInstance}" field="status"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.taxiStatus}">
				<li class="fieldcontain">
					<span id="taxiStatus-label" class="property-label"><g:message code="taxiList.taxiStatus.label" default="Taxi Status" /></span>
					
						<span class="property-value" aria-labelledby="taxiStatus-label"><g:fieldValue bean="${taxiListInstance}" field="taxiStatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.licence}">
				<li class="fieldcontain">
					<span id="licence-label" class="property-label"><g:message code="taxiList.licence.label" default="Licence" /></span>
					
						<span class="property-value" aria-labelledby="licence-label"><g:fieldValue bean="${taxiListInstance}" field="licence"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.taxiTime}">
				<li class="fieldcontain">
					<span id="taxiTime-label" class="property-label"><g:message code="taxiList.taxiTime.label" default="Taxi Time" /></span>
					
						<span class="property-value" aria-labelledby="taxiTime-label"><g:formatDate date="${taxiListInstance?.taxiTime}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${taxiListInstance?.time}">
				<li class="fieldcontain">
					<span id="time-label" class="property-label"><g:message code="taxiList.time.label" default="Time" /></span>
					
						<span class="property-value" aria-labelledby="time-label"><g:formatDate date="${taxiListInstance?.time}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${taxiListInstance?.id}" />
					<g:link class="edit" action="edit" id="${taxiListInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
