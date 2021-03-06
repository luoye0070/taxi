package com;
import springsec.*;
import java.util.ArrayList;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestAttributeEvent;
import javax.servlet.ServletRequestAttributeListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionActivationListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Logger;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-7-17
 * Time: 下午5:37
 * To change this template use File | Settings | File Templates.
 */
public class OnlineListener implements ServletContextListener, ServletContextAttributeListener, HttpSessionListener, HttpSessionAttributeListener, HttpSessionActivationListener, HttpSessionBindingListener, ServletRequestListener, ServletRequestAttributeListener  {
    private static final Logger logger = Logger.getLogger(OnlineListener.class);
    public static ArrayList loginlist = new ArrayList();
    public static ArrayList logoutlist = new ArrayList();
    public static Boolean cxtStart;
    public OnlineListener() {

    }

    public void requestDestroyed(ServletRequestEvent arg0) {

    }

    /**
     * 向session里增加属性时调用
     */
    public void attributeAdded(HttpSessionBindingEvent evt) {
        HttpSession session = evt.getSession();
        if(!loginlist.contains(session.getAttribute("uid"))&&session.getAttribute("uid")!=null)
        {
            loginlist.add(session.getAttribute("uid"));
            System.out.print(loginlist);
        }
    }

    /**
     * 服务器初始化时调用
     */
    public void contextInitialized(ServletContextEvent evt) {
        logger.debug("服务器启动");
        cxtStart = true;
        System.out.print("启动了");
    }

    public void sessionDidActivate(HttpSessionEvent arg0) {
    }

    public void valueBound(HttpSessionBindingEvent arg0) {
    }

    public void attributeAdded(ServletContextAttributeEvent arg0) {
    }

    public void attributeRemoved(ServletContextAttributeEvent arg0) {
    }

    /**
     * session销毁
     */
    public void sessionDestroyed(HttpSessionEvent evt) {
        HttpSession session = evt.getSession();
        if(!loginlist.contains(session.getAttribute("uid")))
        {
            System.out.println("销毁："+session.getAttribute("uid"));
            logoutlist.add(session.getAttribute("uid"));
        }

    }

    public void attributeRemoved(HttpSessionBindingEvent arg0) {

    }

    public void attributeAdded(ServletRequestAttributeEvent evt) {
    }

    public void valueUnbound(HttpSessionBindingEvent arg0) {
    }

    public void sessionWillPassivate(HttpSessionEvent arg0) {
    }

    public void sessionCreated(HttpSessionEvent arg0) {

    }

    public void attributeReplaced(HttpSessionBindingEvent arg0) {

    }

    public void attributeReplaced(ServletContextAttributeEvent arg0) {
    }

    public void attributeRemoved(ServletRequestAttributeEvent arg0) {
    }

    public void contextDestroyed(ServletContextEvent evt) {
        logger.debug("服务器关闭");
        System.out.print("服务器关闭");
    }

    public void attributeReplaced(ServletRequestAttributeEvent arg0) {
    }

    public void requestInitialized(ServletRequestEvent arg0) {
    }
}
