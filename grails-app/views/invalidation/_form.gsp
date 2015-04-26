<%@ page import="taxi.Invalidation" %>



<div class="fieldcontain ${hasErrors(bean: invalidationInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="invalidation.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: invalidationInstance, field: 'latitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: invalidationInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="invalidation.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: invalidationInstance, field: 'longitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: invalidationInstance, field: 'phoneNum', 'error')} ">
	<label for="phoneNum">
		<g:message code="invalidation.phoneNum.label" default="Phone Num" />
		
	</label>
	<g:textField name="phoneNum" value="${invalidationInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: invalidationInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="invalidation.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="state" type="number" value="${invalidationInstance.state}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: invalidationInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="invalidation.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${invalidationInstance?.time}"  />
</div>

