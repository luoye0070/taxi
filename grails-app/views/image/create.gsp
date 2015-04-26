
<%@ page import="springsec.Image" %>
<!doctype html>
<html>
<head>
<meta name="layout" content="head"/>
<link href="${resource()}/js/SWFUpload2.02/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${resource()}/js/SWFUpload2.02/swfupload/swfupload.js"></script>
<script type="text/javascript" src="${resource()}/js/SWFUpload2.02/js/swfupload.queue.js"></script>
<script type="text/javascript" src="${resource()}/js/SWFUpload2.02/js/fileprogress.js"></script>
<script type="text/javascript" src="${resource()}/js/SWFUpload2.02/js/handlers.js"></script>

<script type="text/javascript">
    var swfu;

    window.onload = function() {
        var settings = {
            flash_url : "${resource()}/js/SWFUpload2.02/swfupload/swfupload.swf",
            upload_url: "${resource()}/image/imageupFile",
            post_params: {"PHPSESSID" : "${session.id}"},
            file_size_limit : "2 MB",
            file_types : "*.jpg;*.gif;*.bmp",
            file_types_description : "图片",
            file_upload_limit : 10,  //配置上传个数
            file_queue_limit : 0,
            custom_settings : {
                progressTarget : "fsUploadProgress",
                cancelButtonId : "btnCancel"
            },
            debug: false,

            // Button settings
            button_image_url: "${resource()}/js/SWFUpload2.02/images/TestImageNoText_65x29.png",
            button_width: "65",
            button_height: "29",
            button_placeholder_id: "spanButtonPlaceHolder",
            button_text: '<span class="theFont">浏览</span>',
            button_text_style: ".theFont { font-size: 16; }",
            button_text_left_padding: 12,
            button_text_top_padding: 3,

            file_queued_handler : fileQueued,
            file_queue_error_handler : fileQueueError,
            file_dialog_complete_handler : fileDialogComplete,
            upload_start_handler : uploadStart,
            upload_progress_handler : uploadProgress,
            upload_error_handler : uploadError,
            upload_success_handler : uploadSuccess,
            upload_complete_handler : uploadComplete,
            queue_complete_handler : queueComplete
        };

        swfu = new SWFUpload(settings);
    };


    function setHome(data)
    {
        $.post('${resource()}/hotelImages/setHome',
                {id:data},
                function(response){
                    if(response.result==true)
                    {
                        $.messager.show({
                            title : '提示',
                            msg : "设置成功,您还可以设置"+response.sy+"张"
                        });
                    }
                    else
                        $.messager.alert('提示', response.message, 'error');
                })
    }


    function delHome(data)
    {
        $.post('${resource()}/hotelImages/delHome',
                {id:data},
                function(response){
                    if(response.result==true)
                    {
                        $.messager.show({
                            title : '提示',
                            msg : "设置成功,您还可以设置"+response.sy+"张"
                        });
                        window.location.reload();//当前页面刷新;
                    }
                    else
                        $.messager.alert('提示', response.message, 'error');
                })
    }

    function setType(type,imageid)
    {
        $.post('${resource()}/hotelImages/setType',
                {imgid:imageid,roomtype:type},
                function(response){
                    if(response.result==true)
                    {
                        $.messager.show({
                            title : '提示',
                            msg : "设置成功,您还可以设置"+response.sy+"张"
                        });
                        window.location.reload();//当前页面刷新;
                    }
                    else
                        $.messager.alert('提示', response.message, 'error');
                })
    }

    function deleteimg(imageid)
    {
        var r=confirm("确定要删除么？")
        if (r==true)
        {
            $.post('${resource()}/hotelImages/delete',
                    {id:imageid},
                    function(response){
                        if(response.result==true)
                        {
                            $.messager.show({
                                title : '提示',
                                msg : response.sy
                            });
                            window.location.reload();//当前页面刷新;
                        }
                        else
                            $.messager.alert('提示', response.message, 'error');
                    })
        }
        else
        {
            return
        }
    }

    function delTypeImg(imageid,typeid)
    {//alert(imageid);
        var r=confirm("确定要删除么？")
        if (r==true)
        {
            $.get('${resource()}/hotelImages/delTypeImg',
                    {imgId:imageid,typeId:typeid},
                    function(response){

                        if(response.result==true)
                        {
                            $.messager.show({
                                title : '提示',
                                msg : response.sy
                            });
                            window.location.reload();//当前页面刷新;
                        }
                        else
                            $.messager.alert('提示', response.message, 'error');
                    })

        }
        else
        {
            return
        }
    }
</script>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>
<div id="header">
    <h1 id="logo"><a href="/">SWFUpload</a></h1>
    <div id="version">v2.2.0</div>
</div>

<div id="content">
    <form id="form1" action="index.php" method="post" enctype="multipart/form-data">
        <p>点击“浏览”按钮，选择您要上传的文档文件后，系统将自动上传并在完成后提示您。</p>
        <p>请勿上传包含中文文件名的文件！</p>
        <div class="fieldset flash" id="fsUploadProgress">
            <span class="legend">快速上传</span>
        </div>
        <div id="divStatus">0个文件已上传</div>
        <div>
            <span id="spanButtonPlaceHolder"></span>
            <input id="btnCancel" type="button" value="取消所有上传" onclick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 29px;" />
        </div>

    </form>
</div>
</body>
</html>

