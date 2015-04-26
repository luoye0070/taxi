package com.sec

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class AuthorityController {

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
                "rows":Authority.list(params),
                "total":Authority.count()
        ]
        render info as JSON
    }

    def save() {
        def authorityInstance = new Authority(params)
        def info
        def msg = "出错了！/n"
        if (!authorityInstance.save(flush: true)) {
            authorityInstance.errors.each {
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
        def authorityInstance = Authority.get(id)
        def info = []
        if (!authorityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'authority.label', default: 'Authority'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (authorityInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        authorityInstance.properties = params

        if (!authorityInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def authorityInstance = Authority.get(id),info = []

        if (!authorityInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            authorityInstance.delete(flush: true)
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
