package android

import groovy.util.*

class PhoneAppVersionController {

    def taxiVersion = {
        def fileName = "taxiVersion.xml"
        def fileUrl = request.getRealPath("/")+"upDate"+"/"+fileName
        def parser = new XmlParser()
        def info = parser.parse(fileUrl)
        def appVerCode = info.app.verCode ['@value']
        def appVerName = info.app.verName ['@value']
        def appUpdateInfo = "${info.app[0].updateInfo[0].text()}"
        def appSize = info.app.apkSize ['@value']
        def phoneVersion = Integer.parseInt(params.myVersionCode)
        def webVersion = Integer.parseInt(appVerCode[0])
        def updateMessage = appVerName[0]+","+appUpdateInfo+","+appSize[0]
        if(phoneVersion >= webVersion){
            //服务器端版本号低于手机端版本号时不需要更新
            render "0"
        }else{
            //服务器端版本号高于手机端版本号时需要更新
            render updateMessage
        }

    }

    def taxiHelperVersion = {
        def fileName = "taxiHelperVersion.xml"
        def fileUrl = request.getRealPath("/")+"upDate"+"/"+fileName
        def parser = new XmlParser()
        def info = parser.parse(fileUrl)
        def appVerCode = info.app.verCode ['@value']
        def appVerName = info.app.verName ['@value']
        def appUpdateInfo = "${info.app[0].updateInfo[0].text()}"
        def appSize = info.app.apkSize ['@value']
        def phoneVersion = Integer.parseInt(params.myVersionCode)
        def webVersion = Integer.parseInt(appVerCode[0])
        def updateMessage = appVerName[0]+","+appUpdateInfo+","+appSize[0]
        if(phoneVersion >= webVersion){
            //服务器端版本号低于手机端版本号时不需要更新
            render "0"
        }else{
            //服务器端版本号高于手机端版本号时需要更新
            render updateMessage
        }

    }

}
