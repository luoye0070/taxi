package springsec

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import com.sec.Person

class OnlineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {

    }

    def create() {

    }

    def edit() {

    }

    def datagrid() {

    }

    def datajson() {
        params.offset = (params.rows as int) * ((params.page as int) - 1)
        params.max = params.rows as int
        def onlinelist = Online.list(params)

        def relist = onlinelist.collect {
            [
                id:it.id,
                ip:it.ip,
                userid:Person.get(it.userid)?.username,
                dateCreated:it.dateCreated.format("yyyy-MM-dd HH:mm:ss"),
                dateLogout:it?.dateLogout?.format("yyyy-MM-dd HH:mm:ss"),
                status:it.status
            ]
        }
        def info = [
                "rows":relist,
                "total": Online.count()
        ]
        render info as JSON
    }

    def save() {
        def onlineInstance = new Online(params)
        def info
        def msg = "出错了！/n"
        if (!onlineInstance.save(flush: true)) {
            onlineInstance.errors.each {
                msg = msg + it
            }
            info = [result: false, msg: msg]
        }
        else {
            info = [result: true, msg: "恭喜你，保存成功！"]
        }
        render info as JSON
    }


    def update(Long id, Long version) {
        def onlineInstance = Online.get(id)
        def info = []
        if (!onlineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'online.label', default: 'Online'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (onlineInstance.version > version) {
                info = [result: false, msg: "在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        onlineInstance.properties = params

        if (!onlineInstance.save(flush: true)) {
            info = [result: false, msg: "更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true, msg: "更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def onlineInstance = Online.get(id), info = []

        if (!onlineInstance) {
            info = [result: false, msg: "没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            onlineInstance.delete(flush: true)
            info = [result: true, msg: "删除成功！"]
            render info as JSON
            return
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false, msg: "出错了，删除失败！"]
            render info as JSON
        }
    }
}
