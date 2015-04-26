/**
 *Title:        上传服务接口业务逻辑
 *Description:  记录上传文件信息到数据库等数据库操作
 *@author:      yangfei
 *@create:      2012-2-20
 *@version:     1.0
 *@last:        2012-3-4
 */

package image

import org.springframework.dao.DataIntegrityViolationException
import springsec.*
class InterfaceService {

    private def grailsApplication = new org.codehaus.groovy.grails.commons.DefaultGrailsApplication()

    // 记录上传的图片信息到数据库，返回记录的id
    def recordUpload(def info) {
        // 新增上传文件列表记录
        def imageobj = new Image()
        imageobj.minurl = info.minurl//最小图片路径
        imageobj.midurl = info.midurl   //中图片路径
        imageobj.maxurl = info.maxurl    //大图片路径
        imageobj.gread = info.gread //排序级别
        imageobj.userid = info.userid
        // 统计应用程序相关数据

        // 统计用户相关数据
        def countUser = FileCount.findOrSaveWhere(userid:info.userid)
        countUser.totalSize += info.imageSize
        countUser.fileNum ++
        // 统计应用程序中单用户的数据

        if (imageobj.save(flush: true) && countUser.save(flush: true)) {
            return imageobj.id
        } else {
            imageobj.errors?.each { println it }
            countUser.errors?.each { println it }
            return null
        }
    }

    // 生成图片访问子域名

    String makeDomain() {
        // 生成1-8的随机数，用来生成随机图片域名
        def random = new Random()
        return "img0${(1 + random.nextInt(8)).toString()}"
    }

    // 生成图片url
    String makeUrl(info) {
        String url = "http://${info.domain}.${grailsApplication.metadata["uploadconfig.domainName"]}/"
        // 读取上传路径配置参数
        String uploadFolder = grailsApplication.metadata["uploadconfig.uploadFolder"]
        if (! uploadFolder.endsWith(File.separator)) uploadFolder += File.separator
        // 组合URL
        url = url + info.path.replace(uploadFolder, "").replace(File.separator, "/")
        return url
    }

    // 更新缩略图信息
    def updateThumbnailList(itemid, thumbnailList) {
        if (!thumbnailList) return false
        def item = Image.get(itemid)
        if (item) {
            item.thumbnailList = thumbnailList
            return item.save(flush: true)
        } else {
            return false
        }
    }

    // 删除上传的图片数据（不仅进行文件权属验证，删除文件操作由Image服务处理）
    def delete(def itemid) {
        def item = Image.get(itemid)
        if (!item) return false
        int imageSize = item.imageSize
        try {
            item.delete(flush: true)
        }
        catch (DataIntegrityViolationException e) {
            return false
        }
        // 统计用户相关数据
        def countUser = FileCount.findOrSaveWhere(appId:null, userId:userid)
        countUser.totalSize -= imageSize
        countUser.fileNum --
        // 统计应用程序中单用户的数据
        // 更新统计记录
        return (countUser.save(flush: true))
    }

}