package android

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import taxi.*

import java.text.SimpleDateFormat

class PhoneReserveController {

    def reservation = {
        println params
        Calendar calendar = Calendar.getInstance()
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def startDate = params.startDate
        def dateAndTime
        Date time
        if(startDate.equals("今天")){
            startDate = dateFormat.format(Calendar.getInstance().getTime())
        }else if(startDate.equals("明天")){
            calendar.add(Calendar.DAY_OF_MONTH,+1)
            startDate = dateFormat.format(calendar.getTime())
        }else if(startDate.equals("后天")){
            calendar.add(Calendar.DAY_OF_MONTH,+2)
            startDate = dateFormat.format(calendar.getTime())
        }
        dateAndTime = startDate+" "+params.startTime
        time = simpleDateFormat.parse(dateAndTime)
        def reserveList = new Reserve()
        reserveList.time = time
        reserveList.phoneNum = params.phoneNum
        reserveList.nickName = params.nickName
        reserveList.start = params.start
        reserveList.destination = params.destination
        if(!reserveList.save(flush: true)){
            render "0"
        }else{
            render "1"
        }
    }

    def myReserving = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+2)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def queryMin = dateFormat.format(Calendar.getInstance().getTime())
        def queryMax = dateFormatMax.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(queryMin)
        Date startDateMax = simpleDateFormat.parse(queryMax+" "+"23:59")
        def reserve = Reserve.createCriteria().list(){
            and{
                eq("phoneNum",params.phoneNum)
                eq("state",0)
                between("time",startDateMin,startDateMax)
            }
            order("time","asc")
        }
        if(reserve){
            def reserveTemp = reserve.collect{
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

    def myReserved = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,+2)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        def queryMin = dateFormat.format(Calendar.getInstance().getTime())
        def queryMax = dateFormatMax.format(calendar.getTime())
        Date startDateMin = simpleDateFormat.parse(queryMin)
        Date startDateMax = simpleDateFormat.parse(queryMax+" "+"23:59")
        def reserve = Reserved.createCriteria().list(){
            and{
                eq("phoneNum",params.phoneNum)
                between("time",startDateMin,startDateMax)
            }
            order("time","asc")
        }
        if(reserve){
            def reserveTemp = reserve.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        taxiPhone:it.taxiPhone,
                        phoneNum:it.phoneNum,
                        nickName:it.nickName,
                        time:sdf.format(it.time),
                        start:it.start,
                        destination:it.destination,
                        licence:it.licence
                ]
            }
            def reInfo = ["reserveList":reserveTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    def cancelReserve = {
        String time = (params.time).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        params.time = simpleDate.parse(time)
        def reserve = Reserve.findByPhoneNumAndTimeAndStartAndDestinationAndState(params.phoneNum,params.time,params.start,params.destination,0)
        if(reserve){
            try{
                if(!reserve.delete(flush: true)){
                    render "1"
                }
            }catch (DataIntegrityViolationException e){
                render "0"
            }
        }else{
            render "0"
        }
    }

}
