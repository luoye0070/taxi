package loginLog

import com.OnlineListener
import springsec.Online

class OnlineService {

    def login() {
        if(OnlineListener.loginlist)
            println "loginlist:"+OnlineListener.loginlist
        def tmpStatus
        if(OnlineListener.cxtStart&&tmpStatus!=true)
        {
            tmpStatus = false == true
            def onlinelist = Online.findAllByStatus(true)
            onlinelist.each{
                it.status = false
                it.save(flush: true)
            }
            OnlineListener.cxtStart = false
            tmpStatus = false == false
        }


        if(OnlineListener.loginlist)
        {
            for(int i;i<OnlineListener.loginlist.size();i++)
            {
                def loguser = OnlineListener.loginlist.pop()
                if(loguser?.id)
                {
                    def logobj = new Online()
                    logobj.userid = loguser.id
                    logobj.ip = loguser.ip
                    logobj.status = true
                    if(!logobj.save(flush: true))
                        OnlineListener.loginlist.add(uid)
                }
            }
        }
        //Online.findByUseridAndStatus()
    }

    def logout()
    {
        if(OnlineListener.logoutlist)
         println "logoutlist:"+OnlineListener.logoutlist
        if(OnlineListener.logoutlist)
        {
            for(int i;i<OnlineListener.logoutlist.size();i++)
            {

                def loguser = OnlineListener.logoutlist.pop()
                if(loguser?.id)
                {
                    def logobj = Online.findByUseridAndStatus(loguser.id,true)
                    if(!logobj)
                        return
                    logobj.status = false
                    logobj.dateLogout = new Date()
                    if(!logobj.save(flush: true))
                        OnlineListener.logoutlist.add(uid)
                }
            }
        }
    }

    def systemStart()
    {

    }
}
