package taxi

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class TaxiLocationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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

    def datagrid(){

    }

    def datajson(){
        params.offset = (params.rows as int) * ((params.page as int) - 1)
        params.max = params.rows as int
        def info = [
                "rows":TaxiLocation.list(params),
                "total":TaxiLocation.count()
        ]
        render info as JSON
    }

    def save() {
        def taxiLocationInstance = new TaxiLocation(params)
        def info
        def msg = "出错了！/n"
        if (!taxiLocationInstance.save(flush: true)) {
            taxiLocationInstance.errors.each {
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
        def taxiLocationInstance = TaxiLocation.get(id)
        def info = []
        if (!taxiLocationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxiLocation.label', default: 'TaxiLocation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (taxiLocationInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        taxiLocationInstance.properties = params

        if (!taxiLocationInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def taxiLocationInstance = TaxiLocation.get(id),info = []

        if (!taxiLocationInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            taxiLocationInstance.delete(flush: true)
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
