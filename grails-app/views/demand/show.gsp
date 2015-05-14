
<%@ page import="taxi.Demand" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'demand.label', default: 'Demand')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-demand" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-demand" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
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
			
				<g:if test="${demandInstance?.route}">
				<li class="fieldcontain">
					<span id="route-label" class="property-label"><g:message code="demand.route.label" default="Route" /></span>
					
						<span class="property-value" aria-labelledby="route-label"><g:link controller="route" action="show" id="${demandInstance?.route?.id}">${demandInstance?.route?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${demandInstance?.filePath}">
				<li class="fieldcontain">
					<span id="filePath-label" class="property-label"><g:message code="demand.filePath.label" default="File Path" /></span>
					
						<span class="property-value" aria-labelledby="filePath-label"><g:fieldValue bean="${demandInstance}" field="filePath"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${demandInstance?.hike}">
				<li class="fieldcontain">
					<span id="hike-label" class="property-label"><g:message code="demand.hike.label" default="Hike" /></span>
					
						<span class="property-value" aria-labelledby="hike-label"><g:fieldValue bean="${demandInstance}" field="hike"/></span>
					
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
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${demandInstance?.id}" />
					<g:link class="edit" action="edit" id="${demandInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
