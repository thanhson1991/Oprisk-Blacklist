import groovy.sql.Sql
import msb.platto.commons.Conf

import java.text.NumberFormat

class BiController {
    def dataSource
    def exportExcelService
    def biDisplay = {
        render (view:'/capitalCal/biManage')
    }
    def index = { }
    def searchBI = {
        def var_fromDate
        def var_toDate
        if (params.fromDate) {
            var_fromDate = Date.parse("dd/MM/yyyy", params.fromDate)
        }
        if (params.toDate) {
            var_toDate = Date.parse("dd/MM/yyyy", params.toDate).next()
        }
        def listBI = CalBI.createCriteria().list {
            'eq'('active_status', 1)
            'le'('biDate', var_toDate)
            'ge'('biDate', var_fromDate)
        }
        if(params.exportExcel=="ExportExcel"){

            def header
            def listContent = []
            //listContent<<header
            def biName,biDate,businessPoint,businessPointN4,businessPointNN4,rrhdCapital
            int i = 0
            listBI.each{
                i++
                biName=it.biName
                biDate = it.biDate
                businessPoint = it.businessPoint
                businessPointN4 = it.businessPointN4
                businessPointNN4 = it.businessPointNN4
                rrhdCapital = it.rrhdCapital

                header = [i,biName,biDate,businessPoint,businessPointN4,businessPointNN4,rrhdCapital]
                listContent<<header
            }


            def data
            data = exportExcelService.calBIDisplay(listContent)
//			// // println "DATA:"+data


            //File download
            response.setContentType("application/vnd.ms-excel")
            response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
            response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
        }

        render(view: '/capitalCal/biListDisplay', model: [listBI: listBI, params: params])
    }
    def detailBIDisplay = {
        def calBI = CalBI.get(params.id)
        def biId = calBI.id
        render (view:'/capitalCal/biManage',model:[param:calBI,biId:biId])
    }
    def biListDisplay = {
        def toDate,fromDate
        def today = new Date()
        toDate = DateUtil.formatDate(today)
        toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
        today.setMonth(today.month-1)
        fromDate = DateUtil.formatDate(today)
        fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')
        def listBI = CalBI.createCriteria().list {
                'eq' ('active_status',1)
                'le' ('biDate', toDate)
                'ge' ('biDate', fromDate)
        }
        render (view:'/capitalCal/biListDisplay',model:[listBI:listBI,params:params])
    }

