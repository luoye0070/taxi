package taxi

import com.sec.PersonAuthority
import com.sec.Person
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.converters.JSON

import java.text.SimpleDateFormat

class TaxiController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService
    def taxiService
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

    //验证车牌号的唯一性
    def checkLicence(){
        def licenceObj = Taxi.findByLicence(params.licence)
        if(licenceObj)
        {
            render false
        }
        else
        {
            render true
        }
    }
    //验证司机联系电话的唯一性
    def checkTaxiPhone(){
        def taxiPhoneObj = Taxi.findByTaxiPhone(params.taxiPhone)
        if(taxiPhoneObj)
        {
            render false
        }
        else
        {
            render true
        }
    }
    def datagrid(){

    }

    def datajson(){
        if(params.max){
            params.offset = (params.rows as int) * ((params.page as int) - 1)
            params.max = params.rows as int
        }else{
            params.max= 10
            params.offset = (params.rows as int) * ((params.page as int) - 1)
        }

        def personObj = null
        def personCount = 0

        def result = taxiService.list(params)
        personObj = Taxi.createCriteria().list(params,result?.query)
        personCount = personObj.totalCount
        if(!result.resultList && params.querys1 == "1"){
            personObj = []
            personCount = 0
        }
        if(!result.resultList && params.querys1 == "2"){
            personObj = []
            personCount = 0
        }
        def  relist = personObj.collect {
            def date = new Date().format("yyyy-MM-dd")
            def startTime  = date + " 00:00:00"
            def endTime = date + " 23:59:59"
            def smf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
            startTime = smf.parse(startTime)
            endTime = smf.parse(endTime)
            def state = TaxiState.findByTaxiPhoneAndLoginTimeBetween(it.taxiPhone,startTime,endTime)?.state
            if(state == 1){
                state = "在线"
            }else{
                state = "不在线"
            }
            def personInfo = Person.get(it?.personId)?.username
            [
                    "id":it.id,
                    "licence":it?.licence,
                    "password":it?.password,
                    "taxiPhone":it?.taxiPhone,
                    "name":it?.name,
                    "personId":personInfo,
                    "state":state,
                    "time":it?.time?.format("yyyy-MM-dd HH:mm:ss")
            ]
        }
        def info = [
                "rows":relist,
                "total":personCount
        ]
        render info as JSON
    }

    //导出
    def daochu(){
        def result = taxiService.list(params)
        def excellist  = Taxi.createCriteria().list(result?.query)
        if(!result.resultList && params.querys1 == "1"){
            excellist = []
        }
        if(!result.resultList && params.querys1 == "2"){
            excellist = []
        }
        HSSFWorkbook wb = new HSSFWorkbook();//创建Excel工作簿对象
        HSSFSheet sheet = wb.createSheet("工作表1");//创建Excel工作表对象

        int b = 0
        13.times {
            sheet.setColumnWidth((short)b,(short)4000);
            b++
        }

        if(!params.biaotou){
            HSSFRow row = sheet.createRow((short)0);
            row.setHeightInPoints((short)22)
            row.createCell((short)0).setCellValue("车号"); //设置Excel工作表的值
            row.createCell((short)1).setCellValue("密码");
            row.createCell((short)2).setCellValue("联系电话");
            row.createCell((short)3).setCellValue("姓名");
            row.createCell((short)4).setCellValue("在线状态");
            row.createCell((short)5).setCellValue("管理人员");
            row.createCell((short)6).setCellValue("注册时间");
        }
        int i = 1;
        for (it in excellist) {
            HSSFRow row = sheet.createRow((short) i);
            row.setHeightInPoints((short) 22)
            row.createCell((short) 0).setCellValue(it?.licence);
            row.createCell((short) 1).setCellValue(it?.password);
            row.createCell((short) 2).setCellValue(it?.taxiPhone);
            row.createCell((short) 3).setCellValue(it?.name);
            row.createCell((short) 4).setCellValue(TaxiState.findByTaxiPhone(it.taxiPhone)?.state?"在线":"不在线");
            row.createCell((short) 5).setCellValue(Person.get(it?.personId)?.username);
            row.createCell((short) 6).setCellValue(it?.time?.format("yyyy-MM-dd HH:mm:ss"));
            i++
        }
        def filePath="E:\\aa"
        FileOutputStream fileOut = new FileOutputStream(filePath + "testque.xls");
        wb.write(fileOut);
        response.setHeader("Content-disposition", "attachment; filename=Taxi.xls")     //导出的文件名
        response.contentType = "application/vnd.ms-excel"
        def out = response.outputStream
        def inputStream = new FileInputStream(filePath + "testque.xls")
        byte[] buffer = new byte[1024]
        int j = -1
        while ((j = inputStream.read(buffer)) != -1) {
            out.write(buffer, 0, j)
        }
        out.flush()
        out.close()
        inputStream.close()
    }
    def save() {
        def personId = springSecurityService.currentUser.id
        params.personId = personId
        params.time = new Date()
        params.password  = params.password
        def taxiInstance = new Taxi(params)
        def info
        def msg = "出错了！/n"
        if (!taxiInstance.save(flush: true)) {
            taxiInstance.errors.each {
                msg = msg + it
            }
            info = [result:false,msg:msg]
        }
        else
        {
            info = [result:true,msg:"恭喜你，保存成功！"]
        }
        render info as JSON
    }


    def update(Long id, Long version) {
        def taxiInstance = Taxi.get(id)
        def info = []
        if (!taxiInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxi.label', default: 'Taxi'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (taxiInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        taxiInstance.properties = params

        if (!taxiInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def taxiInstance = Taxi.get(id),info = []

        if (!taxiInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            taxiInstance.delete(flush: true)
            info = [result: true,msg:"删除成功！"]
            render info as JSON
            return
        }
        catch (DataIntegrityViolationException e) {
            info = [result: false,msg:"出错了，删除失败！"]
            render info as JSON
        }
    }
}
