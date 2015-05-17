package website

import com.qq.weixin.mp.aes.Sign
import com.qq.weixin.mp.aes.WXBizMsgCrypt
import grails.converters.JSON
import lj.internet.AppConstant
import lj.internet.HttpConnectionHelper
import lj.wx.WxApiInfo
import org.springframework.dao.DataIntegrityViolationException
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource
import taxi.Customer
import taxi.Demand
import taxi.Invalidation
import taxi.Route

import javax.xml.parsers.DocumentBuilder
import javax.xml.parsers.DocumentBuilderFactory
import java.nio.charset.Charset
import java.text.SimpleDateFormat

class CustomerOfWebController {
    String appId = "wx3ebc66f5e756f12c";
    String appsecret="370b4e753d526da116c6c2cc3c9fdedf";
    String sToken = "7GkZrM";
    String sEncodingAESKey = "7AAEnI4gDXrpxpGWj0S6jZEGPdXmnYFyHx3pyzYYrFn";

    def index() {}

    def getOrCreateOrder(){
        println("url"+request.getRequestURL());
        def errors=null;
        def msgs=null;
        println "接收到的数据" + params
        def nickName=params.nickName;//从参数里面取,这里用微信帐号
        if(!nickName){//从session中取
            nickName=session.getAttribute("nickName");
        }
        if(!nickName){
            errors="用户信息缺失，请返回重试";
            render(view: "/demandRequest/request",model: [errors:errors,msgs:msgs]);
            return;
        }
        nickName=nickName.toString().trim();
        Customer customer=Customer.findByNickName(nickName);
        if(!customer){
            customer=new Customer();
            customer.nickName=nickName;
            customer.password="111111";
            customer.phoneNum="";
            if(!customer.save(flush: true)){
                errors=g.message(error: customer.errors.allErrors.get(0));
                render(view: "/demandRequest/request",model: [errors:errors,msgs:msgs]);
                return;
            }
        }
        session.setAttribute("nickName",nickName);

        def demand =null;
        //从session中获取phone
        String phoneNum=customer.phoneNum;
        if(phoneNum){
            demand = Demand.findByPhoneNum(phoneNum);
        }
        if(demand){//显示打车信息
            render(view: "/demandRequest/demand",model: [demandInstance:demand,errors:errors,msgs:msgs]);
        }else{//显示输入电话号码、加价、路线的界面
            demand =new Demand();
            demand.nickName=nickName;
            demand.phoneNum=phoneNum;

            //微信接口需要的数据
            String baseUrl= grailsApplication.config.grails.config.baseUrl;
            String request_url=createLink(controller: "customerOfWeb",action: "getOrCreateOrder",absolute: true,base: baseUrl);
            if(params.nickName){
                request_url+="?nickName="+params.nickName;
            }
            String appId=this.appId; // 必填，公众号的唯一标识
            String jsapi_ticket=WxApiInfo.getTicket(this.appId,this.appsecret);
            def signHash=Sign.sign(jsapi_ticket,request_url);
            String timestamp=signHash.get("timestamp"); // 必填，生成签名的时间戳
            String nonceStr=signHash.get("nonceStr"); // 必填，生成签名的随机串
            String signature=signHash.get("signature");// 必填，签名，见附录1

            render(view: "/demandRequest/request",model: [demandInstance:demand,errors:errors,msgs:msgs,appId:appId,timestamp:timestamp,nonceStr:nonceStr,signature:signature]);
        }
    }

    //发送打车请求
    def apply = {
        def errors=null;
        def msgs=null;
        println "接收到的数据" + params

        //将电话号码存入customer
        def nickName=params.nickName;//从参数里面取,这里用微信帐号
        if(!nickName){//从session中取
            nickName=session.getAttribute("nickName");
        }
        nickName=nickName.toString().trim();
        Customer customer=Customer.findByNickName(nickName);
        if(!customer){
            //flash.errors="用户信息缺失，请返回重试";
            redirect(action:  "getOrCreateOrder");
            return;
        }
        String phoneNum=params.phoneNum;
        if(!phoneNum){
            flash.errors="手机号不能为空，请填写手机号后重试";
            redirect(action:  "getOrCreateOrder");
            return;
        }
        customer.phoneNum=phoneNum?.trim();
        if(!customer.save(flush: true)){
            println(customer.errors.allErrors);
            flash.errors="乘车请求失败，请重试";
            redirect(action:  "getOrCreateOrder");
            return;
        }

        def demand = new Demand()
        def now = new Date();
        demand.serverTime = now
        demand.time = now;//params.time
        demand.nickName = params.nickName
        demand.filePath = params.filePath
        demand.latitude = Double.parseDouble(params.latitude)
        demand.longitude = Double.parseDouble(params.longitude)
        demand.hike = params.hike
        //demand.hike = 0
        long routeId=0;
        try{routeId=Long.parseLong(params.routeId);}catch (Exception ex){}
        Route route=Route.get(routeId);
        if(!route){
            println(customer.errors.allErrors);
            flash.errors="乘车请求失败，请选择路线后重试";
            redirect(action:  "getOrCreateOrder");
            return;
        }
        demand.route=route.name;
        demand.phoneNum=params.phoneNum;
        if(demand.save(flush: true)){
            //session.setAttribute("phone",params.phoneNum);
            flash.msgs="订单创建成功，等待司机抢单";
            redirect(action:  "getOrCreateOrder");
        }else {
            errors=g.message(error: demand.errors.allErrors.get(0));
            render(view: "/demandRequest/request",model: [demandInstance:demand,errors:errors,msgs:msgs]);
        }
    }

