package springsec

import grails.converters.JSON
import com.sec.Person
import com.sec.PersonAuthority
import com.sec.Authority
import org.springframework.dao.DataIntegrityViolationException

class SystemManagerController {
    def springSecurityService
    def test() {
    }

    def clearCache()
    {
        springSecurityService.clearCachedRequestmaps()
        def info = [result:true,msg:"恭喜你，清除缓存成功！"]
        render info as JSON
    }

    def datagrid()
    {

    }

    def datajson(){
        params.offset = (params.rows as int) * ((params.page as int) - 1)
        params.max = params.rows as int

        def personobj = Person.list(params)

        def  relist = personobj.collect {
            def paobj = PersonAuthority.findAllByPerson(it)
            [
                    "id":it.id,
                    "username":it.username,
                    "password":it.password,
                    "enabled":it.enabled,
                    "accountExpired":it.accountExpired,
                    "accountLocked":it.accountLocked,
                    "passwordExpired":it.passwordExpired,
                    "authority":paobj.authority.authority
            ]
        }

        def info = [
                "rows":relist,
                "total":Person.count()
        ]
        render info as JSON
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
            params.authority.each{
                def paobj = new PersonAuthority()
                paobj.person = personInstance
                paobj.authority = (Authority.get(it))
                paobj.save(flush: true)
            }

            info = [result:true,msg:"恭喜你，保存成功！"]
        }
        render info as JSON
    }


    def update(Long id, Long version) {
        def personInstance = Person.get(id)
        def info = []
        if (!personInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'person.label', default: 'Person'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (personInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        personInstance.properties = params

        params.authority.each{
            def paobj = new PersonAuthority()
            paobj.person = personInstance
            paobj.authority = (Authority.get(it))
            paobj.save(flush: true)
        }

        if (!personInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def personInstance = Person.get(id),info = []

        if (!personInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            personInstance.delete(flush: true)
            info = [result: true,msg:"删除成功！"]
            render info as JSON
            return
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false,msg:"出错了，删除失败！"]
            render info as JSON
        }
    }



    def authoritytree()
    {
        def personobj = Person.get(params.id)
        def authobj = Authority.list()
        def personauthor =  PersonAuthority.findAllByPerson(personobj)?.authority?.authority
        def relist = authobj?.collect{
            def stuts = false
            if(personauthor)
            {
                personauthor.each{ aa->
                    if(it.authority == aa)
                        stuts = true
                }
            }
            [
                    "id":it.id,
                    "text":it.authority,
                    "checked":stuts
            ]
        }
        render relist as JSON
    }



    def resquestsfz()
    {
        println params
    }


    def testmap()
    {
//        def lst= [["id":1,"name":"na"],["id":2,"name":"na"],["id":3,"name":"na"],["id":4,"name":"na"]]
//
//        for (int i=0;i<lst.size();i++)
//        {
//            if(lst[i].id==2){
//                println "it="+lst[i]
//                lst.remove(lst[i])
//            }
//        }
    }

}
