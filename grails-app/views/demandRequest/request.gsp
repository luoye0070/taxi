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
    <title>乘车请求</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap.min.css">

    <!-- 可选的Bootstrap主题文件（一般不用引入） -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.2/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
</head>

<body>
<div class="container">
<div class="row" style="margin: 5px;">
    <g:render template="/layouts/msgs_and_errors"></g:render>
</div>
<g:if test="${demandInstance}">
    <div class="row" style="margin: 5px;margin-top: 0px;">
        <div class="panel panel-default">
            <div class="panel-heading">乘车请求</div>
            <div class="panel-body">
                <form action="${createLink(controller: "customerOfWeb", action: "apply")}" method="POST">
                    <input type="hidden" id="latitude" name="latitude" value="0"/>
                    <input type="hidden" id="longitude" name="longitude" value="0"/>
                    <input type="hidden" name="nickName" value="${demandInstance?.nickName}"/>
                    <input type="hidden" name="filePath" value="无"/>

                    <div class="form-group">
                        <label for="phoneNum">
                            <g:message code="demand.phoneNum.label" default="Phone Num"/>
                        </label>
                        <g:textField class="form-control" name="phoneNum" maxlength="11"
                                     value="${demandInstance?.phoneNum}"/>
                    </div>

                    <div class="form-group">
                        <label for="hike">
                            <g:message code="demand.hike.label" default="Hike"/>
                        </label>
                        <g:textField class="form-control" name="hike" value="${demandInstance?.hike ?: 0}"/>
                    </div>

                    <div class="form-group">
                        <label for="route">
                            <g:message code="demand.route.label" default="Route"/>
                        </label>
                        <g:select class="form-control" id="route" name="routeId" from="${taxi.Route.list()}"
                                  optionKey="id" optionValue="name" value="${demandInstance?.route?.id}"/>
                    </div>

                    <g:submitButton class="btn btn-default" name="submit" value="乘车"></g:submitButton>
                </form>
            </div>
        </div>
    </div>
</g:if>
</div>
<script type="text/javascript">
    wx.config({
        debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId: '${appId}', // 必填，公众号的唯一标识
        timestamp:${timestamp} , // 必填，生成签名的时间戳
        nonceStr: '${nonceStr}', // 必填，生成签名的随机串
        signature: '${signature}',// 必填，签名，见附录1
        jsApiList: ['getLocation'] // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    wx.ready(function(){
        //获取当前位置
        wx.getLocation({
            success: function (res) {
                //alert(JSON.stringify(res));
                document.getElementById("latitude").value=res.latitude;
                document.getElementById("longitude").value=res.longitude;
            },
            cancel: function (res) {
                alert(JSON.stringify(res));
            }
        });
    });
</script>
</body>
</html>