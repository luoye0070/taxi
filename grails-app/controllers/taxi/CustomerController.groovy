package taxi

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class CustomerController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def jasperService
    def springSecurityService
    def exportExcelService
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {

    }

    def create()
    {

    }

    def edit()
    {

    }

    //验证电话号码是否已被使用
    def checkPhone(){
        def personobj = Customer.findByPhoneNum(params.phoneNum)
        if(personobj)
        {
            render false
        }
        else
        {
            render true
        }
    }
    def datagrid(){

    }

    def datajson(){
        if(params.max){
            params.offset = (params.rows as int) * ((params.page as int) - 1)
            params.max = params.rows as int
        }else{
            params.max= 10
            params.offset = (params.rows as int) * ((params.page as int) - 1)
        }
        def query = {
            if(params.querys == "1"){
                like("nickName","%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like("phoneNum","%"+params.queryValue+"%")
            }
            order("dateCreated","desc")
        }
        def customerList = Customer.createCriteria().list (params,query)
        def customerListCount = customerList.totalCount
        def customerResult = customerList?.collect {
            [
                    "id":it?.id,
                    "nickName":it?.nickName,
                    "phoneNum":it?.phoneNum,
                    "password":it?.password,
                    "dateCreated":it?.dateCreated?.format("yyyy-MM-dd HH:mm:ss")
            ]
        }
        def info = [
                "rows":customerResult,
                "total":customerListCount
        ]
        render info as JSON
    }

    def save() {
        def customerInstance = new Customer(params)
        def info
        def msg = "出错了！/n"
        if (!customerInstance.save(flush: true)) {
            customerInstance.errors.each {
                msg = msg + it
            }
            info = [result:false,msg:msg]
        }
        else
        {
            info = [result:true,msg:"恭喜你，保存成功！"]
        }
        render info as JSON
    }


    def update(Long id, Long version) {
        def customerInstance = Customer.get(id)
        def info = []
        if (!customerInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'customer.label', default: 'Customer'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (customerInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        customerInstance.properties = params

        if (!customerInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {
        def customerInstance = Customer.get(id),info = []

        if (!customerInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            customerInstance.delete(flush: true)
            info = [result: true,msg:"删除成功！"]
            render info as JSON
            return
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false,msg:"出错了，删除失败！"]
            render info as JSON
        }
    }
}
