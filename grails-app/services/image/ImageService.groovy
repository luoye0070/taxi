/**
 *Title:        图片处理服务
 *Description:  对本地图片文件识别、缩放、添加水印等
 *              图片处理使用im4java调用GraphicsMagick（依赖im4java包）
 *              设置GraphicsMagick的路径（windows系统需要设置，linux不需要），两种方案任选其一（推荐第二种）
 *                  1.定义：private static String imageMagickPath = "c:\\Program Files\\GraphicsMagick-1.3.12-Q16"
 *                    转换之前设置：convert.setSearchPath(imageMagickPath) //linux下不要设置此值，不然会报错
 *                  2.设置环境变量：IM4JAVA_TOOLPATH = c:\Program Files\GraphicsMagick-1.3.12-Q16
 *@author:      yangfei
 *@create:      2012-1-30
 *@version:     1.2
 *@last:        2012-3-4
 */

package image

import org.apache.commons.io.FileUtils
import org.apache.commons.io.FilenameUtils

import org.im4java.core.ConvertCmd
import org.im4java.core.CompositeCmd
import org.im4java.core.IMOperation
import org.im4java.core.Info

class ImageService {

    static {
        /* 设置im4java默认调用GraphicsMagick处理图片
         * fixbug:  im4java的info类通过调用identify命令实现读取图片信息
         *          但info内部时调用identify命令时，不能传递userGM参数，导致默认使用ImageMagick处理图片
         *          此处设置system-property默认使用GraphicsMagick
         */
        System.setProperty("im4java.useGM", "true")
    }

    // 删除缩略图，list格式：220x220,80x80,610x10000
        def deleteThumbnail(srcFile, list) {
        def tlist = list?.split(",")
        tlist?.each {
            if (it =~ /^[0-9]+[x|X]{1}[0-9]+$/) {
                def i = it.toLowerCase().lastIndexOf('x')
                def width = toInteger(it.substring(0, i))
                def height = toInteger(it.substring(i + 1))
                new File(makeThumbnailFileName(srcFile, width, height)).delete()
            }
        }
        return true
    }

    // 生成缩略图，list格式：220x220,80x80,610x10000
    def makeListThumbnail(fileInfo, list) {
        def thumbnailInfo = ""
        println list?.split(",")
        def tlist = list?.split(",")
        tlist?.each {
            if (it =~ /^[0-9]+[x|X]{1}[0-9]+$/) {
                def i = it.toLowerCase().lastIndexOf('x')
                def width = toInteger(it.substring(0, i))
                def height = toInteger(it.substring(i + 1))
                makeThumbnail(fileInfo, width, height)
                if (thumbnailInfo) thumbnailInfo += ","
                thumbnailInfo += "${width}x${height}"
            }
        }
        return thumbnailInfo
    }

    boolean makeThumbnail(fileInfo, newWidth, newHeight) throws Exception {
        assert new File(fileInfo.path).exists()
        assert fileInfo.isImage
        // 根据文件格式调用不同的缩略图生成方法
        def fileFormat = fileInfo.format.toLowerCase()
        if (fileFormat.startsWith("gif")) {
            return makeThumbnail_gif(fileInfo, newWidth, newHeight)
        } else if (fileFormat.startsWith("jpeg")) {
            return makeThumbnail_jpg(fileInfo, newWidth, newHeight)
        } else if (fileFormat.startsWith("png")) {
            return makeThumbnail_png(fileInfo, newWidth, newHeight)
        } else {
            return makeThumbnail_image(fileInfo, newWidth, newHeight)
        }
    }

    // gif图片缩放方法
    private boolean makeThumbnail_gif(def fileInfo, int newWidth, int newHeight) throws Exception {
        // 缩略图文件名
        String newFile = makeThumbnailFileName(fileInfo.path, newWidth, newHeight)
        // 目标尺寸比原始尺寸大时，gif图片仍用第一帧生成缩略图，但尺寸不放大
        if (newWidth > fileInfo.width && newHeight > fileInfo.height) {
            newWidth = fileInfo.width
            newHeight = fileInfo.height
        }
        // 执行生成缩略图操作，gif仅缩放第一帧
        return makeThumbnailOperation(fileInfo.path + "[0]", newFile, newWidth, newHeight, 80)
    }

