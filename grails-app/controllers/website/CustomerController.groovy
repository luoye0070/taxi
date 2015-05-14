package website

import org.springframework.dao.DataIntegrityViolationException
import taxi.Demand
import taxi.Invalidation
import taxi.Route

import java.text.SimpleDateFormat

class CustomerController {

    def index() {}

    def getOrCreateOrder(){
        def errors=null;
        def msgs=null;

        def demand =null;
        //从session中获取phone
        String phoneNum=session.getAttribute("phone");
        if(phoneNum){
            demand = Demand.findByPhoneNum(phoneNum);
        }
        if(demand){//显示打车信息
            render(view: "/demandRequest/demand",model: [demandInstance:demand,errors:errors,msgs:msgs]);
        }else{//显示输入电话号码、加价、路线的界面
            render(view: "/demandRequest/request",model: [demandInstance:demand,errors:errors,msgs:msgs]);
        }
    }

    //发送打车请求
    def apply = {
        def errors=null;
        def msgs=null;
        println "接收到的数据" + params
        def demand = new Demand()
        def now = new Date();
        demand.serverTime = now
        demand.time = now;//params.time
        demand.nickName = params.nickName
        demand.filePath = params.filePath
        demand.latitude = Double.parseDouble(params.latitude)
        demand.longitude = Double.parseDouble(params.longitude)
        demand.hike = params.hike
        //demand.hike = 0
        demand.route=Route.get(Long.parseLong(params.routeId));
        demand.phoneNum=params.phoneNum;
        if(demand.save(flush: true)){
            session.setAttribute("phone",params.phoneNum);
            redirect(action:  "getOrCreateOrder");
        }else {
            errors=g.message(error: demand.errors.allErrors.get(0));
            render(view: "/demandRequest/request",model: [demandInstance:demand,errors:errors,msgs:msgs]);
        }

//        def now = new Date()
//        String time = (params.time).replace("/"," ")
//        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
//        params.time = simpleDate.parse(time)
//        params.serverTime = now
//        def demand = Demand.findByPhoneNum(params.phoneNum)
//        if (!demand){
//            def demandInstance = new Demand(params)
////            demandInstance.hike = 0    /** 乘客的加价，乘客端升级后去掉这个       **/
//            if(!demandInstance.save(flush: true)){
//                render "0"
//            }else{
//                render "1"
//            }
//        }else{
//            demand.serverTime = now
//            demand.time = params.time
//            demand.nickName = params.nickName
//            demand.filePath = params.filePath
//            demand.latitude = Double.parseDouble(params.latitude)
//            demand.longitude = Double.parseDouble(params.longitude)
//            demand.hike = params.hike
//            //demand.hike = 0
//            demand.route=Route.get(Long.parseLong(params.routeId));
//            demand.save(flush: true)
//            render "1"
//        }
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
}
