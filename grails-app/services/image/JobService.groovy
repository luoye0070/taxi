/**
 *Title:        图片中心作业处理
 *Description:  异步生成缩略图作业
 *                  依赖ImageService生成缩略图
 *                  依赖InterfaceService更新文件记录的缩略图信息
 *@author:      yangfei
 *@create:      2012-3-4
 *@version      1.0
 *
 */

package image

class JobService {

    // 定义任务列表
    static jobs = []
    def ImageService
    def InterfaceService

    // 添加生成缩略图任务
    def addMakeThumbnailJob(fileInfo, thumbnailList) {
        def item = [op:"MakeThumbnail", info:fileInfo, list:thumbnailList]
        jobs.add(item)
    }
    // 添加删除缩略图任务
    def addDelThumbnailJob(fileid, filePath, thumbnailList) {
        def item = [op:"DelThumbnail", fileid:fileid, path:filePath, list:thumbnailList]
        jobs.add(item)
    }

    // 执行处理任务
    def doJobs() {
        def item = jobs ? jobs.remove(0) : null
        if (item) {
            if (item.op == "MakeThumbnail") {
                // 生成缩略图操作
                def thumbnailList = ImageService.makeListThumbnail(item.info, item.list)
                // 更新文件记录的缩略图信息
                InterfaceService.updateThumbnailList(item.info.fileid, thumbnailList)
            } else if (item.op == "DelThumbnail") {
                // 删除数据库记录
                InterfaceService.delete(item.fileid)
                // 删除缩略图操作
                ImageService.deleteThumbnail(item.path, item.list)
                // 删除原图
                new File(item.path).delete()
            }
        }
    }

}
