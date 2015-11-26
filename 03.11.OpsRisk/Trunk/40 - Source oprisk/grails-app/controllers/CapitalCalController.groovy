import groovy.sql.Sql
import msb.platto.commons.Conf
import java.text.MessageFormat
import java.text.NumberFormat

class CapitalCalController {
    def dataSource
    def exportExcelService
    def index = { }
    def capitalDisplay = {
        render (view:'/capitalCal/addCapital')
    }
    def saveCapital = {
    //    println('aaaaaa')
    //    NumberFormat nf = NumberFormat.getInstance(Locale.US)
    //    DecimalFormat df = new DecimalFormat("###,###.00")
        if(params.calCapitalB){
            if(params.bia_year){
                params.bia_year = Date.parse("dd/MM/yyyy",params.bia_year)
            }
            if(params.bia_year1){
                params.bia_year1 = Date.parse("dd/MM/yyyy",params.bia_year1)
            }
            if(params.bia_year2){
                params.bia_year2 = Date.parse("dd/MM/yyyy",params.bia_year2)
            }
            if(params.bia_year3){
                params.bia_year3 = Date.parse("dd/MM/yyyy",params.bia_year3)
            }
            if(params.sa_year){
                params.sa_year = Date.parse("dd/MM/yyyy",params.sa_year)
            }
            if(params.asa_year){
                params.asa_year = Date.parse("dd/MM/yyyy",params.asa_year)
            }
            params.id = params.calId
        //    println(params.asa_calResult)
            render (view:'/capitalCal/addCapital',model:[param:calculateGI(params)])
            return
        }
        if(params.addNewCal){
            def calCapital = new CapitalCal(params)
            calCapital.active_status = 1
            if(!params.bia_calResult || !params.sa_calResult || !params.asa_calResult){
                flash.error = "Cần tính toán vốn trước khi lưu"
                render (view:'/capitalCal/addCapital',model:[param:params])
                return
            }
            // Tính lại vốn trước khi lưu
/*            NumberFormat nf = NumberFormat.getInstance(Locale.US);
            DecimalFormat df = new DecimalFormat("###,###.00")*/
        //    calculateGI(params)
            calCapital.properties = params
            if(calCapital.save(flush: true)){
        //        println("bbbb")
                /*def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
        //        arrCc += ''
                sendEmailCalCap("CALCAP",arrTo,arrCc,"",""+calCapital.id+"","Tạo mới tính toán vốn","","")*/

                flash.message = "Anh/chị đã tạo mới thành công!"
            //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:capitalListDisplay)
                return
            }else{
                flash.error = "Anh/chị đã tạo mới thất bại!"
            //    render (view:'/capitalCal/addCapital',model:[param:calCapital])
                redirect (action:capitalListDisplay)
                return
            }
        }
        if(params.saveEditCal){
            def calCapital = CapitalCal.get(params.calId)
        //    def oldCapVar = listValueChange(calCapital)


            // Tính lại vốn trước khi lưu
/*            NumberFormat nf = NumberFormat.getInstance(Locale.US);
            DecimalFormat df = new DecimalFormat("###,###.00")*/

        //    calculateGI(params)
            calCapital.properties = params
            if(calCapital.save(flush: true)){
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
                redirect (action:capitalListDisplay)
                return
            }
        }
        if(params.delete){
        //    println(params.calId)
            def calCapital = CapitalCal.get(params.calId)
            calCapital.active_status = 0
            if(calCapital.save(flush: true)){
                /*def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
                //        arrCc += ''
                sendEmailCalCap("CALCAP",arrTo,arrCc,"",""+calCapital.id+"","Xóa tính toán vốn","","")*/
                flash.message = "Anh/chị đã xóa thành công!"
                redirect (action:capitalListDisplay)
                return
            }
        }

    }
    def calculateGI(def param){
        def sql = new Sql(dataSource)
/*        int bia_count = 0
        def var_bia_profit1
        def var_bia_profit2
        def var_bia_profit3*/
        NumberFormat nf = NumberFormat.getInstance(Locale.US)


        param.bia_alpha = nf.parse(param.bia_alpha)
        param.bia_profit1 = nf.parse(param.bia_profit1)
        param.bia_profit2 = nf.parse(param.bia_profit2)
        param.bia_profit3 = nf.parse(param.bia_profit3)

        def functionReturn = sql.rows("select bia_calResultFunction(?, ?, ?, ?, ?) AS bia_calResult", [param.bia_profit1, param.bia_profit2, param.bia_profit3,param.bia_alpha, 0])
        param.bia_calResult = nf.format(functionReturn["bia_calResult"][0])
        /*if(param.bia_profit1 > 0){
            bia_count++
            var_bia_profit1 = param.bia_profit1
        }else{
            var_bia_profit1 = 0
        }
        if(param.bia_profit2 > 0){
            bia_count++
            var_bia_profit2 = param.bia_profit2
        }else{
            var_bia_profit2 = 0
        }
        if(param.bia_profit3 > 0){
            bia_count++
            var_bia_profit3 = param.bia_profit3
        }else{
            var_bia_profit3 = 0
        }

        if(bia_count>0){
            def functionReturn = sql.rows("select bia_calResultFunction(?, ?, ?, ?, ?) AS bia_calResult", [var_bia_profit1, var_bia_profit2, var_bia_profit3, param.bia_alpha,bia_count])
            param.bia_calResult = nf.format(functionReturn["bia_calResult"][0])
        }else{
            param.bia_calResult = 0
        }*/

        param.sa_businessProfit = nf.parse(param.sa_businessProfit)
        param.sa_financialProfit = nf.parse(param.sa_financialProfit)
        param.sa_retailProfit = nf.parse(param.sa_retailProfit)
        param.sa_bankProfit = nf.parse(param.sa_bankProfit)
        param.sa_paymentsProfit = nf.parse(param.sa_paymentsProfit)
        param.sa_serviceProfit = nf.parse(param.sa_serviceProfit)
        param.sa_assetsProfit = nf.parse(param.sa_assetsProfit)
        param.sa_agencyProfit = nf.parse(param.sa_agencyProfit)
        param.sa_beta1 = nf.parse(param.sa_beta1)
        param.sa_beta2 = nf.parse(param.sa_beta2)
        param.sa_beta3 = nf.parse(param.sa_beta3)
        param.sa_beta4 = nf.parse(param.sa_beta4)
        param.sa_beta5 = nf.parse(param.sa_beta5)
        param.sa_beta6 = nf.parse(param.sa_beta6)
        param.sa_beta7 = nf.parse(param.sa_beta7)
        param.sa_beta8 = nf.parse(param.sa_beta8)
        /*param.sa_calResult = ((param.sa_businessProfit * param.sa_beta1)+
                (param.sa_financialProfit * param.sa_beta2)+
                (param.sa_retailProfit * param.sa_beta3)+
                (param.sa_bankProfit * param.sa_beta4)+
                (param.sa_paymentsProfit * param.sa_beta5)+
                (param.sa_serviceProfit * param.sa_beta6)+
                (param.sa_assetsProfit * param.sa_beta7)+
                (param.sa_agencyProfit * param.sa_beta8))*/
        def functionReturn2 = sql.rows("select sa_calResultFunction(?, ?, ?, ?,?, ?, ?, ?,?, ?, ?, ?,?, ?, ?, ?) as sa_calResult",
                [param.sa_businessProfit,param.sa_beta1,param.sa_financialProfit,param.sa_beta2,
                 param.sa_retailProfit,param.sa_beta3,
                 param.sa_bankProfit,param.sa_beta4,param.sa_paymentsProfit,param.sa_beta5,
                 param.sa_serviceProfit,param.sa_beta6,param.sa_assetsProfit,param.sa_beta7,
                 param.sa_agencyProfit,param.sa_beta8])
    //    println("bbbbb"+functionReturn2)
        param.sa_calResult = nf.format(functionReturn2["sa_calResult"][0])

        param.asa_businessProfit = nf.parse(param.asa_businessProfit)
        param.asa_financialProfit = nf.parse(param.asa_financialProfit)
        param.asa_loanPropfit = nf.parse(param.asa_loanPropfit)
        param.asa_loanBankProfit = nf.parse(param.asa_loanBankProfit)
        param.asa_paymentProfit = nf.parse(param.asa_paymentProfit)
        param.asa_serviceProfit = nf.parse(param.asa_serviceProfit)
        param.asa_assetsProfit = nf.parse(param.asa_assetsProfit)
        param.asa_retailProfit = nf.parse(param.asa_retailProfit)
        param.asa_beta1 = nf.parse(param.asa_beta1)
        param.asa_beta2 = nf.parse(param.asa_beta2)
        param.asa_m = nf.parse(param.asa_m)
        param.asa_beta5 = nf.parse(param.asa_beta5)
        param.asa_beta6 = nf.parse(param.asa_beta6)
        param.asa_beta7 = nf.parse(param.asa_beta7)
        param.asa_beta8 = nf.parse(param.asa_beta8)
        /*param.asa_calResult = ((param.asa_businessProfit * param.asa_beta1)+
                (param.asa_financialProfit * param.asa_beta2)+
                (param.asa_loanPropfit * param.asa_m * param.sa_beta3)+
                (param.asa_loanBankProfit * param.asa_m * param.sa_beta4)+
                (param.asa_paymentProfit * param.asa_beta5)+
                (param.asa_serviceProfit * param.asa_beta6)+
                (param.asa_assetsProfit * param.asa_beta7)+
                (param.asa_retailProfit * param.asa_beta8))*/

        def functionReturn3 = sql.rows("select asa_calResultFunction(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) as asa_calResult",
                [param.asa_businessProfit,param.asa_beta1,param.asa_financialProfit,param.asa_beta2,
                 param.asa_loanPropfit,param.asa_m,param.sa_beta3,
                 param.asa_loanBankProfit,param.sa_beta4,param.asa_paymentProfit,param.asa_beta5,
                 param.asa_serviceProfit,param.asa_beta6,param.asa_assetsProfit,param.asa_beta7,
                 param.asa_retailProfit,param.asa_beta8])
    //    println("aaaaa"+functionReturn3)
        param.asa_calResult = nf.format(functionReturn3["asa_calResult"][0])

        return param
    }
    def listValueChange(CapitalCal cc){
        def ccrt = new ArrayList()
        ccrt << cc.biaCode
        ccrt << cc.bia_year
        ccrt << cc.bia_year1
        ccrt << cc.bia_year2
        ccrt << cc.bia_year3
        ccrt << cc.bia_profit1
        ccrt << cc.bia_profit2
        ccrt << cc.bia_profit3
        ccrt << cc.bia_alpha
        ccrt << cc.bia_calResult

        ccrt << cc.saCode
        ccrt << cc.sa_year
        ccrt << cc.sa_businessProfit
        ccrt << cc.sa_financialProfit
        ccrt << cc.sa_retailProfit
        ccrt << cc.sa_bankProfit
        ccrt << cc.sa_paymentsProfit
        ccrt << cc.sa_serviceProfit
        ccrt << cc.sa_assetsProfit
        ccrt << cc.sa_agencyProfit
        ccrt << cc.sa_beta1
        ccrt << cc.sa_beta2
        ccrt << cc.sa_beta3
        ccrt << cc.sa_beta4
        ccrt << cc.sa_beta5
        ccrt << cc.sa_beta6
        ccrt << cc.sa_beta7
        ccrt << cc.sa_beta8
        ccrt << cc.sa_calResult

        ccrt << cc.asaCode
        ccrt << cc.asa_year
        ccrt << cc.asa_businessProfit
        ccrt << cc.asa_financialProfit
        ccrt << cc.asa_loanPropfit
        ccrt << cc.asa_loanBankProfit
        ccrt << cc.asa_paymentProfit
        ccrt << cc.asa_serviceProfit
        ccrt << cc.asa_assetsProfit
        ccrt << cc.asa_retailProfit
        ccrt << cc.asa_beta1
        ccrt << cc.asa_beta2
        ccrt << cc.asa_m
        ccrt << cc.asa_beta5
        ccrt << cc.asa_beta6
        ccrt << cc.asa_beta7
        ccrt << cc.asa_beta8
        ccrt << cc.asa_calResult

        return ccrt
    }

