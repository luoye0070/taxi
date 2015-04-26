/**
 *Title:        文件上传服务
 *Description:  处理request.getFile取得的文件数据，写入指定的路径下，仅校验文件大小和文件扩展名
 *              本服务需要读取application.properties中的三个配置
 *                  uploadconfig.uploadFolder        // 上传文件保存目录
 *                  uploadconfig.maxUploadSize       // 最大上传文件大小
 *                  uploadconfig.allowFileExt        // 允许上传的文件扩展名，例：".jpg,.jpeg,.png,.gif"
 *@author:      yangfei
 *@create:      2012-1-30
 *@version      1.2
 *@last:        2012-3-4
 */

package image
import org.apache.commons.io.FilenameUtils
import grails.util.GrailsUtil

class UploadService {

    private def grailsApplication = new org.codehaus.groovy.grails.commons.DefaultGrailsApplication()

    // 上传图片文件，成功时返回文件磁盘路径，失败时返回null
    String uploadImage(def file){
        try {
            // 验证上传
            if (!validateUpload(file)) { return null }
            // 生成文件全名
            String destFileName = makeImageDestFileName(file)
            if (! destFileName) { return null }
            // 保存文件
            File destFile = new File(destFileName)
            file.transferTo(destFile)
            return destFileName
        }
        catch (Exception e) {
            println e.toString()
            return null
        }
    }

    // 上传前检查文件有效性
    private boolean validateUpload(def file) {
        // 验证上传文件大小（配置为kb）
        long maxUploadSize = grailsApplication.metadata["uploadconfig.maxUploadSize"].toLong() * 1024
        println "maxUploadSize:"+maxUploadSize
        if (file.empty || file.size > maxUploadSize || file.originalFilename == "") {
            println("maxUploadSize:${maxUploadSize}")
            println("${new Date().format("yyyy-MM-dd HH:mm:ss")}\t文件名:${file?.originalFilename}\t文件大小:${file.size}\t文件大小无效!")
            return false
        }
        // 验证文件扩展名
        String allowFileExt = grailsApplication.metadata["uploadconfig.allowFileExt"].toLowerCase()
        String fileExtName = FilenameUtils.getExtension(file.originalFilename).toLowerCase()
        if (allowFileExt.indexOf(fileExtName) == -1) {
            println("${new Date().format("yyyy-MM-dd HH:mm:ss")}\t文件名:${file?.originalFilename}\t文件扩展名无效!")
            return false
        }
        // 通过验证
        return true
    }

    // 文件命名（full path)
    private String makeImageDestFileName(def file) {
        // 初始化变量
        String fileName = grailsApplication.metadata["uploadconfig.uploadFolder"]
        // 开发和测试环境下，忽略选项配置文件选项，指定上传目录
        if (GrailsUtil.environment == "development" || GrailsUtil.environment == "test") {
            fileName = "d:\\uploadtest\\"
        }
        if (! fileName.endsWith(File.separator)) fileName += File.separator
        // 根据日期生成目录名
        fileName += "${new Date().format("yyyy${File.separator}MM${File.separator}dd${File.separator}")}"
        // 目标文件名
        def random = new Random()
        fileName += "${new Date().format("HHmmss")}${(1000 + random.nextInt(9000)).toString()}"
        // 连接扩展名
        def fileExt = FilenameUtils.getExtension(file.originalFilename).toLowerCase()
        if (fileExt == "bmp") { fileExt = "jpg" }
        if (!fileExt) { fileExt = "jpg" }
        fileName += ".${fileExt}"
        // 生成目标文件夹
        File dir = new File(fileName).getParentFile()
        if (! dir.exists()) { dir.mkdirs() }
        return fileName
    }

}
