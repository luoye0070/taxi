package android

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException
import taxi.*

import java.text.SimpleDateFormat

class PhoneDemandController {

    //司机查询订单，返回距离司机有效范围内的订单数据
    def handle = {
        println params

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def end = dateFormat.format(Calendar.getInstance().getTime())
        Date endTime = dateFormat.parse(end)
        def start = dateFormat.format(new Date(endTime.getTime()-15*60*1000))
        Date startTime = dateFormat.parse(start)
        double latitudeTaxi = Double.parseDouble(params.latitude)       //纬度
        double longitudeTaxi = Double.parseDouble(params.longitude)     //经度
        //把一个距离东西南北方位各2km的正方形规定为搜索的区域。
        double latitudeMin = latitudeTaxi - 0.018000
        double latitudeMax = latitudeTaxi + 0.018000
        double longitudeMin = longitudeTaxi - 0.018000
        double longitudeMax = longitudeTaxi + 0.018000

        def licence = Taxi.findByTaxiPhone(params.taxiPhoneNum).licence
        def taxiInfo = TaxiLocation.findByLicence(licence)
        if(!taxiInfo){
            def taxiLocation = new TaxiLocation()
            taxiLocation.taxiPhone = params.taxiPhoneNum
            taxiLocation.licence = licence
            taxiLocation.latitude = latitudeTaxi
            taxiLocation.longitude = longitudeTaxi
            taxiLocation.save()
        }else{
            taxiInfo.taxiPhone = params.taxiPhoneNum
            taxiInfo.latitude = latitudeTaxi
            taxiInfo.longitude =longitudeTaxi
            taxiInfo.save()
        }

        //查询规定范围的经度和纬度，再获取id最小的数据
        def demand = Demand.createCriteria().list() {
            and{
                eq("state",0)
//                测试时注释
//                between("latitude",latitudeMin,latitudeMax)
//                between("longitude",longitudeMin,longitudeMax)
//                between("serverTime",startTime,endTime)
            }
        }
        def a=latitudeTaxi+longitudeTaxi
        def temp=[:]
        def m=[]
        def tempList = []
        demand.each{attr->
            temp[attr.phoneNum]=Math.abs((attr.latitude+attr.longitude)-a)
        }
        temp=temp.sort{it.value}

        //返回符合条件的三个订单
        demand.each{attr->
          temp.eachWithIndex { Map.Entry<Object, Object> entry, int i ->
              if(i<3){
                  if(attr.phoneNum==entry.key){
                      m+=attr
                  }
              }
          }
        }
        if(m.size()!=0){
            for(int i=m.size()-1;i>=0;i--){
                tempList.add(m[i])
            }
            println "m的详细数据"+m
            println "tempList的详细数据"+tempList
         def demandInfo=["demandList":tempList]
            render demandInfo as JSON
        }else{
            render "0"
        }

        //返回符合条件的一条订单
//        demand.each{attr->
//            temp.eachWithIndex { Map.Entry<Object, Object> entry, int i ->
//                if(i==0){
//                    if(attr.phoneNum==entry.key){
//                        m=attr
//                    }
//                }
//            }
//        }
//        if(m){
//            def demandInfo=["demandList":[m]]
//            render demandInfo as JSON
//        }else{
//            render "0"
//        }
    }

    //司机端发送查询到的结果关键字，来抢单
    def end = {
        /**
         * 2013-12-2 10:22
         **/

        Date now = new Date()
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        def time = simpleDateFormat.format(now)
        def demand = Demand.findByPhoneNum(params.phoneNum)
        def taxi = Taxi.findByTaxiPhone(params.taxiPhone)
        if(demand){
            if (demand.state ==0){
                try {
                    demand.state = 1
                    def taxiList = new TaxiList()
                    taxiList.licence = taxi.licence
                    taxiList.taxiPhone = params.taxiPhone
                    taxiList.phoneNum = demand.phoneNum
                    taxiList.time = demand.time
                    taxiList.taxiTime = now
                    taxiList.state = 0
                    taxiList.hike = demand.hike
                    taxiList.nickName = demand.nickName
                    taxiList.route=demand.route;
                    if(taxiList.save(flush: true) && !demand.delete(flush: true))
                    {
                        render time
                    }
                    else {
                        println(taxiList.getErrors().allErrors)
                    }

                }catch (DataIntegrityViolationException e){
                    render "0"
                }
            }else{
                render "0"
            }
        }else{
            render "0"
        }
    }

    //用户端上传录音文件
    def upload = {
        if(request.method=="POST"){
            def uploadFile = request.getFile("filename")
            if(!uploadFile.empty){
                def fileName = uploadFile.getOriginalFilename();
                def filePath = request.getRealPath("/")+"media"+"/"+fileName;
                try{
                    uploadFile.transferTo(new File(filePath))
                }catch (Exception e){
                    e.printStackTrace()
                }
            }
        }
    }
}
