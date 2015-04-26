<%@ page import="springsec.Online" %>



<div class="fieldcontain ${hasErrors(bean: onlineInstance, field: 'ip', 'error')} ">
    <label for="ip">
        <g:message code="online.ip.label" default="Ip"/>

    </label>
    <g:textField name="ip" maxlength="30" value="${onlineInstance?.ip}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: onlineInstance, field: 'userid', 'error')} required">
    <label for="userid">
        <g:message code="online.userid.label" default="Userid"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field name="userid" type="number" value="${onlineInstance.userid}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: onlineInstance, field: 'dateLogout', 'error')} ">
    <label for="dateLogout">
        <g:message code="online.dateLogout.label" default="Date Logout"/>

    </label>
    <g:datePicker name="dateLogout" precision="day" value="${onlineInstance?.dateLogout}" default="none"
                  noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: onlineInstance, field: 'status', 'error')} ">
    <label for="status">
        <g:message code="online.status.label" default="Status"/>

    </label>
    <g:checkBox name="status" value="${onlineInstance?.status}"/>
</div>

