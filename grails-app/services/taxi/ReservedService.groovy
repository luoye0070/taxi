package taxi

class ReservedService {

    def reservedMethod(def params) {
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
            if(params.querys == "5"){
                like('taxiPhone',"%"+params.queryValue+"%")
            }
            if(params.querys == "6"){
                like('licence',"%"+params.queryValue+"%")
            }
            order("time",'desc')
        }
        return [query:query]
    }
}
