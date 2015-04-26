package com.sec

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class PersonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService
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
        def person = springSecurityService?.currentUser
        def authorityId = PersonAuthority.findByPerson(person).authority.id
        def state = Authority.get(authorityId).state
        def authobj = Authority.findAllByStateLessThan(state)
        [authobj:authobj]

    }

    //验证用户名是否重复
    def  checkUserName(){
        def personobj = Person.findByUsername(params.username)
        if(personobj)
        {
            render false
        }
        else
        {
            render true
        }

    }

    //获取权限
    def authoritytree(){
        def person = springSecurityService?.currentUser
        def authorityId = PersonAuthority.findByPerson(person).authority.id
        def state = Authority.get(authorityId).state
        def authobj = Authority.findAllByStateLessThan(state)
        def relist = authobj?.collect{
            def stuts = false
            [
                    "id":it.id,
                    "text":it.authChinese,
                    "checked":stuts
            ]
        }
        render relist as JSON
    }

    def datajson(){
        params.offset = (params.rows as int) * ((params.page as int) - 1)
        params.max = params.rows as int

        def personList = Person.list(params)
        def relist = personList?.collect{
            def personObj = Person.get(it.id)
            def paobj = PersonAuthority.findAllByPerson(personObj)
            def enable
            if(it.enabled == true){
                enable = '是'
            }else{
                enable = '否'
            }
            [
                    "id":it.id,
                    "username":it.username,
                    "password":it.password,
                    "enabled":enable,
                    "authority":paobj?.authority?.authChinese
            ]
        }
        def info = [
                "rows":relist,
                "total":Person.count()
        ]
        render info as JSON
    }

    def test(){

    }
    def save() {
        def personInstance = new Person(params)
        def info
        def msg = "出错了！/n"
        if (!personInstance.save(flush: true)) {
            personInstance.errors.each {
                msg = msg + it
            }
            info = [result:false,msg:msg]
        }
        else
        {
            def personAuthorityInstance = new PersonAuthority()
            if(params.authority){
                personAuthorityInstance.authority = Authority.get(params.authority)
                personAuthorityInstance.person = personInstance
            }
            if (!personAuthorityInstance.save(flush: true)) {
                personAuthorityInstance.errors.each {
                    msg = msg + it
                }
                info = [result:false,msg:msg]
            }else{
                info = [result:true,msg:"恭喜你，保存成功！"]
            }
        }
        render info as JSON
    }
    def update(Long id, Long version) {
        def personInstance = Person.get(id)
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), id])
            redirect(action: "list")
            return
        }
        def info = []
        if(params.password){
            personInstance.password = params.password
        }
        if(params.enabled){
            personInstance.enabled = true
        }
        if(params.size() == 6){
            personInstance.enabled = false
        }
        if (!personInstance.save(flush: true)) {
            personInstance.errors.each {
                println it
            }
            info = [result: false,msg:"更新失败了！!"]
            render info as JSON
            return
        }
        else
        {
            def paobj =PersonAuthority.findAllByPerson(personInstance)
            paobj.each{
                it.delete(flush: true)
            }
            def personAuthorityObj = new PersonAuthority()
            personAuthorityObj.person = personInstance
            def authorityId
            if(params.authority){
                if(params.authority.size() == 1){
                    authorityId = Authority.get(params.authority)

                }else{
                    authorityId =Authority.findByAuthChinese(params.authority)
                }
                personAuthorityObj.authority = authorityId
                if(!personAuthorityObj.save(flush: true)){
                    personAuthorityObj.errors.each {
                        println it
                    }
                    info = [result: false,msg:"更新失败了！!"]
                    render info as JSON
                    return
                }
            }
            info = [result:true,msg:"恭喜你，更新成功！"]
            render info as JSON
        }
    }

    def delete(Long id) {

        def personInstance = Person.get(id),info = []
        if (!personInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }
        try {
            def personAuthorityInstance = PersonAuthority.findAllByPerson(personInstance)
            if(personAuthorityInstance){
                personAuthorityInstance.each{
                    it.delete(flush: true)
                }
                personInstance.delete(flush: true)
                info = [result: true,msg:"删除成功！"]
                render info as JSON
                return
                info = [result: true,msg:"删除成功！"]
                render info as JSON

            }
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false,msg:"出错了，删除失败！"]
            render info as JSON
        }
    }
}
