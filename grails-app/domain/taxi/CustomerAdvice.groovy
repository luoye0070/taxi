package taxi

class CustomerAdvice {
    String phoneNum
    String advice
    Date time

    static constraints = {
        phoneNum(size: 11..11,blank: false)
        advice(size: 0..400)
    }
}
