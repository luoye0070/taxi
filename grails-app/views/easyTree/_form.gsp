<%@ page import="com.sec.EasyTree" %>



<div class="fieldcontain ${hasErrors(bean: easyTreeInstance, field: 'text', 'error')} ">
	<label for="text">
		<g:message code="easyTree.text.label" default="Text" />
		
	</label>
	<g:textField name="text" maxlength="30" value="${easyTreeInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: easyTreeInstance, field: 'attributes', 'error')} ">
	<label for="attributes">
		<g:message code="easyTree.attributes.label" default="Attributes" />
		
	</label>
	<g:textField name="attributes" maxlength="100" value="${easyTreeInstance?.attributes}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: easyTreeInstance, field: 'state', 'error')} ">
	<label for="state">
		<g:message code="easyTree.state.label" default="State" />
		
	</label>
	<g:textField name="state" maxlength="20" value="${easyTreeInstance?.state}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: easyTreeInstance, field: 'pid', 'error')} required">
	<label for="pid">
		<g:message code="easyTree.pid.label" default="Pid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pid" type="number" value="${easyTreeInstance.pid}" required=""/>
</div>

