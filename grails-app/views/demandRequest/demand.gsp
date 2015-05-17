<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-5-15
  Time: 上午1:24
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>乘车订单</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
</head>

<body>
<div class="container">
    <div class="row" style="margin: 5px;">
        <g:render template="/layouts/msgs_and_errors"></g:render>
    </div>
    <g:if test="${demandInstance}">
        <div class="row" style="margin: 5px;margin-top: 0px;">
            <div class="panel panel-default">
                <div class="panel-heading">乘车订单信息</div>
                <div class="panel-body">
                    <ol class="property-list demand">

                        <g:if test="${demandInstance?.nickName}">
                            <li class="fieldcontain">
                                <span id="nickName-label" class="property-label"><g:message code="demand.nickName.label"
                                                                                            default="Nick Name"/></span>

                                <span class="property-value" aria-labelledby="nickName-label"><g:fieldValue
                                        bean="${demandInstance}" field="nickName"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.phoneNum}">
                            <li class="fieldcontain">
                                <span id="phoneNum-label" class="property-label"><g:message code="demand.phoneNum.label"
                                                                                            default="Phone Num"/></span>

                                <span class="property-value" aria-labelledby="phoneNum-label"><g:fieldValue
                                        bean="${demandInstance}" field="phoneNum"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.state}">
                            <li class="fieldcontain">
                                <span id="state-label" class="property-label"><g:message code="demand.state.label"
                                                                                         default="State"/></span>

                                <span class="property-value" aria-labelledby="state-label"><g:fieldValue
                                        bean="${demandInstance}" field="state"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.filePath}">
                            <li class="fieldcontain">
                                <span id="filePath-label" class="property-label"><g:message code="demand.filePath.label"
                                                                                            default="File Path"/></span>

                                <span class="property-value" aria-labelledby="filePath-label"><g:fieldValue
                                        bean="${demandInstance}" field="filePath"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.latitude}">
                            <li class="fieldcontain">
                                <span id="latitude-label" class="property-label"><g:message code="demand.latitude.label"
                                                                                            default="Latitude"/></span>

                                <span class="property-value" aria-labelledby="latitude-label"><g:fieldValue
                                        bean="${demandInstance}" field="latitude"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.longitude}">
                            <li class="fieldcontain">
                                <span id="longitude-label" class="property-label"><g:message
                                        code="demand.longitude.label" default="Longitude"/></span>

                                <span class="property-value" aria-labelledby="longitude-label"><g:fieldValue
                                        bean="${demandInstance}" field="longitude"/></span>

                            </li>
                        </g:if>

                        <g:if test="${demandInstance?.serverTime}">
                            <li class="fieldcontain">
                                <span id="serverTime-label" class="property-label"><g:message
                                        code="demand.serverTime.label" default="Server Time"/></span>

                                <span class="property-value" aria-labelledby="serverTime-label"><g:formatDate
                                        date="${demandInstance?.serverTime}" format="yyyy-MM-dd HH:mm:ss"/></span>

                            </li>
                        </g:if>

                        %{--<g:if test="${demandInstance?.time}">--}%
                            %{--<li class="fieldcontain">--}%
                                %{--<span id="time-label" class="property-label"><g:message code="demand.time.label"--}%
                                                                                        %{--default="Time"/></span>--}%

                                %{--<span class="property-value" aria-labelledby="time-label"><g:formatDate--}%
                                        %{--date="${demandInstance?.time}" format="yyyy-MM-dd HH:mm:ss"/></span>--}%

                            %{--</li>--}%
                        %{--</g:if>--}%

                    </ol>

                    <form action="${createLink(controller: "customerOfWeb", action: "cancel")}" method="post">
                        <input type="hidden" name="id" value="${demandInstance?.id}"/>
                        <input type="submit" class="btn btn-default"
                               value="${message(code: 'default.button.cancel.label', default: 'Cancel')}"/>
                    </form>
                </div>
            </div>
        </div>
    </g:if>
</div>
</body>
</html>