<%@ page import="taxi.TaxiLocation" %>



<div class="fieldcontain ${hasErrors(bean: taxiLocationInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="taxiLocation.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: taxiLocationInstance, field: 'latitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiLocationInstance, field: 'licence', 'error')} ">
	<label for="licence">
		<g:message code="taxiLocation.licence.label" default="Licence" />
		
	</label>
	<g:textField name="licence" value="${taxiLocationInstance?.licence}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiLocationInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="taxiLocation.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: taxiLocationInstance, field: 'longitude')}" required=""/>
</div>

