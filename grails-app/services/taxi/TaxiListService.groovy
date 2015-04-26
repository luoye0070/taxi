package taxi

class TaxiListService {

    def taxiListMethod(def params) {
        def stateQuery,taxiStateQuery
        if(params.querys == "3" && (params.queryValue == "未" || params.queryValue == "未评" || params.queryValue == "未评价")){
            stateQuery = TaxiList.findAllByState(0).id
        }else  if(params.querys == "3" && params.queryValue == "评价" ){
            stateQuery = TaxiList.findAllByState(1).id
        }
        if(params.querys == "4" && (params.queryValue == "未" || params.queryValue == "未评" || params.queryValue == "未评价")){
            taxiStateQuery = TaxiList.findAllByTaxiState(0).id
        }else  if(params.querys == "4" && params.queryValue == "评价" ){
            taxiStateQuery = TaxiList.findAllByTaxiState(1).id
        }
        def query = {
            if(params.querys == "1"){
                like('taxiPhone',"%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like('phoneNum',"%"+params.queryValue+"%")
            }
            if(params.querys == "5"){
                like('evaluation',"%"+params.queryValue+"%")
            }
            if(params.querys == "6"){
                like('status',"%"+params.queryValue+"%")
            }
            if(params.querys == "7"){
                like('taxiStatus',"%"+params.queryValue+"%")
            }
            if(params.querys == "8"){
                like('licence',"%"+params.queryValue+"%")
            }
            if(stateQuery){
                'in'('id',stateQuery)
            }
            if(taxiStateQuery){
                'in'('id',taxiStateQuery)
            }
            order("time",'desc')
        }
       return[stateQuery:stateQuery,taxiStateQuery:taxiStateQuery,query:query]
    }
}
