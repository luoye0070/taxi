package taxi

class DemandService {

    def demandMethod(def params){
        def stateQuery
        if(params.querys == "3" && (params.queryValue == "未" || params.queryValue == "未接" || params.queryValue == "未接单")){
            stateQuery = Demand.findAllByState(0).id
        }else  if(params.querys == "3" && (params.queryValue == "已" || params.queryValue == "已接" || params.queryValue == "已接单")){
            stateQuery = Demand.findAllByState(1).id
        }
        def query = {
            if(params.querys == "1"){
                like('nickName',"%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like('phoneNum',"%"+params.queryValue+"%")
            }
            if(stateQuery){
                'in'('id',stateQuery)
            }
            order("time",'desc')
        }
       return[stateQuery:stateQuery,query:query]
    }
}
