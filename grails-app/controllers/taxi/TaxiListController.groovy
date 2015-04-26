package taxi

import com.sec.Person
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class TaxiListController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def taxiListService
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
        def result = taxiListService.taxiListMethod(params)
        def taxiAdviceList = TaxiList.createCriteria().list(params,result?.query)
        def count = taxiAdviceList.totalCount
        if(result?.stateQuery == [] || result?.taxiStateQuery == []){
            taxiAdviceList = []
            count = 0
        }
        def demandList = taxiAdviceList?.collect {
            def state ,taxiState
            if(it.state == 1){
                state = "评价"
            }else{
                state = "未评价"
            }
            if(it.taxiState == 1){
                taxiState = "评价"
            }else{
                taxiState = "未评价"
            }
            [
                    "id":it.id,
                    "taxiPhone":it?.taxiPhone,
                    "phoneNum":it?.phoneNum,
                    "state":state,
                    "taxiState":taxiState,
                    "evaluation":it?.evaluation,
                    "status":it?.status,
                    "taxiStatus":it?.taxiStatus,
                    "licence":it?.licence,
                    "taxiTime":it?.taxiTime.format("yyyy-MM-dd HH:mm:ss"),
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
        def result = taxiListService.taxiListMethod(params)
        def excellist  = TaxiList.createCriteria().list(result?.query)
        if(result?.stateQuery == [] || result?.taxiStateQuery == []){
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
            row.createCell((short)0).setCellValue("司机电话"); //设置Excel工作表的值
            row.createCell((short)1).setCellValue("乘客电话");
            row.createCell((short)2).setCellValue("乘客评价状态");
            row.createCell((short)3).setCellValue("司机评价状态");
            row.createCell((short)4).setCellValue("服务情况");
            row.createCell((short)5).setCellValue("司机是否接人");
            row.createCell((short)6).setCellValue("是否诚信打车");
            row.createCell((short)7).setCellValue("司机车牌号");
            row.createCell((short)8).setCellValue("司机接受订单时间");
            row.createCell((short)9).setCellValue("乘客发起订单时间");
        }
        int i = 1;
        for (it in excellist) {
            HSSFRow row = sheet.createRow((short) i);
            row.setHeightInPoints((short) 22)
            row.createCell((short) 0).setCellValue(it?.taxiPhone);
            row.createCell((short) 1).setCellValue(it?.phoneNum);
            row.createCell((short) 2).setCellValue(it?.state?"评价":"未评价");
            row.createCell((short) 3).setCellValue(it?.taxiState?"评价":"未评价");
            row.createCell((short) 4).setCellValue(it?.evaluation);
            row.createCell((short) 5).setCellValue(it?.status);
            row.createCell((short) 6).setCellValue(it?.taxiStatus);
            row.createCell((short) 7).setCellValue(it?.licence);
            row.createCell((short) 8).setCellValue(it?.taxiTime?.format("yyyy-MM-dd HH:mm:ss"));
            row.createCell((short) 9).setCellValue(it?.time?.format("yyyy-MM-dd HH:mm:ss"));
            i++
        }
        def filePath="E:\\aa"
        FileOutputStream fileOut = new FileOutputStream(filePath + "testque.xls");
        wb.write(fileOut);
        response.setHeader("Content-disposition", "attachment; filename=taxiList.xls")     //导出的文件名
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
        def taxiListInstance = new TaxiList(params)
        def info
        def msg = "出错了！/n"
        if (!taxiListInstance.save(flush: true)) {
            taxiListInstance.errors.each {
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
        def taxiListInstance = TaxiList.get(id)
        def info = []
        if (!taxiListInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'taxiList.label', default: 'TaxiList'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (taxiListInstance.version > version) {
                info = [result: false,msg:"在保存之前记录已经被更改，更新失败了！"]
                render info as JSON
                return
            }
        }

        taxiListInstance.properties = params

        if (!taxiListInstance.save(flush: true)) {
            info = [result: false,msg:"更新失败了！"]
            render info as JSON
            return
        }
        info = [result: true,msg:"更新成功！"]
        render info as JSON
    }

    def delete(Long id) {

        def taxiListInstance = TaxiList.get(id),info = []

        if (!taxiListInstance) {
            info = [result: false,msg:"没有找到记录，删除失败！"]
            render info as JSON
            return
        }

        try {
            taxiListInstance.delete(flush: true)
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
