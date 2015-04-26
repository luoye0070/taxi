package taxi

import com.sec.Person
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class TaxiService {

    def list(def params){

        def resultList = []
        def personId
        if(params.querys == "4"  && params.queryValue ){
            def person = Person.findAllByUsernameLike("%"+params.queryValue+"%")
            if(person){
                personId = person.id
            }
        }
        if(params.querys1 == "1"){
            def dateTime
            if(params.queryValue1){
                dateTime = params.queryValue1
            }else{
                dateTime = new Date().format("yyyy-MM-dd")
            }
            def list = TaxiState.list()
            list.each{
                if(dateTime == it.loginTime.format("yyyy-MM-dd") ) {
                    resultList += it.taxiPhone
                }
            }
        }else if(params.querys1 == "2"){
            def dateTime
            if(params.queryValue1){
                dateTime = params.queryValue1
            }else{
                dateTime = new Date().format("yyyy-MM-dd")
            }
            def allList = Taxi.list().taxiPhone
            def inList = []
            TaxiState.list().each{
                if(dateTime == it.loginTime.format("yyyy-MM-dd") ) {
                    inList += it.taxiPhone
                }
            }
            resultList = allList - inList
        }
        def query = {
            if(params.querys == "1"){
                like('licence',"%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like('name',"%"+params.queryValue+"%")
            }
            if(params.querys == "3"){
                like('taxiPhone',"%"+params.queryValue+"%")
            }
            if(params.querys == "4"){
                'in'('personId',personId)
            }
            if(params.querys1 == "1" && resultList){
                'in'('taxiPhone',resultList)
            }
            if(params.querys1 == "2" && resultList){
                'in'('taxiPhone',resultList)
            }
            if(SpringSecurityUtils.ifAllGranted("ROLE_USER")){
                def currentPerson = springSecurityService?.currentUser?.id
                eq('personId',currentPerson)
            }
            order("time","desc")
        }

        return [resultList: resultList, query: query]
    }
}
