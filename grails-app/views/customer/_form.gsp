<%@ page import="taxi.Customer" %>



<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'nickName', 'error')} required">
	<label for="nickName">
		<g:message code="customer.nickName.label" default="Nick Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nickName" maxlength="12" required="" value="${customerInstance?.nickName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'phoneNum', 'error')} required">
	<label for="phoneNum">
		<g:message code="customer.phoneNum.label" default="Phone Num" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="phoneNum" maxlength="11" required="" value="${customerInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: customerInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="customer.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" maxlength="20" required="" value="${customerInstance?.password}"/>
</div>