    // jpg图片缩放方法
    private boolean makeThumbnail_jpg(def fileInfo, int newWidth, int newHeight) throws Exception {
        // 缩略图文件名
        String newFile = makeThumbnailFileName(fileInfo.path, newWidth, newHeight)
        // 目标尺寸比原始尺寸大时，jpg文件直接复制，不进行缩放
        if (newWidth > fileInfo.width && newHeight > fileInfo.height) {
            FileUtils.copyFile(new File(fileInfo.path), new File(newFile))
            return true
        }
        // 执行生成缩略图操作
        return makeThumbnailOperation(fileInfo.path, newFile, newWidth, newHeight, fileInfo.quality)
    }

    // png图片缩放方法
    private boolean makeThumbnail_png(def fileInfo, int newWidth, int newHeight) throws Exception {
        // 缩略图文件名
        String newFile = makeThumbnailFileName(fileInfo.path, newWidth, newHeight)
        // 目标尺寸比原始尺寸大时，png文件直接复制，不进行缩放
        if (newWidth > fileInfo.width && newHeight > fileInfo.height) {
            FileUtils.copyFile(new File(fileInfo.path), new File(newFile))
            return true
        }
        // png图片需保持原有格式不变，缩放后再重名为指定缩略图名
        String destFile = FilenameUtils.removeExtension(newFile) + '.png'
        // 执行生成缩略图操作
        if (makeThumbnailOperation(fileInfo.path, destFile, newWidth, newHeight, null)) {
            FileUtils.moveFile(new File(destFile), new File(newFile)) // 修改png缩略图文件名为指定的缩略图名
            return true
        } else {
            return false
        }
    }

    // 默认图片缩放方法
    private boolean makeThumbnail_image(def fileInfo, int newWidth, int newHeight) throws Exception {
        // 缩略图文件名
        String newFile = makeThumbnailFileName(fileInfo.path, newWidth, newHeight)
        // 目标尺寸比原始尺寸大时，默认图片处理方式仍然要生成缩略图（压缩为jpg）
        if (newWidth > fileInfo.width && newHeight > fileInfo.height) {
            newWidth = fileInfo.width
            newHeight = fileInfo.height
        }
        // 执行生成缩略图操作
        return makeThumbnailOperation(fileInfo.path, newFile, newWidth, newHeight, 80)
    }

    // 执行生成缩略图操作
    private boolean makeThumbnailOperation(srcFile, newFile, newWidth, newHeight, quality) throws Exception {
        try {
            // 缩放图片
            IMOperation op = new IMOperation()
            op.addImage()
            if (quality) { op.quality(quality) }
            op.resize(newWidth, newHeight)
            op.addImage()
            ConvertCmd convert = new ConvertCmd(true) // 参数为true表示使用GraphicsMagick
            convert.run(op, srcFile, newFile)
            return true
        }
        catch (Exception e) {
            e.printStackTrace()
            return false
        }
    }

    // 生成缩略图文件名
    def makeThumbnailFileName(String srcPath, width, height) throws Exception {
        //return "${srcPath}_${width}x${height}.${getExtension(srcPath)}"
        def filename = "${srcPath}_${width}x${height}.jpg"
        delFile(filename)
        return filename
    }

