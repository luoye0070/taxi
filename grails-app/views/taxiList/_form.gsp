<%@ page import="taxi.TaxiList" %>



<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'taxiPhone', 'error')} required">
	<label for="taxiPhone">
		<g:message code="taxiList.taxiPhone.label" default="Taxi Phone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="taxiPhone" maxlength="11" required="" value="${taxiListInstance?.taxiPhone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'phoneNum', 'error')} ">
	<label for="phoneNum">
		<g:message code="taxiList.phoneNum.label" default="Phone Num" />
		
	</label>
	<g:textField name="phoneNum" maxlength="11" value="${taxiListInstance?.phoneNum}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="taxiList.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="state" type="number" value="${taxiListInstance.state}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'taxiState', 'error')} required">
	<label for="taxiState">
		<g:message code="taxiList.taxiState.label" default="Taxi State" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="taxiState" type="number" value="${taxiListInstance.taxiState}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'evaluation', 'error')} ">
	<label for="evaluation">
		<g:message code="taxiList.evaluation.label" default="Evaluation" />
		
	</label>
	<g:textField name="evaluation" value="${taxiListInstance?.evaluation}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="taxiList.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${taxiListInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'taxiStatus', 'error')} ">
	<label for="taxiStatus">
		<g:message code="taxiList.taxiStatus.label" default="Taxi Status" />
		
	</label>
	<g:textField name="taxiStatus" value="${taxiListInstance?.taxiStatus}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'licence', 'error')} ">
	<label for="licence">
		<g:message code="taxiList.licence.label" default="Licence" />
		
	</label>
	<g:textField name="licence" value="${taxiListInstance?.licence}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'taxiTime', 'error')} required">
	<label for="taxiTime">
		<g:message code="taxiList.taxiTime.label" default="Taxi Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="taxiTime" precision="day"  value="${taxiListInstance?.taxiTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: taxiListInstance, field: 'time', 'error')} required">
	<label for="time">
		<g:message code="taxiList.time.label" default="Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="time" precision="day"  value="${taxiListInstance?.time}"  />
</div>

