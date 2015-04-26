package taxi

class TaxiAdvice {
    String taxiPhone
    String advice
    Date time

    static constraints = {
        taxiPhone(size: 2..50,blank: false)
        advice(size: 0..400)
    }
}
