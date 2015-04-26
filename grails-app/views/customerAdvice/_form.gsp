<%@ page import="taxi.CustomerAdvice" %>



<div class="fieldcontain ${hasErrors(bean: customerAdviceInstance, field: 'phoneNum', 'error')} required">
	<label for="phoneNum">
		<g:message code="customerAdvice.phoneNum.label" default="Phone Num" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phoneNum" maxlength="11" required="" value="${customerAdviceInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerAdviceInstance, field: 'advice', 'error')} ">
	<label for="advice">
		<g:message code="customerAdvice.advice.label" default="Advice" />
		
	</label>
	<g:textArea name="advice" cols="40" rows="5" maxlength="400" value="${customerAdviceInstance?.advice}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerAdviceInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="customerAdvice.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${customerAdviceInstance?.time}"  />
</div>

