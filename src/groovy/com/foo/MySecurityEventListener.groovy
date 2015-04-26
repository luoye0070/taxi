package com.foo
import org.springframework.context.ApplicationListener
import org.springframework.security.authentication.event. AuthenticationSuccessEvent
import org.springframework.security.web.session.HttpSessionEventPublisher
import javax.servlet.http.HttpSessionEvent

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-8-16
 * Time: 下午12:27
 * Spring 安全控件登录成功事件
 */



class MySecurityEventListener extends HttpSessionEventPublisher implements ApplicationListener<AuthenticationSuccessEvent>{
    void onApplicationEvent(AuthenticationSuccessEvent event) {
       // handle the event

    }



    public void sessionCreated(HttpSessionEvent event) {

        System.out.print(event)
        // 将用户加入到在线用户列表中
    }






}