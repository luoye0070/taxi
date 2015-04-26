package springsec

class Image {
    String minurl //最小图片路径
    String midurl   //中图片路径
    String maxurl     //大图片路径
    long gread    //排序级别
    long userid
    static constraints = {
        minurl blank: true,nullable: true,maxSize:150
        midurl blank: true,nullable: true,maxSize:150
        maxurl blank: true,nullable: true,maxSize:150
        gread  blank: true,nullable: true
        userid blank: true,nullable: true
    }
}
