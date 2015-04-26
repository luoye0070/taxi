package taxi

class Customer {
    String nickName
    String phoneNum
    String password
    Date dateCreated

    static constraints = {
        nickName(size: 2..12,blank: false)
        phoneNum(size: 11..11,blank: false)
        password(size: 6..20,blank: false)
        dateCreated(nullable: true)
    }
}