    //取消打车请求
    def cancel = {
        flash.errors="取消订单不成功，请重试";
        long id=0;
        try{
            id=Long.parseLong(params.id);
        }catch (Exception ex){}
        def demand = Demand.get(id);
        if (demand&&demand.state == 0)
        {
            try{
                def invalidation = new Invalidation()
                invalidation.phoneNum = demand.phoneNum
                invalidation.state = demand.state
                invalidation.latitude = demand.latitude
                invalidation.longitude = demand.longitude
                invalidation.time = demand.time
                invalidation.hike = demand.hike             /**  2013-12-2:12:20 **/
                if(!demand.delete(flush: true) && invalidation.save(flush: true)){
                    flash.msgs="订单已经成功取消";
                    flash.errors=null;
                }
            }catch(DataIntegrityViolationException e){

            }
        }
        redirect(action:  "getOrCreateOrder");
    }

    //微信接口
    def wxapi(){
        //公众平台上开发者设置的token, appID, EncodingAESKey
        String sToken = this.sToken;
        String sAppID = this.appId;
        String sEncodingAESKey = this.sEncodingAESKey;

        //获取微信发的消息
        //获取参数
        String msg_signature = params.signature;
        String timestamp = params.timestamp;
        String nonce = params.nonce;


        if ( !msg_signature ||  !timestamp ||  !nonce)
        {
            response.getWriter().print("failed by null");
            response.getWriter().flush();
            response.getWriter().close();
            return;
        }

       println("msg_signature->" + msg_signature + "||timestamp->" + timestamp + "||nonce->" + nonce);

        WXBizMsgCrypt wxcpt = new WXBizMsgCrypt(sToken, sEncodingAESKey, sAppID);

        if (request.method == "GET")
        {//验证接入
            String echostr = request.getParameter("echostr");
            //echostr="";
            println("echostr->" + echostr);
            if (wxcpt.VerifySignature(timestamp, nonce, msg_signature)==0) {//有效
                render(echostr);
                println("验证接入成功");
                return;
            }
            render("");
        }

        //读取消息
        byte[] buffer=new byte[1024];
        int length = 0;
        StringBuilder sb = new StringBuilder("");
        InputStream inputS=request.getInputStream();
        while ((length=inputS.read(buffer, 0, 1024)) >0)
        {
            String strTemp = new String(buffer,0,length,"UTF8");
            sb.append(strTemp);
        }

        String sReqData = sb.toString();
        println("sReqData-->"+sReqData);

        //解密数据
        String sMsg = "";  //解析之后的明文
        sMsg = sReqData;
        /*try{
            sMsg =wxcpt.decryptMsg(msg_signature, timestamp, nonce, sReqData);//解密
        }catch (Exception ex){
            render("ERR: Decrypt fail, ex: "+ex.message);
            println("ERR: Decrypt fail, ex: "+ex.message);
            return;
        }*/
        println("sMsg->"+sMsg);

        try
        {
            //解析数据
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            StringReader sr = new StringReader(sMsg);
            InputSource is = new InputSource(sr);
            Document document = db.parse(is);
            Element root = document.getDocumentElement();
            String FromUserName = root.getElementsByTagName("FromUserName").item(0).getTextContent();
            String  ToUserName = root.getElementsByTagName("ToUserName").item(0).getTextContent();
            String CreateTime = root.getElementsByTagName("CreateTime").item(0).getTextContent();

            String baseUrl= grailsApplication.config.grails.config.baseUrl;
            String reContent = "";
            String urlStr = createLink(controller: "customerOfWeb",action: "getOrCreateOrder",base: baseUrl,absolute: true).toString()+"?nickName="+FromUserName;
            String picUrl =baseUrl+"/images/dctp.jpg";
            String reItem = "<item>"+
                    "<Title><![CDATA[" + "谢谢关注" + "]]></Title>"+
                    "<Description><![CDATA[" + "点击进入乘车" + "]]></Description>"+
                    "<PicUrl><![CDATA[" + picUrl + "]]></PicUrl>"+
                    "<Url><![CDATA[" + urlStr + "]]></Url>"+
                    "</item>";
            reContent += reItem;
            //查询自动回复内容
            String reXmlOfCC = "<xml>"+
                    "<ToUserName><![CDATA[" + FromUserName + "]]></ToUserName>"+
                    "<FromUserName><![CDATA[" + ToUserName + "]]></FromUserName>"+
                    "<CreateTime>" + CreateTime + "</CreateTime>"+
                    "<MsgType><![CDATA[news]]></MsgType>"+
                    "<ArticleCount>" + 1 + "</ArticleCount>"+
                    "<Articles>" + reContent + ""+
                    "</Articles>"+
                    "<FuncFlag>0</FuncFlag>"+
                    "</xml>";

            String  MsgType = root.getElementsByTagName("MsgType").item(0).getTextContent();
            String reXml = "";
            if ("event" == MsgType){//事件消息类型
                String EventStr = root.getElementsByTagName("Event").item(0).getTextContent();//事件类型
                if ("subscribe" == EventStr)
                { //这里只处理添加关注事件
                    baseUrl= grailsApplication.config.grails.config.baseUrl;
                    reContent = "";
                    urlStr = "";
                    picUrl = baseUrl+"/images/dctp.jpg";
                    reItem = "<item>"+
                                     "<Title><![CDATA[" + "谢谢关注" + "]]></Title>"+
                                     "<Description><![CDATA[" + "谢谢关注,要打车请回复'乘车'" + "]]></Description>"+
                                     "<PicUrl><![CDATA[" + picUrl + "]]></PicUrl>"+
                                     "<Url><![CDATA[" + urlStr + "]]></Url>"+
                                     "</item>";
                    reContent += reItem;

                    //查询自动回复内容
                    reXml = "<xml>"+
                        "<ToUserName><![CDATA[" + FromUserName + "]]></ToUserName>"+
                        "<FromUserName><![CDATA[" +ToUserName  + "]]></FromUserName>"+
                        "<CreateTime>" + CreateTime + "</CreateTime>"+
                        "<MsgType><![CDATA[news]]></MsgType>"+
                        "<ArticleCount>" + 1 + "</ArticleCount>"+
                        "<Articles>" + reContent + ""+
                        "</Articles>"+
                        "<FuncFlag>0</FuncFlag>"+
                        "</xml>";
                }else if("CLICK" == EventStr){
                    String EventKeyStr = root.getElementsByTagName("EventKey").item(0).getTextContent();//
                    if("V1001_CHENG_CHE"==EventKeyStr){
                        reXml =reXmlOfCC;
                    }
                }
            }
            else if ("text" == MsgType){//文本消息类型，现在暂时只处理文本消息
                String Content = root.getElementsByTagName("Content").item(0).getTextContent();
                String keyword = Content.trim();
                if("乘车".equals(keyword)){//返回打车连接
                    //查询自动回复内容
                    reXml = reXmlOfCC;
                }
            }

            //返回消息
            println("reXml->" + reXml);

            String reEncryptMsg = ""; //xml格式的密文
            reEncryptMsg = reXml;
            //reEncryptMsg=wxcpt.encryptMsg(reXml, timestamp, nonce);
            println("reEncryptMsg->" + reEncryptMsg);
            render(reEncryptMsg);
        }
        catch (Exception ex)
        {
            println("ERR: " + ex.message);
            render("");//出错了，返回空串
        }
    }

