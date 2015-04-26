<!doctype html>
<html>
<head>
    <title>打车软件综合管理系统</title>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/jquery.cookie.js" charset="utf-8"></script>
    <link id="easyuiTheme" rel="stylesheet" href="${resource()}/js/jquery-easyui-1.2.6/themes/default/easyui.css" type="text/css"/>
    <link href="${resource()}/js/jquery-easyui-1.2.6/themes/icon.css" rel="stylesheet" type="text/css"/>
    <link href="${resource()}/js/jquery-easyui-1.2.6/portal.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/jquery.portal.js" charset="utf-8"></script>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${resource()}/js/jquery-easyui-1.2.6/syUtil.js"></script>
    <script type="text/javascript">
        $(function(){
        })
    </script>
</head>
<body id="indexLayout" class="easyui-layout">
<div region="north" class="logo" style="height:60px;overflow: hidden;" href="${resource()}/easyuiLayout/north"></div>

<div region="east" title="当前日期" split="true" style="width:200px;overflow: hidden;" href="${resource()}/easyuiLayout/east"></div>

<div region="center" title="欢迎使用打车软件综合管理系统" style="overflow: hidden;" href="${resource()}/easyuiLayout/center"></div>

<div region="west" title="功能导航" split="false" style="width:200px;overflow: hidden;" href="${resource()}/easyuiLayout/west"></div>

<div region="south" style="height:20px;overflow: hidden;" href=""></div>


<script type="text/javascript" charset="utf-8">
    $(function () {
        $('form input').bind('keyup', function (event) {/* 增加回车提交功能 */
            if (event.keyCode == '13') {
                $(this).submit();
            }
        });


    });
</script>
</div>
<script type="text/javascript" charset="utf-8">
    $(function () {
        if (sy.isLessThanIe8()) {
            $.messager.show({
                title:'警告',
                msg:'您使用的浏览器版本太低！<br/>建议您使用谷歌浏览器来获得更快的页面响应效果！',
                timeout:1000 * 30
            });
        }
    });
</script>
</body>
</html>
