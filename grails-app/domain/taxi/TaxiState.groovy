package taxi

//司机端的使用情况
class TaxiState {
    String taxiPhone       //联系电话
    Date loginTime         //登陆时间
    Date exitTime          //退出时间
    int state              //使用状态
    static constraints = {
        loginTime(nullable: true)
        exitTime(nullable: true)
    }
}
