package android

import grails.converters.JSON
import taxi.*

import java.text.SimpleDateFormat

class PhoneTaxiListController {

    def queryMe = {
        def time = (params.time).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        Date taxiListTime = simpleDate.parse(time)
        def taxiList = TaxiList.findAllByPhoneNumAndTime(params.phoneNum,taxiListTime)
        if (taxiList){
            def taxiListInfo = ["taxiList":taxiList]
            render taxiListInfo as JSON
        }else{
            render 0
        }
    }

    def queryLeave = {
        def taxiList = TaxiList.createCriteria().list {
            and {
                eq("phoneNum",params.phoneNum)
                eq("state",0)
            }
            maxResults(1)
            order("id","asc")
        }
        if(taxiList){
            def taxiListTemp=taxiList.collect {
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        licence:it.licence,
                        phoneNum:it.phoneNum,
                        time:sdf.format(it.time),
                        state:it.state,
                        status:it.status,
                        evaluation:it.evaluation
                ]
            }
            def taxiListInfo = ["taxiList":taxiListTemp]
            render taxiListInfo as JSON
        }else{
            render "0"
        }
    }

    def evaluation = {
        println params
        String time = (params.time).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        params.time = simpleDate.parse(time)
        def taxiList = TaxiList.findByPhoneNumAndTimeAndState(params.phoneNum,params.time,0)
        taxiList.status = params.status
        taxiList.evaluation = params.evaluation
        taxiList.state = 1
        if(taxiList.save(flush: true)){
            render "1"
        }else{
            render "0"
        }
    }

    def taxiLeave = {
        Date exitTime,dayDate,dayEndDate
        Calendar calendar = Calendar.getInstance()
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        def query = dateFormatMax.format(calendar.getTime())
        def exitDate = dateFormat.format(calendar.getTime())
        exitTime = dateFormat.parse(exitDate)
        dayDate = dateFormat.parse(query+" "+"00:00")
        dayEndDate = dateFormat.parse(query+" "+"23:59")
        def todayTaxi = TaxiState.findByTaxiPhoneAndLoginTimeBetween(params.taxiPhone,dayDate,dayEndDate)
        def todayTaxiInstance = TaxiState.get(todayTaxi.id)
//        todayTaxiInstance.state = 0
//        todayTaxiInstance.exitTime = exitTime
        //保存退出时间此处等待司机端应用的更新
//        todayTaxiInstance.save()
        def taxiList = TaxiList.createCriteria().list {
            and {
                eq("taxiPhone",params.taxiPhone)
                eq("taxiState",0)
            }
            maxResults(1)
            order("id","desc")
        }
        if(taxiList){
            def taxiListTemp=taxiList.collect {
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        taxiPhone:it.taxiPhone,
                        phoneNum:it.phoneNum,
                        time:sdf.format(it.time),
                        taxiTime:sdf.format(it.taxiTime)
                ]
            }
            def taxiListInfo = ["taxiList":taxiListTemp]
            render taxiListInfo as JSON
        }else{
            render "0"
        }
    }

    def carry = {
        def taxiList = TaxiList.createCriteria().list {
            and {
                eq("taxiPhone",params.taxiPhone)
                eq("phoneNum",params.phoneNum)
                eq("taxiState",0)
            }
            maxResults(1)
            order("id","desc")
        }
        if(taxiList){
            def taxiListTemp=taxiList.collect {
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        taxiPhone:it.taxiPhone,
                        phoneNum:it.phoneNum,
                        time:sdf.format(it.time),
                        taxiTime:sdf.format(it.taxiTime)
                ]
            }
            def taxiListInfo = ["taxiList":taxiListTemp]
            render taxiListInfo as JSON
        }else{
            render "0"
        }
    }

    def taxiEvaluation = {
        String time = (params.taxiTime).replace("/"," ")
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        params.taxiTime = simpleDate.parse(time)
        def taxiList = TaxiList.findByPhoneNumAndTaxiTimeAndTaxiPhone(params.phoneNum,params.taxiTime,params.taxiPhone)
        taxiList.taxiStatus = params.taxiStatus
        taxiList.taxiState = 1
        if(taxiList.save(flush: true)){
            render "1"
        }else{
            render "0"
        }
    }

    def todayDemandList = {
        Calendar calendar = Calendar.getInstance()
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        SimpleDateFormat dateFormatMax = new SimpleDateFormat("yyyy-MM-dd")
        def queryMin = dateFormatMax.format(calendar.getTime())
        Date startDateMin = dateFormat.parse(queryMin+" "+"00:00")
        Date startDateMax = dateFormat.parse(queryMin+" "+"23:59")
        def taxiList = TaxiList.createCriteria().list(){
            and{
                eq("taxiPhone",params.taxiPhone)
                between("taxiTime",startDateMin,startDateMax)
            }
            order("time","asc")
        }
        if(taxiList){
            def taxiListTemp = taxiList.collect{
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                [
                        phoneNum:it.phoneNum,
                        taxiTime:sdf.format(it.taxiTime),
                        taxiState:it.taxiState,
                        nickName:it.nickName,
                        hike:it.hike

                ]
            }
            def reInfo = ["taxiList":taxiListTemp]
            render reInfo as JSON
        }else{
            render "0"
        }
    }

    def recentTaxiList = {
        Calendar calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_MONTH,-2)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def query = dateFormat.format(calendar.getTime())
        def end = simpleDateFormat.format(Calendar.getInstance().getTime())
        Date beginDate = simpleDateFormat.parse(query+" "+"00:00:00")
        Date endDate = simpleDateFormat.parse(end)
        def taxiList = TaxiList.createCriteria().list {
            and{
                eq("phoneNum",params.phoneNum)
                between("taxiTime",beginDate,endDate)
            }
            order("time","asc")
        }

        if(taxiList){
            def taxiListTemp = taxiList.collect{
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                [
                        phoneNum: it.phoneNum,
                        time: sdf.format(it.time),
                        state: it.state,
                        licence: it.licence
                ]
            }
            def reInfo = ["taxiList":taxiListTemp]
            render reInfo as JSON
        }else{
            render "0"
        }



    }

}
