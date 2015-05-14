<%@ page import="taxi.Route" %>



<div class="fieldcontain ${hasErrors(bean: routeInstance, field: 'fromStation', 'error')} required">
	<label for="fromStation">
		<g:message code="route.fromStation.label" default="From Station" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fromStation" maxlength="128" required="" value="${routeInstance?.fromStation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: routeInstance, field: 'toStation', 'error')} required">
	<label for="toStation">
		<g:message code="route.toStation.label" default="To Station" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="toStation" maxlength="128" required="" value="${routeInstance?.toStation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: routeInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="route.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="name" cols="40" rows="5" maxlength="256" required="" value="${routeInstance?.name}"/>
</div>

