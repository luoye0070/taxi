package taxi

import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class InvalidationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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
        def query = {
            if(params.querys == "1"){
                like('phoneNum',"%"+params.queryValue+"%")
            }
            order("time",'desc')
        }
        def taxiAdviceList = Invalidation.createCriteria().list(params,query)
        def count = taxiAdviceList.totalCount
        def demandList = taxiAdviceList?.collect {
            [
                    "id":it.id,
                    "latitude":it?.latitude,
                    "phoneNum":it?.phoneNum,
                    "longitude":it?.longitude,
                    "time":it?.time.format("yyyy-MM-dd HH:mm:ss")
            ]
        }
        def info = [
                "rows":demandList,
                "total":count
        ]
        render info as JSON
    }
    //导出excel表格
    def exportExcel(){
        def query = {
            if(params.querys == "1"){
                like('phoneNum',"%"+params.queryValue+"%")
            }
            order("time",'desc')
        }
        def excellist  = Invalidation.createCriteria().list(query)

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
            row.createCell((short)0).setCellValue("纬度"); //设置Excel工作表的值
            row.createCell((short)1).setCellValue("经度");
            row.createCell((short)2).setCellValue("乘客电话");
            row.createCell((short)3).setCellValue("时间");
        }
        int i = 1;
        for (it in excellist) {
            HSSFRow row = sheet.createRow((short) i);
            row.setHeightInPoints((short) 22)
            row.createCell((short) 0).setCellValue(it?.latitude);
            row.createCell((short) 1).setCellValue(it?.longitude);
            row.createCell((short) 2).setCellValue(it?.phoneNum);
            row.createCell((short) 3).setCellValue(it?.time?.format("yyyy-MM-dd HH:mm:ss"));
            i++
        }
        def filePath="E:\\aa"
        FileOutputStream fileOut = new FileOutputStream(filePath + "testque.xls");
        wb.write(fileOut);
        response.setHeader("Content-disposition", "attachment; filename=Invalidation.xls")     //导出的文件名
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
        def invalidationInstance = new Invalidation(params)
        def info
        def msg = "出错了！/n"
        if (!invalidationInstance.save(flush: true)) {
            invalidationInstance.errors.each {
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
        def invalidationInstance = Invalidation.get(id)
        def info = []
        if (!invalidationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'invalidation.label', default: 'Invalidation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (invalidationInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        invalidationInstance.properties = params

        if (!invalidationInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def invalidationInstance = Invalidation.get(id),info = []

        if (!invalidationInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            invalidationInstance.delete(flush: true)
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
