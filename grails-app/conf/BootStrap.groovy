import com.sec.Person

class BootStrap {

    def init = { servletContext ->
        //new Person(username:"caipng",password:"123456",enabled:true,accountExpired:false,accountLocked:false,passwordExpired:false).save(flush:true)
    }
    def destroy = {
    }
}
