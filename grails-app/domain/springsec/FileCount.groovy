package springsec

class FileCount {
    long userid
    long totalSize //总文件大小
    long maxSize // 限制大小
    long fileNum  //文件个数
    static constraints = {
        maxSize blank:false,nullable: false
        totalSize blank:false,nullable: false
        userid blank:false,nullable: false
        fileNum blank:false,nullable: false
    }
}
