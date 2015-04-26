<%@ page import="com.sec.Authority" %>



<div class="fieldcontain ${hasErrors(bean: authorityInstance, field: 'authority', 'error')} required">
	<label for="authority">
		<g:message code="authority.authority.label" default="Authority" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="authority" maxlength="30" required="" value="${authorityInstance?.authority}"/>
</div>

