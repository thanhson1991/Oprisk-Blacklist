import grails.converters.JSON
import msb.platto.commons.Conf
import msb.platto.fingerprint.User

import java.text.MessageFormat
import java.text.NumberFormat

class KrisController {
    def springSecurityService
    def exportExcelService
    def index = { }
    def krisDisplay = {
        def donvi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
        def donvi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0');
        def donvi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0');
        def toDate,fromDate
        def today = new Date()
        toDate = DateUtil.formatDate(today)
        toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
        today.setMonth(today.month-1)
        fromDate = DateUtil.formatDate(today)
        fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')
        def currentUserRole = springSecurityService.authentication.getAuthorities()
        //    println(currentUserRole[0])
        def currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
        def listKRI = Kris.createCriteria().list {
            'eq'('active_status', '1')
            if (currentUserRole[0] != "ROLE_CVQLRR") {
                "eq"("donvi_3", UnitDepart.findById(currentUser.tenDonVi3.toLong()))
            }
            "ge"("ngay_nhap", fromDate)
            "le"("ngay_nhap", toDate)
            order ("id", "desc")
        }
    //    println(listKRI)
        render (view:'/kris/krisListDisplay',model:[donvi1:donvi1,donvi2:donvi2,donvi3:donvi3,listKRI:listKRI,nowUser:currentUser])
    }
    def kristrackDisplay = {
        render (view:'/kris/trackKRI')
    }
    def krisManagePage = {
        def donvi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
        def donvi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0');
        def donvi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0');

        def currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
        render (view:'/kris/krisManage',model:[donvi1:donvi1,donvi2:donvi2,donvi3:donvi3,currentUser:currentUser])
    }
    def saveKRI = {
     //   println(params.addNewKRI)
        if(params.addNewKRI){
     //      println("da vao day")
            if(Kris.findByMaKRI(params.maKRI)){
      //          println("da vao day2")
                flash.error = "Mã KRI đã tồn tại"
                params.ngay_pd = Date.parse("dd/MM/yyyy",params.ngay_pd)
                params.ngay_cn = Date.parse("dd/MM/yyyy",params.ngay_cn)
                params.ngay_bd_td = Date.parse("dd/MM/yyyy",params.ngay_bd_td)
                params.ngay_kt_td = Date.parse("dd/MM/yyyy",params.ngay_kt_td)
                def kriVar = new Kris(params)
                def userCreate = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
                def var_donvi1
                def var_donvi2
                def var_donvi3
                if(params.donvi1){
                    var_donvi1 = UnitDepart.findById(params.donvi1)
                }
                if(params.donvi2){
                    var_donvi2 = UnitDepart.findById(params.donvi2)
                }
                if(params.donvi3){
                    var_donvi3 = UnitDepart.findById(params.donvi3)
                }

                def var_user_tn = ErrorMasterUserCreate.findByUserEmail(params.OutLook1)
                def var_user_pd = ErrorMasterUserCreate.findByUserEmail(params.OutLook2)
                kriVar.usernhap = userCreate
                kriVar.donvi_1 = var_donvi1
                kriVar.donvi_2 = var_donvi2
                kriVar.donvi_3 = var_donvi3
                kriVar.user_tn = var_user_tn
                kriVar.user_pd = var_user_pd
                def user_tn_dv1 = UnitDepart.findById(kriVar.user_tn.tenDonVi1)
                def user_tn_dv2 = UnitDepart.findById(kriVar.user_tn.tenDonVi2)
                def user_tn_dv3 = UnitDepart.findById(kriVar.user_tn.tenDonVi3)
                def user_pd_dv1 = UnitDepart.findById(kriVar.user_pd.tenDonVi1)
                def user_pd_dv2 = UnitDepart.findById(kriVar.user_pd.tenDonVi2)
                def user_pd_dv3 = UnitDepart.findById(kriVar.user_pd.tenDonVi3)
                def donvi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
                def donvi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0');
                def donvi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0');
                def nowUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())

                render (view:'/kris/krisManage',model:[donvi1:donvi1,donvi2:donvi2,donvi3:donvi3,kriDetails:kriVar,
                                                       user_tn_dv1:user_tn_dv1,user_tn_dv2:user_tn_dv2,user_tn_dv3:user_tn_dv3,
                                                       user_pd_dv1:user_pd_dv1,user_pd_dv2:user_pd_dv2,user_pd_dv3:user_pd_dv3,
                                                       nowUser:nowUser])
                return
            }
            else{
        //        println("da vao day3")
                params.ngay_pd = Date.parse("dd/MM/yyyy",params.ngay_pd)
                params.ngay_cn = Date.parse("dd/MM/yyyy",params.ngay_cn)
                params.ngay_bd_td = Date.parse("dd/MM/yyyy",params.ngay_bd_td)
                params.ngay_kt_td = Date.parse("dd/MM/yyyy",params.ngay_kt_td)
                def kriVar = new Kris(params)
                def userCreate = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
                def var_donvi1
                def var_donvi2
                def var_donvi3
                if(params.donvi1){
                    var_donvi1 = UnitDepart.findById(params.donvi1)
                }
                if(params.donvi2){
                    var_donvi2 = UnitDepart.findById(params.donvi2)
                }
                if(params.donvi3){
                    var_donvi3 = UnitDepart.findById(params.donvi3)
                }

                def var_user_tn = ErrorMasterUserCreate.findByUserEmail(params.OutLook1)
                def var_user_pd = ErrorMasterUserCreate.findByUserEmail(params.OutLook2)
                kriVar.usernhap = userCreate
                kriVar.donvi_1 = var_donvi1
                kriVar.donvi_2 = var_donvi2
                kriVar.donvi_3 = var_donvi3
                kriVar.user_tn = var_user_tn
                kriVar.user_pd = var_user_pd
                kriVar.ngay_nhap = new Date()
                kriVar.active_status = 1
                if(params.hfDeleteFile=="deleteFile")
                {
                    kriVar.fileName =null
                }

                if(params.uploadFile!=null && params.uploadFile!="")
                {
                    def file = request.getFile('uploadFile')

                    if(!file.empty){

                        def fileName = file.getOriginalFilename()
                        String absolutePath = getServletContext().getRealPath("krisFile/"+ fileName)
                        File fileOut = new File(absolutePath)
                        file.transferTo(fileOut)
                        kriVar.fileName = fileName

                    }
                }
                if(kriVar.save()){
                    def arrTo=[]
                    def arrCc=[]
                    if(kriVar.user_tn.userEmail.contains('@')){
                        arrTo += kriVar.user_tn.userEmail
                    }else{
                        arrTo += kriVar.user_tn.userEmail+'@msb.com.vn'
                    }
/*                    if(kriVar.user_pd.userEmail.contains('@')){
                        arrCc += kriVar.user_pd.userEmail
                    }else{
                        arrCc += kriVar.user_pd.userEmail+'@msb.com.vn'
                    }*/

                    if(kriVar.usernhap.userEmail.contains('@')){
                        arrCc += kriVar.usernhap.userEmail
                    }else{
                        arrCc += kriVar.usernhap.userEmail+'@msb.com.vn'
                    }
                    sendEmailKRI("KRI",arrTo,arrCc,"",""+kriVar.id+"","Tạo mới KRI","","",kriVar.motaKRI)

                    flash.message = "Anh/chị đã tạo mới thành công!"
                    redirect (action: krisDisplay)
                    return
                }
            }
        }
        if(params.saveEdit){
            params.ngay_pd = Date.parse("dd/MM/yyyy",params.ngay_pd)
            params.ngay_cn = Date.parse("dd/MM/yyyy",params.ngay_cn)
            params.ngay_bd_td = Date.parse("dd/MM/yyyy",params.ngay_bd_td)
            params.ngay_kt_td = Date.parse("dd/MM/yyyy",params.ngay_kt_td)
            def kriVar =  Kris.get(params.krisID)
            def oldKriVar = listValueChangeKRI(kriVar)
            def oldUser_tn = kriVar.user_tn
            kriVar.properties = params

            def var_donvi1
            def var_donvi2
            def var_donvi3
            if(params.donvi1){
                var_donvi1 = UnitDepart.findById(params.donvi1)
            }
            if(params.donvi2){
                var_donvi2 = UnitDepart.findById(params.donvi2)
            }
            if(params.donvi3){
                var_donvi3 = UnitDepart.findById(params.donvi3)
            }
            def var_user_tn = ErrorMasterUserCreate.findByUserEmail(params.OutLook1)
            def var_user_pd = ErrorMasterUserCreate.findByUserEmail(params.OutLook2)

            kriVar.donvi_1 = var_donvi1
            kriVar.donvi_2 = var_donvi2
            kriVar.donvi_3 = var_donvi3
            kriVar.user_tn = var_user_tn
            kriVar.user_pd = var_user_pd
            if(params.hfDeleteFile=="deleteFile")
            {
                kriVar.fileName =null
            }

            if(params.uploadFile!=null && params.uploadFile!="")
            {
                def file = request.getFile('uploadFile')

                if(!file.empty){

                    def fileName = file.getOriginalFilename()
                    String absolutePath = getServletContext().getRealPath("krisFile/"+ fileName)
                    File fileOut = new File(absolutePath)
                    file.transferTo(fileOut)
                    kriVar.fileName = fileName

                }
            }
            if(kriVar.save()){
                def arrTo=[]
                def arrCc=[]
                //arrCc += Conf.findByType('cc_email').value
                if(kriVar.user_tn.userEmail.contains('@')){
                    arrTo += kriVar.user_tn.userEmail
                }else{
                    arrTo += kriVar.user_tn.userEmail+'@msb.com.vn'
                }

/*                if(kriVar.user_pd.userEmail.contains('@')){
                    arrCc += kriVar.user_pd.userEmail
                }else{
                    arrCc += kriVar.user_pd.userEmail+'@msb.com.vn'
                }*/
                if(oldUser_tn != kriVar.user_tn){
                    if(oldUser_tn.userEmail.contains('@')){
                        arrCc += oldUser_tn.userEmail
                    }else{
                        arrCc += oldUser_tn.userEmail+'@msb.com.vn'
                    }
                }

                def userEdit = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
                if(userEdit.userEmail.contains('@')){
                    arrCc += userEdit.userEmail
                }else{
                    arrCc += userEdit.userEmail+'@msb.com.vn'
                }

                def cTiet = ''
                def cTitle = ["Mã KRI","Tiêu đề KRI","Mã/Tên rủi ro","Loại KRI","Mô tả KRI","NH chuyên doanh/ khối",
                              "CN Trung tâm/ Phòng","PGD/ phòng ban/ tổ nhóm","Tần suất theo dõi","Đơn vị đo lường",
                              "Công thức đo lường","Nguồn số liệu",
                              "Đơn vị cung cấp số liệu","Phân loại theo sự kiện RRHĐ cấp 1",
                              "Phân loại theo sự kiện RRHĐ cấp 2","Phân loại theo sự kiện RRHĐ cấp 3",
                              "Ngưỡng 1","Ngưỡng 2",
                              "Ngưỡng 3","Ngưỡng giới hạn","Email nhận cảnh báo ngưỡng 1","Email nhận cảnh báo ngưỡng 2",
                              "Email nhận cảnh báo ngưỡng 3","Email nhận cảnh báo ngưỡng giới hạn",
                              "Người chịu trách nhiệm quản lý KRI",
                              "Người phê duyệt KRI",
                              "Ngày phê duyệt",
                              "Ngày cập nhật",
                              "Ngày bắt đầu theo dõi",
                              "Ngày kết thúc theo dõi",
                              "Trạng thái",
                              "Ghi chú"]
                def newKriVar = listValueChangeKRI(kriVar)
                for(int i = 0; i < oldKriVar.size();i++){

                    if(oldKriVar[i] != newKriVar[i]){
                        //       println(i)
                        cTiet += cTitle[i]+": " +newKriVar[i] +"<br>"
                    }

                }
                if(cTiet == ''){
                }else{
                    cTiet = "Mô tả:<font color='red'>"+cTiet+"</font> <br>"
                }
				println("to :"+arrTo )
				println("cc :"+arrCc )
				println("mo ta :" +cTiet)
                sendEmailKRI("KRI",arrTo,arrCc,cTiet,""+kriVar.id+"","Sửa KRI","","",kriVar.motaKRI)

                flash.message = "Anh/chị đã cập nhật thành công!"
                redirect (action: krisDisplay)
                return
            }
        }
        if(params.delete){
            def kriVar =  Kris.get(params.krisID)
            kriVar.active_status = 0
            if(kriVar.save(flush:true)){
                def arrTo=[]
                def arrCc=[]
                //arrTo += Conf.findByType('cc_email').value
                if(kriVar.user_tn.userEmail.contains('@')){
                    arrTo += kriVar.user_tn.userEmail
                }else{
                    arrTo += kriVar.user_tn.userEmail+'@msb.com.vn'
                }

                def userEdit = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
                if(userEdit.userEmail.contains('@')){
                    arrCc += userEdit.userEmail
                }else{
                    arrCc += userEdit.userEmail+'@msb.com.vn'
                }
                sendEmailKRI("KRI",arrTo,arrCc,"",""+kriVar.id+"","Xóa KRI","","",kriVar.motaKRI)


                flash.message = "Anh/chị đã xóa thành công!"
                redirect (action: krisDisplay)
                return
            }
        }
    }

    def listValueChangeKRI(Kris cc){
        def ccrt = new ArrayList()
        ccrt << cc.maKRI
        ccrt << cc.ttKRI
        ccrt << cc.maRR
        ccrt << cc.loaiKRI
        ccrt << cc.motaKRI
        ccrt << cc.donvi_1
        ccrt << cc.donvi_2
        ccrt << cc.donvi_3
        ccrt << cc.tstd
        ccrt << cc.dvdl
        ccrt << cc.ctdl
        ccrt << cc.nguonsl
        ccrt << cc.donviccsl
        ccrt << cc.rrhd1
        ccrt << cc.rrhd2
        ccrt << cc.rrhd3
        ccrt << cc.nguong1
        ccrt << cc.nguong2
        ccrt << cc.nguong3
        ccrt << cc.nguonggh
        ccrt << cc.emailcb1
        ccrt << cc.emailcb2
        ccrt << cc.emailcb3
        ccrt << cc.emailcbgh
        ccrt << cc.user_tn.userEmail
        ccrt << cc.user_pd.userEmail
        ccrt << cc.ngay_pd
        ccrt << cc.ngay_cn
        ccrt << cc.ngay_bd_td
        ccrt << cc.ngay_kt_td
        ccrt << cc.trang_thai
        ccrt << cc.ghi_chu
        ccrt << cc.ngay_nhap

        return ccrt
    }

    def searchKRI = {
        NumberFormat nf = NumberFormat.getInstance(Locale.US)
        def currentUserRole = springSecurityService.authentication.getAuthorities()
    //    println(currentUserRole[0])
        def currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
        def var_fromDate
        def var_toDate
        def listKRITrueForm = []
        def trackKRI
        if(params.fromDate){
            var_fromDate = Date.parse("dd/MM/yyyy",params.fromDate)
        }
        if(params.toDate){
            var_toDate = Date.parse("dd/MM/yyyy",params.toDate).next()
        }
        def listKRI = Kris.createCriteria().list {
                    'eq' ('active_status','1')
            if(currentUserRole[0] != "ROLE_CVQLRR"){
                   "eq" ("donvi_3", UnitDepart.findById(currentUser.tenDonVi3.toLong()))
            }
            if(params.fromDate){
                   "ge" ("ngay_nhap", var_fromDate)
            }
            if(params.fromDate){
                    "le" ("ngay_nhap", var_toDate)
            }
            if(params.s_rrhd1){
                "eq" ("rrhd1",params.s_rrhd1)
            }
            if(params.s_rrhd2){
                "eq" ("rrhd2",params.s_rrhd2)
            }
            if(params.s_loaiKRI){
                "eq" ("loaiKRI", params.s_loaiKRI)
            }
            if(params.donvi1){
                "eq" ("donvi_1", UnitDepart.findById(params.donvi1))
            }
            if(params.donvi2){
                "eq" ("donvi_2", UnitDepart.findById(params.donvi2))
            }
            if(params.donvi3){
                "eq" ("donvi_3", UnitDepart.findById(params.donvi3))
            }
            if(params.tstd){
                "eq" ("tstd",params.tstd)
            }
            if(params.nguonsl){
                "eq" ("nguonsl",params.nguonsl)
            }
            if(params.trang_thai){
                "eq" ("trang_thai",params.trang_thai)
            }
            order ("id", "desc")
        }
        if(params.alertType){
            /*if(params.alertType == "0"){
            //    println("Trang")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong1)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "1"){
            //    println("Xanh")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong1) && nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong2)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "2"){
            //    println("Cam")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong2) && nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong3)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "3"){
             //   println("Do")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong3) && nf.parse(trackKRI.kriVal) < nf.parse(kri.nguonggh)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "4"){
            //    println("Den")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) > nf.parse(kri.nguonggh)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }*/
            if(params.alertType == "0"){
            //    println("Xanh")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong1)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "1"){
            //    println("Cam")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong1) && nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong2)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "2"){
            //    println("Do")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong2) && nf.parse(trackKRI.kriVal) < nf.parse(kri.nguong3)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }
            else if(params.alertType == "3"){
             //   println("Den")
                listKRI.each {kri ->
                    trackKRI = TrackKRI.findByKriObjAndActive_status(kri,1,[sort: "inputDate", order: "desc"])
                    if(trackKRI) {
                        if (nf.parse(trackKRI.kriVal) >= nf.parse(kri.nguong3)) {
                            listKRITrueForm << kri
                        }
                    }
                }
            }

        }else{
        //    println("Khong co gi")
            listKRITrueForm = listKRI
        }

        if(params.exportExcel=="ExportExcel"){

            def header //= ['Mã KRI','Mã/Tên rủi ro','Tiêu đề KRI','Tấn suất theo dõi','Loại KRI','NHCD/Khối','CN/TT/Phòng','PGD/Phòng ban/Tổ nhóm','Trạng thái','Nguồn số liệu']
            def listContent = []
            //listContent<<header
            def maKRI,maRR,ttKRI,tstd,loaiKRI,donvi_1='',donvi_2='',donvi_3='',trang_thai,nguonsl


            listKRITrueForm.each{

                maKRI=it.maKRI
                donvi_1 = it.donvi_1?it.donvi_1.name:""
                donvi_2 = it.donvi_2?it.donvi_2.name:""
                donvi_3 = it.donvi_3?it.donvi_3.name:""
                maRR = it.maRR
                ttKRI = it.ttKRI
                tstd = it.tstd
                loaiKRI = it.loaiKRI
                trang_thai = it.trang_thai
                nguonsl = it.nguonsl
                header = [maKRI,maRR,ttKRI,tstd,loaiKRI,donvi_1,donvi_2,donvi_3,trang_thai,nguonsl]
                listContent<<header
            }


            def data
            data = exportExcelService.kriDisplay(listContent)
//			// // println "DATA:"+data


            //File download
            response.setContentType("application/vnd.ms-excel")
            response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
            response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
        }

     //   println(currentUserRole[0])
        def donvi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
        def donvi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0');
        def donvi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0');
        render (view:'/kris/krisListDisplay',model:[donvi1:donvi1,donvi2:donvi2,donvi3:donvi3,listKRI:listKRITrueForm,nowUser:currentUser,params:params])
    }

    def viewKRIDetail = {
        def kriDetails = Kris.findById(params.id)
        def user_tn_dv1 = UnitDepart.findById(kriDetails.user_tn.tenDonVi1)
        def user_tn_dv2 = UnitDepart.findById(kriDetails.user_tn.tenDonVi2)
        def user_tn_dv3 = UnitDepart.findById(kriDetails.user_tn.tenDonVi3)
        def user_pd_dv1 = UnitDepart.findById(kriDetails.user_pd.tenDonVi1)
        def user_pd_dv2 = UnitDepart.findById(kriDetails.user_pd.tenDonVi2)
        def user_pd_dv3 = UnitDepart.findById(kriDetails.user_pd.tenDonVi3)
        def donvi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
        def donvi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0');
        def donvi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0');
        def nowUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())

        render (view:'/kris/krisManage',model:[donvi1:donvi1,donvi2:donvi2,donvi3:donvi3,kriDetails:kriDetails,
                                               user_tn_dv1:user_tn_dv1,user_tn_dv2:user_tn_dv2,user_tn_dv3:user_tn_dv3,
                                               user_pd_dv1:user_pd_dv1,user_pd_dv2:user_pd_dv2,user_pd_dv3:user_pd_dv3,
                                               nowUser:nowUser])
    }
    def pageAddTrackKRI = {
        def detailsKRI
        def trackKRIList
        if(params.maKRI){
            detailsKRI = Kris.findByMaKRI(params.maKRI)
        }
        if(detailsKRI){
        //    trackKRIList = TrackKRI.findAllByKriObjAndActive_status(detailsKRI,1,[sort: "inputDate", order: "desc"])
            trackKRIList = TrackKRI.createCriteria().list {
                eq ('kriObj',detailsKRI)
                eq ('active_status','1')
                order ('kridateVal','desc')
                order ('inputDate','desc')
            }
        }
        render (view:'/kris/trackKRI', model:[detailsKRI:detailsKRI,trackKRIList:trackKRIList,kriCode:params.maKRI])
    }

    def loadKRI = {
        def detailsKRI
        def trackKRIList
        if(params.maKRI){
            detailsKRI = Kris.findByMaKRI(params.maKRI)
        }
        if(detailsKRI){
            trackKRIList = TrackKRI.createCriteria().list {
                eq ('kriObj',detailsKRI)
                eq ('active_status','1')
                order ('kridateVal','desc')
                order ('inputDate','desc')
            }
        //            findAllByKriObjAndActive_status(detailsKRI,1,[sort: "inputDate", order: "desc"])
        }
        String content = g.render(template:"/kris/trackKRITemp", model:[detailsKRI:detailsKRI,trackKRIList:trackKRIList,kriCode:params.maKRI])
        render content
    }
    def addTrackKris = {
        NumberFormat nf = NumberFormat.getInstance(Locale.US)
        def detailsKRI
        def trackKRIList
        if(params.krisID){
            detailsKRI = Kris.findByMaKRI(params.krisID)
        }
        if(params.kridateVal){
            params.kridateVal = Date.parse("dd/MM/yyyy",params.kridateVal)
        }
        if(params.inputDate){
            params.inputDate = Date.parse("dd/MM/yyyy HH:mm:ss",params.inputDate)
        }
        if(params.addKrisBt){

           def trackKRIVar = new TrackKRI(params)
           trackKRIVar.kriObj = detailsKRI
           trackKRIVar.inputDate = new Date()
           trackKRIVar.kriObj.ngay_cn = trackKRIVar.inputDate
           trackKRIVar.active_status = 1
        //    println(trackKRIVar.properties)
           if(trackKRIVar.save()){
               def nguongcb
               def maucanhbao
               def arrTo=[]
               def arrCc=[]
               arrTo += Conf.findByType('cc_email').value
               //    arrCc += 'anhnnt1@m1tech.com.vn'
               /*if( nf.parse(trackKRIVar.kriVal) < nf.parse(detailsKRI.nguong1)){
                   maucanhbao = "Chưa tới ngưỡng"
                   nguongcb = ""
                //   arrCc += trackKRIVar.kriObj.emailcb1
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong1) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong2)){
                   maucanhbao = "Xanh lá"
                   nguongcb = trackKRIVar.kriObj.nguong1
                   arrCc += trackKRIVar.kriObj.emailcb1
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong2) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong3)){
                   maucanhbao = "Cam"
                   nguongcb = trackKRIVar.kriObj.nguong2
                   arrCc += trackKRIVar.kriObj.emailcb2
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong3) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguonggh)){
                   maucanhbao = "Đỏ"
                   nguongcb = trackKRIVar.kriObj.nguong3
                   arrCc += trackKRIVar.kriObj.emailcb3
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguonggh)){
                   maucanhbao = "Đen"
                   nguongcb = trackKRIVar.kriObj.nguonggh
                   arrCc += trackKRIVar.kriObj.emailcbgh
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }*/

               if( nf.parse(trackKRIVar.kriVal) < nf.parse(detailsKRI.nguong1)){
                   maucanhbao = "Chưa tới ngưỡng"
                   nguongcb = ""
                   //   arrCc += trackKRIVar.kriObj.emailcb1
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Tạo mới theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong1) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong2)){
                   maucanhbao = "Cam"
                   nguongcb = trackKRIVar.kriObj.nguong1
                   arrCc += trackKRIVar.kriObj.emailcb1
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong2) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong3)){
                   maucanhbao = "Đỏ"
                   nguongcb = trackKRIVar.kriObj.nguong2
                   arrCc += trackKRIVar.kriObj.emailcb2
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong3)){
                   maucanhbao = "Đen"
                   nguongcb = trackKRIVar.kriObj.nguong3
                   arrCc += trackKRIVar.kriObj.emailcb3
                   sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                           trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
               }

               flash.message = "Anh/chị đã tạo mới thành công!"
           }
        }
        if(params.editKrisBt){
            def trackKRIVar = TrackKRI.get(params.trackKrisID)
            trackKRIVar.properties = params
            trackKRIVar.inputDate = new Date()
            trackKRIVar.kriObj.ngay_cn = trackKRIVar.inputDate
        //    println(trackKRIVar.properties)
            if(trackKRIVar.save()){
                def nguongcb
                def maucanhbao
                def arrTo=[]
                def arrCc=[]
                arrTo += Conf.findByType('cc_email').value
                //    arrCc += 'anhnnt1@m1tech.com.vn'
                /*if(nf.parse(trackKRIVar.kriVal) < nf.parse(detailsKRI.nguong1)){
                    maucanhbao = "Chưa tới ngưỡng"
                    nguongcb = ""
                    //   arrCc += trackKRIVar.kriObj.emailcb1
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong1) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong2)){
                    maucanhbao = "Xanh lá"
                    nguongcb = trackKRIVar.kriObj.nguong1
                    arrCc += trackKRIVar.kriObj.emailcb1
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong2) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong3)){
                    maucanhbao = "Cam"
                    nguongcb = trackKRIVar.kriObj.nguong2
                    arrCc += trackKRIVar.kriObj.emailcb2
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong3) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguonggh)){
                    maucanhbao = "Đỏ"
                    nguongcb = trackKRIVar.kriObj.nguong3
                    arrCc += trackKRIVar.kriObj.emailcb3
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguonggh)){
                    maucanhbao = "Đen"
                    nguongcb = trackKRIVar.kriObj.nguonggh
                    arrCc += trackKRIVar.kriObj.emailcbgh
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }*/

                if(nf.parse(trackKRIVar.kriVal) < nf.parse(detailsKRI.nguong1)){
                    maucanhbao = "Chưa tới ngưỡng"
                    nguongcb = ""
                    //   arrCc += trackKRIVar.kriObj.emailcb1
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Sửa theo dõi KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong1) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong2)){
                    maucanhbao = "Cam"
                    nguongcb = trackKRIVar.kriObj.nguong1
                    arrCc += trackKRIVar.kriObj.emailcb1
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong2) && nf.parse(trackKRIVar.kriVal) < nf.parse(trackKRIVar.kriObj.nguong3)){
                    maucanhbao = "Đỏ"
                    nguongcb = trackKRIVar.kriObj.nguong2
                    arrCc += trackKRIVar.kriObj.emailcb2
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }else if(nf.parse(trackKRIVar.kriVal) >= nf.parse(trackKRIVar.kriObj.nguong3)){
                    maucanhbao = "Đen"
                    nguongcb = trackKRIVar.kriObj.nguong3
                    arrCc += trackKRIVar.kriObj.emailcb3
                    sendEmailtrackKRI("trackKRI",arrTo,arrCc,"",""+trackKRIVar.kriObj.id+"","Vượt ngưỡng giá trị KRI","","",trackKRIVar.kriObj.motaKRI,
                            trackKRIVar.kriObj.ttKRI,trackKRIVar.kriObj.dvdl,trackKRIVar.kriVal,nguongcb,maucanhbao)
                }

                flash.message = "Anh/chị đã cập nhật thành công!"
            }
        }
        /*if(detailsKRI){
        //    trackKRIList = TrackKRI.findAllByKriObjAndActive_status(detailsKRI,1,[sort: "inputDate", order: "desc"])
            trackKRIList = TrackKRI.createCriteria().list {
                eq ('kriObj',detailsKRI)
                eq ('active_status','1')
                order ('kridateVal','desc')
                order ('inputDate','desc')
            }
        }*/
    //    println("aaaa")
        redirect (action: 'pageAddTrackKRI',params:[maKRI:params.krisID])
    }
    def deleteTrackKris = {
        def detailsKRI
    //    println(params.id)
     //   println(params.maKRI)
        if(params.maKRI){
            detailsKRI = Kris.findByMaKRI(params.maKRI)
        }
        def trackKRIList
        def trackKRIVar = TrackKRI.get(params.id)
     //   println(trackKRIVar)
        trackKRIVar.active_status = 0
        if(trackKRIVar.save(flush:true)){
        //    trackKRIList = TrackKRI.findAllByKriObjAndActive_status(detailsKRI,1,[sort: "inputDate", order: "desc"])
        //    println(trackKRIList)
            trackKRIList = TrackKRI.createCriteria().list {
                eq ('kriObj',detailsKRI)
                eq ('active_status','1')
                order ('kridateVal','desc')
                order ('inputDate','desc')
            }
            flash.message = "Anh/chị đã xóa thành công!"
        }
        render (view:'/kris/trackKRI',model:[detailsKRI:detailsKRI,trackKRIList:trackKRIList,kriCode:detailsKRI.maKRI])
    }
    def trackKRIexport = {
        NumberFormat nf = NumberFormat.getInstance(Locale.US)
        def detailsKRI
        //    println(params.id)
        //   println(params.maKRI)
        if(params.maKRI){
            detailsKRI = Kris.findByMaKRI(params.maKRI)
        }
        def trackKRIList
        if(detailsKRI){
        //    trackKRIList = TrackKRI.findAllByKriObjAndActive_status(detailsKRI,1,[sort: "inputDate", order: "desc"])
            trackKRIList = TrackKRI.createCriteria().list {
                eq ('kriObj',detailsKRI)
                eq ('active_status','1')
                order ('kridateVal','desc')
                order ('inputDate','desc')
            }
        }
        if(params.exportExcel=="ExportExcel"){

            def header //= ['Mã KRI','Mã/Tên rủi ro','Tiêu đề KRI','Tấn suất theo dõi','Loại KRI','NHCD/Khối','CN/TT/Phòng','PGD/Phòng ban/Tổ nhóm','Trạng thái','Nguồn số liệu']
            def listContent = []
            //listContent<<header
            def maKRI,kridateVal,kriVal,inputUser,inputDate,canhbao,userNote


            trackKRIList.each{

                maKRI=detailsKRI.maKRI
                kridateVal = it.kridateVal
                kriVal = it.kriVal
                inputUser = it.inputUser
                inputDate = it.inputDate
                /*if(nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong1)){
                    canhbao = "Chưa tới ngưỡng"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong1) && nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong2)){
                    canhbao = "Xanh lá"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong2) && nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong3)){
                    canhbao = "Cam"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong3) && nf.parse(it.kriVal) < nf.parse(detailsKRI.nguonggh)){
                    canhbao = "Đỏ"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguonggh)){
                    canhbao = "Đen"
                }*/
                if(nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong1)){
                    canhbao = "Chưa tới ngưỡng"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong1) && nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong2)){
                    canhbao = "Cam"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong2) && nf.parse(it.kriVal) < nf.parse(detailsKRI.nguong3)){
                    canhbao = "Đỏ"
                }else if(nf.parse(it.kriVal) >= nf.parse(detailsKRI.nguong3)){
                    canhbao = "Đen"
                }
                userNote = it.userNote?it.userNote:""
                header = [maKRI,kridateVal,kriVal,inputUser,inputDate,canhbao,userNote]
                listContent<<header
            }


            def data
            data = exportExcelService.trackKriDisplay(listContent)
