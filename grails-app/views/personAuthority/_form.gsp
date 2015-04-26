<%@ page import="com.sec.PersonAuthority" %>



<div class="fieldcontain ${hasErrors(bean: personAuthorityInstance, field: 'authority', 'error')} required">
	<label for="authority">
		<g:message code="personAuthority.authority.label" default="Authority" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="authority" name="authority.id" from="${com.sec.Authority.list()}" optionKey="id" required="" value="${personAuthorityInstance?.authority?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: personAuthorityInstance, field: 'person', 'error')} required">
	<label for="person">
		<g:message code="personAuthority.person.label" default="Person" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="person" name="person.id" from="${com.sec.Person.list()}" optionKey="id" required="" value="${personAuthorityInstance?.person?.id}" class="many-to-one"/>
</div>

