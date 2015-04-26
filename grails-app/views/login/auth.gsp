<html>
<head>
    <meta name='layout' content='head'/>
    <title><g:message code="springSecurity.login.title"/></title>
    <link type="text/css" rel="stylesheet" href="${resource(dir: "css",file: "auth.css")}"/>
    <script type="text/javascript">
        $(function(){

            setTimeout(dev,1000)

            function dev(){
                if(window.top!= window.self){
                    window.top.location.href = window.self.location.href
                }
            }

            document.onkeydown=function(e){
                if((e.keyCode || e.which) ==13){
                    loging()
                }
            }
            function loging(){
                var username = $("#username").val();
                var password = $("#password").val();
                if(username==''||password=='')
                {
                    $("#message").html("提示：账号或密码不能为空！");
                    return false;
                }
                var mydate = new Date();
                $.post("${resource()}/login/pri_auth",
                        {j_username:username,j_password:password,
                            ajax:"true",
                            time:mydate.toString()}
                        ,function (data){
                            onlogin(data)
                        });
                return false;
            }
            $("#reset").click(function(){
                var username = $("#username").val("");
                var password = $("#password").val("");
            })

            $("#btn").click(function(){
                loging()
            })

            function onlogin(data)
            {
                if(data.success)
                {
                    window.location.href='${resource()}'
                }
                else
                {
                    $("#message").html("提示：账号或密码错误！");
                }
            }

        })


    </script>
</head>

<body>
<div id='login'>
    <div id="diyi"></div>
    <div id="yongHu">
        <div id="message">${flash.message}</div>
        <input type='text' class='text_' name='j_username'  id='username'/><br>
        <input type='password' class='text_' name='j_password' id='password'/><br>
        <div class="blank"></div>
        <a href="#" id="btn"><img src="${resource()}/images/myImages/login.png" alt=""></a>
        <a href="#" id="reset"><img src="${resource()}/images/myImages/reset.png" alt=""></a>
    </div>
</div>
<script type='text/javascript'>
    <!--
    (function() {
        document.forms['loginForm'].elements['j_username'].focus();
    })();
    // -->
</script>
</body>
</html>



