package com.sec

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class EasyTreeController {

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
                "rows":EasyTree.list(params),
                "total":EasyTree.count()
        ]
        render info as JSON
    }

    def save() {
        def easyTreeInstance = new EasyTree(params)
        def info
        def msg = "出错了！/n"
        if (!easyTreeInstance.save(flush: true)) {
            easyTreeInstance.errors.each {
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
        def easyTreeInstance = EasyTree.get(id)
        def info = []
        if (!easyTreeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'easyTree.label', default: 'EasyTree'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (easyTreeInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        easyTreeInstance.properties = params

        if (!easyTreeInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def easyTreeInstance = EasyTree.get(id),info = []

        if (!easyTreeInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            easyTreeInstance.delete(flush: true)
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
