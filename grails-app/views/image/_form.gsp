<%@ page import="springsec.Image" %>



<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'minurl', 'error')} ">
	<label for="minurl">
		<g:message code="image.minurl.label" default="Minurl" />
		
	</label>
	<g:textField name="minurl" maxlength="50" value="${imageInstance?.minurl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'midurl', 'error')} ">
	<label for="midurl">
		<g:message code="image.midurl.label" default="Midurl" />
		
	</label>
	<g:textField name="midurl" maxlength="50" value="${imageInstance?.midurl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'maxurl', 'error')} ">
	<label for="maxurl">
		<g:message code="image.maxurl.label" default="Maxurl" />
		
	</label>
	<g:textField name="maxurl" maxlength="50" value="${imageInstance?.maxurl}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: imageInstance, field: 'gread', 'error')} required">
	<label for="gread">
		<g:message code="image.gread.label" default="Gread" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="gread" type="number" value="${imageInstance.gread}" required=""/>
</div>

