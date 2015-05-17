package lj.wx

import grails.converters.JSON

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 15-5-17
 * Time: 下午1:17
 * To change this template use File | Settings | File Templates.
 */
class WxApiInfo {
    public static String access_token=null;
    public static int expires_in=0;
    public static Date getTime=null;

    public static String ticket=null;
    public static int ticket_expires_in=0;
    public static Date ticket_getTime=null;

    public static String getAccessToken(String appId,String appSecret){
        if(access_token&&getTime){
            Date now=new Date();
            Calendar calendar=Calendar.getInstance();
            calendar.setTime(getTime);
            calendar.add(Calendar.SECOND,expires_in-100);
            if(now.before(calendar.getTime())){
                return access_token;
            }
        }
        //获取token并保存
        getTime=new Date();
        //获取access_token
        def url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appId+"&secret="+appSecret;
        String reMsg=url.toURL().getText("utf8");
        println("WxApiInfo-reMsg->"+reMsg);

        def reObj= JSON.parse(reMsg);
        access_token=reObj.access_token;
        try {expires_in=Integer.parseInt(reObj.expires_in)}catch (Exception ex){}
        println("WxApiInfo-access_token->"+access_token);
        return access_token;
    }
    public static String getTicket(String appId,String appSecret){
        if(ticket&&ticket_getTime){
            Date now=new Date();
            Calendar calendar=Calendar.getInstance();
            calendar.setTime(ticket_getTime);
            calendar.add(Calendar.SECOND,ticket_expires_in-100);
            if(now.before(calendar.getTime())){
                return ticket;
            }
        }
        //获取ticket并保存
        ticket_getTime=new Date();
        //获取access_token
        getAccessToken(appId,appSecret);
        def url="https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+access_token+"&type=jsapi";
        String reMsg=url.toURL().getText("utf8");
        println("WxApiInfo-reMsg->"+reMsg);

        def reObj= JSON.parse(reMsg);
        ticket=reObj.ticket;
        try {ticket_expires_in=Integer.parseInt(reObj.expires_in)}catch (Exception ex){}
        println("WxApiInfo-ticket->"+ticket);
        return ticket;
    }
}
