package springsec

class Online {
    long userid        //用户id
    String ip           //登录ip
    Date dateCreated   //登录日期
    Date dateLogout   // 退出时间
    boolean status     //状态   true 在线 false 不在线

    static constraints = {
        ip maxSize: 30,blank: true,nullable: true
        userid blank: true,nullable: true
        dateCreated blank: true,nullable: true
        dateLogout blank: true,nullable: true
    }
}