    /**
     * 读取文件信息
     * 返回结果：[磁盘文件绝对路径、磁盘文件大小、是否是图片、图片格式、图片大小、宽度、高度、JPEG质量]
     *          [path, size, isImage, format, imageSize, width, height, quality]
     * @param filePath   文件绝对路径
     */
    def fileInfo(String filePath) throws Exception {
        return fileInfo(new File(filePath))
    }
    def fileInfo(File file) throws Exception {
        // 检查文件是否存在
        if (! file.exists()) { return null }
        // 读取图片文件属性
        Info info
        String path = file.getAbsolutePath()
        // gif图片只读取第一帧
        String pathfix = path.toLowerCase().endsWith("gif") ? "[0]" : ""
        Integer size = file.size()
        Boolean isImage = false
        String format = ""
        String imageSize = ""
        Integer width = 0
        Integer height = 0
        Integer quality = 0
        try {
            info = new Info(path + pathfix)
            format = info.getProperty("Format")
            imageSize = info.getProperty("Filesize")
            String _geometry = info.getProperty("Geometry")
            int i = _geometry.lastIndexOf('x')
            width = toInteger(_geometry.substring(0, i))
            height = toInteger(_geometry.substring(i + 1))
            quality = toInteger(info.getProperty("JPEG-Quality"))
            isImage = width && height
        }
        catch (Exception e) {
            e.printStackTrace()
            isImage = false
            format = ""
            imageSize = ""
            width = 0
            height = 0
            quality = 0
        }
        return ["path":path, "size":size, "isImage":isImage, "format":format,
                "imageSize":imageSize, "width":width, "height":height, "quality":quality]
    }

    /**
     * 给图片加文字水印
     * 暂不支持中文，可能是字体问题 by yangfei 2011-11-24
     * @param srcPath   源图片路径
     * @param markText  水印文字
     */
    boolean addMarkText(String srcPath, String markText) throws Exception {
        try {
            def info = fileInfo(srcPath)
            if (! info.isImage) { return false }

            IMOperation op = new IMOperation()
            if (info.quality) { op.quality(info.quality) }
            op.font("c:\\WINDOWS\\Fonts\\simhei.ttf")
            op.gravity("southeast").pointsize(24).fill("#CCC").draw("text 5,5 ${markText}")
            op.addImage()
            op.addImage()
            ConvertCmd convert = new ConvertCmd(true) // 参数为true表示使用GraphicsMagick
            //convert.createScript("d:\\c", op) // 生成命令行脚本文件(调试用)
            convert.run(op, srcPath, srcPath)
            return true
        }
        catch (Exception e) {
            e.printStackTrace()
            return false
        }
    }

    /**
     * 给图片加图片水印
     * @param srcPath   源图片路径
     * @param markImage 水印图片路径
     */
    def addMarkImage(String srcPath, String markImage) throws Exception {
        return addMarkImage(srcPath, markImage, 50)
    }
    def addMarkImage(String srcPath, String markImage, int dissolve) throws Exception {
        try {
            def info = fileInfo(markImage)
            if (! info.isImage) { return false }
            info = fileInfo(srcPath)
            if (! info.isImage) { return false }

            IMOperation op = new IMOperation()
            op.gravity("southeast")
            op.dissolve(Math.min((dissolve>=20 ? dissolve : 20), 90))
            op.addImage()
            op.addImage()
            op.addImage()
            CompositeCmd cmd = new CompositeCmd(true)
            cmd.run(op, markImage, srcPath, srcPath)
            return true
        }
        catch (Exception e) {
            e.printStackTrace()
            return false
        }
    }
    
    // 缩放图像
    boolean resizeImage(srcFile, newWidth, newHeight, quality) throws Exception {
        try {
            // 缩放图片
            IMOperation op = new IMOperation()
            op.addImage()
            if (quality) { op.quality(quality) }
            op.resize(newWidth, newHeight)
            op.addImage()
            ConvertCmd convert = new ConvertCmd(true) // 参数为true表示使用GraphicsMagick
            convert.run(op, srcFile, srcFile)
            return true
        }
        catch (Exception e) {
            e.printStackTrace()
            return false
        }
    }

    // 删除指定文件
    private delFile(path) {
        File targetFile = new File(path)
        if (targetFile.isFile()) { targetFile.delete() }
    }
    
    // 字符串转整形数
    private Integer toInteger(def n) {
        if (n) {
            String x = "${n}".trim()
            return x.isInteger() ? x.toInteger() : 0
        } else
            return 0
    }

}
