package taxi

//乘客发起的预约还没有被司机接受的订单
class Reserve {
    String phoneNum     //乘客电话
    String nickName     //乘客昵称
    Date time           //预约乘车时间
    String start        //起点
    String destination  //终点
    int state           //预约状态

    static constraints = {
        nickName(size: 2..12,blank: false)
        phoneNum(size: 11..11,blank: false)
        start(size: 0..20)
        destination(size: 0..20)
        state(size:1..1)
    }
}
