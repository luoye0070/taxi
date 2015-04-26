<%@ page import="taxi.Reserve" %>



<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'nickName', 'error')} required">
	<label for="nickName">
		<g:message code="reserve.nickName.label" default="Nick Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nickName" maxlength="12" required="" value="${reserveInstance?.nickName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'phoneNum', 'error')} required">
	<label for="phoneNum">
		<g:message code="reserve.phoneNum.label" default="Phone Num" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phoneNum" maxlength="11" required="" value="${reserveInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'start', 'error')} ">
	<label for="start">
		<g:message code="reserve.start.label" default="Start" />
		
	</label>
	<g:textField name="start" maxlength="20" value="${reserveInstance?.start}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="reserve.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" maxlength="20" value="${reserveInstance?.destination}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="reserve.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="state" type="number" value="${reserveInstance.state}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: reserveInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="reserve.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${reserveInstance?.time}"  />
</div>

