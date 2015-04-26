package taxi

import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.poifs.filesystem.POIFSFileSystem
import org.apache.poi.hssf.usermodel.HSSFSheet
import org.apache.poi.hssf.usermodel.HSSFRow
import org.apache.poi.hssf.usermodel.HSSFCell
/*import com.excelUtil
import  OnlineTest.Que
import  OnlineTest.QueDB*/
class ExcelController {

    def index() { }

    def daochu(){
        def query = {
            if(params.querys == "1"){
                like("nickName","%"+params.queryValue+"%")
            }
            if(params.querys == "2"){
                like("phoneNum","%"+params.queryValue+"%")
            }
            order("dateCreated","desc")
        }
        def excellist  = Customer.createCriteria().list(query)
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
            row.createCell((short)0).setCellValue("乘客昵称"); //设置Excel工作表的值
            row.createCell((short)1).setCellValue("乘客电话");
            row.createCell((short)2).setCellValue("乘客密码");
            row.createCell((short)3).setCellValue("注册时间");
        }
        int i = 1;
        for (it in excellist) {
            HSSFRow row = sheet.createRow((short) i);
            row.setHeightInPoints((short) 22)
            row.createCell((short) 0).setCellValue(it?.nickName);
            row.createCell((short) 1).setCellValue(it?.phoneNum);
            row.createCell((short) 2).setCellValue(it?.password);
            row.createCell((short) 3).setCellValue(it?.dateCreated?.format("yyyy-MM-dd HH:mm:ss"));
            i++
        }
        def filePath="E:\\aa"
        FileOutputStream fileOut = new FileOutputStream(filePath + "testque.xls");
        wb.write(fileOut);
        response.setHeader("Content-disposition", "attachment; filename=Customer.xls")     //导出的文件名
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



}