    def capitalListDisplay = {
        def thisYear = new Date()
        def firstDayofYear = '1/1/'+ thisYear.getAt(Calendar.YEAR)
        def lastDayofYear = '31/12/'+ thisYear.getAt(Calendar.YEAR)
        firstDayofYear = Date.parse("dd/MM/yyyy",firstDayofYear)
        lastDayofYear = Date.parse("dd/MM/yyyy",lastDayofYear)
    //    println(thisYear)
        def listCap = CapitalCal.createCriteria().list {
            'eq' ('active_status','1')
                'between' ('bia_year',firstDayofYear, lastDayofYear)
        }
        render (view:'/capitalCal/capitalListDisplay',model:[listCap:listCap,params:params])
    }
    def searchCapital = {
        def firstDayofYear = '1/1/'+ params.capital_year
        def lastDayofYear = '31/12/'+ params.capital_year
        firstDayofYear = Date.parse("dd/MM/yyyy",firstDayofYear)
        lastDayofYear = Date.parse("dd/MM/yyyy",lastDayofYear)

        def listCap = CapitalCal.createCriteria().list {
            'eq' ('active_status','1')
            if(params.capital_year){
                'between' ('bia_year',firstDayofYear,lastDayofYear)
            }
        }

        if(params.exportExcel=="ExportExcel"){

            def header //= ['Mã KRI','Mã/Tên rủi ro','Tiêu đề KRI','Tấn suất theo dõi','Loại KRI','NHCD/Khối','CN/TT/Phòng','PGD/Phòng ban/Tổ nhóm','Trạng thái','Nguồn số liệu']
            def listContent = []
            //listContent<<header
            def bia_year,bia_calResult,sa_calResult,asa_calResult
            int i = 0
            listCap.each{
                i++
                bia_year=it.bia_year
                bia_calResult = it.bia_calResult
                sa_calResult = it.sa_calResult
                asa_calResult = it.asa_calResult
                header = [i,bia_year,bia_calResult,sa_calResult,asa_calResult]
                listContent<<header
            }


            def data
            data = exportExcelService.capitalCalDisplay(listContent)
//			// // println "DATA:"+data


            //File download
            response.setContentType("application/vnd.ms-excel")
            response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
            response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
        }
        render (view:'/capitalCal/capitalListDisplay',model:[listCap:listCap])
    }
    def viewCapDetails = {
        def capDetails = CapitalCal.get(params.id)
        render (view:'/capitalCal/addCapital',model:[param:capDetails])
    }
    def sendEmailCalCap(String code,def to, def cc,String CTLoi,String Id,String action,String Ykien,String nameStatus){
        if(ErrorMail.findByCode('Check').enableSendEmail=='Y'){
            def to2 = [],to3 = []
            def cc2 = [],cc3 = []
            cc2 = cc
            to2 = to

            for(int i=0;i<to2.size();i++){
                to3[i] = to2[i]
            }
            for(int i=0;i<cc2.size();i++){
                cc3[i] = cc2[i]
            }
            def errorMail = ErrorMail.findByCode(code)
            if(errorMail.enableSendEmail=='Y'){
                def content = MessageFormat.format(errorMail.content, [action,CTLoi,Id].toArray())
                def subject = MessageFormat.format(errorMail.subject, [Id,action,''].toArray())
                sendMail(to3,content,cc3,subject)
            }
        }
    }
    def sendMail(def toEmail, String htmlContent,def ccEmail,String sub){
        sendMail {
            multipart true
            from new String("qlrr_oprisk@msb.com.vn")
//			to new String(toEmail)
            to toEmail.toArray()
//			cc toEmail
            cc ccEmail.toArray()
            subject new String(sub)
            html htmlContent
        }
    }
}
