<%@ page import="taxi.TaxiAdvice" %>



<div class="fieldcontain ${hasErrors(bean: taxiAdviceInstance, field: 'taxiPhone', 'error')} required">
	<label for="taxiPhone">
		<g:message code="taxiAdvice.taxiPhone.label" default="Taxi Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taxiPhone" maxlength="50" required="" value="${taxiAdviceInstance?.taxiPhone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiAdviceInstance, field: 'advice', 'error')} ">
	<label for="advice">
		<g:message code="taxiAdvice.advice.label" default="Advice" />
		
	</label>
	<g:textArea name="advice" cols="40" rows="5" maxlength="400" value="${taxiAdviceInstance?.advice}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiAdviceInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="taxiAdvice.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${taxiAdviceInstance?.time}"  />
</div>

