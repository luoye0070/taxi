<%@ page import="taxi.Taxi" %>



<div class="fieldcontain ${hasErrors(bean: taxiInstance, field: 'licence', 'error')} required">
	<label for="licence">
		<g:message code="taxi.licence.label" default="Licence" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="licence" maxlength="50" required="" value="${taxiInstance?.licence}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="taxi.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" maxlength="20" required="" value="${taxiInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiInstance, field: 'taxiPhone', 'error')} required">
	<label for="taxiPhone">
		<g:message code="taxi.taxiPhone.label" default="Taxi Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taxiPhone" maxlength="11" required="" value="${taxiInstance?.taxiPhone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="taxi.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="50" required="" value="${taxiInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiInstance, field: 'time', 'error')} ">
	<label for="time">
		<g:message code="taxi.time.label" default="Time" />
		
	</label>
	<g:datePicker name="time" precision="day"  value="${taxiInstance?.time}" default="none" noSelection="['': '']" />
</div>

