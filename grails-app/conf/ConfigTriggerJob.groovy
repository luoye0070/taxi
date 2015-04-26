import loginLog.OnlineService
import taxi.TaxiList

/*
* To change this template, choose Tools | Templates
* and open the template in the editor.
*/

/**
 *
 * @蔡平  在线统计的  定时器
 */

class ConfigTriggerJob {
    def concurrent = false  
    def OnlineService
    def getTriggers(){
        return config.grails.plugin.xyz.someTriggerConfig
    }
    def execute() {
        if (new Date().format("HH:mm") == "23:59"){
            def taxiList = TaxiList.findAllByTaxiState(0)
            taxiList.each{
                it.taxiState = 1
                it.taxiStatus = "诚信打车"
            }
        }

    }
}


