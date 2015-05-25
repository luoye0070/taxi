package android

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import taxi.*

import java.text.SimpleDateFormat

class PhoneReservedController {

    //今天可接预约
    def todayReserving = {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(Calendar.getInstance().getTime())
        def queryMax = dateFormatMax.format(Calendar.getInstance().getTime())
        Date startDateMin = simpleDateFormat.parse(query)
        Date startDateMax = simpleDateFormat.parse(queryMax+" "+"23:59")
        def reserving = Reserve.createCriteria().list(){
            and{
                between("time",startDateMin,startDateMax)
            }
            maxResults(10)
            order("time","asc")
        }
        if(reserving){
            def reserveTemp = reserving.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        state:it.state
                ]
            }
            println reserveTemp
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            println "1"
            render "0"
        }
    }

    //明天可接预约
    def tomorrowReserving = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+1)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(query+" "+"00:00")
        Date startDateMax = simpleDateFormat.parse(query+" "+"23:59")
        def reserving = Reserve.createCriteria().list(){
            and{
                between("time",startDateMin,startDateMax)
            }
            maxResults(10)
            order("time","asc")
        }
        if(reserving){
            def reserveTemp = reserving.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        state:it.state
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    //后天可接预约
    def dayAfterTomorrowReserving = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+2)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(query+" "+"00:00")
        Date startDateMax = simpleDateFormat.parse(query+" "+"23:59")
        def reserving = Reserve.createCriteria().list(){
            and{
                between("time",startDateMin,startDateMax)
            }
            maxResults(10)
            order("time","asc")
        }
        if(reserving){
            def reserveTemp = reserving.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        state:it.state
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    //今天已接受的预约
    def todayReserved = {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(Calendar.getInstance().getTime())
        def queryMax = dateFormatMax.format(Calendar.getInstance().getTime())
        Date startDateMin = simpleDateFormat.parse(query)
        Date startDateMax = simpleDateFormat.parse(queryMax+" "+"23:59")
        def reserved = Reserved.createCriteria().list(){
            and{
                eq("taxiPhone",params.taxiPhone)
                between("time",startDateMin,startDateMax)
            }

            order("time","asc")
        }
        if(reserved){
            def reserveTemp = reserved.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        taxiPhone:it.taxiPhone
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    //明天已接受的预约
    def tomorrowReserved = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+1)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(query+" "+"00:00")
        Date startDateMax = simpleDateFormat.parse(query+" "+"23:59")
        def reserved = Reserved.createCriteria().list(){
            and{
                eq("taxiPhone",params.taxiPhone)
                between("time",startDateMin,startDateMax)
            }
            order("time","asc")
        }
        if(reserved){
            def reserveTemp = reserved.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        taxiPhone:it.taxiPhone
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    //后天已接受的预约
    def dayAfterTomorrowReserved = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+2)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def query = dateFormat.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(query+" "+"00:00")
        Date startDateMax = simpleDateFormat.parse(query+" "+"23:59")
        def reserved = Reserved.createCriteria().list(){
            and{
                eq("taxiPhone",params.taxiPhone)
                between("time",startDateMin,startDateMax)
            }
            order("time","asc")
        }
        if(reserved){
            def reserveTemp = reserved.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        taxiPhone:it.taxiPhone
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    def orderReserve = {
        System.out.println("orderReserve");
        String time = (params.time).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        System.out.println("orderReserve->"+params.time+","+params.nickName+","+params.phoneNum+","+params.start+","+params.destination);
        params.time = simpleDate.parse(time)
        def reserve = Reserve.findByTimeAndNickNameAndPhoneNumAndStartAndDestinationAndState(params.time,params.nickName,params.phoneNum,params.start,params.destination,0)
        def taxi = Taxi.findByTaxiPhone(params.taxiPhone)
        if(reserve){
            System.out.println("orderReserve->"+reserve);
            reserve.state = 1
            def reserveList = new Reserved()
            reserveList.licence = taxi.licence
            reserveList.taxiPhone = params.taxiPhone
            reserveList.phoneNum = reserve.phoneNum
            reserveList.nickName = reserve.nickName
            reserveList.time = reserve.time
            reserveList.start = reserve.start
            reserveList.destination = reserve.destination
            if(reserveList.save(flush: true)&&!reserve.delete(flush: true)){
                System.out.println("orderReserve->1");
                render "1"
            }else{
                System.out.println("orderReserve->0");
                render "0"
            }
        }else{
            render "0"
        }
    }


}
