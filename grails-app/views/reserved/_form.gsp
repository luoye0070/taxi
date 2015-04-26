<%@ page import="taxi.Reserved" %>



<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'taxiPhone', 'error')} required">
	<label for="taxiPhone">
		<g:message code="reserved.taxiPhone.label" default="Taxi Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taxiPhone" maxlength="11" required="" value="${reservedInstance?.taxiPhone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'nickName', 'error')} required">
	<label for="nickName">
		<g:message code="reserved.nickName.label" default="Nick Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nickName" maxlength="12" required="" value="${reservedInstance?.nickName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'phoneNum', 'error')} required">
	<label for="phoneNum">
		<g:message code="reserved.phoneNum.label" default="Phone Num" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phoneNum" maxlength="11" required="" value="${reservedInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'start', 'error')} ">
	<label for="start">
		<g:message code="reserved.start.label" default="Start" />
		
	</label>
	<g:textField name="start" maxlength="20" value="${reservedInstance?.start}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="reserved.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" maxlength="20" value="${reservedInstance?.destination}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'licence', 'error')} ">
	<label for="licence">
		<g:message code="reserved.licence.label" default="Licence" />
		
	</label>
	<g:textField name="licence" value="${reservedInstance?.licence}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reservedInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="reserved.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${reservedInstance?.time}"  />
</div>

