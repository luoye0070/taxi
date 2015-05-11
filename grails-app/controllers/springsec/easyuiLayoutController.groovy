package springsec

import com.sec.Authority
import com.sec.PersonAuthority
import grails.converters.JSON
import com.sec.EasyTree
import com.sec.Person
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils


class easyuiLayoutController {
    def springSecurityService
    def OnlineService
    def SpringSecurityUtils
    def index() {

    }

    def center() {

    }

    def mens() {

    }

    def north() {

    }


    def east() {
        OnlineService.login()
        if(params.id)
        {
            def easyobj = Online.findAllByStatus(true)
            def relist = easyobj?.collect{
                [
                        "id":it.id,
                        "username":Person.get(it.userid)?.username,
                        "dateCreated":it.dateCreated.format("yyyy-MM-dd HH:mm:ss"),
                        "ip":it.ip
                ]
            }
            render relist as JSON
        }
    }

    def west() {

    }

    def centerson() {

    }

    def ctrltree() {
        def personId = springSecurityService?.currentUser?.id
        def personObj = Person.get(personId)
        def authority = PersonAuthority.findAllByPerson(personObj).authority.id
        def userRole = Authority.findAllByIdInList(authority).authority
        def easyobj=[]
//        def easyobj
        if (!params.id)
        {
            userRole.each{
                easyobj+= EasyTree.findAllByUserRoleLike("%"+it+"%")
            }
            easyobj = easyobj.unique()
//          easyobj = EasyTree.findAllByPid(0)
        } else{
            easyobj = EasyTree.findAllByPid(params.id)
        }
        def relist = easyobj?.collect {
            [
                    "id": it.id,
                    "text": it.text,
                    "state": it.state,
                    "attributes": it.attributes,
                    "pid": it.pid,
                    "userRole": it.userRole
            ]
        }
        println(relist);
        render relist as JSON
    }




    def savetree() {
        params.userRole = params.userRole.toString() - "["-"]"

        def treeobj = new EasyTree(), info
        treeobj.text = params.text
        treeobj.attributes = params.attributes
        treeobj.state = "open"
        treeobj.userRole = params.userRole
        if (!params.pid)
            treeobj.pid = 0
        else
            treeobj.pid = params.pid as long

        if (!treeobj.save(flush: true)) {
            treeobj.errors.each {
                msg = msg + it
            }
            info = [result: false, msg: msg]
        } else {
            def easyold = EasyTree.get(treeobj.pid)
            if (easyold) {
                easyold.state = "closed"
                if (!easyold.save(flush: true)) {
                    easyold.errors.each {
                        msg = msg + it
                    }
                    info = [result: false, msg: msg]
                } else {
                    info = [result: true, msg: "恭喜你，保存成功！"]
                }
            } else {
                info = [result: true, msg: "恭喜你，保存成功！"]
            }
        }

        render info as JSON
    }

    def edittree() {
        params.userRole = params.userRole.toString() - "["-"]"
        def msg = " "
        def treeobj = EasyTree.get(params.id), info
        treeobj.text = params.text
        treeobj.attributes = params.attributes
        treeobj.userRole = params.userRole
        if (!params.pid)
            treeobj.pid = 0
        else
            treeobj.pid = params.pid as long

        if (!treeobj.save(flush: true)) {
            treeobj.errors.each {
                msg = msg + it
            }
            info = [result: false, msg: msg]
        } else {

            def easyold = EasyTree.get(treeobj.pid)
            if (easyold) {
                easyold.state = "closed"
                if (!easyold.save(flush: true)) {
                    easyold.errors.each {
                        msg = msg + it
                    }
                    info = [result: false, msg: msg]
                } else {
                    info = [result: true, msg: "恭喜你，保存成功！"]
                }
            } else {
                info = [result: true, msg: "恭喜你，保存成功！"]
            }

        }

        render info as JSON
    }


    def deletetree() {
        def msg, info
        if (!EasyTree.findByPid(params.id)) {
            def treeobj = EasyTree.get(params.id)
            if (!treeobj.delete(flush: true)) {
                msg = "删除成功"
                info = [result: true, msg: msg, id: params.id]
            } else {
                msg = "删除失败！"
                info = [result: false, msg: msg]
            }
        } else {
            msg = "有子节点不能删除，请先删除子节点！"
            info = [result: false, msg: msg]
        }
        render info as JSON
    }

    def mencurd() {

    }


    def mencurdtest()
    {

    }

    def authoritytree()
    { def relist
        if (params.id){
            def etobj = EasyTree.get(params.id)
            println etobj.userRole
            def authobj = Authority.list()
            relist = authobj?.collect{
                def stuts = false
                if(etobj?.userRole)
                {
                    if(etobj.userRole.contains(it.authority))
                        stuts = true
                }
                [
                        "id":it.authority,
                        "text":it.authority,
                        "checked":stuts
                ]
            }
        }
        else{
            def authobj = Authority.list()
            relist = authobj?.collect{
                def stuts = false
                [
                        "id":it.authority,
                        "text":it.authority,
                        "checked":stuts
                ]
            }
        }
        println("relist->"+relist);
        render relist as JSON
    }




}