    def saveCalBI = {
        //    println('aaaaaa')
        //NumberFormat nf = NumberFormat.getInstance(Locale.US)
        //    DecimalFormat df = new DecimalFormat("###,###.00")
        if(params.calBI){
            if(params.biDate){
                params.biDate = Date.parse("dd/MM/yyyy",params.biDate)
            }
        //    println(calculateBI(params).rrhdCapital)
            render (view:'/capitalCal/biManage',model:[param:calculateBI(params),biId:params.biId])
            return
        }
        if(params.addBIParam){
            def calBI = new CalBI(params)
        //    calBI.active_status = 1
            if(!params.businessPoint || !params.businessPointN4 || !params.businessPointNN4 || !params.rrhdCapital){
                flash.error = "Cần tính toán vốn trước khi lưu"
                render (view:'/capitalCal/biManage',model:[param:params])
                return
            }
            if(params.biDate){
                params.biDate = Date.parse("dd/MM/yyyy",params.biDate)
            }
            // Tính lại vốn trước khi lưu


/*            if(CalBI.findByBiDate(params.biDate)){
                flash.error = "Trùng ngày báo cáo"
                render (view:'/capitalCal/biManage',model:[param:params])
                return
            }*/
        //    calculateBI(params)
            calBI.properties = params
            calBI.active_status = 1
            if(calBI.save(flush: true)){
                //        println("bbbb")
                /*def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
                //        arrCc += ''
                sendEmailCalCap("CALCAP",arrTo,arrCc,"",""+calCapital.id+"","Tạo mới tính toán vốn","","")*/

                flash.message = "Anh/chị đã tạo mới thành công!"
                //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:biListDisplay)
                return
            }else{
                flash.error = "Anh/chị đã tạo mới thất bại!"
                //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:biListDisplay)
                return
            }
        }
        if(params.saveBIParam){
            def calBI = CalBI.get(params.biId)
        //    def oldCapVar = listValueChange(calCapital)


            // Tính lại vốn trước khi lưu

/*            if(CalBI.findByBiDate(params.biDate) && CalBI.findByBiDate(params.biDate) != calBI){
                flash.error = "Trùng ngày báo cáo"
                render (view:'/capitalCal/biManage',model:[param:params])
                return
            }*/
            if(params.biDate){
                params.biDate = Date.parse("dd/MM/yyyy",params.biDate)
            }
        //    calculateBI(params)
            calBI.properties = params
            if(calBI.save(flush: true)){
                /*def cTiet = ''
                def cTitle = ["Mã BIA","Năm","Năm 1","Năm 2","Năm 3","Lợi nhuận gộp năm 1","Lợi nhuận gộp năm 2",
                              "Lợi nhuận gộp năm 3","Hệ số Alpha BIA","Kết quả tính vốn theo BIA","Mã SA",
                              "Năm","Lợi nhuận lĩnh vực kinh doanh tài chính doanh nghiệp",
                              "Lợi nhuận lĩnh vực kinh doanh thị trường tài chính","Lợi nhuận lĩnh vực bán lẻ",
                              "Lợi nhuận lĩnh vực ngân hàng thương mại","Lợi nhuận lĩnh vực thanh toán",
                              "Lợi nhuận lĩnh vực kinh doanh dịch vụ đại lý","Lợi nhuận lĩnh vực quản lý tài sản",
                              "Lợi nhuận lĩnh vực kinh doanh môi giới bán lẻ","Beta 1","Beta 2","Beta 3","Beta 4",
                              "Beta 5","Beta 6","Beta 7","Beta 8","Kết quả tính toán vốn theo SA","Mã ASA","Năm",
                              "Lợi nhuận lĩnh vực kinh doanh tài chính doanh nghiệp",
                              "Lợi nhuận lĩnh vực kinh doanh thị trường tài chính",
                              "Lợi nhuận lĩnh vực kinh doanh cho vay và ứng trước",
                              "Lợi nhuận lĩnh vực kinh doanh cho vay và ứng trước NHTM",
                              "Lợi nhuận lĩnh vực thanh toán","Lợi nhuận lĩnh vực kinh doanh dịch vụ đại lý",
                              "Lợi nhuận lĩnh vực quản lý tài sản",
                              "Lợi nhuận lĩnh vực kinh doanh môi giới bán lẻ",
                              "Beta 1","Beta 2","Beta M",
                              "Beta 5","Beta 6","Beta 7","Beta 8","Kết quả tính toán vốn theo ASA"]
                def newCapVar = listValueChange(calCapital)
                for(int i = 0; i < oldCapVar.size();i++){

                    if(oldCapVar[i] != newCapVar[i]){
                        //       println(i)
                        cTiet += cTitle[i]+": " + oldCapVar[i] + " --> " +newCapVar[i] +"<br>"
                    }

                }
                if(cTiet == ''){
                    cTiet = "Không có thay đổi gì"
                }
                def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
                //        arrCc += ''
                sendEmailCalCap("CALCAP",arrTo,arrCc,cTiet,""+calCapital.id+"","Cập nhật tính toán vốn","","")*/

                flash.message = "Anh/chị đã cập nhật thành công!"
                //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:biListDisplay)
                return
            }else{
                flash.error = "Anh/chị đã cập nhật thất bại!"
                //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:biListDisplay)
                return
            }
        }
        if(params.delete){
            //    println(params.calId)
            def calBI = CalBI.get(params.biId)
            calBI.active_status = 0
            if(calBI.save(flush: true)){
                /*def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
                //        arrCc += ''
                sendEmailCalCap("CALCAP",arrTo,arrCc,"",""+calCapital.id+"","Xóa tính toán vốn","","")*/
                flash.message = "Anh/chị đã xóa thành công!"
                redirect (action:biListDisplay)
                return
            }else{
                flash.error = "Anh/chị đã xóa thất bại!"
                //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:biListDisplay)
                return
            }
        }
        if(params.exportExcelDetails=="exportExcelDetails"){

            def header
            def listContent = []
            //listContent<<header
            def calBI = CalBI.get(params.biId)
                header = [calBI.biName,DateUtil.formatDate(calBI.biDate),
                          calBI.profitIncomeNN4,calBI.profitIncomeN4,calBI.profitIncome,
                          calBI.profitCostNN4,calBI.profitCostN4,calBI.profitCost,
                          calBI.serviceIncomeNN4,calBI.serviceIncomeN4,calBI.serviceIncome,
                          calBI.serviceCostNN4,calBI.serviceCostN4,calBI.serviceCost,
                          calBI.anotherIncomeNN4,calBI.anotherIncomeN4,calBI.anotherIncome,
                          calBI.anotherCostNN4,calBI.anotherCostN4,calBI.anotherCost,
                          calBI.profitBusinessStockNN4,calBI.profitBusinessStockN4,calBI.profitBusinessStock,
                          calBI.profitBusinessInvestNN4,calBI.profitBusinessInvestN4,calBI.profitBusinessInvest,
                          calBI.businessPointNN4,calBI.businessPointN4,calBI.businessPoint,
                          calBI.rrhdCapital]
                listContent<<header

            def data
            data = exportExcelService.calBIDetails(listContent)
//			// // println "DATA:"+data


            //File download
            response.setContentType("application/vnd.ms-excel")
            response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
            response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )

            def biId = calBI.id
            render (view:'/capitalCal/biManage',model:[param:calBI,biId:biId])
            return
        }

    }
    def checkinputDate = {
        if(params.inputDate){
            params.inputDate = Date.parse("dd/MM/yyyy",params.inputDate)
        }
        if(CalBI.findByBiDate(params.inputDate)){
            render 0
            return
        }else {
            render 1
            return
        }
    }
    def checkinputDate2 = {
        if(params.inputDate){
            params.inputDate = Date.parse("dd/MM/yyyy",params.inputDate)
        }
        if(CalBI.findByBiDate(params.inputDate) && !CalBI.findByIdAndBiDate(Long.parseLong(params.biIDvar),params.inputDate)){
            render 0
            return
        }else {
            render 1
            return
        }
    }

    def calculateBI(def param){
        def sql = new Sql(dataSource)
        NumberFormat nf = NumberFormat.getInstance(Locale.US)


        param.profitIncome = nf.parse(param.profitIncome.toString())
        param.profitCost = nf.parse(param.profitCost.toString())
        param.serviceIncome = nf.parse(param.serviceIncome.toString())
        param.serviceCost = nf.parse(param.serviceCost.toString())
        param.anotherIncome = nf.parse(param.anotherIncome.toString())
        param.anotherCost = nf.parse(param.anotherCost.toString())
        param.profitBusinessStock = nf.parse(param.profitBusinessStock.toString())
        param.profitBusinessInvest = nf.parse(param.profitBusinessInvest.toString())
/*        param.businessPoint = Math.abs(param.profitIncome-param.profitCost)+
                param.serviceIncome+param.serviceCost+param.anotherIncome+
                param.anotherCost+Math.abs(param.profitBusinessStock)+Math.abs(param.profitBusinessInvest)*/
        def biFuncReturn = sql.rows("select bi_calResultFunction(?, ?, ?, ?, ?, ?, ?, ?) AS businessPoint",
                [param.profitIncome,param.profitCost,param.serviceIncome,param.serviceCost,
                 param.anotherIncome,param.anotherCost,param.profitBusinessStock,param.profitBusinessInvest])
        param.businessPoint = biFuncReturn["businessPoint"][0]

        param.profitIncomeN4 = nf.parse(param.profitIncomeN4.toString())
        param.profitCostN4 = nf.parse(param.profitCostN4.toString())
        param.serviceIncomeN4 = nf.parse(param.serviceIncomeN4.toString())
        param.serviceCostN4 = nf.parse(param.serviceCostN4.toString())
        param.anotherIncomeN4 = nf.parse(param.anotherIncomeN4.toString())
        param.anotherCostN4 = nf.parse(param.anotherCostN4.toString())
        param.profitBusinessStockN4 = nf.parse(param.profitBusinessStockN4.toString())
        param.profitBusinessInvestN4 = nf.parse(param.profitBusinessInvestN4.toString())
/*        param.businessPointN4 = Math.abs(param.profitIncomeN4-param.profitCostN4)+
                param.serviceIncomeN4+param.serviceCostN4+param.anotherIncomeN4+
                param.anotherCostN4+Math.abs(param.profitBusinessStockN4)+Math.abs(param.profitBusinessInvestN4)*/
        def biFuncReturn2 = sql.rows("select bi_calResultFunction(?, ?, ?, ?, ?, ?, ?, ?) AS businessPoint",
                [param.profitIncomeN4,param.profitCostN4,param.serviceIncomeN4,param.serviceCostN4,
                 param.anotherIncomeN4,param.anotherCostN4,param.profitBusinessStockN4,param.profitBusinessInvestN4])
        param.businessPointN4 = biFuncReturn2["businessPoint"][0]


        param.profitIncomeNN4 = nf.parse(param.profitIncomeNN4.toString())
        param.profitCostNN4 = nf.parse(param.profitCostNN4.toString())
        param.serviceIncomeNN4 = nf.parse(param.serviceIncomeNN4.toString())
        param.serviceCostNN4 = nf.parse(param.serviceCostNN4.toString())
        param.anotherIncomeNN4 = nf.parse(param.anotherIncomeNN4.toString())
        param.anotherCostNN4 = nf.parse(param.anotherCostNN4.toString())
        param.profitBusinessStockNN4 = nf.parse(param.profitBusinessStockNN4.toString())
        param.profitBusinessInvestNN4 = nf.parse(param.profitBusinessInvestNN4.toString())
/*        param.businessPointNN4 = Math.abs(param.profitIncomeNN4-param.profitCostNN4)+
                param.serviceIncomeNN4+param.serviceCostNN4+param.anotherIncomeNN4+
                param.anotherCostNN4+Math.abs(param.profitBusinessStockNN4)+Math.abs(param.profitBusinessInvestNN4)*/
        def biFuncReturn3 = sql.rows("select bi_calResultFunction(?, ?, ?, ?, ?, ?, ?, ?) AS businessPoint",
                [param.profitIncomeNN4,param.profitCostNN4,param.serviceIncomeNN4,param.serviceCostNN4,
                 param.anotherIncomeNN4,param.anotherCostNN4,param.profitBusinessStockNN4,param.profitBusinessInvestNN4])
        param.businessPointNN4 = biFuncReturn3["businessPoint"][0]

        def biTotalReturn = sql.rows("select bi_TotalFunction(?, ?, ?) AS rrhdCapital",
                [param.businessPoint,param.businessPointN4,param.businessPointNN4])
        param.rrhdCapital = biTotalReturn["rrhdCapital"][0]

/*        println('-------------------')
        println(param.businessPointNN4)
        println(param.businessPointN4)
        println(param.businessPoint)
        println(param.rrhdCapital)*/
        return param
    }
}
