package android

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import taxi.*

import java.text.SimpleDateFormat

class PhoneCustomerController {

    //登陆
    def login = {

        def customer = Customer.findByPhoneNumAndPassword(params.phoneNum,params.password)
        if (customer){
            render "phoneNum="+customer.phoneNum+";nickName="+customer.nickName
        }else{
            render "0"
        }
    }

    //注册
    def register = {
        params.dataCreated = new Date()
        def customer = Customer.findByPhoneNum(params.phoneNum)
        if(!customer){
            def customerInstance = new Customer(params)
            if (!customerInstance.save(flush: true)){
                render "0"
            }else{
                render "1"
            }
        }else{
            render "0"
        }
    }

    //发送打车请求
    def apply = {
        println "接收到的数据" + params
        def now = new Date()
        String time = (params.time).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        params.time = simpleDate.parse(time)
        params.serverTime = now
        def demand = Demand.findByPhoneNum(params.phoneNum)
        if (!demand){
            def demandInstance = new Demand(params)
//            demandInstance.hike = 0    /** 乘客的加价，乘客端升级后去掉这个       **/
            if(!demandInstance.save(flush: true)){
                render "0"
            }else{
                render "1"
            }
        }else{
            demand.serverTime = now
            demand.time = params.time
            demand.nickName = params.nickName
            demand.filePath = params.filePath
            demand.latitude = Double.parseDouble(params.latitude)
            demand.longitude = Double.parseDouble(params.longitude)
            demand.hike = params.hike
            demand.hike = 0
            //demand.route=Route.get(Long.parseLong(params.routeId));
            demand.save(flush: true)
            render "1"
        }
    }

    //取消打车请求
    def cancel = {
        def demand = Demand.findByPhoneNum(params.phoneNum)
        if (demand)
        {
            if (demand.state == 0){
                try{
                    def invalidation = new Invalidation()
                    invalidation.phoneNum = demand.phoneNum
                    invalidation.state = demand.state
                    invalidation.latitude = demand.latitude
                    invalidation.longitude = demand.longitude
                    invalidation.time = demand.time
                    invalidation.hike = demand.hike             /**  2013-12-2:12:20 **/
                    if(!demand.delete(flush: true) && invalidation.save(flush: true)){
                        render "1"
                    }else{
                        render "0"
                    }
                }catch(DataIntegrityViolationException e){
                    render "0"
                }
            }else{
                render "0"
            }
        }else{
            render "0"
        }
    }

    def alter = {
        def customer = Customer.findByPhoneNum(params.phoneNum)
        customer.nickName = params.nickName
        customer.password = params.password
        if (!customer.save(flush: true)){
            render "0"
        }else{
            render "1"
        }
    }

    def taxiLocation = {
        def date = new Date().format("yyyy-MM-dd")
        def startTime  = date + " 00:00:00"
        def endTime = date + " 23:59:59"
        def smf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        startTime = smf.parse(startTime)
        endTime = smf.parse(endTime)
        double latitudeCustomer = Double.parseDouble(params.latitude)       //纬度
        double longitudeCustomer = Double.parseDouble(params.longitude)     //经度
        def taxiList = TaxiState.findAllByStateAndLoginTimeBetween(1,startTime,endTime)
        def location = latitudeCustomer+longitudeCustomer
        def taxiOnLine = []
        def temp = [:]
        def m = []
        def taxiLocation = []
        taxiList.each {attr->
            def taxi = TaxiLocation.findByTaxiPhone(attr.taxiPhone)
            taxiOnLine+=taxi
        }

        taxiOnLine.each {attr->
            temp[attr.taxiPhone] = Math.abs((attr.latitude+attr.longitude)-location)
        }
        temp = temp.sort{it.value}

        taxiOnLine.each {attr->
            temp.eachWithIndex{Map.Entry<Object,Object> entry, int i ->
                if(i<20){
                    if(attr.taxiPhone == entry.key){
                        m+=attr
                    }
                }
            }
        }

        if(m.size()!=0){
            for(int i=m.size()-1;i>=0;i--){
                taxiLocation.add(m[i])
            }
            def locationInfo = ["taxiLocation":taxiLocation]
            render locationInfo as JSON
        }else{
            render "0"
        }
    }

    def myTaxiLocation = {
        def taxi = TaxiLocation.findAllByLicence(params.licence)
        if(taxi){
            def locationInfo = ["taxiLocation":taxi]
            render locationInfo as JSON
        }else{
            render "0"
        }
    }

}
