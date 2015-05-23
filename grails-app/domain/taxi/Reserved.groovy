package taxi

//乘客发起的预约已被司机接受的订单
class Reserved {
    String licence          //车号
    String taxiPhone        //司机联系电话
    String phoneNum         //乘客联系电话
    String nickName         //昵称
    Date time               //乘车时间
    String start            //起点
    String destination      //终点

    static constraints = {
        taxiPhone(size: 11..11,blank: false)
        nickName(size: 2..64,blank: false)
        phoneNum(size: 11..11,blank: false)
        start(size: 0..20)
        destination(size: 0..20)
    }
}
