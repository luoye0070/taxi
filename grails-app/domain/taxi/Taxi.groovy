package taxi

//司机端用到的登陆表
class Taxi {
    String licence      //车号
    String password     //密码
    String taxiPhone    //联系电话
    String name         //姓名
    Date time           //注册时间
    Long personId       //添加该车租车司机的管理人员
    String serviceID    //服务证号
    static constraints = {
        licence(size: 2..50,blank: false)
        password(size: 6..20,blank: false)
        taxiPhone(size: 11..11,blank: false)
        name(size: 2..50,blank: false)
        serviceID(blank: true,nullable: true,maxSize: 50)
        time(nullable: true)
    }
}