//			// // println "DATA:"+data


            //File download
            response.setContentType("application/vnd.ms-excel")
            response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
            response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
        }
    }
    def getEvenList2={
        def eventList2=["-1"]

        if(params.parent_id ){
            eventList2=Event.executeQuery(' from Event e where e.parent!=null and  e.parent='+params.parent_id)
        }
        render eventList2 as JSON

    }
    def getFirstNodesFromLevel2 = {
        String source = params.id

        Event node = Event.get(params[source])

        def parentAllNodes=Event.executeQuery(' from Event t where t.ord = 0')
        //def firstNode=UnitDepart.get(node.id)
        String htmlRes = '<option></option>' + "\n"
        parentAllNodes.each{n->
            if(n.id== node.parent.id)
            {

                htmlRes += '<option selected="selected"  value="' + n.id + '">'+ n.name + '</option>' + "\n"
            }
            else
                htmlRes += '<option value="' + n.id + '">' + n.name + '</option>' + "\n"
        }
        render htmlRes
    }
    def getQLRR_donvi = {
        def currentUser = ErrorMasterUserCreate.findByUserEmail("qlrr_oprisk")
        def donvi = [:]
        donvi << [donvi1:currentUser.tenDonVi1,donvi2:currentUser.tenDonVi2,donvi3:currentUser.tenDonVi3]
        render donvi as JSON
        return
    }
    def sendEmailKRI(String code,def to, def cc,String CTLoi,String Id,String action,String Ykien,String nameStatus,String motaKRI){
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
                def conten = MessageFormat.format(errorMail.content, [action,motaKRI,CTLoi,Id].toArray())
                def subject = MessageFormat.format(errorMail.subject, [Id,action,''].toArray())
                sendMail(to3,conten,cc3,subject)
            }
        }
    }
    def sendEmailtrackKRI(String code,def to, def cc,String CTLoi,String Id,String action,String Ykien,String nameStatus,String motaKRI,String tieudeKRI,String donviDo,String kriValUpdate,String gtNguong,String mauCanhbao){
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
                def conten = MessageFormat.format(errorMail.content, [tieudeKRI,motaKRI,donviDo,kriValUpdate,gtNguong,mauCanhbao,Id].toArray())
                def subject = MessageFormat.format(errorMail.subject, [Id,action,''].toArray())
                sendMail(to3,conten,cc3,subject)
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
