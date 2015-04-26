<%@ page import="taxi.Demand" %>



<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'nickName', 'error')} ">
	<label for="nickName">
		<g:message code="demand.nickName.label" default="Nick Name" />
		
	</label>
	<g:textField name="nickName" maxlength="12" value="${demandInstance?.nickName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'phoneNum', 'error')} ">
	<label for="phoneNum">
		<g:message code="demand.phoneNum.label" default="Phone Num" />
		
	</label>
	<g:textField name="phoneNum" maxlength="11" value="${demandInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="demand.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="state" type="number" value="${demandInstance.state}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'filePath', 'error')} ">
	<label for="filePath">
		<g:message code="demand.filePath.label" default="File Path" />
		
	</label>
	<g:textField name="filePath" value="${demandInstance?.filePath}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="demand.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: demandInstance, field: 'latitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="demand.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: demandInstance, field: 'longitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'serverTime', 'error')} required">
	<label for="serverTime">
		<g:message code="demand.serverTime.label" default="Server Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="serverTime" precision="day"  value="${demandInstance?.serverTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: demandInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="demand.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${demandInstance?.time}"  />
</div>

