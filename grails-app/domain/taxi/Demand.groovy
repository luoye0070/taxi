package taxi

//乘客发起的及时打车请求
class Demand {
    String phoneNum
    String nickName
    Date time
    double latitude
    double longitude
    int state
    String filePath
    Date serverTime
    String hike     /****  2013-12-2 10:10 增加的加价字段  by 黄证 ****/
    static constraints = {
        nickName(size: 2..12)
        phoneNum(size: 11..11)
        state(size:1..1)
    }
}
