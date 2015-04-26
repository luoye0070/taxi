<script type="text/javascript" charset="utf-8">
    function logout(b) {
        $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {
            if (r) {
                location.href = "${resource()}/logout/index";
            }
        });
    }

    var userInfoWindow;
    function showUserInfo() {
        userInfoWindow = $('<div/>').window({
            modal : true,
            title : '当前用户信息',
            width : 350,
            height : 300,
            collapsible : false,
            minimizable : false,
            maximizable : false,
            href : '#',
            onClose : function() {
                $(this).window('destroy');
            }
        });
    }
</script>
<div style="position: absolute; right: 0px; bottom: 0px; ">
    <span>
        权限：
        <sec:ifAllGranted roles="ROLE_SUPERVISOR">超级管理员</sec:ifAllGranted>
        <sec:ifAllGranted roles="ROLE_ADMIN">管理员</sec:ifAllGranted>
        <sec:ifAllGranted roles="ROLE_USER">普通用户</sec:ifAllGranted>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        用户名：<sec:username/>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    </span>
    <a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_pfMenu" iconCls="icon-ok">更换皮肤</a> <a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_kzmbMenu" iconCls="icon-help">控制面板</a> <a href="javascript:void(0);" class="easyui-menubutton" menu="#layout_north_zxMenu" iconCls="icon-back">注销</a>
</div>
<div id="layout_north_pfMenu" style="width: 120px; display: none;">
    <div onclick="sy.changeTheme('default');">default</div>
    <div onclick="sy.changeTheme('gray');">gray</div>
    <div onclick="sy.changeTheme('cupertino');">cupertino</div>
    <div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
    <div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
    <div onclick="sy.changeTheme('sunny');">sunny</div>
</div>
<div id="layout_north_kzmbMenu" style="width: 100px; display: none;">
    %{--<div onclick="showUserInfo();">个人信息</div>--}%
    <div class="menu-sep"></div>
    <div>
        <span>更换主题</span>
        <div style="width: 120px;">
            <div onclick="sy.changeTheme('default');">default</div>
            <div onclick="sy.changeTheme('gray');">gray</div>
            <div onclick="sy.changeTheme('cupertino');">cupertino</div>
            <div onclick="sy.changeTheme('dark-hive');">dark-hive</div>
            <div onclick="sy.changeTheme('pepper-grinder');">pepper-grinder</div>
            <div onclick="sy.changeTheme('sunny');">sunny</div>
        </div>
    </div>
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
    <div onclick="loginAndRegDialog.dialog('open');">锁定窗口</div>
    <div class="menu-sep"></div>
    <div onclick="logout();">重新登录</div>
    <div onclick="logout(true);">退出系统</div>
</div>
