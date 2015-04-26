package taxi

import com.sec.Person
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class DemandController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def demandService
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
        def result = demandService.demandMethod(params)
        def taxiAdviceList = Demand.createCriteria().list(params,result?.query)
        def count = taxiAdviceList.totalCount
        if(result?.stateQuery == []){
            taxiAdviceList = []
            count = 0
        }

        def demandList = taxiAdviceList?.collect {
            def state
            if(it?.state == 1){
                state = "已接单"
            }else{
                state = "未接单"
            }
            [
                    "id":it.id,
                    "nickName":it?.nickName,
                    "phoneNum":it?.phoneNum,
                    "state":state,
                    "serverTime":it?.serverTime?.format("yyyy-MM-dd HH:mm:ss"),
                    "time":it?.time?.format("yyyy-MM-dd HH:mm:ss")
            ]
        }
        def info = [
                "rows":demandList,
                "total":count
        ]
        render info as JSON
    }

    //导出excel表
    def exportExcel(){
        def result = demandService.demandMethod(params)
        def excellist  = Demand.createCriteria().list(result?.query)
        if(result?.stateQuery == []){
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
            row.createCell((short)0).setCellValue("乘客昵称");
            row.createCell((short)1).setCellValue("乘客电话");
            row.createCell((short)2).setCellValue("请求状态");
            row.createCell((short)3).setCellValue("服务器时间");
            row.createCell((short)4).setCellValue("系统时间");
        }
        int i = 1;
        for (it in excellist) {
            HSSFRow row = sheet.createRow((short) i);
            row.setHeightInPoints((short) 22)
            row.createCell((short) 0).setCellValue(it?.nickName);
            row.createCell((short) 1).setCellValue(it?.phoneNum);
            row.createCell((short) 2).setCellValue(it?.state?"已接单":"未接单");
            row.createCell((short) 3).setCellValue(it?.serverTime?.format("yyyy-MM-dd HH:mm:ss"));
            row.createCell((short) 4).setCellValue(it?.time?.format("yyyy-MM-dd HH:mm:ss"));
            i++
        }
        def filePath="E:\\aa"
        FileOutputStream fileOut = new FileOutputStream(filePath + "testque.xls");
        wb.write(fileOut);
        response.setHeader("Content-disposition", "attachment; filename=Demand.xls")     //导出的文件名
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
        def demandInstance = new Demand(params)
        def info
        def msg = "出错了！/n"
        if (!demandInstance.save(flush: true)) {
            demandInstance.errors.each {
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
        def demandInstance = Demand.get(id)
        def info = []
        if (!demandInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'demand.label', default: 'Demand'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (demandInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        demandInstance.properties = params

        if (!demandInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def demandInstance = Demand.get(id),info = []

        if (!demandInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            demandInstance.delete(flush: true)
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
