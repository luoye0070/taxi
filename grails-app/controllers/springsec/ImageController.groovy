package springsec

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import image.UploadService

class ImageController {
    def UploadService
    def InterfaceService
    def ImageService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {

    }

    def create()
    {

    }

    def imageupFile()
    {
            def file = request.getFile('Filedata')
            def filePath
            if(!file.empty) {
                def filename =  UploadService.uploadImage(file)
                if (filename)
                {
                    def list = "110x110,300x300,600x600"

                    println filename
                    def fileInfo = ImageService.fileInfo(filename)

                    ImageService.makeListThumbnail(fileInfo,list )
                    def info = []//,minurl,midurl,maxurl,userid,imageSize
                      info = [
                         minurl:filename,
                         midurl:filename,
                         maxurl:filename,
                         imageSize:file.size,
                         userid:(long)1,
                         gread:(long)0
                      ]
                    def result = InterfaceService.recordUpload(info)
                    if (result)
                    {
                        render info = [msg: "文件上传成功",result: true,obj:result ]
                    }
                    else
                    {
                        render info = [msg: "文件存储失败",result: false,obj:result]
                    }

                }
                else{
                    render info = [msg: "文件验证失败",result: false]
                }
            }
         /*
            def b = ff.lastIndexOf('.')
            def str3 = System.currentTimeMillis()
            def ran = (new java.util.Random().nextInt(89999)) + 10000
            def fileName=str3+ran+(ff.substring(b))
            if(fileName.toLowerCase().endsWith(".jpg")||fileName.toLowerCase().endsWith(".gif")||fileName.toLowerCase().endsWith(".png")||fileName.toLowerCase().endsWith(".jpeg"))
            {

                filePath=getServletContext().getRealPath("/")+"/upimage/"+"${new Date().format("yyyy-MM-dd")}//"

                try{
                    if (!(new java.io.File(filePath).isDirectory())) //如果文件夹不存在
                    {
                        new java.io.File(filePath).mkdir();      //不存在 excel 文件夹，则建立此文件夹
                    }

                    f.transferTo(new File(filePath+fileName))
                    def imageobj = new Image()
                    imageobj.minurl = filePath + fileName
                    imageobj.midurl=  filePath + fileName
                    imageobj.maxurl = filePath + fileName
                    imageobj.gread =  0
                    if(!imageobj.save(flush:true))
                        imageobj.errors.each {
                            println it
                        }
                    render imageobj.minurl

                }catch(Exception e){
                    println e.toString()
                    e.printStackTrace();        //创建文件夹失败
                    render "文件上传出错";
                }





            }
            else
            {
                render "文件类型非法！"
            }
        }
        else
        {
            render "文件上传失败！"
        }  */
    }

    def edit()
    {

    }

    def datagrid(){

    }

    def datajson(){
        params.offset = (params.rows as int) * ((params.page as int) - 1)
        params.max = params.rows as int
        def info = [
                "rows":Image.list(params),
                "total":Image.count()
        ]
        render info as JSON
    }

    def save() {
        def imageInstance = new Image(params)
        def info
        def msg = "出错了！/n"
        if (!imageInstance.save(flush: true)) {
            imageInstance.errors.each {
                msg = msg + it
            }
            info = [result:false,msg:msg]
        }
        else
        {
            info = [result:true,msg:"恭喜你，保存成功！"]
        }
        render info as JSON
    }


    def update(Long id, Long version) {
        def imageInstance = Image.get(id)
        def info = []
        if (!imageInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'image.label', default: 'Image'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (imageInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        imageInstance.properties = params

        if (!imageInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def imageInstance = Image.get(id),info = []

        if (!imageInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            imageInstance.delete(flush: true)
            info = [result: true,msg:"删除成功！"]
            render info as JSON
            return
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false,msg:"出错了，删除失败！"]
            render info as JSON
        }
    }
}
