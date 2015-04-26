package android

import taxi.*

class PhoneAdviceController {

    def CustomerAdvice={
        def advice = new CustomerAdvice(params)
        def now = new Date()
        advice.time = now
        if (!advice.save(flush: true)){
            render "0"
        }else{
            render "1"
        }
    }

    def TaxiAdvice={
        def advice = new TaxiAdvice(params)
        def now = new Date()
        advice.time = now
        if (!advice.save(flush: true)){
            render "0"
        }else{
            render "1"
        }
    }
}
