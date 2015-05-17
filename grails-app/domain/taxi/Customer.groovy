package taxi

class Customer {
    String nickName
    String phoneNum
    String password
    Date dateCreated

    static constraints = {
        nickName(size: 2..64,blank: false)
        phoneNum(size: 11..11,blank: true,nullable: true)
        password(size: 6..20,blank: true,nullable: true)
        dateCreated(nullable: true)
    }
}
