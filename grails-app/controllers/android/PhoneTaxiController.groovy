package android

import taxi.*

import java.text.SimpleDateFormat

class PhoneTaxiController {

    //登陆
    def login() {
        Date loginTime, dayDate, dayEndDate
        Calendar calendar = Calendar.getInstance()
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        def query = dateFormatMax.format(calendar.getTime())
        def loginDate = dateFormat.format(calendar.getTime())
        loginTime = dateFormat.parse(loginDate)
        dayDate = dateFormat.parse(query + " " + "00:00")
        dayEndDate = dateFormat.parse(query + " " + "23:59")
        def taxi = Taxi.findByTaxiPhoneAndPassword(params.taxiPhone, params.password)
        def todayTaxi = TaxiState.findByTaxiPhoneAndLoginTimeBetween(params.taxiPhone, dayDate, dayEndDate)
        if (taxi) {
            if (todayTaxi != null) {
                def todayTaxiInstance = TaxiState.get(todayTaxi.id)
                todayTaxiInstance.loginTime = loginTime
                todayTaxiInstance.state = 1
                todayTaxiInstance.save()
                render "taxiPhone=" + taxi.taxiPhone + ";password=" + taxi.password
            } else {
                def temp = new TaxiState()
                temp.taxiPhone = params.taxiPhone
                temp.state = 1
                temp.loginTime = loginTime
                temp.save()
                render "taxiPhone=" + taxi.taxiPhone + ";password=" + taxi.password
            }
        } else {
            render "0"
        }
    }

    def alter = {
        def taxi = Taxi.findByTaxiPhone(params.taxiPhone)
        taxi.password = params.password
        if (!taxi.save(flush: true)) {
            render "0"
        } else {
            render "1"
        }
    }

    def leave = {
        println params
        Date exitTime, dayDate, dayEndDate
        Calendar calendar = Calendar.getInstance()
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        def query = dateFormatMax.format(calendar.getTime())
        def loginDate = dateFormat.format(calendar.getTime())
        exitTime = dateFormat.parse(loginDate)
        dayDate = dateFormat.parse(query + " " + "00:00")
        dayEndDate = dateFormat.parse(query + " " + "23:59")
        def todayTaxi = TaxiState.findByTaxiPhoneAndLoginTimeBetween(params.taxiPhone, dayDate, dayEndDate)
        if (todayTaxi != null) {
            def todayTaxiInstance = TaxiState.get(todayTaxi.id)
            todayTaxiInstance.exitTime = exitTime
            todayTaxiInstance.state = 0
            todayTaxiInstance.save()
        }
    }

}