    //创建菜单
    def createWxcd(){
        String appId = this.appId;
        String appsecret=this.appsecret;
       //获取access_token
       def url="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+appId+"&secret="+appsecret;
       String reMsg=url.toURL().getText("utf8");
       println("reMsg->"+reMsg);

       def reObj= JSON.parse(reMsg);
       String access_token=reObj.access_token;
       println("access_token->"+access_token);

       //添加菜单
      HttpConnectionHelper helper=new HttpConnectionHelper();
      ArrayList<HashMap<String, String>> paramList=new ArrayList<HashMap<String, String>>();
        HashMap<String, String> param1=new HashMap<String, String>();
        param1.put(AppConstant.HttpParamRe.PARAM_NAME,"access_token");
        param1.put(AppConstant.HttpParamRe.PARAM_VALUE,access_token);
        paramList.add(param1);

        String baseUrl= grailsApplication.config.grails.config.baseUrl;
        String urlStr = createLink(controller: "customerOfWeb",action: "getOrCreateOrder",base: baseUrl,absolute: true).toString()+"?nickName=111";
        String cdData="{\n" +
                "     \"button\":[\n" +
                "       {\t\n" +
                "          \"type\":\"click\",\n" +
                "          \"name\":\"乘车\",\n" +
                "          \"key\":\"V1001_CHENG_CHE\"\n" +
                "       }" +
                "       ]\n" +
                " }";

        helper.postData("https://api.weixin.qq.com/cgi-bin/menu/create",paramList,cdData);


    }
}
