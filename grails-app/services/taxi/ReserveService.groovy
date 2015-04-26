package taxi

class ReserveService {

    def reserveMethod(def params) {
        def stateQuery
        if(params.querys == "5" && (params.queryValue == "未" || params.queryValue == "未接" || params.queryValue == "未接单")){
            stateQuery = Reserve.findAllByState(0).id
        }else  if(params.querys == "5" && (params.queryValue == "已" || params.queryValue == "已接" || params.queryValue == "已接单")){
            stateQuery = Reserve.findAllByState(1).id
        }
        def query = {
            if(params.querys == "1"){
                like('nickName',"%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like('phoneNum',"%"+params.queryValue+"%")
            }
            if(params.querys == "3"){
                like('start',"%"+params.queryValue+"%")
            }
            if(params.querys == "4"){
                like('destination',"%"+params.queryValue+"%")
            }
            if(stateQuery){
                'in'('id',stateQuery)
            }
            order("time",'desc')
        }
        return [stateQuery:stateQuery,query:query]
    }
}
