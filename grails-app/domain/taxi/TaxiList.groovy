package taxi

//司机接受的及时打车订单数据
class TaxiList {
    String nickName      /****  2013-12-2 10:10 增加的昵称字段  by 黄证 ****/
    String taxiPhone    //司机电话号码
    String phoneNum     //乘客的电话号码
    String licence      //车号
    Date time       //乘客发起订单的时间
    Date taxiTime   //司机接受订单的时间
    int state       //乘客是否对订单进行评价
    int taxiState   //司机对订单是否评价
    String status        //打车状态
    String evaluation    //服务评价
    String taxiStatus        //打车状态
    String hike      /****  2013-12-2 10:10 增加的加价字段  by 黄证 ****/
    String route; //路线
    static constraints = {
        taxiPhone(size: 11..11,blank: false)
        phoneNum(size: 11..11)
        state(size:1..1)
        taxiState(size:1..1)
        evaluation blank: true,nullable: true;
        status blank: true,nullable: true;
        taxiStatus blank: true,nullable: true;
        route(nullable: true);
    }
}
