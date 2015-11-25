import grails.converters.JSON
import groovy.sql.Sql
import org.codehaus.groovy.grails.web.json.JSONObject

import java.text.*;
import java.text.Normalizer.Form;
import java.util.*;
import msb.platto.commons.Conf
import java.util.logging.ErrorManager;

import javax.swing.text.MaskFormatter.MaskCharacter;
import javax.swing.text.html.HTML;
import javax.swing.text.html.HTMLDocument.HTMLReader.ConvertAction;

import grails.util.Environment
//import msb.ldap.LdapUser
import msb.platto.fingerprint.*
import msb.platto.utils.DateUtil;

import org.apache.jasper.compiler.Node.ParamsAction;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.junit.Assert;
import org.springframework.web.multipart.commons.CommonsMultipartFile

import org.apache.naming.factory.SendMailFactory;
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.hssf.usermodel.HSSFWorkbook
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.usermodel.Font
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.hssf.util.Region
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.tools.ant.taskdefs.SendEmail;
import java.util.Locale;
import org.springframework.context.i18n.LocaleContextHolder as LCH

class OpErrorController {
    def riskService
	def errorService
    def springSecurityService
    Role role
	def dataSource
	def sqlserverDataSource  
	String Mail="@msb.com.vn"
	def messageSource
	def exportExcelService
	

    def index = {
		session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new Locale("vi", "VN")

    }
    def dashboard = {
        def user = User.findByUsername( springSecurityService.principal.username)        
        render view:'/opError/dashboard', model:[user:user]
    }
	
  
	//Error
	def errorManagementList={
		def user = User.findByUsername(springSecurityService.principal.username)
		def errorMC=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		if(errorMC==null)
		{
			flash.message = "Vui lòng kiểm tra lại username trong chức năng quản lý người gây lỗi"
			flash.messageType = "message info"
			redirect (controller:'opError', action:'getErrorDisplay')
		}
		
	
		def errorlist1=ErrorList.executeQuery('from ErrorList e where e.ord=1 and e.status>=0 order by e.code+0')

		//def unitDepart=UnitDepart.findAllByParent(UnitDepart.findByName('Horizontal Tree'))
		def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')
			
						
		def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		
		def today = DateUtil.formatDate(new Date())
		
		def errorStatus=ErrorStatus.executeQuery('from ErrorStatus e where status>=0 order by e.code+0')
						
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
		
		def errorCheck=ErrorCheck.executeQuery('from ErrorCheck e where status>=0 order by e.code+0')
	
		def errorCategory = ErrorCategory.executeQuery('from ErrorCategory e where status>=0 order by e.code+0')
		
		def unitDepart3=UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def errorList3=ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')
		
		def unitDepart2=UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		def errorList2=ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')
//		// // println errorList2
		
		render view:'/opError/errorManaList',model:[errorList2:errorList2,unitDepart2:unitDepart2,errorlist1:errorlist1,unitDepart:unitDepart,department:department,currDate:today,user:user,errorStatus:errorStatus,errorType:errorType,errorCheck:errorCheck,errorCategory:errorCategory,unitDepart3:unitDepart3,errorList3:errorList3]
	}
	
	def getUnitDepart2={
		
		def unitDepart2=["-1"]
		
			if(params.parent_id ){
				unitDepart2=UnitDepart.executeQuery(' from UnitDepart e where e.parent!=null and e.parent='+params.parent_id+' and e.status >=0 order by e.code+0')
				
			}
		render unitDepart2 as JSON
		 
	}
	

	def getUnitDepart1={
		
		def unitDepart1=["-1"]
		
			if(params.parent_id ){
				unitDepart1=UnitDepart.executeQuery(' from UnitDepart e where e.parent!=null and e.parent=1 and e.status >=0 order by e.code+0')
				
			}
		render unitDepart1 as JSON
		 
	}
	def getIdUnitDepart1={
		
		def currIdLevel1=-1;
//		// // println "params.parent_id:"+params.parent_id
		
			if(params.parent_id ){
				def unitDepart1=UnitDepart.get(params.parent_id.toInteger())	
//				// // println "unitDepart1:"+unitDepart1
				currIdLevel1=unitDepart1.parent.id
//				// // println currIdLevel1
			}
		render currIdLevel1.toString()
	}
	
	

	def getErrorList2={
		def errorList2=["-1"]
		
			if(params.parent_id ){
				errorList2=ErrorList.executeQuery(' from ErrorList e where e.parent!=null and  e.parent='+params.parent_id+' and e.status >=0 order by e.code+0')			
			}		
		render errorList2 as JSON

	}
	
	
	def getErrorList3={
		def errorList3=["-1"]
		
			if(params.parent_id ){
				errorList3=ErrorList.executeQuery(' from ErrorList e where e.parent!=null and  e.parent='+params.parent_id+' and e.status >=0 order by e.code+0')
			}
			
		render errorList3 as JSON

	}
	
	
	//Save ErrorManageemtnList - Add New
	def saveErrorManaList={
		
		
		def errorManagement=new ErrorManagement()
		
		
	
		
		errorManagement.bienPhapKhacPhuc=params.BienPhapKhacPhuc
		if(params.ThoiHanKhacPhuc!=null && params.ThoiHanKhacPhuc.length()>4)
			errorManagement.thoiHanKhacPhuc=DateUtil.parseInputDate(params.ThoiHanKhacPhuc +' 00:00:00')
		
		//errorManagement.yKienCacDonViKhac=params.YKienCacDonViKhac
		errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
		errorManagement.motaChiTiet =params.MotaChiTiet
		errorManagement.moTaAnhHuong = params.MoTaAnhHuong
		if(params.SoLuongKiemTra!='')
			errorManagement.soLuongKiemTra = params.SoLuongKiemTra
		else
		errorManagement.soLuongKiemTra = 0
		errorManagement.tongSoChonMau = params.TongSoChonMau
		errorManagement.nguoiNhap=params.NguoiNhap

		//def user = User.findByUsername(params.NguoiNhap)
		
		
		def errorMC=ErrorMasterUserCreate.findByUserEmail(params.NguoiNhap)
		errorManagement.tenDonViNhap1=errorMC.tenDonVi1
		errorManagement.tenDonViNhap2=errorMC.tenDonVi2
		errorManagement.tenDonViNhap3=errorMC.tenDonVi3
		
		
		

//		errorManagement.nHCD=params.NHCD
		errorManagement.tenDonVi1 = params.TenDonVi1
		errorManagement.tenDonVi2 = params.TenDonVi2
		errorManagement.tenDonVi3 = params.TenDonVi3
				
		errorManagement.loiCap1=params.LoiCap1
		errorManagement.loiCap2=params.LoiCap2
		errorManagement.loiCap3=params.LoiCap3
		
		errorManagement.thoiGianNhapVaoHeThong=new Date()	
		errorManagement.giaTriGiaoDich=params.GiaTriGiaoDich
		errorManagement.hoSoVaTenHoSo=params.HoSoVaTenHoSo
		errorManagement.maGiaoDich=params.MaGiaoDich
		errorManagement.soCifKhachHang=params.SoCifKhachHang
		errorManagement.tenKhachHang=params.TenKhachHang
		errorManagement.trangThai=params.TrangThai.toInteger()	
		errorManagement.loaiTien=params.LoaiTien
		/*errorManagement.errorType=ErrorType.get(params.errorType)*/
		errorManagement.errorCheck=ErrorCheck.get(params.errorCheck)
		errorManagement.errorCategory = ErrorCategory.get(params.errorCategory)	
		
		def file = request.getFile('uploadFile')
		if(!file.empty){
		def fileName = file.getOriginalFilename()
		String absolutePath = getServletContext().getRealPath("errorFiles/"+ fileName)
		File fileOut = new File(absolutePath)
		file.transferTo(fileOut)
		errorManagement.fileName = fileName
		}
			
		def userCreate=new ErrorUserCreate()
		def userEmailParam			
		def _d=new 	Department()
		def _ud=new UnitDepart()
		
		
		for(int i=1;i<=params.dateCount.toInteger();i++)
		{	
		
			if(params.('HoVaTen_'+i)!=null && params.('HoVaTen_'+i).trim()!="")
			{
				userCreate=new ErrorUserCreate()
				
				userCreate.userEmail=params.('OutLook_'+i)
				userCreate.levelError=params.('Mucdoloi_'+i)
				userCreate.fullName=params.('HoVaTen_'+i)
				userCreate.title=params.('ChucDanh_'+i)
				userCreate.bDSUser=params.('BdsUser_'+i)
				userCreate.codeSalary=params.('IdNhanSu_'+i)
				userCreate.tenDonVi1=params.('NHCD_Id_'+i)
				userCreate.tenDonVi2=params.('TenDonVi_Id_'+i)
				userCreate.tenDonVi3=params.('PGD_Id_'+i)
				
				userCreate.errorDonVi1=params.TenDonVi1
				userCreate.errorDonVi2=params.TenDonVi2
				userCreate.errorDonVi3=params.TenDonVi3
 
				
					
				errorManagement.addToErrorUserCreate(userCreate)
			}			
		}
		//Save Comment
		
		if(params.YKienCacDonViKhac!=null && params.YKienCacDonViKhac!="")
		{
			def comment=new ErrorsComment()
			def user = User.findByUsername( springSecurityService.principal.username)
			comment.createdBy=user
			comment.content=params.YKienCacDonViKhac
			comment.dateCreated=new Date()	
			comment.createdUserUpload=user.username
			errorManagement.addToErrorsComments(comment)
		}
		
		
		errorManagement.save(flush:true)

		def arrTo=[]
		def arrCc=[params.NguoiNhap]
		for(int i=1;i<=params.dateCount.toInteger();i++)
		{			
			if(params.('OutLook_'+i)==''){
				arrTo +="default" 
			}else{
				arrTo +=params.('OutLook_'+i) 
			}						 
			
			if(i==params.dateCount.toInteger()){
				 
				sendEmailError("CR",arrTo,arrCc,params.MotaChiTiet,""+errorManagement.id+"",ErrorList.get(params.LoiCap3).name,"","")
			}
		}
			
		flash.message = "Lỗi mới đã được nhập vào hệ thống."
		flash.messageType = "message info"
		if(errorManagement.hasErrors()){
			errorManagement.errors.each{
				
				flash.message = "Lỗi sảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ."
				flash.messageType = "message info"
			}
		}
		
		if(params.ROLES=='GDTTL2'){
			redirect (controller:'opError', action:'getErrorDisplayLevel2')		
		}else if(params.ROLES=='GDTTL3'){
			redirect (controller:'opError', action:'getErrorDisplayLevel3')
		}else if(params.ROLES=='GDTTL4'){
			redirect (controller:'opError', action:'getErrorDisplayLevel4')
		}else if(params.ROLES=='GDTT'){
			redirect (controller:'opError', action:'getErrorDisplayLevel1')
		}else{
			redirect (controller:'opError', action:'getErrorDisplay')
		}
	}
	def sendEmailError(String code,def to, def cc,String CTLoi,String Id,String LoiCap3,String Ykien,String nameStatus){
//		def restrictMail1 = ErrorRestrictEmail.findAll()
//		def toArray = []
//		
//		toArray = to
//		def intersect1 = toArray.intersect(restrictMail1) as TreeSet
//		def intersect2 = restrictMail1.intersect(toArray) as TreeSet
//		assert intersect1 == intersect2
//		// // println ">>>>>>>>" + intersect1
 
		if(ErrorMail.findByCode('Check').enableSendEmail=='Y'){
//			def restrictMail = ErrorRestrictEmail.findAll()
			def to2 = [],to3 = []
			def cc2 = [],cc3 = []
			cc2 = cc
			to2 = to
//			def toIndex = 0,ccIndex =0
//			Boolean flag
//		
//			
//			for(int i=0;i< to.size() ;i++){
//				for(int j=0; j < restrictMail.size();j++){
//					flag = false
//					if(to[i].toString()==restrictMail[j].userEmail.toString()){
//						flag = true
//						break
//					}
//				}
//				if(flag==false){
//					to2[toIndex] = to[i]
//					toIndex +=1
//					flag =false
//				}
//			}
//			for(int i=0;i< cc.size() ;i++){
//				for(int j=0; j < restrictMail.size();j++){
//					flag = false
//					if(cc[i].toString()==restrictMail[j].userEmail.toString()){
//						flag = true
//						break
//					}
//				}
//				if(flag==false){
//					cc2[ccIndex] = cc[i]
//					ccIndex +=1
//					flag =false
//				}
//			}
//			if(!to2){
//				to3 = "default@msb.com.vn"
//			 }else{
				for(int i=0;i<to2.size();i++){
					to3[i] = riskService.convertEmail(to2[i])
				}
//			}
//			if(!cc2){
//				cc3 = "qlrr_oprisk@msb.com.vn"
//			}else{
				for(int i=0;i<cc2.size();i++){
					cc3[i] = riskService.convertEmail(cc2[i])
				}
//			}
			def errorMail = ErrorMail.findByCode(code)
			if(errorMail.enableSendEmail=='Y' && (code=='CR'|| code=='ED' || code=='DEL')){
				def conten = MessageFormat.format(errorMail.content, [LoiCap3,CTLoi,Id].toArray())
				def subject = MessageFormat.format(errorMail.subject, [Id,LoiCap3].toArray())
				sendMail(to3,conten,cc3,subject)
			}else if (errorMail.enableSendEmail=='Y'&& code=='CM'){
		 	 	def conten = MessageFormat.format(errorMail.content, [LoiCap3,CTLoi,Ykien,Id].toArray())
				def subject = MessageFormat.format(errorMail.subject, [Id,LoiCap3].toArray())
				sendMail(to3,conten,cc3,subject)
			}else if(errorMail.enableSendEmail=='Y' && code=='DTT'){
				def conten = MessageFormat.format(errorMail.content, [LoiCap3,CTLoi,nameStatus,Id].toArray())
				def subject = MessageFormat.format(errorMail.subject, [Id,LoiCap3].toArray())
				sendMail(to3,conten,cc3,subject)
			}	
		}
		
	}
	
	
//	String str="Dear {0} <br> me trio mua to vai {1} asdfsdfsd {1} cong a con"
//	String ab=MessageFormat.format("Dear {0} <br> me trio mua to vai {1} asdfsdfsd  cong a con", ['Bui Minh Duc', 'AAABBCCC'].toArray())
//	// // println "SSStttrrr:"+ ab
	
	def getDisplayName ={
		
		def username=params.username
		def fullNameOutlook=["",""]
		def user = ErrorMasterUserCreate.findByUserEmail(username) 
		
		 
		if(user!=null)
		{
		
			
			def fullName=user.fullName
			def title=user.title
			def bDsUser=user.bDSUser
			def codeSalary=user.codeSalary
			//def unitDepart=user.unitDepart.name	
			//def department=user.department.name
			def tenDonVi1=UnitDepart.get(user.tenDonVi1)
			def tenDonVi2=UnitDepart.get(user.tenDonVi2)
			def tenDonVi3=UnitDepart.get(user.tenDonVi3)
					
			fullNameOutlook = [fullName,title,bDsUser,codeSalary,tenDonVi1.name,tenDonVi2.name,tenDonVi3.name,tenDonVi1.id,tenDonVi2.id,tenDonVi3.id]
		}
		render fullNameOutlook as JSON
		
	   }
	

	
	//Hien thi danh sach loi
	def displayErrorQLRR={
	
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
	
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
		/*	if(params.NHCDLoi!=null && params.NHCDLoi!='')
				eq("tenDonVi1",params.NHCDLoi)
			if(params.CNLoi!=null && params.CNLoi!='')
				eq("tenDonVi2",params.CNLoi)
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)*/
			if(params.IdNhanSu!=null&&params.IdNhanSu!='')
				eq("codeSalary",params.IdNhanSu)
				
				
			
		}
		def ErrorDonVi
	
		if(params.action=='displayErrorQLRR')
			ErrorDonVi = 'ErrorDonVi'

		def fromDate,toDate
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck
		
		if(params.HTPH!=null && params.HTPH!='')
			errorCheck=ErrorCheck.get(params.HTPH)
			
		
		
		def errorManagement=ErrorManagement.createCriteria().list{

			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
			
			eq('tenDonViNhap1',errorMasterUser.tenDonVi1)
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)
				
			if(params.NHCD!=null&&params.NHCD!='')// Ã„ï¿½Ã†Â¡n ViÃŒÂ£ nhÃƒÂ¢ÃŒÂ£p LÃƒÂ´ÃŒÆ’i
				eq('tenDonViNhap1',params.NHCD)
			if(params.CN!=null&&params.CN!='')
				eq('tenDonViNhap2',params.CN)
			if(params.PGD!=null&&params.PGD!='')
				eq('tenDonViNhap3',params.PGD)
			
			if(params.NHCDLoi!=null && params.NHCDLoi!='') // Ã„ï¿½Ã†Â¡n ViÃŒÂ£ GÃƒÂ¢y lÃƒÂ´ÃŒÆ’i
				eq("tenDonVi1",params.NHCDLoi)
			if(params.CNLoi!=null && params.CNLoi!='')
				eq("tenDonVi2",params.CNLoi)
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)

		
			if(params.LoiCap1!=null&&params.LoiCap1!='')
				eq('loiCap1',params.LoiCap1)
			if(params.LoiCap2!=null&&params.LoiCap2!='')
				eq('loiCap2',params.LoiCap2)
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			
				
			if(params.HTPH!=null && params.HTPH!='')
				eq('errorCheck',errorCheck)

			order("id", "desc")
		}
		
		render view:'/opError/errorManaDisplayAllError', model:[errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,ErrorDonVi:ErrorDonVi]
	}
	
	def getErrorDisplay={
		render view:'/opError/errorManaDisplayAllError', model:[NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,exportExcel:params.exportExcel]

	}

    def getErrorDisplayAjaxDataTb={
        def errorUser
        def errorManagement
        println(params)
        if((params.NguoiGayLoi!=null && params.NguoiGayLoi!='') ||
                (params.IdNhanSu!=null&&params.IdNhanSu!='')){
            errorUser= ErrorUserCreate.withCriteria(){
                if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
                    eq("userEmail",params.NguoiGayLoi)
                if(params.IdNhanSu!=null&&params.IdNhanSu!='')
                    eq("codeSalary",params.IdNhanSu)

            }
        }


        def fromDate,toDate
        if(params.fromDate!=null)
        {
            fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
            toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
        }
        else
        {
            fromDate = new Date();
            fromDate.setMonth(fromDate.month-1);
            toDate=new Date();
        }

        def errorCategory
        if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
        {
            errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
        }
        def errorCheck

        if(params.HTPH!=null && params.HTPH!='')
            errorCheck=ErrorCheck.get(params.HTPH)
        //    println(errorUser?.errorManagement?.id)
        def query  = {
            if (((params.NguoiGayLoi != null && params.NguoiGayLoi != '') || (params.IdNhanSu != null && params.IdNhanSu != ''))
                    && errorUser && errorUser.size > 0) {

                'in'('id', errorUser.errorManagement.id)
                /*    println('1')
                    errorUserCreate{
                        'in'('id',errorUser.id)
                    }*/
            }

            if (((params.NguoiGayLoi != null && params.NguoiGayLoi != '') || (params.IdNhanSu != null && params.IdNhanSu != ''))
                    && (!errorUser || errorUser.size <= 0)) {
                //    println('2')
                errorUserCreate {
                    eq('id', '-1'.toLong())
                }
            }


            if (params.LoaiNghiepVu != null && params.LoaiNghiepVu != '')
                eq('errorCategory', errorCategory)

            if (params.NHCD != null && params.NHCD != '')
                eq('tenDonViNhap1', params.NHCD)
            if (params.CN != null && params.CN != '')
                eq('tenDonViNhap2', params.CN)
            if (params.PGD != null && params.PGD != '')
                eq('tenDonViNhap3', params.PGD)

            if (params.NHCDLoi != null && params.NHCDLoi != '')
                eq("tenDonVi1", params.NHCDLoi)
            if (params.CNLoi != null && params.CNLoi != '')
                eq("tenDonVi2", params.CNLoi)
            if (params.PGDLoi != null && params.PGDLoi != '')
                eq("tenDonVi3", params.PGDLoi)


            if (params.LoiCap1 != null && params.LoiCap1 != '')
                eq('loiCap1', params.LoiCap1)
            if (params.LoiCap2 != null && params.LoiCap2 != '')
                eq('loiCap2', params.LoiCap2)
            if (params.LoiCap3 != null && params.LoiCap3 != '')
                eq('loiCap3', params.LoiCap3)
            if (params.NguoiNhap != null && params.NguoiNhap != '')
                eq('nguoiNhap', params.NguoiNhap)
            if (params.TrangThai != null && params.TrangThai != '')
                eq('trangThai', params.TrangThai.toInteger())
            if (params.KieuNgay == null) {
                between('ngayXayRa', fromDate, toDate)
            } else if (params.KieuNgay == "1") {
                between('ngayXayRa', fromDate, toDate)
            } else if (params.KieuNgay == "2") {
                between('thoiHanKhacPhuc', fromDate, toDate)
            } else if (params.KieuNgay == "3")
                between('thoiGianNhapVaoHeThong', fromDate, toDate)
            if (params.HTPH != null && params.HTPH != '')
                eq('errorCheck', errorCheck)

            if(params.iSortCol_0 == '0'){
                order("id", params.sSortDir_0)
            }else if (params.iSortCol_0 == '7'){
                order("ngayXayRa", params.sSortDir_0)
            }else if (params.iSortCol_0 == '8'){
                order("thoiHanKhacPhuc", params.sSortDir_0)
            }else if (params.iSortCol_0 == '9'){
                order("thoiGianNhapVaoHeThong", params.sSortDir_0)
            }

        }


        errorManagement=ErrorManagement.createCriteria().list(query)
        def resultTotal = new ArrayList()
        def result = new ArrayList()
        def resultFinal = new JSONObject()
        def currentuser = User.findByUsername(springSecurityService.authentication.getName())
        def curentrole = UserRole.findByUser(currentuser)
        if(params.sSearch){
            println("1")
            println("------")
            errorManagement.eachWithIndex{tt,i ->
                def userEmal = ''
                def levelError = ''
                def linkDetails
                if(curentrole.role.authority.equals("ROLE_CVQLRR")){
                    linkDetails = "<a href="+
                            "${createLink(controller:'opError',action:'getErrorDetail',params:[id:tt.id])}>Xem</a>"
                }else{
                    linkDetails = "<a href="+
                            "${createLink(controller: 'opError', action: 'viewErrorDetail', params: [id:tt.id])}>Xem</a>"

                }
                tt.errorUserCreate.each{u ->
                    userEmal += u?.userEmail +"<br>"
                    levelError = u?.levelError +"<br>"
                }
                def temp1 = UnitDepart.get(tt.tenDonVi3)?.name.toString();
                def temp2 = ErrorList.get(tt.loiCap3)?.name.toString()
                def temp3 = ErrorStatus.get(tt.trangThai).nameStatus.toString()
            //    println(i)

                 if(tt.id.toString().contains(params.sSearch)||temp1.contains(params.sSearch)||
                         temp2.contains(params.sSearch)||tt.motaChiTiet.toString().contains(params.sSearch)||
                         userEmal.toString().contains(params.sSearch)||levelError.toString().contains(params.sSearch)||
                         temp3.contains(params.sSearch)||DateUtil.formatDetailDate(tt.ngayXayRa).toString().contains(params.sSearch)||
                         DateUtil.formatDetailDate(tt.thoiHanKhacPhuc).toString().contains(params.sSearch)||DateUtil.formatDetailDate(tt.thoiGianNhapVaoHeThong).toString().contains(params.sSearch)){
                        resultTotal.add([tt.id,tt?temp1:null,
                                   tt?temp2:null,tt.motaChiTiet,userEmal,levelError,
                                   temp3,DateUtil.formatDate(tt.ngayXayRa),
                                   DateUtil.formatDate(tt.thoiHanKhacPhuc),
                                   DateUtil.formatDetailDate(tt.thoiGianNhapVaoHeThong),
                                   linkDetails])
                }
            }
            if(params.exportExcel=="ExportEcel"){
                def data
                data = exportExcelService.errorDisplay(resultTotal)
                writeExcel(data)
            }else{
                for(int i = params.iDisplayStart.toInteger(); i < (params.iDisplayStart.toInteger() + 10);i++){
                    if(i < resultTotal.size()){
                        result << resultTotal[i]
                    }
                }
                resultFinal.put("iTotalRecords", ErrorManagement.count());
                resultFinal.put("iTotalDisplayRecords", resultTotal.size());
                resultFinal.put("aaData", result);
                render resultFinal as JSON
            }
        }else{
            if(params.exportExcel=="ExportEcel"){
                def header //= ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
                def listContent = []
                //listContent<<header
                String ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap
//			SimpleDateFormat Spdate = new SimpleDateFormat("yyyy-MM-dd");
                errorManagement.each {
                    //// // println it
                    ID = it.id
                    tenDV = (UnitDepart.get(it.tenDonVi3)?.code+'-'+UnitDepart.get(it.tenDonVi3)?.name)
                    nhomLoi3 = (ErrorList.get(it.loiCap3)?.code+'-'+ErrorList.get(it.loiCap3)?.name)
                    moTaLoi = it.motaChiTiet
                    userLoi=''
                    capDoLoi=''
                    it.errorUserCreate.each {
                        userLoi = userLoi + it?.userEmail + '\n'
                        capDoLoi = capDoLoi + it?.levelError + '\n'
                    }
                    trangThai = ErrorStatus.get(it.trangThai)?.nameStatus

                    ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
                    thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )

                    ngayGioNhap = DateUtil.formatDate(it.thoiGianNhapVaoHeThong)
                    header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap]
                    listContent<<header
                }// end if params.exportExcel

                def data
                data = exportExcelService.errorDisplay(listContent)
                writeExcel(data)

            }
            for(int i = params.iDisplayStart.toInteger(); i < (params.iDisplayStart.toInteger() + 10);i++){
                if(i < errorManagement.size()){
                    def userEmal = ''
                    def levelError = ''
                    def linkDetails
                    if(curentrole.role.authority.equals("ROLE_CVQLRR")){
                        linkDetails = "<a href="+
                                "${createLink(controller:'opError',action:'getErrorDetail',params:[id:errorManagement[i].id])}>Xem</a>"
                    }else{
                        linkDetails = "<a href="+
                                "${createLink(controller: 'opError', action: 'viewErrorDetail', params: [id:errorManagement[i].id])}>Xem</a>"

                    }
                    errorManagement[i].errorUserCreate.each{u ->
                        userEmal += u?.userEmail +"<br>"
                        levelError = u?.levelError +"<br>"
                    }
                    result <<[errorManagement[i].id,errorManagement[i]?UnitDepart.get(errorManagement[i].tenDonVi3)?.name:null,
                              errorManagement[i]?ErrorList.get(errorManagement[i].loiCap3)?.name:null,errorManagement[i].motaChiTiet,userEmal,levelError,
                                   ErrorStatus.get(errorManagement[i].trangThai).nameStatus,DateUtil.formatDate(errorManagement[i].ngayXayRa),
                                   DateUtil.formatDate(errorManagement[i].thoiHanKhacPhuc),DateUtil.formatDetailDate(errorManagement[i].thoiGianNhapVaoHeThong),
                                   linkDetails]
                }
            }
            resultFinal.put("iTotalRecords", ErrorManagement.count());
            resultFinal.put("iTotalDisplayRecords", errorManagement.size());
            resultFinal.put("aaData", result);
            render resultFinal as JSON
        }
    }
	
	def getErrorDetail={
		
		
		//sendMail(['anhnnt1@m1tech.com.vn'],'XXX',['anhnnt1@m1tech.com.vn'],'XXX')
		//def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code+0')
		def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		def today = DateUtil.formatDate(new Date())
		def errorManagement=ErrorManagement.get(params.id.toInteger())
		def user = User.findByUsername( springSecurityService.principal.username)
		
		def errorlist1=ErrorList.executeQuery('from ErrorList e where e.ord=1 and e.status>=0 order by e.code+0')
		def error1=ErrorList.get(errorManagement.loiCap1.toInteger())
		
		def errorlist2=ErrorList.findAllByParentAndStatusGreaterThan(error1,-1)		
		def error2=ErrorList.get(errorManagement.loiCap2.toInteger())		
		def errorlist3=ErrorList.findAllByParentAndStatusGreaterThan(error2,-1)
		
		def unitDepart1=UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');
		
		def unit1=UnitDepart.get(errorManagement.tenDonVi1)
		def unitDepart2=UnitDepart.findAllByParentAndStatusGreaterThan(unit1,-1)			 
		def unitDepart3= UnitDepart.findAllByParentAndStatusGreaterThan(UnitDepart.get(errorManagement.tenDonVi2),-1)		 
		def countErrorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement).size()
		if(countErrorUsers==0)
			countErrorUsers=1
		
		def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
		
		 
		def errorStatus=ErrorStatus.executeQuery('from ErrorStatus e where status>=0 order by e.code+0')
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		def errorCheck = ErrorCheck.executeQuery('from ErrorCheck e where status>=0 order by e.code+0')
		def errorCategory = ErrorCategory.executeQuery('from ErrorCategory e where status>=0 order by e.code+0')
		
		 
		 
		def allUnitDepart3=UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def allErrorList3 = ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')
		def allUnitDepart2=UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		def allErrorList2 = ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')
		 
		
		def isSave="NoSave" 
		if(errorManagement.nguoiNhap.toLowerCase() == springSecurityService.principal.username.toLowerCase())
			isSave="Save"
		
		def role = user.getAuthorities().authority
		def check = false
			role.each{
			if (it=='ROLE_GDTT_LEVEL2'){
				check = true
			}
			else
				isSave="Save"
			}
			def isSaveStatus="No"
			def userCreate=errorManagement.errorUserCreate
			def userC
			errorManagement.errorUserCreate.each{
		
			if(it.userEmail.toLowerCase()==springSecurityService.principal.username.toLowerCase())
			{
				isSaveStatus="Yes"
			}
		
		}
		render view:'/opError/errorManaDetail',model:[errorManagement:errorManagement,errorlist1:errorlist1,errorlist2:errorlist2,errorlist3:errorlist3,allErrorList3:allErrorList3,unitDepart1:unitDepart1,unitDepart2:unitDepart2,unitDepart3:unitDepart3,allUnitDepart3:allUnitDepart3,currDate:today,countErrorUsers:countErrorUsers,errorComment:errorComment,user:user,errorStatus:errorStatus,errorType:errorType,errorCheck:errorCheck,errorCategory:errorCategory,isSave:isSave,isSaveStatus:isSaveStatus,allUnitDepart2:allUnitDepart2,allErrorList2:allErrorList2]		
	}
	
	def viewErrorDetail={
				
//		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		//def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code+0')
		//def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		def today = DateUtil.formatDate(new Date())
		def errorManagement=ErrorManagement.get(params.id.toInteger())
		def user = User.findByUsername( springSecurityService.principal.username)
		def errorCheck = ErrorCheck.executeQuery('from ErrorCheck e where status>=0 order by e.code+0')
		def errorCategory = ErrorCategory.executeQuery('from ErrorCategory e where status>=0 order by e.code+0')
		
		def unitDepart1=UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0');		
		def unit1=UnitDepart.get(errorManagement.tenDonVi1)
		def unitDepart2=UnitDepart.findAllByParentAndStatusGreaterThan(unit1,-1)		
		def unitDepart3= UnitDepart.findAllByParentAndStatusGreaterThan(UnitDepart.get(errorManagement.tenDonVi2),-1)
		
		def errorlist1=ErrorList.executeQuery('from ErrorList e where e.ord=1 and e.status>=0 order by e.code+0')
		def error1=ErrorList.get(errorManagement.loiCap1.toInteger())		
		def errorlist2=ErrorList.findAllByParentAndStatusGreaterThan(error1,-1)
		def error2=ErrorList.get(errorManagement.loiCap2.toInteger())
		def errorlist3=ErrorList.findAllByParentAndStatusGreaterThan(error2,-1)
		
			
		
		def countErrorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement).size()
		
		if(countErrorUsers==0)
			countErrorUsers=1
		
		def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
		def errorStatus=ErrorStatus.executeQuery('from ErrorStatus e where status>=0 order by e.code+0')
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
		def isSave="NoSave"
		 
		
		if(errorManagement.nguoiNhap.toLowerCase()== springSecurityService.principal.username.toLowerCase())
			isSave="Save"		
			
		def role = user.getAuthorities().authority
		def check = false
		role.each{
			if (it=='ROLE_GDTT'||it== 'ROLE_GDTT_LEVEL2'|| it=='ROLE_GDTT_LEVEL3'||it=='ROLE_GDTT_LEVEL4'){
				check = true				
			}
			else
				isSave="Save"
		}
		def isSaveStatus="No"
		def userCreate=errorManagement.errorUserCreate
		def userC
		errorManagement.errorUserCreate.each{
			
			if(it.userEmail.toLowerCase()==springSecurityService.principal.username.toLowerCase())
			{
				isSaveStatus="Yes"
			}
			
		}
		def allUnitDepart3=UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def allErrorList3 = ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')
//		def allUnitDepart2=UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
//		def allErrorList2 = ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')
		 		
		render view:'/opError/viewErrorManaDetail',model:[errorType:errorType,errorManagement:errorManagement,errorlist1:errorlist1,errorlist2:errorlist2,errorlist3:errorlist3,allErrorList3:allErrorList3,unitDepart1:unitDepart1,unitDepart2:unitDepart2,unitDepart3:unitDepart3,allUnitDepart3:allUnitDepart3,currDate:today,countErrorUsers:countErrorUsers,errorComment:errorComment,user:user,errorStatus:errorStatus,isSave:isSave,errorType:errorType,isSaveStatus:isSaveStatus,errorCheck:errorCheck,errorCategory:errorCategory]
		
	}
	//Delete all Error Delete
	
	def deleteAllErrorManagement={
		
		def allError=ErrorManagement.getAll()
		print allError
		allError.each{
			def errorManagement=ErrorManagement.get(it.id)
			def errorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement)
			
			errorUsers.each{
				errorManagement.removeFromErrorUserCreate(it)
				it.delete(flush:true)
			}
			def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
			 
			errorComment.each{
				errorManagement.removeFromErrorsComments(it)
				it.delete(flush:true)
			}
			errorManagement.delete(flush:true)
		}
		
	
		redirect (controller:'opError', action:'getErrorDisplay')
	}
	
	//Update ErrorManagement
	def updateErrorManaList={
		
		
		//THuc hien xoa
		if(params.actionButton=="errorDelete")
		{
			def errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())
			def errorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement)
			
			errorUsers.each{
				errorManagement.removeFromErrorUserCreate(it)
				it.delete(flush:true)
			}
			def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
			
			errorComment.each{
				errorManagement.removeFromErrorsComments(it)
				it.delete(flush:true)
			}
			def arrTo=[]
			def arrCc=[errorManagement.nguoiNhap]
			if(errorManagement.nguoiSua!=''){
				arrCc+=[errorManagement.nguoiSua]
			}
			 
			for(int i=1;i<=params.dateCount.toInteger();i++)
			{
				if(params.('OutLook_'+i)==''){
					arrTo +="default"
				}else{
					arrTo +=params.('OutLook_'+i)
				}
				if(i==params.dateCount.toInteger()){
					sendEmailError("DEL",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorManagement+"",ErrorList.get(errorManagement.loiCap3)?.name,"","")
				}
			}
			
			errorManagement.delete(flush:true)
			flash.message="Lỗi đã được xóa thành công."
			
		}
		else if (params.actionButton=="updateStatus")
		{
			
			def errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())			
			errorManagement.trangThai=  params.TrangThai.toInteger()			
			errorManagement.thoiGianCapNhapTrangThai = new Date()
			flash.message = "Trạng thái đã được cập nhật."

			errorManagement.save(flush:true)
			def arrTo=[]
			def arrCc=[errorManagement.nguoiNhap]
			if(errorManagement.nguoiSua!=''){
				arrCc+=[errorManagement.nguoiSua]
			}
			def nameStatus = ErrorStatus.get(params.TrangThai.toInteger())
			 
			for(int i=1;i<=params.dateCount.toInteger();i++)
			{
				if(params.('OutLook_'+i)==''){
					arrTo +="default"
				}else{
					arrTo +=params.('OutLook_'+i)
				}
				if(i==params.dateCount.toInteger()){
					sendEmailError("DTT",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorManagement+"",ErrorList.get(errorManagement.loiCap3)?.name,"",nameStatus.nameStatus)
				}
			}
			if(errorManagement.hasErrors()){
				errorManagement.errors.each{
					
					flash.message = "Lỗi sảy ra: Xin vui lòng gửi thoonng tin lên IT Service Desk để được hỗ trợ."
					flash.messageType = "message info"
				}
			}
			
		}
		
		else
		{
				//Do phia nghiep vu yeu cau lang ngoang nen lam theo cach sau:
				//1. Tim ErrorManagement update
				//2. Xoa het du lieu trong ban errorUser roi insert vao lai
			
				def errorManagement
				if(params.actionButton=="dupplicateError")
				{
					 
					 errorManagement=new ErrorManagement()
					 errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
					 errorManagement.nguoiNhap=params.NguoiNhap
					 def errorMC=ErrorMasterUserCreate.findByUserEmail(params.NguoiNhap)
					 errorManagement.tenDonViNhap1=errorMC.tenDonVi1
					 errorManagement.tenDonViNhap2=errorMC.tenDonVi2
					 errorManagement.tenDonViNhap3=errorMC.tenDonVi3
					 errorManagement.thoiGianNhapVaoHeThong = new Date()
					 errorManagement.fileName = params.fileName
					 	
					
					 flash.message = "Lỗi đã được dupplicate thành công."
					 flash.messageType = "message info"
				 
				}
				else 
				{
					
					 errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())
					 errorManagement.thoiGianSua = new Date()
					 errorManagement.nguoiSua = springSecurityService.principal.username
					 def errorStatus = ErrorStatus.findById(params.TrangThai)
					 
					 def TrangThaiTruoc = errorManagement.trangThai.toInteger()
					 if(errorManagement.trangThai!=params.TrangThai)
					 {
						 errorManagement.thoiGianCapNhapTrangThai = new Date()
					 }
					 
					 //Xoa Error User Create
					 def errorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement)					 
					 errorUsers.each{
						 errorManagement.removeFromErrorUserCreate(it)
						 it.delete(flush:true)
					 }
					 flash.message = "Anh/chị đã cập nhập thành công"
					 flash.messageType = "message info"
				}
					 
				//// // println params
				def TrangThaiTruoc
				if(params.actionButton!="dupplicateError")
					TrangThaiTruoc = errorManagement.trangThai.toInteger()
				errorManagement.bienPhapKhacPhuc=params.BienPhapKhacPhuc
				if(params.ThoiHanKhacPhuc!=null && params.ThoiHanKhacPhuc.length()>4)
				errorManagement.thoiHanKhacPhuc=DateUtil.parseInputDate(params.ThoiHanKhacPhuc +' 00:00:00')				
				errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
				errorManagement.motaChiTiet=params.MotaChiTiet
				//errorManagement.nguoiNhap=params.NguoiNhap
//				errorManagement.nHCD=params.NHCD
				errorManagement.tenDonVi1 = params.TenDonVi1
				errorManagement.tenDonVi2 = params.TenDonVi2
				errorManagement.tenDonVi3 = params.TenDonVi3	//				
				errorManagement.loiCap1=params.LoiCap1
				errorManagement.loiCap2=params.LoiCap2
				errorManagement.loiCap3=params.LoiCap3				
				if(params.SoLuongKiemTra!='')
					errorManagement.soLuongKiemTra = params.SoLuongKiemTra
				else
				errorManagement.soLuongKiemTra = 1
				errorManagement.tongSoChonMau = params.TongSoChonMau
				errorManagement.moTaAnhHuong=params.MoTaAnhHuong
				errorManagement.giaTriGiaoDich=params.GiaTriGiaoDich
				errorManagement.hoSoVaTenHoSo=params.HoSoVaTenHoSo
				errorManagement.maGiaoDich=params.MaGiaoDich
				errorManagement.soCifKhachHang=params.SoCifKhachHang
				errorManagement.tenKhachHang=params.TenKhachHang
				errorManagement.trangThai=  params.TrangThai.toInteger()
				errorManagement.loaiTien=params.LoaiTien
				errorManagement.errorCheck = ErrorCheck.get(params.errorCheck)
				errorManagement.errorCategory = ErrorCategory.get(params.errorCategory)
				
				if(params.hfDeleteFile=="deleteFile")
				{				
					errorManagement.fileName =null
				}
				/*errorManagement.errorType=ErrorType.get(params.errorType)*/
				 
				if(params.uploadFile!=null && params.uploadFile!="")
				{
					def file = request.getFile('uploadFile')
				
					if(!file.empty){					
						
						def fileName = file.getOriginalFilename()						
						String absolutePath = getServletContext().getRealPath("errorFiles/"+ fileName)
						File fileOut = new File(absolutePath)
						file.transferTo(fileOut)					
						errorManagement.fileName = fileName					
						
					}
				}
				
			
				
				
				
				def userCreate=new ErrorUserCreate()
				 
				for(int i=1;i<=params.dateCount.toInteger();i++)
				{
					 
					if(params.('HoVaTen_'+i)!=null && params.('HoVaTen_'+i)!="")
					{
						 
						userCreate=new ErrorUserCreate()			
						userCreate.userEmail=params.('OutLook_'+i)
						userCreate.levelError=params.('Mucdoloi_'+i)
						userCreate.fullName=params.('HoVaTen_'+i)
						userCreate.title=params.('ChucDanh_'+i)
						userCreate.bDSUser=params.('BdsUser_'+i)
						userCreate.codeSalary=params.('IdNhanSu_'+i)
						userCreate.tenDonVi1=params.('NHCD_Id_'+i)
						userCreate.tenDonVi2=params.('TenDonVi_Id_'+i)
						userCreate.tenDonVi3=params.('PGD_Id_'+i)
						
						userCreate.errorDonVi1=params.TenDonVi1
						userCreate.errorDonVi2=params.TenDonVi2
						userCreate.errorDonVi3=params.TenDonVi3
						
						errorManagement.addToErrorUserCreate(userCreate)

					}
				}
				//flash.message = "LÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i Ãƒâ€žÃ¢â‚¬ËœÃƒÆ’Ã‚Â£ Ãƒâ€žÃ¢â‚¬ËœÃƒâ€ Ã‚Â°ÃƒÂ¡Ã‚Â»Ã‚Â£c lÃƒâ€ Ã‚Â°u vÃƒÆ’Ã‚Â o hÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¡ thÃƒÂ¡Ã‚Â»Ã¢â‚¬Ëœng."
		
		errorManagement.save(flush:true)
		
		def arrTo=[]
		def arrCc=[params.NguoiNhap]
		if(params.actionButton!="dupplicateError"){
			
			for(int i=1;i<=params.dateCount.toInteger();i++)
			{	
				if(params.('OutLook_'+i)==''){
					arrTo +="default"
				}else{
					arrTo +=params.('OutLook_'+i)
				}
				if(errorManagement.nguoiSua != params.NguoiNhap)			
					arrCc+=errorManagement.nguoiSua
				if(i==params.dateCount.toInteger()){
					if(TrangThaiTruoc != params.TrangThai.toInteger()){
						def nameStatus = ErrorStatus.get(params.TrangThai.toInteger())
						sendEmailError("DTT",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorManagement+"",ErrorList.get(params.LoiCap3).name,"",nameStatus.nameStatus)
					}else{
						sendEmailError("ED",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorManagement+"",ErrorList.get(params.LoiCap3).name,"","")
					}
					
				}
			}
		}else{
			for(int i=1;i<=params.dateCount.toInteger();i++)
			{
				if(params.('OutLook_'+i)==''){
					arrTo +="default"
				}else{
					arrTo +=params.('OutLook_'+i)
				}
				 
				if(i==params.dateCount.toInteger()){
//					sendEmailError("CR",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorManagement+"",ErrorList.get(params.LoiCap3).name,"","")
					sendEmailError("CR",arrTo,arrCc,params.MotaChiTiet,""+errorManagement.id+"",ErrorList.get(params.LoiCap3)?.name,"","")
				}
			}
		}
				if(errorManagement.hasErrors()){
					errorManagement.errors.each{
						 
						flash.message = "Lỗi sảy ra: Xin vui lòng gửi thoonng tin lên IT Service Desk để được hỗ trợ."
						flash.messageType = "message info"
					}
				}				
		}
		if(params.ROLES=='GDTTL2'){
			redirect (controller:'opError', action:'getErrorDisplayLevel2')
		}else if(params.ROLES=='GDTTL3'){
			redirect (controller:'opError', action:'getErrorDisplayLevel3')
		}else if(params.ROLES=='GDTTL4'){
			redirect (controller:'opError', action:'getErrorDisplayLevel4')
		}else if(params.ROLES=='GDTT'){
			redirect (controller:'opError', action:'getErrorDisplayLevel1')
		}else{	
			redirect (controller:'opError', action:'getErrorDisplay')
		}
  
	}

///Bao cao
	def reportError={		
		def errorManagement = null
			
		def unitDepart=UnitDepart.getAll()
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		render view:'/opError/rList', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1,typeReport:typeReport]
	}
	
	def preloadReport={
		
		
		
    }
	def reportList = {
		def model = [:]
		def process
		def fromDate
		def toDate
		def department,users,departmentId
		def departments = Department.findAllByStatusGreaterThanEquals('0')
		if (params.search){
			if (params.department){
				department = Department.get(params.department)
				departmentId=department.id
			}
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}else{
			def today = new Date()
			toDate = DateUtil.formatDate(today)
			toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
			today.setMonth(today.month-1)
			fromDate = DateUtil.formatDate(today)
			fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

		}
		if(department){
			users= User.findAllByProp1(department.id)
			departmentId = department.id
		}
		else
			users=User.list()
			
		if (users.size()>0){
			process = OpRiskProcess.createCriteria().list{
				ge('status',0)
				between('dateCreated',fromDate,toDate)
				'in'('employee',users)
				order("id", "desc")
			}
		}
		model << [process:process,departments:departments,departmentId:departmentId]
		render view:'/opRisk/reportList', model:model

	}
	
		//Bao cao liet ke danh sach loi
	def reportErrorList={


		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')		
		def errorStatus=ErrorStatus.getAll()
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
/*		if (params.exportExcel=="ExportExcel"){

			
		}*/
			
			def allUnitDepart3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
			def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
			def allErrorList3 = ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')
			def allErrorList2 = ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')
			def unitDepart2
			if(params.CNLoi){
				def error = UnitDepart.get(params.NHCDLoi)
				
				unitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 and e.parent= ? order by e.code+0',error)
				
//				unitDepart2 = UnitDepart.findAllWhere(parent: error)
//				unitDepart2 = UnitDepart.findAllByParent(error)
				
			}
			def errorList2
			if(params.LoiCap2){
				def error = ErrorList.get(params.LoiCap1)
//				errorList2 = ErrorList.findAllByParent(error)
				errorList2 = ErrorList.executeQuery('from ErrorList e where e.ord =2 and e.status>=0 and parent = ? order by e.code+0',error)
//				errorList2 = ErrorList.findAllWhere(parent: error)
//				// // println params.LoiCap2+" >>>>>>>> "+error+" >>>>>>>>>>>> "+ errorList2.name
			}
			def unitDepart2Nhap
			if(params.CN){
				def error = UnitDepart.get(params.NHCD)
				unitDepart2Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 and parent = ? order by e.code+0',error)
//				unitDepart2Nhap = UnitDepart.findAllWhere(parent: error)
			}
			render view:'/opError/errorReportList', model:[errorStatus:errorStatus,errorType:errorType,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,allErrorList3:allErrorList3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,allUnitDepart3:allUnitDepart3,unitDepart2:unitDepart2,errorList2:errorList2,unitDepart2Nhap:unitDepart2Nhap,allUnitDepart2:allUnitDepart2,allErrorList2:allErrorList2]
	}
    def ajaxtbreportErrorList = {
        def fromDate,toDate
        def user = User.findByUsername( springSecurityService.principal.username)

        def nameMa
        def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)

        def role = user.getAuthorities().authority
        def checkRole = false

        role.each{
            if (it=='ROLE_GDTT'){
                checkRole = true
            }
        }
        def checkRole2 = false

        role.each{
            if (it=='ROLE_CVQLRR'){
                checkRole2 = true
            }
        }

        if(params.fromDate!=null)
        {
            fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
            toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
        }
        else
        {
            fromDate = new Date();
            fromDate.setMonth(fromDate.month-1);
            toDate=new Date();
        }

        def errorUser
/*            errorUser= ErrorUserCreate.withCriteria(){
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
			*//*if(params.NHCDLoi!=null && params.NHCDLoi!='')
				eq("tenDonVi1",params.NHCDLoi)
			if(params.CNLoi!=null && params.CNLoi!='')
				eq("tenDonVi2",params.CNLoi)
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)*//*
			if(params.IdNhanSu!=null&&params.IdNhanSu!='')
				eq("codeSalary",params.IdNhanSu)
		}*/

        if((params.NguoiGayLoi!=null && params.NguoiGayLoi!='') ||
                (params.IdNhanSu!=null&&params.IdNhanSu!='')){
            errorUser= ErrorUserCreate.withCriteria(){
                if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
                    eq("userEmail",params.NguoiGayLoi)
                if(params.IdNhanSu!=null&&params.IdNhanSu!='')
                    eq("codeSalary",params.IdNhanSu)

            }
        }

        def errorCategory
        if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
        {
            errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
        }
        def errorCheck
        if(params.HTPH != null && params.HTPH!='')
        {
            errorCheck = ErrorCheck.get(params.HTPH)
        }

        def errorManagement
        /*errorManagement = ErrorManagement.createCriteria().list{
        if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
        {
            errorUserCreate{
                if(errorUser.size()>0){
                    'in'('id',errorUser.id)
                }else{
                    eq('id','-1'.toLong())
                }
            }
        }*/

        def query  = {
            if(((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
                    && errorUser && errorUser.size > 0)
            {
                errorUserCreate{
                    'in'('id',errorUser.id)
                }
            }

            if(((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
                    && (!errorUser || errorUser.size <= 0))
            {
                errorUserCreate{
                    eq('id','-1'.toLong())
                }
            }


            if(params.HTPH!=null&&params.HTPH!=''){
                eq('errorCheck',errorCheck)
            }
            if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!=''){
                eq('errorCategory',errorCategory)
            }
            if(params.NHCD!=null&&params.NHCD!=''){// Ã„ï¿½Ã†Â¡n ViÃŒÂ£ nhÃƒÂ¢ÃŒÂ£p LÃƒÂ´ÃŒÆ’i
                eq('tenDonViNhap1',params.NHCD)
            }
            if(params.CN!=null&&params.CN!=''){
                eq('tenDonViNhap2',params.CN)
            }
            ///Neu la role GDTT
            if(checkRole)
            {

                eq('tenDonViNhap3',errorMasterUser.tenDonVi3)

            }
            else
            {
                if(params.PGD!=null&&params.PGD!='')
                    eq('tenDonViNhap3',params.PGD)
            }


            if(params.NHCDLoi!=null && params.NHCDLoi!=''){
                eq("tenDonVi1",params.NHCDLoi)
            }
            if(params.CNLoi!=null && params.CNLoi!=''){
                eq("tenDonVi2",params.CNLoi)
            }
            if(params.PGDLoi!=null && params.PGDLoi!=''){
                eq("tenDonVi3",params.PGDLoi)
            }

            if(params.LoiCap1!=null && params.LoiCap1!=''){
                eq('loiCap1',params.LoiCap1)
            }

            if(params.LoiCap2!=null && params.LoiCap2!=''){
                eq('loiCap2',params.LoiCap2)
            }
            if(params.LoiCap3!=null && params.LoiCap3!='')
                eq('loiCap3',params.LoiCap3)
            if(params.NguoiNhap!=null && params.NguoiNhap!=''){
                eq('nguoiNhap',params.NguoiNhap)
            }
            //params.trangThai.toInterger()

            if(params.TrangThai!=null && params.TrangThai!='')
            {
                eq('trangThai',params.TrangThai.toInteger())
            }

            if(params.KieuNgay==null)
            {
                between('ngayXayRa',fromDate,toDate)
            }
            else if (params.KieuNgay=="1")
            {
                between('ngayXayRa',fromDate,toDate)
            }
            else if(params.KieuNgay=="2")
            {
                between('thoiHanKhacPhuc',fromDate,toDate)
            }
            else if(params.KieuNgay=="3")		{
                between('thoiGianNhapVaoHeThong',fromDate,toDate)
            }
            order("id", "desc")
        }

        errorManagement=ErrorManagement.createCriteria().list(query)
        def result = new ArrayList()
        def resultTotal = new ArrayList()
        if(params.sSearch){
            errorManagement.each{tt ->
                def userEmal = ''
                def levelError = ''
                def userfullname = ''
                def usertitle = ''
                def usertenDonVi1 = ''
                def usertenDonVi2 = ''
                def codetenDonvi2 = ''
                def usertenDonVi3 = ''
                def codetenDonvi3 = ''
                def bDsUser = ''
                def codeSalaryUser = ''
                def linkDetails = ''
                tt.errorUserCreate.each{u ->
                    userEmal += u?.userEmail +"<br>"
                    levelError = u?.levelError +"<br>"
                    userfullname += u.fullName +"<br>"
                    usertitle += u.title +"<br>"
                    usertenDonVi1 += UnitDepart.get(u.tenDonVi1)?.name +"<br>"
                    if(u.tenDonVi2.length()>3) {
                        usertenDonVi2 += "<br>"
                        codetenDonvi2 += "<br>"
                    }
                    else {
                        usertenDonVi2 += UnitDepart.get(u.tenDonVi2)?.name +"<br>"
                        codetenDonvi2 += UnitDepart.get(u.tenDonVi2)?.code +"<br>"
                    }
                    usertenDonVi3 += UnitDepart.get(u.tenDonVi3)?.name + "<br>"
                    codetenDonvi3 += UnitDepart.get(u.tenDonVi3)?.code + "<br>"
                    bDsUser += u.bDSUser + "<br>"
                    codeSalaryUser += u.codeSalary + "<br>"
                }
                def errorComent = ''
                tt.errorsComments.each{z ->
                    errorComent += "["+DateUtil.formatDetailDate(z.dateCreated)+"]"+ " [" +z.createdUserUpload +"] :"+" "+z.content +"<br>"
                }
                if(checkRole2){
                    linkDetails = "<a href="+
                            "${createLink(controller:'opError',action:'getErrorDetail',params:[id:tt.id])}>Xem</a>"
                }else{
                    linkDetails = "<a href="+
                            "${createLink(controller: 'opError', action: 'viewErrorDetail', params: [id:tt.id])}>Xem</a>"

                }
                def fileLink = ''
                if(tt.fileName){
                    fileLink = "<a  id='lblFilename' name='lblFilename' href="+ "${resource(dir:'errorFiles',file:tt.fileName)}"+">+${tt.fileName}</a>"
                }
                if(tt.id.toString().contains(params.sSearch)|| tt.errorCategory?.name.toString().contains(params.sSearch)||ErrorList.get(tt.loiCap1)?.name.toString().contains(params.sSearch)||
                        ErrorList.get(tt.loiCap2)?.name.toString().contains(params.sSearch)||ErrorList.get(tt.loiCap3)?.name.toString().contains(params.sSearch)||
                        tt.errorCheck?.name.toString().contains(params.sSearch)||DateUtil.formatDetailDate(tt.ngayXayRa).toString().contains(params.sSearch)|| tt.motaChiTiet.toString().contains(params.sSearch)||
                        tt.moTaAnhHuong.toString().contains(params.sSearch)||tt.bienPhapKhacPhuc.toString().contains(params.sSearch)||DateUtil.formatDetailDate(tt.thoiHanKhacPhuc).toString().contains(params.sSearch)||
                        ErrorStatus.get(tt.trangThai).nameStatus.toString().contains(params.sSearch)||userEmal.toString().contains(params.sSearch)||levelError.toString().contains(params.sSearch)||userfullname.toString().contains(params.sSearch)||usertitle.toString().contains(params.sSearch)||
                        usertenDonVi1.toString().contains(params.sSearch)||usertenDonVi2.toString().contains(params.sSearch)||usertenDonVi3.toString().contains(params.sSearch)||bDsUser.toString().contains(params.sSearch)||codeSalaryUser.toString().contains(params.sSearch)||
                        tt.nguoiNhap.toString().contains(params.sSearch)||ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.fullName.toString().contains(params.sSearch)||
                        ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.title.toString().contains(params.sSearch)||
                        UnitDepart.get(tt.tenDonViNhap1)?.name.toString().contains(params.sSearch)||UnitDepart.get(tt.tenDonViNhap2)?.name.toString().contains(params.sSearch)||
                        UnitDepart.get(tt.tenDonViNhap3)?.name.toString().contains(params.sSearch)||
                        ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.bDSUser.toString().contains(params.sSearch)||
                        ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.codeSalary.toString().contains(params.sSearch)||
                        tt.maGiaoDich.toString().contains(params.sSearch)||tt.giaTriGiaoDich.toString().contains(params.sSearch)||tt.loaiTien.toString().contains(params.sSearch)||tt.soCifKhachHang.toString().contains(params.sSearch)||
                        tt.tenKhachHang.toString().contains(params.sSearch)||tt.hoSoVaTenHoSo.toString().contains(params.sSearch)||UnitDepart.get(tt.tenDonVi1)?.name.toString().contains(params.sSearch)||
                        UnitDepart.get(tt.tenDonVi2)?.name.toString().contains(params.sSearch)||UnitDepart.get(tt.tenDonVi3)?.name.toString().contains(params.sSearch)||
                        tt.soLuongKiemTra.toString().contains(params.sSearch)||tt.tongSoChonMau.toString().contains(params.sSearch)||fileLink.toString().contains(params.sSearch)||
                        tt.nguoiSua.toString().contains(params.sSearch)||
                        DateUtil.formatDetailDate(tt.thoiGianSua).toString().contains(params.sSearch)||
                        DateUtil.formatDetailDate(tt.thoiGianNhapVaoHeThong).toString().contains(params.sSearch)||
                        errorComent.toString().contains(params.sSearch)){
                    resultTotal << [tt.id, tt.errorCategory?.name,ErrorList.get(tt.loiCap1)?.name,
                               ErrorList.get(tt.loiCap2)?.name,ErrorList.get(tt.loiCap3)?.name,
                               tt.errorCheck?.name,DateUtil.formatDate(tt.ngayXayRa), tt.motaChiTiet,
                               tt.moTaAnhHuong,tt.bienPhapKhacPhuc,DateUtil.formatDate(tt.thoiHanKhacPhuc),
                               ErrorStatus.get(tt.trangThai).nameStatus,userEmal,levelError,userfullname,usertitle,
                               usertenDonVi1,usertenDonVi2,usertenDonVi3,bDsUser,codeSalaryUser,
                               tt.nguoiNhap,ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.fullName,
                               ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.title,
                               UnitDepart.get(tt.tenDonViNhap1)?.name,UnitDepart.get(tt.tenDonViNhap2)?.name,
                               UnitDepart.get(tt.tenDonViNhap3)?.name,
                               ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.bDSUser,
                               ErrorMasterUserCreate.findByUserEmail(tt.nguoiNhap)?.codeSalary,
                               tt.maGiaoDich,tt.giaTriGiaoDich,tt.loaiTien,tt.soCifKhachHang,
                               tt.tenKhachHang,tt.hoSoVaTenHoSo,UnitDepart.get(tt.tenDonVi1)?.name,
                               UnitDepart.get(tt.tenDonVi2)?.name,UnitDepart.get(tt.tenDonVi3)?.name,
                               tt.soLuongKiemTra,tt.tongSoChonMau,fileLink,
                               tt.nguoiSua,
                               DateUtil.formatDetailDate(tt.thoiGianSua),
                               DateUtil.formatDetailDate(tt.thoiGianNhapVaoHeThong),
                               errorComent,linkDetails,codetenDonvi2,codetenDonvi3] //46
                }


            }

            if(params.exportExcel=="ExportEcel"){
                def dataExport = []
                resultTotal.each {rsT ->
                    dataExport << [rsT[0],rsT[35],UnitDepart.findByName(rsT[36]).code,rsT[36],UnitDepart.findByName(rsT[37]).code,rsT[37],
                                   rsT[12],rsT[13],rsT[14],rsT[15],rsT[16],rsT[46],rsT[17],rsT[47],rsT[18],rsT[19],rsT[20],rsT[1],rsT[2],rsT[3],rsT[4],
                                   rsT[5],rsT[6],rsT[7],rsT[8],rsT[9],rsT[10],rsT[11],rsT[21],rsT[22],rsT[23],rsT[24],rsT[25],rsT[26],rsT[27],
                                   rsT[28],rsT[29],rsT[30],rsT[31],rsT[32],rsT[33],rsT[34],rsT[38],rsT[39],rsT[40],rsT[41],rsT[42],rsT[43],rsT[44]]
/*                    header=[Id,NHCDKhoi,idCN,CN,idPGD,PGD,userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi,
                            loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai,
                            userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap,
                            maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo,
                            soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien]*/
                }
                def data
                data = exportExcelService.errorList(dataExport)
                writeExcel(data)
            }else{
                for(int i = params.iDisplayStart.toInteger(); i < (params.iDisplayStart.toInteger() + 10);i++){
                    if(i < resultTotal.size()){
                        result << resultTotal[i]
                    }
                }
                def resultFinal = new JSONObject()
                resultFinal.put("iTotalRecords", ErrorManagement.count());
                resultFinal.put("iTotalDisplayRecords", result.size());
                resultFinal.put("aaData", result);
                render resultFinal as JSON
            }
        }else{
            if(params.exportExcel=="ExportEcel"){
                def comments
                def header
                def listContent = []
//Thông tin mô tả
                def Id,loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai
//Thông tin gây lỗi
                def userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi
//Thông tun nhập lỗi
                def userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap
//Thông tin khách hàng
                def maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo
//Thông tin khác
                def NHCDKhoi,CN,idCN,PGD,idPGD,soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien
                println "Bc>>: " + errorManagement.size()
                errorManagement.eachWithIndex{c,i ->
                    //Thông tin mô tả
                    Id=""+c.id+""
                    NHCDKhoi= UnitDepart.get(c?.tenDonVi1)?.name
                    idCN= UnitDepart.get(c?.tenDonVi2)?.code
                    CN= UnitDepart.get(c?.tenDonVi2)?.name
                    idPGD= UnitDepart.get(c?.tenDonVi3)?.code
                    PGD = UnitDepart.get(c?.tenDonVi3)?.name

                    //Người gây lỗi
                    userOutLookLoi=''
                    capDoLoi=''
                    hoVaTenLoi=''
                    chucDanhLoi=''
                    NHCDKhoiLoi=''
                    IdCNLoi=''
                    CNLoi=''
                    IdPGDLoi=''
                    PGDLoi=''
                    userHeThongLoi=''
                    IDNhanSuLoi=''
                    c.errorUserCreate.each{

                        userOutLookLoi = userOutLookLoi + it.userEmail  + '\n'
                        capDoLoi = capDoLoi + it.levelError  + '\n'
                        hoVaTenLoi = hoVaTenLoi + it.fullName + '\n'
                        chucDanhLoi = chucDanhLoi + it.title + '\n'
                        NHCDKhoiLoi = NHCDKhoiLoi + UnitDepart.get(it.tenDonVi1)?.name + '\n'
                        if (it.tenDonVi2.length()>3)
                            CNLoi = CNLoi + '\n'
                        else{
                            IdCNLoi = IdCNLoi + UnitDepart.get(it.tenDonVi2)?.code + '\n'
                            CNLoi = CNLoi + UnitDepart.get(it.tenDonVi2)?.name + '\n'
                        }

                        if (it.tenDonVi3.length()>3)
                            PGDLoi = PGDLoi + '\n'
                        else{
                            IdPGDLoi = IdPGDLoi+UnitDepart.get(it.tenDonVi3)?.code + '\n'
                            PGDLoi = PGDLoi + UnitDepart.get(it.tenDonVi3)?.name + '\n'
                        }
                        userHeThongLoi = userHeThongLoi + it.bDSUser + '\n'
                        IDNhanSuLoi = IDNhanSuLoi + it.codeSalary + '\n'
                    }

//					------------------------------------------
                    loaiNghieoVu=c.errorCategory?.name
                    loiMuc1=(ErrorList.get(c.loiCap1)?.code+'-'+ErrorList.get(c.loiCap1)?.name)
                    loiMuc2=(ErrorList.get(c.loiCap2)?.code+'-'+ErrorList.get(c.loiCap2)?.name)
                    loiMuc3=(ErrorList.get(c.loiCap3)?.code+'-'+ErrorList.get(c.loiCap3)?.name)
                    hinhThucPH=c.errorCheck?.name
                    ngaySayRa=DateUtil.formatDate(c.ngayXayRa)
                    moTaChiTietLoi=c.motaChiTiet
                    moTaAnhHuong=c.moTaAnhHuong
                    kienNghiKP=c.bienPhapKhacPhuc
                    thoiHanKP=DateUtil.formatDate(c.thoiHanKhacPhuc)
                    trangThai=ErrorStatus.get(c.trangThai).nameStatus



                    //Người nhập lỗi
                    userOutLookNhap=c.nguoiNhap
                    hoVaTenNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.fullName?:''
                    chucDanhNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.title?:''
                    NHCDKhoiNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi1)?.name?:''
                    CNNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi2)?.name?:''
                    PGDNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi3)?.name?:''
                    userHeThongNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.bDSUser?:''
                    IDNhanSuNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.codeSalary?:''
                    //Thông tin khách hàng
                    maGiaoDich=c.maGiaoDich
                    giaTriGiaoDich=c.giaTriGiaoDich
                    loaiTien=c.loaiTien
                    soCif=c.soCifKhachHang
                    tenKhachHang=c.tenKhachHang
                    hoSoTenHoSo=c.hoSoVaTenHoSo
                    //Thông tin khác
//					NHCDKhoi=UnitDepart.get(c.tenDonVi1).name
//					CN=UnitDepart.get(c.tenDonVi2).name
//					PGD=UnitDepart.get(c.tenDonVi3).name
                    soLuongSaiPham=c.soLuongKiemTra
                    tongSoChonMau=c.tongSoChonMau
                    fileDinhKem=c.fileName?c.fileName:''
                    nguoiCapNhat=c.nguoiSua?c.nguoiSua:''
                    if (c.thoiGianSua==null)
                        GTCapNhat=c.thoiGianNhapVaoHeThong?DateUtil.formatDate(c.thoiGianNhapVaoHeThong):''
                    else
                        GTCapNhat=c.thoiGianSua?DateUtil.formatDate(c.thoiGianSua):''
                    TGKhacPhuc=c.thoiGianCapNhapTrangThai?DateUtil.formatDate(c.thoiGianCapNhapTrangThai):''
                    comments = ''
                    c.errorsComments.each{
                        comments = comments + "["+it.dateCreated+"]"+" "+"["+it.createdUserUpload+"]:"+" "+it.content + '\n\n'
                    }

                    YKien=comments
                    header=[Id,NHCDKhoi,idCN,CN,idPGD,PGD,userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi,
                            loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai,
                            userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap,
                            maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo,
                            soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien]

                    listContent<<header
                }
                def data
                data =exportExcelService.errorList(listContent)
                //File download
                writeExcel(data)


            }
            for(int i = params.iDisplayStart.toInteger(); i < (params.iDisplayStart.toInteger() + 10);i++) {
                if (i < errorManagement.size()) {
                    def userEmal = ''
                    def levelError = ''
                    def userfullname = ''
                    def usertitle = ''
                    def usertenDonVi1 = ''
                    def usertenDonVi2 = ''
                    def usertenDonVi3 = ''
                    def bDsUser = ''
                    def codeSalaryUser = ''
                    def linkDetails = ''
                    errorManagement[i].errorUserCreate.each{u ->
                        userEmal += u?.userEmail +"<br>"
                        levelError = u?.levelError +"<br>"
                        userfullname += u.fullName +"<br>"
                        usertitle += u.title +"<br>"
                        usertenDonVi1 += UnitDepart.get(u.tenDonVi1)?.name +"<br>"
                        if(u.tenDonVi2.length()>3) usertenDonVi2 += "<br>"
                        else  usertenDonVi2 += UnitDepart.get(u.tenDonVi2)?.name +"<br>"
                        usertenDonVi3 += UnitDepart.get(u.tenDonVi3)?.name + "<br>"
                        bDsUser += u.bDSUser + "<br>"
                        codeSalaryUser += u.codeSalary + "<br>"
                    }
                    def errorComent = ''
                    errorManagement[i].errorsComments.each{z ->
                        errorComent += "["+DateUtil.formatDetailDate(z.dateCreated)+"]"+ " [" +z.createdUserUpload +"] :"+" "+z.content +"<br>"
                    }
                    if(checkRole2){
                        linkDetails = "<a href="+
                                "${createLink(controller:'opError',action:'getErrorDetail',params:[id:errorManagement[i].id])}>Xem</a>"
                    }else{
                        linkDetails = "<a href="+
                                "${createLink(controller: 'opError', action: 'viewErrorDetail', params: [id:errorManagement[i].id])}>Xem</a>"

                    }
                    def fileLink = ''
                    if(errorManagement[i].fileName){
                        fileLink = "<a  id='lblFilename' name='lblFilename' href="+ "${resource(dir:'errorFiles',file:errorManagement[i].fileName)}"+">+${errorManagement[i].fileName}</a>"
                    }
                    result << [errorManagement[i].id, errorManagement[i].errorCategory?.name,ErrorList.get(errorManagement[i].loiCap1)?.name,
                               ErrorList.get(errorManagement[i].loiCap2)?.name,ErrorList.get(errorManagement[i].loiCap3)?.name,
                               errorManagement[i].errorCheck?.name,DateUtil.formatDate(errorManagement[i].ngayXayRa), errorManagement[i].motaChiTiet,
                               errorManagement[i].moTaAnhHuong,errorManagement[i].bienPhapKhacPhuc,DateUtil.formatDate(errorManagement[i].thoiHanKhacPhuc),
                               ErrorStatus.get(errorManagement[i].trangThai).nameStatus,userEmal,levelError,userfullname,usertitle,
                               usertenDonVi1,usertenDonVi2,usertenDonVi3,bDsUser,codeSalaryUser,
                               errorManagement[i].nguoiNhap,ErrorMasterUserCreate.findByUserEmail(errorManagement[i].nguoiNhap)?.fullName,
                               ErrorMasterUserCreate.findByUserEmail(errorManagement[i].nguoiNhap)?.title,
                               UnitDepart.get(errorManagement[i].tenDonViNhap1)?.name,UnitDepart.get(errorManagement[i].tenDonViNhap2)?.name,
                               UnitDepart.get(errorManagement[i].tenDonViNhap3)?.name,
                               ErrorMasterUserCreate.findByUserEmail(errorManagement[i].nguoiNhap)?.bDSUser,
                               ErrorMasterUserCreate.findByUserEmail(errorManagement[i].nguoiNhap)?.codeSalary,
                               errorManagement[i].maGiaoDich,errorManagement[i].giaTriGiaoDich,errorManagement[i].loaiTien,errorManagement[i].soCifKhachHang,
                               errorManagement[i].tenKhachHang,errorManagement[i].hoSoVaTenHoSo,UnitDepart.get(errorManagement[i].tenDonVi1)?.name,
                               UnitDepart.get(errorManagement[i].tenDonVi2)?.name,UnitDepart.get(errorManagement[i].tenDonVi3)?.name,
                               errorManagement[i].soLuongKiemTra,errorManagement[i].tongSoChonMau,fileLink,
                               errorManagement[i].nguoiSua,
                               DateUtil.formatDetailDate(errorManagement[i].thoiGianSua),
                               DateUtil.formatDetailDate(errorManagement[i].thoiGianNhapVaoHeThong),
                               errorComent,linkDetails]
                }
            }
            def resultFinal = new JSONObject()
            resultFinal.put("iTotalRecords", ErrorManagement.count());
            resultFinal.put("iTotalDisplayRecords", errorManagement.size());
            resultFinal.put("aaData", result);
            render resultFinal as JSON
        }

    }
	//Bao cao nguoi gay loi
	def reportErrorUserCreate1={
		Sql sql = new Sql(dataSource)
		def sqlServer = Sql.newInstance(sqlserverDataSource)
		def errorMasterUser,callInsert	
		def fromDate,toDate
		def result=[]
		if(params.search){
		try{			
			sql.call("{CALL CreateTableErrorUser()}")			
		}catch(Exception e){}
		
		 
		def sqlSelectErrorUser=""
		
		if(!params.search){
//				sqlSelectErrorUser = "SELECT C.id,C.user_email,C.full_name,C.title,C.ten_don_vi1,C.ten_don_vi2,C.ten_don_vi3,C.code_salary,C.bdsuser,IFNULL(SL_Loi_Zero(0,'0',C.user_email,'00-00-00','00-00-00',0,'','','','','','','','','',''),0) AS so_luon_loi0,IFNULL(SL_Loi_Zero(1,'0',C.user_email,'00-00-00','00-00-00',0,'','','','','','','','','',''),0) AS so_luong_loi,Tong_Loi_Quy_Doi(C.user_email,'00-00-00','00-00-00',0,'','','','','','','','','','') AS tong_loi_quy_doi,ROUND(Cap_Doi_Loi_TB(C.user_email,'00-00-00','00-00-00',0,'','','','','','','','','',''),2) AS cap_do_loi_tb,B.ten_don_vi_nhap3,B.nguoi_nhap,B.thoi_gian_nhap_vao_he_thong,B.error_category_id,B.loi_cap3,B.trang_thai, B.ngay_xay_ra FROM error_master_user_create C LEFT JOIN  error_user_create A ON C.user_email=A.user_email LEFT JOIN error_management B ON A.error_management_id=B.id GROUP BY C.user_email ORDER BY C.id DESC"
//			try{
//				callInsert=sql.call("{CALL Insert_ErrorUser()}")
//			}catch(Exception e){}
//			sqlSelectErrorUser = "SELECT * FROM ErrorUser ORDER BY id DESC"
			
		}else{
		
			String findInCT = ""
			
			if(params.TrangThai){
				findInCT += " AND B.trang_thai="+params.TrangThai+" "
			}
			if(params.HTPH){
				findInCT +=" AND B.error_check_id="+params.HTPH+" "
			}
			if(params.LoaiNghiepVu){
				findInCT += " AND B.error_category_id="+""+params.LoaiNghiepVu+"" 
			}
			if(params.NguoiNhap){
				findInCT += " AND B.nguoi_nhap="+'"'+params.NguoiNhap+'" '
			}
			if(params.LoiCap3)
				findInCT += " AND B.loi_cap3 = "+params.LoiCap3+" "
			else{
				
				if(params.LoiCap2){
//					// // println "chon loi cap 2"
					findInCT += " AND B.loi_cap3 IN (SELECT u.id FROM error_list u WHERE u.ord =3 AND u.parent_id="+params.LoiCap2+") "// lọc tìm tất cả các loi thuộc con của loi 2
				}else{
					
					if(params.LoiCap1){
//						// // println "chon NH"
					//	listDv1 = UnitDepart.executeQuery("from UnitDepart u where u.ord=2 and u.parent='"+params.NHCDLoi+"'")//lấy ra tất cả các đơn vị 2 thuộc con của đơn vị 1
						findInCT += " AND B.loi_cap3 IN (SELECT u.id FROM error_list u WHERE u.ord =3 AND u.parent_id IN (SELECT e.id FROM error_list e WHERE e.ord =2 AND e.parent_id = "+params.LoiCap1+") ) "// lấy ra tất cả các đơn vị 3 thuộc con của đơn vị 2,1
					}
				}
			}
			if(params.PGD){
				findInCT += " AND B.ten_don_vi_nhap3 = "+params.PGD+" "
			}else{
				if(params.CN){
					findInCT += " AND B.ten_don_vi_nhap3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id="+params.CN+") "// lọc tìm tất cả các loi thuộc con của loi 2
				}else{
					if(params.NHCD){
						findInCT += " AND B.ten_don_vi_nhap3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id IN (SELECT e.id FROM unit_depart e WHERE e.ord =2 AND e.parent_id = "+params.NHCD+") ) "// lấy ra tất cả các đơn vị 3 thuộc con của đơn vị 2,1
					}
				}	
			}
			def fromDate1,toDate1
			fromDate1 = DateUtil.parseInputDate(params.fromDate+" 00:00:00")
			toDate1 = DateUtil.parseInputDate(params.toDate+" 23:59:59")
			if(params.KieuNgay==null)
				findInCT += " AND B.ngay_xay_ra BETWEEN "+'"'+fromDate1.format('yyyy-MM-dd')+' 00:00:00"' + " AND " +'"'+toDate1.format('yyyy-MM-dd')+' 23:59:00"' 
			else if (params.KieuNgay=="1")
				findInCT += " AND B.ngay_xay_ra BETWEEN "+'"'+fromDate1.format('yyyy-MM-dd')+' 00:00:00"' + " AND " +'"'+toDate1.format('yyyy-MM-dd')+' 23:59:00"'
			else if(params.KieuNgay=="2")
				findInCT += " AND B.thoi_han_khac_phuc BETWEEN "+'"'+fromDate1.format('yyyy-MM-dd')+' 00:00:00"' + " AND " +'"'+toDate1.format('yyyy-MM-dd')+' 23:59:00"'
			else if(params.KieuNgay=="3")
				findInCT += " AND B.thoi_gian_nhap_vao_he_thong BETWEEN "+'"'+fromDate1.format('yyyy-MM-dd')+' 00:00:00"' + " AND " +'"'+toDate1.format('yyyy-MM-dd')+' 23:59:00"'
			  
//			  ===========================================
			String findview =" WHERE "
			if(params.PGDLoi)
				findview += " C.ten_don_vi3 = "+params.PGDLoi+" "
			else{
				if(params.CNLoi){

					findview += "C.ten_don_vi3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id="+params.CNLoi+") "// lọc tìm tất cả các đơn vị thuộc con của đơn vị 2
				}else{
			  
				  	if(params.NHCDLoi){

						  findview += " C.ten_don_vi3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id IN (SELECT e.id FROM unit_depart e WHERE e.ord =2 AND e.parent_id = "+params.NHCDLoi+") ) "// lọc tìm tất cả các đơn vị thuộc con của đơn vị 2
					  }
				}
			}
			if(params.NguoiGayLoi){
				if(params.NHCDLoi)
					findview += " AND" 	
				findview += " C.user_email = "+'"'+params.NguoiGayLoi+'" '
			}	
			if(params.IdNhanSu){
				if(params.NguoiGayLoi || params.NHCDLoi)
					findview += " AND"
				findview += " C.code_salary = "+params.IdNhanSu+" "
			}
			println ">>>>>>>>>>>" + findInCT
			findInCT = findInCT+findview
//			println ">>>>>>>>>>>" + findInCT
//			println ">>>+ "+ "{CALL Find_Insert_ErrorUser('"+""+findInCT+""+"')}"
//			println "aaaa>>: " + params.fromDate
//			println "bbbb>>: " + params.toDate
			
			try {
				if(params.NHCDLoi || params.NHCD || params.LoiCap1 || params.NguoiGayLoi || params.IdNhanSu || params.TrangThai || params.HTPH || params.LoaiNghiepVu || params.NguoiNhap || params.KieuNgay!="1")
					callInsert=sql.call("{CALL Find_Insert_ErrorUser('"+""+findInCT+""+"')}")
				else 
					callInsert=sql.call("{CALL Insert_ErrorUser()}")
			} catch (Exception e) {
				 
			}
//		tìm kiếm theo người và đơn vị gây lỗi
			sqlSelectErrorUser = "SELECT * FROM ErrorUser C ORDER BY C.id DESC"
//			if(params.PGDLoi)
//				sqlSelectErrorUser += " C.dvLoi3 = '"+params.PGDLoi+"' and "
//			else{
//				if(params.CNLoi){
////				// // println "chon CN"
//					sqlSelectErrorUser += " C.dvLoi3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id="+params.CNLoi+") and "// lọc tìm tất cả các đơn vị thuộc con của đơn vị 2
//				}else{
//					
//					if(params.NHCDLoi){
////						// // println "chon NH"
//						sqlSelectErrorUser += " C.dvLoi3 IN (SELECT u.id FROM unit_depart u WHERE u.ord =3 AND u.parent_id IN (SELECT e.id FROM unit_depart e WHERE e.ord =2 AND e.parent_id = "+params.NHCDLoi+") ) and "// lọc tìm tất cả các đơn vị thuộc con của đơn vị 2
//					}
//				}
//			}	
//			if(params.NguoiGayLoi)
//				sqlSelectErrorUser += " C.username = '"+params.NguoiGayLoi+"' and "	
//			if(params.IdNhanSu)
//				sqlSelectErrorUser += " C.idemployee = '"+params.IdNhanSu+"' and "
//			
//			sqlSelectErrorUser += " C.stt >= 0 ORDER BY C.id DESC"
		}
//		// // println ">>>>>>: " + sqlSelectErrorUser
		
			errorMasterUser=sql.rows(sqlSelectErrorUser)
		
//		// // println "AAAAAAAAAA"+ errorMasterUser
		def sqlCommand

		if(params.fromDate)
		{	
			SimpleDateFormat dt = new SimpleDateFormat('dd/MM/yyyy')
			Date fDate = dt.parse(params.fromDate) 
			Date tDate = dt.parse(params.toDate)	 
			
//			// // println "aaaaa>>>"+DateUtil.formatDate(fDate)													
			sqlCommand = "select   Teller_ID, Sum(Tong_GD) from LoiGD_GDV where '1'='1' and (  [Date] between convert(datetime, '"+DateUtil.formatDate(fDate)+"', 103) and convert(datetime, '"+DateUtil.formatDate(tDate)+"', 103)) and Muc=1 group by teller_id "
		}else{
			
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
			sqlCommand = "select   Teller_ID, Sum(Tong_GD) from LoiGD_GDV where '1'='1' and ( [Date] between convert(datetime, '"+DateUtil.formatDate(fromDate)+"', 103) and convert(datetime, '"+DateUtil.formatDate(toDate)+"', 103)) and Muc=1 group by teller_id "
		}
	 		
		
		def rs  = sqlServer.rows(sqlCommand)
		def _bdsUser=""
		def tongGD=0
		def flag = false
		for(int i=0;i<errorMasterUser.size();i++){
			_bdsUser= errorMasterUser[i].userbds		
			tongGD=0
			for(int j=0;j<rs.size;j++){
				if(rs[j][0].toString().trim()==_bdsUser.trim()){					
					tongGD=rs[j][1]					 
				}
			}
		
			result << [rs:tongGD,ErrorUser:errorMasterUser[i]]
		}
	}
//		// // println "result>>>>: " + result
		 
		if(params.exportExcel=="ExportExcel"){			
			def listTitle //=['Mã','User Name','Họ và tên','Chức danh','NHCD/Khối lỗi','Chi nhánh/Trung tâm lỗi','PGD/Tổ/Nhóm lỗi','ID nhân sự','User BDS','Muc mức độ TB','Số lượng lỗi','Số lượng giao dịch']
			
			def arrayList=[]
			
//			arrayList<<listTitle
			
			def ID,userEmail,fullName,title,tendonvi1,Idtendonvi2,tendonvi2,Idtendonvi3,tendonvi3,mucdoTB,codeSalary,dbsUser,soluongloi0,soluongloi,tongloiqd,capdoloi,soluongGD
			result.each{
				DecimalFormat df = new DecimalFormat("#,###")
				ID = ""+it.ErrorUser.id+""
				userEmail=it.ErrorUser.username
				fullName=it.ErrorUser.fullname
				title=it.ErrorUser.title
				tendonvi1=UnitDepart.get(it.ErrorUser.dvLoi1)?.name
				Idtendonvi2=""+UnitDepart.get(it.ErrorUser.dvLoi2)?.code+""
				tendonvi2=UnitDepart.get(it.ErrorUser.dvLoi2)?.name
				Idtendonvi3=""+UnitDepart.get(it.ErrorUser.dvLoi3)?.code+""
				tendonvi3=UnitDepart.get(it.ErrorUser.dvLoi3)?.name
				codeSalary=it.ErrorUser.idemployee?:''
				dbsUser=it.ErrorUser.userbds?:''
				
//				// // println ">>>>>>>>>>:0 "+ it.ErrorUser.slLoi0
//				// // println ">>>>>>>>>>:1 "+ it.ErrorUser.slLoi1
//				// // println ">>>>>>>>>>:T "+ it.ErrorUser.TLQD
//				// // println ">>>>>>>>>>:C "+ it.ErrorUser.CDLTB
				
				soluongloi0=""+it.ErrorUser.slLoi0?it.ErrorUser.slLoi0:'0'+""
				soluongloi=""+it.ErrorUser.slLoi1?it.ErrorUser.slLoi1:'0'+""
				tongloiqd=""+it.ErrorUser.TLQD?it.ErrorUser.TLQD:'0.0'+""
				capdoloi=""+it.ErrorUser.CDLTB?it.ErrorUser.CDLTB:'0.0'+""
				soluongGD=""+df.format(it.rs)+""
				
//				// // println ">>>>>>>>>>11:0 "+ soluongloi0
//				// // println ">>>>>>>>>>11:1 "+ soluongloi
//				// // println ">>>>>>>>>>11:T "+ tongloiqd
//				// // println ">>>>>>>>>>11:C "+ capdoloi
				
			 
				
				listTitle=[ID,userEmail,fullName,title,tendonvi1,Idtendonvi2,tendonvi2,Idtendonvi3,tendonvi3,codeSalary,dbsUser,soluongloi0,soluongloi,tongloiqd,capdoloi,soluongGD]
				arrayList<<listTitle
			}
			def data
			data = exportExcelService.errorUserCreate(arrayList)
			writeExcel(data)
		}
		def allErrorList1 = ErrorList.executeQuery('from ErrorList e where e.ord=1 and e.status>=0 order by e.code+0')
		def allErrorList2 = ErrorList.executeQuery('from ErrorList e where e.ord=2 and e.status>=0 order by e.code+0')
		def allErrorList3 = ErrorList.executeQuery('from ErrorList e where e.ord=3 and e.status>=0 order by e.code+0')
		def allDonViNhap1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')
		def allDonViNhap2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		def allDonViNhap3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def allErrorCheck = ErrorCheck.executeQuery('from ErrorCheck e where e.status>=0 order by e.code+0 ')//HTPH
		def allbusiness = ErrorCategory.executeQuery('from ErrorCategory e where e.status>=0 order by e.code+0')// loai nghiep vu
		def allDonViLoi1 = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')
		def allDonViLoi2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		def allDonViLoi3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def allErrorStatus = ErrorStatus.executeQuery('from ErrorStatus e where e.status>=0 order by e.code+0')
 
		render view:'/opError/errorReportUserCreate', model:[masterUserCreate:result,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,NguoiNhap:params.NguoiNhap,DonViLoi1:params.NHCDLoi,DonViLoi2:params.CNLoi,DonViLoi3:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi,LoiCap3:params.LoiCap3,LoiCap2:params.LoiCap2,LoiCap1:params.LoiCap1,LoaiNghiepVu:params.LoaiNghiepVu,erroCheck:params.HTPH,TrangThai:params.TrangThai,CheckDate:params.CheckDate,allErrorList1:allErrorList1,allErrorList2:allErrorList2,allErrorList3:allErrorList3,allDonViNhap1:allDonViNhap1,allDonViNhap2:allDonViNhap2,allDonViNhap3:allDonViNhap3,allErrorCheck:allErrorCheck,allbusiness:allbusiness,allDonViLoi1:allDonViLoi1,allDonViLoi2:allDonViLoi2,allDonViLoi3:allDonViLoi3,allErrorStatus:allErrorStatus,NguoiGayLoi:params.NguoiGayLoi,IdNhanSu:params.IdNhanSu,search:params.search,kieuNgay:params.KieuNgay]

	}
	def reportErrorUserCreate={
		
		def user = User.findByUsername( springSecurityService.principal.username)
		def masterUserCreate=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def TenDonVi3_GDTT = masterUserCreate.tenDonVi3
		def role = user.getAuthorities().authority
		def checkGDTT = false
		def checGDTT_LEVEL2= false
		def checGDTT_LEVEL3= false
		role.each{
			if (it=='ROLE_GDTT'){
				checkGDTT = true
			}
			if(it=='ROLE_GDTT_LEVEL2'){
				checGDTT_LEVEL2=true
//				// // println "vao roles 2"
			}
			if(it=='ROLE_GDTT_LEVEL3'){
				checGDTT_LEVEL3=true
			}
		}

		def fromDate,toDate
		def sqlFromDate,sqlToDate
		
		def sql = Sql.newInstance(sqlserverDataSource)
		 
		
		def sqlCommand="select   Teller_ID, Sum(Tong_GD) from LoiGD_GDV"			
			sqlCommand +=" where '1'='1' "
						 

			 
		if(params.fromDate!=null)
		{
			
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
			
			sqlCommand +=" and ( [Date] between convert(datetime, '"+params.fromDate+"', 103) and convert(datetime, '"+params.toDate+"', 103)) "
			
		}
		else
		{
			
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
	 
			sqlCommand +=" and ( [Date] between convert(datetime, '"+  DateUtil.formatDate(fromDate)+"', 103) and convert(datetime, '"+DateUtil.formatDate(toDate)+"', 103)) "
		}
		sqlCommand +="and Muc=1 group by teller_id "
		//sqlCommand +=" and Teller_id= '"+errorUser.BDSUser+"' "		
		
		
		def rs  = sql.rows(sqlCommand)
	 
		def ErrorM
		def ErrorUserC
		def tellerId
		 
		def result=[]	
		
		def errorUser = ErrorUserCreate.withCriteria(){
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
			
			
				
			
//			if(params.NHCDLoi!=null && params.NHCDLoi!='')
//				eq("tenDonVi1",params.NHCDLoi)
//			if(params.CNLoi!=null && params.CNLoi!='')
//				eq("tenDonVi2",params.CNLoi)
//			if(params.PGDLoi!=null && params.PGDLoi!='')
//				eq("tenDonVi3",params.PGDLoi)
			if(params.IdNhanSu!=null&&params.IdNhanSu!='')
				eq("codeSalary",params.IdNhanSu)
		}	
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck
		if(params.HTPH != null && params.HTPH!='')
		{
			errorCheck = ErrorCheck.get(params.HTPH)
		}
//		(checkGDTT==true)|| (checGDTT_LEVEL2==true) || (checGDTT_LEVEL3==true) ||
				ErrorM = ErrorManagement.createCriteria().listDistinct{
					if( (params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!='')||(params.NHCDLoi!=null&&params.NHCDLoi!='')||(params.CNLoi!=null && params.CNLoi!='')||(params.PGDLoi!=null && params.PGDLoi!=''))
					{
						
						errorUserCreate{
							if(errorUser.size()>0){
								'in'('id',errorUser.id)
							}else{
								eq('id','-1'.toLong())
							}
						}
					}
					/*NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,
					trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,
					tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,
					tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,
					IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi*/
				if(checkGDTT){
					eq("tenDonViNhap3",masterUserCreate.tenDonVi3)
				}
				if(checGDTT_LEVEL2){
					eq("tenDonViNhap2",masterUserCreate.tenDonVi2)
				}
				if(checGDTT_LEVEL3){
					eq("tenDonViNhap1",masterUserCreate.tenDonVi1)
				}	
					if(params.LoiCap1!=null && params.LoiCap1!='')
						eq('loiCap1',params.LoiCap1)
					
					if(params.LoiCap2!=null && params.LoiCap2!='')
						eq('loiCap2',params.LoiCap2)
					if(params.LoiCap3!=null && params.LoiCap3!='')
						eq('loiCap3',params.LoiCap3)
						
					if(params.TrangThai !=null && params.TrangThai!='')
						eq('trangThai',params.TrangThai.toInteger())
					
					if(params.NguoiNhap !=null && params.NguoiNhap!='')
						eq('nguoiNhap',params.NguoiNhap)
					
					if(params.LoaiNghiepVu !=null && params.LoaiNghiepVu!='')
					{
					def _errorCate=ErrorCategory.get(params.LoaiNghiepVu.toInteger())						
						eq('errorCategory',_errorCate)
					}
					if(params.NHCD !=null && params.NHCD!='')
						eq('tenDonViNhap1',params.NHCD)
						
					if(params.CN !=null && params.CN!='')
						eq('tenDonViNhap2',params.CN)
					
					if(params.PGD !=null && params.PGD!='')
						eq('tenDonViNhap3',params.PGD)
						
						
					if(params.NHCDLoi!=null && params.NHCDLoi!='')
						eq('tenDonVi1',params.NHCDLoi)
					
					if(params.CNLoi !=null && params.CNLoi!='')
						eq('tenDonVi2',params.CNLoi)
					
					if(params.PGDLoi !=null && params.PGDLoi!='')
						eq('tenDonVi3',params.PGDLoi)
						
					/*if(params.unitDepart !=null && params.unitDepart!='')
						eq('tenDonVi', params.unitDepart)*/
						
					if(params.KieuNgay==null)
						between('ngayXayRa',fromDate,toDate)
					else if (params.KieuNgay=="1")
						between('ngayXayRa',fromDate,toDate)
					else if(params.KieuNgay=="2")
					{						
						between('thoiHanKhacPhuc',fromDate,toDate)
					}
					else if(params.KieuNgay=="3")
						between('thoiGianNhapVaoHeThong',fromDate,toDate)

				}
				def userCreate11=ErrorM.errorUserCreate
				//1. Lay ra danh sacu Nguoi tao loi theo Error
				//2. Lay id ErrorManagement Theo Id
				//3. Chay cau lenh query theo nguoi tao laoi
			 
				def idErrorM=""
				for(int i=0;i<ErrorM.size();i++)
				{
					idErrorM=idErrorM + ErrorM[i].id+","
				}
				idErrorM =idErrorM +"0"
				 
				
				def errorUserC
				def bd =new Sql(dataSource)
				def temp
				if(params.NguoiGayLoi!=null && params.NguoiGayLoi!="")
				{
//					if(checkGDTT)
//						errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName, e.levelError, e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.userEmail=:fullN  and e.tenDonVi3=:tenDonVi3N GROUP BY e.tenDonVi1, e.userEmail ',[fullN:params.NguoiGayLoi],[tenDonVi3N:masterUserCreate.tenDonVi3])
//					else					
						//errorUserC=ErrorUserCreate.executeQuery('Select * from (  SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName,Sum( e.levelError), e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.userEmail=:fullN GROUP BY e.tenDonVi1, e.userEmail ',[fullN:params.NguoiGayLoi])
					//errorUserC=ErrorUserCreate.executeQuery('Select  C.bDSUser, COUNT(C.id), C.userEmail,C.fullName,Sum( C.levelError), C.errorManagement,C.title,C.codeSalary,C.tenDonVi1,C.tenDonVi2,C.tenDonVi3  from (  SELECT e.bDSUser, e.id, e.userEmail,e.fullName, e.levelError, e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.userEmail=:fullN ORDER BY e.id DESC) as C GROUP BY C.tenDonVi1, C.userEmail ',[fullN:params.NguoiGayLoi])
					
					errorUserC = bd.rows('SELECT bdsuser, COUNT(id) as TotalCount, user_email,full_name,SUM(level_error) level_error, error_management_id,title,code_salary,ten_don_vi1,ten_don_vi2,ten_don_vi3  FROM ( SELECT bdsuser, id, user_email,full_name, level_error, error_management_id,title,code_salary,ten_don_vi1,ten_don_vi2,ten_don_vi3 FROM error_user_create where error_management_id in  ('+idErrorM+') and user_email=:fullN ORDER BY id DESC) AS C GROUP BY ten_don_vi3, user_email',[fullN:params.NguoiGayLoi])

				}
				else
				{
//					if(checkGDTT)
//						errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName,e.levelError, e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.tenDonVi3=:tenDonVi3N GROUP BY e.tenDonVi1, e.userEmail ',[tenDonVi3N:masterUserCreate.tenDonVi3])
//					else
					//	errorUserC=ErrorUserCreate.executeQuery(' SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName,Sum(e.levelError), e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') GROUP BY e.tenDonVi1, e.userEmail order by e.id ASC ')
						
						errorUserC = bd.rows('SELECT bdsuser, COUNT(id) as TotalCount, user_email,full_name,SUM(level_error) level_error, error_management_id,title,code_salary,ten_don_vi1,ten_don_vi2,ten_don_vi3  FROM ( SELECT bdsuser, id, user_email,full_name, level_error, error_management_id,title,code_salary,ten_don_vi1,ten_don_vi2,ten_don_vi3 FROM error_user_create where error_management_id in  ('+idErrorM+') ORDER BY id DESC) AS C GROUP BY ten_don_vi3, user_email')
						
				
				}	
				

				def _bdsUser=""
				def tongGD=0;
				for(int i=0;i<errorUserC.size();i++){
					_bdsUser= errorUserC[i][0]
					tongGD=0				
					for(int j=0;j<rs.size;j++){						
						if(rs[j][0].toString().trim()==_bdsUser.trim()){
							tongGD=rs[j][1]
							 
						}
					}
				
					result << [rs:tongGD,ErrorUserCreate:errorUserC[i]]
				}
		
		def unitDepart
		if(checGDTT_LEVEL2)
			unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+masterUserCreate.tenDonVi2+'')
		if(checGDTT_LEVEL3){
			def unitD1 = UnitDepart.get(masterUserCreate.tenDonVi1)
			def unitD2 = UnitDepart.findAllByParent(unitD1)
			unitDepart=UnitDepart.createCriteria().listDistinct{			
			parent{
					if(unitD2.size()>0){
						'in'('id',unitD2.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
		}
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def allErrorList2 = ErrorList.executeQuery(' from ErrorList e where e.ord=2 and e.status >=0 order by e.code+0')
		def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		 
		def allUnitDepart3=UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')

		def errorStatus=ErrorStatus.getAll()
		//// // println "params.typeReport:"+result[0].ErrorUserCreate.bdsuser
		 
		
		if (params.exportExcel=="ExportExcel" && params.typeReport){
			 
			def listTitle //=['Mã','Họ và tên','Mức độ TB','Số lượng lỗi','Số lượng giao dịch','KPI']


			def arrayList=[]
			//arrayList<<listTitle
			def ID=0,fullName,mucdoTB,soluongloi,soluongGD,KPI
			result.each{
				 
				ID += 1
				fullName=it.ErrorUserCreate.full_name
			 
				mucdoTB=  (it.ErrorUserCreate.level_error/it.ErrorUserCreate.TotalCount).round(2)
				soluongloi=it.ErrorUserCreate.TotalCount
				soluongGD=it.rs
				KPI=''
				listTitle=[ID,fullName,mucdoTB,soluongloi,soluongGD,KPI]
				arrayList<<listTitle
					
			}
			def data			
			data = exportExcelService.reportErrorUnit(arrayList)						
			writeExcel(data)	
		} 
		if(params.exportExcel=="ExportExcel" && !params.typeReport){
			

			def listTitle //=['Mã','User Name','Họ và tên','Chức danh','NHCD/Khối lỗi','Chi nhánh/Trung tâm lỗi','PGD/Tổ/Nhóm lỗi','ID nhân sự','User BDS','Muc mức độ TB','Số lượng lỗi','Số lượng giao dịch']
			
			def arrayList=[]
//			arrayList<<listTitle		
			
			def ID=0,userEmail,fullName,title,tendonvi1,tendonvi2,tendonvi3,mucdoTB,codeSalary,dbsUser,soluongloi,soluongGD
			result.each{
				ID +=1
				userEmail=it.ErrorUserCreate.user_email
				fullName=it.ErrorUserCreate.full_name
				title=it.ErrorUserCreate.title
				tendonvi1=UnitDepart.get(it.ErrorUserCreate.ten_don_vi1)?.name
				tendonvi2=UnitDepart.get(it.ErrorUserCreate.ten_don_vi2)?.name
				if(it.ErrorUserCreate.ten_don_vi3?.length()>5)
					tendonvi3=''
				else
					tendonvi3=UnitDepart.get(it.ErrorUserCreate.ten_don_vi3)?.name				
				codeSalary=it.ErrorUserCreate.code_salary
				dbsUser=it.ErrorUserCreate.bdsuser
				mucdoTB=  (it.ErrorUserCreate.level_error/it.ErrorUserCreate.TotalCount).round(2)
				soluongloi=it.ErrorUserCreate.TotalCount
				soluongGD=it.rs
				
				listTitle=[ID,userEmail,fullName,title,tendonvi1,tendonvi2,tendonvi3,codeSalary,dbsUser,mucdoTB,soluongloi,soluongGD]
				arrayList<<listTitle
			}
			def data			
			data = exportExcelService.errorUserCreate(arrayList)
			writeExcel(data)									
		}
		
		if(params.typeReport!=null)
		{
			
			render view:'/opError/errorReportByUnit', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,allUnitDepart2:allUnitDepart2,allErrorList2:allErrorList2,allUnitDepart3:allUnitDepart3]
		}
		else
		{
			def userErrorCreateList=ErrorUserCreate.executeQuery(" FROM ErrorUserCreate e where  e.userEmail!='' GROUP BY e.userEmail")
			
			render view:'/opError/errorReportUserCreate', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,allUnitDepart3:allUnitDepart3,TenDonVi3_GDTT:TenDonVi3_GDTT,allUnitDepart2:allUnitDepart2,allErrorList2:allErrorList2]
		}
	}
//	CA
	def reportErrorLevel={
		def fromDate,toDate
		def user = User.findByUsername( springSecurityService.principal.username)
		def masterUserCreate=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def tendovi3_masterUserCreate=masterUserCreate.tenDonVi3
		
		def role = user.getAuthorities().authority
		def checkGDTT = false
		def checkGDTT_LEVEL2 = false
		def checkGDTT_LEVEL3 = false
		role.each{
			if (it=='ROLE_GDTT'){
				checkGDTT = true
			}
			if(it=='ROLE_GDTT_LEVEL2'){
				
				checkGDTT_LEVEL2=true
			}
			if(it=='ROLE_GDTT_LEVEL3'){
				checkGDTT_LEVEL3=true				
			}
		}
		
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
			
		}
		 
		def db = new Sql(dataSource)

		String strSQL="SELECT Loi_cap1,Loi_cap2,Loi_cap3,COUNT(*) FROM error_management WHERE ngay_xay_ra BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "

		
		if(params.KieuNgay==null)
			strSQL="SELECT Loi_cap1,Loi_cap2,Loi_cap3,COUNT(*) FROM error_management WHERE ngay_xay_ra BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "
		else if (params.KieuNgay=="1")
			strSQL="SELECT Loi_cap1,Loi_cap2,Loi_cap3,COUNT(*) FROM error_management WHERE ngay_xay_ra BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "
		else if(params.KieuNgay=="2")	
			strSQL="SELECT Loi_cap1,Loi_cap2,Loi_cap3,COUNT(*) FROM error_management WHERE thoi_han_khac_phuc BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "			
		else if(params.KieuNgay=="3")
			strSQL="SELECT Loi_cap1,Loi_cap2,Loi_cap3,COUNT(*) FROM error_management WHERE thoi_gian_nhap_vao_he_thong BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "
			
		
		
		
		if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='' )
		{
			strSQL="SELECT DISTINCT error_management.`loi_cap1`,error_management.`loi_cap2` , COUNT('loi_cap2') FROM error_user_create INNER JOIN error_management ON error_management.`id`=error_user_create.error_management_id "
			strSQL= strSQL+ " WHERE ngay_xay_ra BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'  and error_user_create.`user_email`='"+params.NguoiGayLoi+"'"
		}
	
	
		

		if(params.NHCD!=null && params.NHCD!='')
			strSQL =strSQL + " and ten_don_vi1 ="+ params.NHCD
			
		if(params.CN != null && params.CN != '')		
			strSQL = strSQL + " and ten_don_vi2 ="+params.CN
			
			
		if(params.PGD!=null&&params.PGD!='')
			strSQL = strSQL + " and ten_don_vi3 ="+params.PGD
			
	
			
		if(params.TrangThai!=null && params.TrangThai!=''){
			strSQL =strSQL + " and trang_thai ="+ params.TrangThai.toInteger()
			
			}

		if(params.LoiCap1!=null && params.LoiCap1!='')
			strSQL = strSQL +" and loi_cap1="+ params.LoiCap1
		
		if(params.LoiCap2!=null && params.LoiCap2!='')
			strSQL = strSQL +" and loi_cap2="+ params.LoiCap2
		if(params.LoiCap3!=null && params.LoiCap3!='')
			strSQL = strSQL +" and loi_cap3="+ params.LoiCap3
					  	
		if(params.LoaiNghiepVu != null && params.LoaiNghiepVu != '')				
			strSQL = strSQL +" and error_category_id = '"+ params.LoaiNghiepVu +"'"	
		if(params.NguoiNhap != null && params.NguoiNhap !='')
			strSQL = strSQL + " and nguoi_nhap ='" + params.NguoiNhap+"'"	
	
		
		if(checkGDTT)
			strSQL = strSQL + " and ten_don_vi_nhap3 ="+ masterUserCreate.tenDonVi3
		if(checkGDTT_LEVEL2)	
			strSQL = strSQL + " and ten_don_vi_nhap2 ="+ masterUserCreate.tenDonVi2
		if(checkGDTT_LEVEL3)
			strSQL = strSQL + " and ten_don_vi_nhap1 ="+ masterUserCreate.tenDonVi1
		strSQL =strSQL + " GROUP BY Loi_cap3 "	
		 

		
		def errorManagement = db.rows(strSQL)
		def unitDepart
		if(checkGDTT_LEVEL2)
			unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+masterUserCreate.tenDonVi2+'')
		if(checkGDTT_LEVEL3){
			def unitD1 = UnitDepart.get(masterUserCreate.tenDonVi1)
			def unitD2 = UnitDepart.findAllByParent(unitD1)
			unitDepart = UnitDepart.createCriteria().listDistinct{
				parent{
					if(unitD2.size()>0){
						'in'('id',unitD2.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
		}
		if(params.exportExcel=="ExportExcel"){

			def header //= ['Mã','Loại lỗi cấp 1','loại lỗi cấp 2','Loại lỗi câos 3','Số lượng lỗi']
			def listContent = []
			//listContent<<header
			def ID=0,loailoi1,loailoi2,loailoi3,slloi
			 
			errorManagement.each {
				ID += 1
				loailoi1 = ErrorList.get(it.Loi_cap1)?.name				
				loailoi2 = ErrorList.get(it.Loi_cap2)?.name
				loailoi3 = ErrorList.get(it.Loi_cap3)?.name
				slloi = it[3]
				header = [ID,loailoi1,loailoi2,loailoi3,slloi]
				listContent<<header
			}
					
			
			def data			
			data =exportExcelService.reportErrorLevel(listContent)
			writeExcel(data)
				
		}
		
/*		def exportReportErrorLevel(){
			
			def footer=messageSource.getMessage('opError.footlerExcel',null,LCH.getLocale())
			def html=messageSource.getMessage('opError.templateExcel',["a","b","C",footer].toArray(),LCH.getLocale());
			return [file: "BaoCaoLoaiLoi.xls", data: html]
		}*/
		
//		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code')
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def errorStatus=ErrorStatus.getAll()
		def allErrorList2 = ErrorList.executeQuery(' from ErrorList e where e.ord=2 and e.status >=0 order by e.code+0')
		def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		def allUnitDepart3 = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		
		render view:'/opError/errorReportLevel', model:[allErrorList2:allErrorList2,allUnitDepart2:allUnitDepart2,allUnitDepart3:allUnitDepart3,errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1,errorStatus:errorStatus,errorStatus:errorStatus,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,TenDonVi3_GDTT:tendovi3_masterUserCreate]
	}
	//Xoa Comment o Error
	def deleteErrorComment = {
		def comment = ErrorsComment.get(params.deleteId)		
		def errorManagement = comment.errorsManagements			
		
		errorManagement.removeFromErrorsComments(comment)
		flash.message="Anh/chị đã xóa thành công."
		redirect (controller:'opError',action:'getErrorDetail',params:['id':errorManagement.id])
	}

	def report = {
		def model = [:]
		def process
		def fromDate
		def toDate
		def department,users,departmentId
		def departments = Department.findAllByStatusGreaterThanEquals('0')
		if (params.search){
			if (params.department){
				department = Department.get(params.department)
				departmentId=department.id
			}
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}else{
			def today = new Date()
			toDate = DateUtil.formatDate(today)
			toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
			today.setMonth(today.month-1)
			fromDate = DateUtil.formatDate(today)
			fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

		}
		if(department){
			users= User.findAllByProp1(department.id)
			departmentId = department.id
		}
		else
			users=User.list()

		if (users.size()>0){
			process = OpRiskProcess.createCriteria().list{
				ge('status',0)
				between('dateCreated',fromDate,toDate)
				'in'('employee',users)
				order("id", "desc")
			}
		}
		
		model << [process:process,departmentId:departmentId,departments:departments]
		render view:'/opRisk/report', model:model

	}
	def addErrorComment = {
				
		
		def user = User.findByUsername( springSecurityService.principal.username)
		def errorManagement = ErrorManagement.get(params.idErrorComment.toInteger())
		
		
		def comment = new ErrorsComment()
		comment.createdBy = user
		comment.content=params.YKienCacDonViKhac
		comment.dateCreated=new Date()
		comment.createdUserUpload=user.username
		
		errorManagement.addToErrorsComments(comment)
		errorManagement.save(flush:true)
		def arrTo=[]
		def arrCc=[errorManagement?.nguoiNhap]

		if(errorManagement.nguoiSua!=''){
			 
			arrCc+=[errorManagement?.nguoiSua]
		}
		for(int i=1;i<=params.dateCount.toInteger();i++)
		{
			if(params.('OutLook_'+i)==''){
				arrTo +="default"
			}else{
				arrTo +=params.('OutLook_'+i)
			}
			if(i==params.dateCount.toInteger()){
				sendEmailError("CM",arrTo,arrCc,params.MotaChiTiet,""+params.idErrorComment+"",ErrorList.get(params.LoiCap3)?.name,params.YKienCacDonViKhac,"")
			}
		}
		
		if(errorManagement.hasErrors()){
			errorManagement.errors.each{
				
			}
		}
		flash.message = "Anh/chị đã gửi ý kiến thành công."
		if(params.getErrorDetail=="getErrorDetail"){
			redirect (controller:'opError',action:'getErrorDetail',params:['id':errorManagement.id])
		}else{
			redirect (controller:'opError',action:'viewErrorDetail',params:['id':errorManagement.id])
		}
	}
	def viewErrorUserCreate={
		def userErrorCreate=ErrorUserCreate.executeQuery(" FROM ErrorUserCreate e where  e.userEmail!='' GROUP BY e.userEmail")

		//SELECT  * FROM error_user_create GROUP BY user_email
		//// // println "userError"+ userError
		render view:'/opError/errorManaUser', model:[userErrorCreate:userErrorCreate]
	}
	
	def countUser(def nguoi1,nguoi2,nguoi3,nguoi4)
	{
		Integer count =0;
		if(nguoi1!=null && nguoi1!='')
		{
			count ++
		}
	}
	def checkConvertDateTime(def dateCheck)
	{
		try {
			Date.parse("MM-dd-yyyy",dateCheck)
		
		} catch (ParseException e) {		
			return false;
		}
		return true;
	}
	def viewErrorImportExcel={
		
		 
		String contentError=''
		Long currCif=0
		Long currgiaTriGiaoDich=0
		String currDescription
		try{
			
			def file = request.getFile('file')
			 
			if(file){
			 
			
			 def fileName = 'Error'
			 file.transferTo(new File(fileName))			
			 def importer = new ErrorImporter(fileName)
			 
			 def error=new ErrorManagement()
			 def department=new Department()
			 def unitDepartment=new UnitDepart()
			 def loiCap1=new ErrorList()
			 def loiCap2=new ErrorList()
			 def trangthai=new ErrorStatus()
			 def errorUserCreate=new ErrorUserCreate()
			 def errors = importer.getError()
			
			 int i=2
			 Boolean isValidDate1=false
			 Boolean isValidDate2=false
			 Boolean isValidDate3=false
			 def comment = new ErrorsComment()
			
				errors.each{data->
					
					i++	
					isValidDate1=checkConvertDateTime(data['NgayXayRa'].toString())
					isValidDate2=checkConvertDateTime(data['ThoiGianNhap'].toString())
					isValidDate3=checkConvertDateTime(data['ThoiGianKhacPhuc'].toString())
					
						
					
					if(data['TenNH']!=null && data['TenNH']!='' && data['TenDonVi']!=null && data['TenDonVi']!='' && data['LoaiLoiCap1']!=null && data['LoaiLoiCap2']!=null && isValidDate1 && isValidDate2 && isValidDate3)
					{				
						department=Department.findByName(data['TenNH'])
//						if(department==null)
//						{
//							contentError +=i.toString()+","						
//						}
						
						unitDepartment=UnitDepart.findByName(data['TenDonVi'])
						loiCap1=ErrorList.findByNameAndParentIsNull(data['LoaiLoiCap1'])
						loiCap2=ErrorList.findByNameAndParentIsNotNull(data['LoaiLoiCap2'])
						trangthai=ErrorStatus.findByNameStatus(data['TrangThai']?data['TrangThai']:'')						
						if(department!=null && unitDepartment!=null && trangthai!=null && loiCap1!=null && loiCap2!=null ){
							error=new ErrorManagement()
							error.nHCD=department.id
							error.department=department
							error.unitDepart=unitDepartment
							error.tenDonVi=unitDepartment.id						
							
							error.ngayXayRa=Date.parse("yyyy-MM-dd",data['NgayXayRa'].toString())
							
							error.nguoiNhap=data['NguoiNhap']
							error.thoiGianNhapVaoHeThong=Date.parse("yyyy-MM-dd",data['ThoiGianNhap'].toString())
							error.thoiHanKhacPhuc=Date.parse("yyyy-MM-dd",data['ThoiGianKhacPhuc'].toString())
							error.trangThai=trangthai.id
							error.loiCap1=loiCap1.id
							error.loiCap2=loiCap2.id
							
	//						String loiCap1=''
	//						String loiCap2=''
							
							error.motaChiTiet=data['MoTaChiTietLoi']
							currgiaTriGiaoDich=data['GiaTriGiaoDich']
							
							error.maGiaoDich=data['MaGiaoDich']
							error.giaTriGiaoDich=currgiaTriGiaoDich.toString()
							currCif=data['SoCif']
							error.soCifKhachHang=currCif.toString()
							
							
							error.tenKhachHang=data['TenKH']
							error.hoSoVaTenHoSo=data['SoVaTenHoSo']?data['SoVaTenHoSo']:''
							error.bienPhapKhacPhuc=data['BienPhapKhacPhuc']
							//error.thoiHanKhacPhuc
							error.nguoiNhap=data['NguoiNhap']?data['NguoiNhap']:''
							//error.TrangThai
							//error.yKienCacDonViKhac=data['YKienVoiLoiNay']
							
							def _d=new Department()
							def _ud=new UnitDepart()
							for(int j=1;j<5;j++)
							{
								
									errorUserCreate=new ErrorUserCreate()
									errorUserCreate.userEmail=data['NguoiGayLoi'+j]
									errorUserCreate.levelError=data['MucDoLoi'+j]?data['MucDoLoi'+j]:''
									errorUserCreate.fullName=data['HoVaTen'+j]?data['HoVaTen'+j]:''
									errorUserCreate.title=data['ChucDanh'+j]?data['ChucDanh'+j]:''
									errorUserCreate.bDSUser=data['UserBDS'+j]?data['UserBDS'+j]:''
								
									
									error.addToErrorUserCreate(errorUserCreate)
									
								
							
							}
							
							
							comment = new ErrorsComment()
							def user = User.findByUsername(data['NguoiNhap']?data['NguoiNhap']:'')
							
							if(user!=null)
								comment.createdBy =user
							comment.createdUserUpload=data['NguoiNhap']?data['NguoiNhap']:''
							comment.content=data['YKienVoiLoiNay']
							comment.dateCreated=new Date()
	//						
							
							error.addToErrorsComments(comment)		
							
							error.save(flush:true)
							if(error.hasErrors()){
								error.errors.each{
									 
									flash.message = "Lỗi sảy ra: Xin vui lòng gửi thoonng tin lên IT Service Desk để được hỗ trợ."
									flash.messageType = "message info"
									
								}
							}
						}
						else
						{
							
							

							contentError +="<br> LÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i tÃƒÂ¡Ã‚ÂºÃ‚Â¡i dÃƒÆ’Ã‚Â²ng " +i+":"
	
							if (department ==null)
								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [TÃƒÆ’Ã‚Âªn NHCD/KhÃƒÂ¡Ã‚Â»Ã¢â‚¬Ëœi]-"
							if(unitDepartment ==null)
								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [TÃƒÆ’Ã‚Âªn Ãƒâ€žÃ¢â‚¬ËœÃƒâ€ Ã‚Â¡n vÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¹]-"
							if (loiCap1 ==null)
								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [LoÃƒÂ¡Ã‚ÂºÃ‚Â¡i lÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i cÃƒÂ¡Ã‚ÂºÃ‚Â¥p 1]-"
							if (loiCap2 ==null)
								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [LoÃƒÂ¡Ã‚ÂºÃ‚Â¡i lÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i cÃƒÂ¡Ã‚ÂºÃ‚Â¥p 2]-"
							if (trangthai==null)

								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [TrÃƒÂ¡Ã‚ÂºÃ‚Â¡ng ThÃƒÆ’Ã‚Â¡i]-"
//							if(currDescription==null && currDescription.trim().length()<1)
//								contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [MÃƒÆ’Ã‚Â´ tÃƒÂ¡Ã‚ÂºÃ‚Â£ chi tiÃƒÂ¡Ã‚ÂºÃ‚Â¿t]"

						}
					
						
					}					
					else

					{
						contentError +="<br> LÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i tÃƒÂ¡Ã‚ÂºÃ‚Â¡i dÃƒÆ’Ã‚Â²ng " +i+":"

						if(isValidDate1==false)
						contentError +=" Sai Ãƒâ€žÃ¢â‚¬ËœÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¹nh dÃƒÂ¡Ã‚ÂºÃ‚Â¡ng ngÃƒÆ’Ã‚Â y thÃƒÆ’Ã‚Â¡ng [Ngay xay ra]"
												
						if(isValidDate2==false)
							contentError +=" Sai Ãƒâ€žÃ¢â‚¬ËœÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¹nh dÃƒÂ¡Ã‚ÂºÃ‚Â¡ng ngÃƒÆ’Ã‚Â y thÃƒÆ’Ã‚Â¡ng [Thoi Gian Nhap]"
							
						if(isValidDate3==false)
						contentError +=" Sai Ãƒâ€žÃ¢â‚¬ËœÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¹nh dÃƒÂ¡Ã‚ÂºÃ‚Â¡ng ngÃƒÆ’Ã‚Â y thÃƒÆ’Ã‚Â¡ng [Thoi Gian Khac Phuc]"
						
						if(data['TenNH']==null || data['TenNH']=='')
							contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [TÃƒÆ’Ã‚Âªn NHCD/KhÃƒÂ¡Ã‚Â»Ã¢â‚¬Ëœi]-"
							
						if(data['TenDonVi']==null || data['TenDonVi']=='')
							contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [TÃƒÆ’Ã‚Âªn Ãƒâ€žÃ¯Â¿Â½Ãƒâ€ Ã‚Â¡n VÃƒÂ¡Ã‚Â»Ã¢â‚¬Â¹]-"
						if(data['LoaiLoiCap1']==null)
							contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [LoÃƒÂ¡Ã‚ÂºÃ‚Â¡i LÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i CÃƒÂ¡Ã‚ÂºÃ‚Â¥p 1]"
						if(data['LoaiLoiCap2']==null)
							contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [LoÃƒÂ¡Ã‚ÂºÃ‚Â¡i LÃƒÂ¡Ã‚Â»Ã¢â‚¬â€�i CÃƒÂ¡Ã‚ÂºÃ‚Â¥p 2]"
//						if(currDescription==null || currDescription.trim().length()<1)
//							contentError +=" KhÃƒÆ’Ã‚Â´ng tÃƒÆ’Ã‚Â¬m thÃƒÂ¡Ã‚ÂºÃ‚Â¥y [MÃƒÆ’Ã‚Â´ tÃƒÂ¡Ã‚ÂºÃ‚Â£ chi tiÃƒÂ¡Ã‚ÂºÃ‚Â¿t]"
					}
				}				
			 }
			if (contentError!="")
			{
				flash.message = contentError
				flash.messageType = "message info"
			}	
		
			}catch(Exception e){}
			
		
		render view:'/opError/errorImportExcel'


	}
	
	//Hien thi danh sach loi da nhap
	def getErrorDisplayLevel1={
		
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def TenDonVi3_GDTT = errorMasterUser.tenDonVi3

		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
		
							
		}
		
		def fromDate,toDate
		 
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck

		
		def errorManagement=ErrorManagement.createCriteria().list{

			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)

			
			eq('tenDonViNhap3',errorMasterUser.tenDonVi3)
//			//params.PGD=errorUser.tenDonVi1
			
		
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)
			
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			if(!params.search)
				maxResults(30)
			order("id", "desc")
		}
		if(params.exportExcel=="ExportExcel"){

			def header = ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
			def listContent = []
			//listContent<<header
			def ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap
			
			 
			errorManagement.each{
				
				ID=it.id
				tenDV = UnitDepart.get(it.tenDonVi3)?.name
				nhomLoi3 = ErrorList.get(it.loiCap3)?.name
				moTaLoi = it.motaChiTiet
				userLoi=''
				capDoLoi=''
				it.errorUserCreate.each {
					userLoi = userLoi + it?.userEmail + '\n'
					capDoLoi = capDoLoi + it?.levelError + '\n'
				}
				trangThai = ErrorStatus.get(it.trangThai)?.nameStatus
				
				ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
				thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )
				ngayGioNhap = DateUtil.formatDate( it.thoiGianNhapVaoHeThong )
				header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap]
				listContent<<header
			}	
				
			
			def data			
			data = exportExcelService.errorDisplay(listContent)
//			// // println "DATA:"+data
			
			
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}
		render view:'/opError/getErrorDisplayLevel1', model:[errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi3Loi:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi,TenDonVi3_GDTT:TenDonVi3_GDTT]
	}

	
	
	
	def getErrorDisplayLevel2={
		
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
							
		}
		
		def fromDate,toDate
		 
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}

		
				
		
//		// // println "UnitDepart>>>>>>>>>>>"+ unitDepart.name
		def errorManagement=ErrorManagement.createCriteria().list{
		
			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
			
			 
//			// // println "UnitDepart.findAllByParent>>>>>>>" + UnitDepart.findAllByParent()
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)

			
			eq('tenDonViNhap2',errorMasterUser.tenDonVi2)
//			PARAMS.PGD=ERRORUSER.TENDONVI1
			
			if(params.PGD!= null&& params.PGD!='')
				eq('tenDonViNhap3',params.PGD)
			
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq('tenDonVi3',params.PGDLoi)
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			if(!params.search)
				maxResults(30)
			order("id", "desc")
		}
		if(params.exportExcel=="ExportExcel"){
			
			def header = ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
			def listContent = []
			//listContent<<header
			def ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap
			
			 
			errorManagement.each {
				//// // println it
				ID=it.id
				tenDV = UnitDepart.get(it.tenDonVi3)?.name
				nhomLoi3 = ErrorList.get(it.loiCap3)?.name
				moTaLoi = it.motaChiTiet
				userLoi=''
				capDoLoi=''
				it.errorUserCreate.each {
					userLoi = userLoi + it?.userEmail + '\n'
					capDoLoi = capDoLoi + it?.levelError + '\n'
				}
				trangThai = ErrorStatus.get(it.trangThai)?.nameStatus
				
				ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
				thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )
				ngayGioNhap = DateUtil.formatDate( it.thoiGianNhapVaoHeThong )
				header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap]
				listContent<<header
			}
			def data
			data = exportExcelService.errorDisplay(listContent)
			
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
				
		}
		
		def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+errorMasterUser.tenDonVi2+' order by e.code+0')
		
		render view:'/opError/getErrorDisplayLevel2', model:[errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi3Loi:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi,unitDepart:unitDepart]
		}
	def getErrorDisplayLevel3={
		
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
							
		}
		
		def fromDate,toDate
		 
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}

		
				
		
//		// // println "UnitDepart>>>>>>>>>>>"+ unitDepart.name
        println "TUNGLV+++++++++++++:: "+ params
		def errorManagement=ErrorManagement.createCriteria().list{
		
			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
			
			 
//			// // println "UnitDepart.findAllByParent>>>>>>>" + UnitDepart.findAllByParent()
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)

			
			eq('tenDonViNhap1',errorMasterUser.tenDonVi1)
//			PARAMS.PGD=ERRORUSER.TENDONVI1
			
			if(params.PGD!= null&& params.PGD!='')
				eq('tenDonViNhap3',params.PGD)
			
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq('tenDonVi3',params.PGDLoi)
		
		
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
            println "TUNGLV params.search: "+params.search
			if(!params.search)
				maxResults(30)
			order("id", "desc")
		}
		
		//def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+errorMasterUser.tenDonVi1+'')
		//def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent in (26.27.28.29.30) ')
		def unitD=UnitDepart.get(errorMasterUser.tenDonVi1);
		 
		def unitDepart2=UnitDepart.findAllByParent(unitD)
		
//		CV
		def unitDepart=UnitDepart.createCriteria().listDistinct{
			
			parent{
				if(unitDepart2.size()>0){
					'in'('id',unitDepart2.id)
				}else{
					eq('id','-1'.toLong())
				}
			} 
			order("code", "asc")
		}
		if(params.exportExcel=="ExportExcel"){

			//def header = ['Ten Don Vi','Nhom loi muc 3','Mo ta loi','User loi','Cap do loi','Trang thai','Ngay say ra','Thoi han khac phuc','Ngay gio nhap']
			def header = ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
			def listContent = []
			//listContent<<header
			def ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap
			
			 
			errorManagement.each {
				//// // println it
				ID=it.id
				tenDV = UnitDepart.get(it.tenDonVi3)?.name
				nhomLoi3 = ErrorList.get(it.loiCap3)?.name
				moTaLoi = it.motaChiTiet
				userLoi=''
				capDoLoi=''
				it.errorUserCreate.each {
					userLoi = userLoi + it?.userEmail + '\n'
					capDoLoi = capDoLoi + it?.levelError + '\n'
				}
				trangThai = ErrorStatus.get(it.trangThai)?.nameStatus


				ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
				thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )
				ngayGioNhap = DateUtil.formatDate( it.thoiGianNhapVaoHeThong )
				header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap]
				listContent<<header
			}
			def data			
			data = exportExcelService.errorDisplay(listContent)						
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
			println "TUNGLV+++++++++++++++++++: "+ errorManagement.size()
		}
		
		render view:'/opError/getErrorDisplayLevel2', model:[errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi3Loi:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi,unitDepart:unitDepart]
		}
	
	def getErrorDisplayLevel4={
		
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
							
		}
		
		def fromDate,toDate
		 
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}

		
				
		
//		// // println "UnitDepart>>>>>>>>>>>"+ unitDepart.name
		def errorManagement=ErrorManagement.createCriteria().list{
		
			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
			
			 
//			// // println "UnitDepart.findAllByParent>>>>>>>" + UnitDepart.findAllByParent()
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)

			

//			PARAMS.PGD=ERRORUSER.TENDONVI1
			
			if(params.PGD!= null&& params.PGD!='')
				eq('tenDonViNhap3',params.PGD)
			
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq('tenDonVi3',params.PGDLoi)
		
			
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			if(!params.search)
				maxResults(30)
			order("id", "desc")
		}
		
		//def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+errorMasterUser.tenDonVi1+'')
		//def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent in (26.27.28.29.30) ')
		if(params.exportExcel){

			//def header = ['Ten Don Vi','Nhom loi muc 3','Mo ta loi','User loi','Cap do loi','Trang thai','Ngay say ra','Thoi han khac phuc','Ngay gio nhap']
			def header = ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
			def listContent = []
			//listContent<<header
			def ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap
			
			 
			errorManagement.each {
				//// // println it
				ID = it.id
				tenDV = UnitDepart.get(it.tenDonVi3)?.name
				nhomLoi3 = ErrorList.get(it.loiCap3)?.name
				moTaLoi = it.motaChiTiet
				userLoi=''
				capDoLoi=''
				it.errorUserCreate.each {
					userLoi = userLoi + it?.userEmail + '\n'
					capDoLoi = capDoLoi + it?.levelError + '\n'
				}
				trangThai = ErrorStatus.get(it.trangThai)?.nameStatus
				
				ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
				thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )
				ngayGioNhap = DateUtil.formatDate( it.thoiGianNhapVaoHeThong )
				header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc,ngayGioNhap]
				listContent<<header
			}
			def data			
			data = exportExcelService.errorDisplay(listContent)						
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
				
		}
		
		render view:'/opError/getErrorDisplayLevel2', model:[errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi3Loi:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi]
		}
	
	//Hien thi danh sach loi bi nhap
	def getErrorDisplayLevelAssign={
		
		def user = User.findByUsername(springSecurityService.principal.username)
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		
		def tendovi3_masterUserCreate=errorMasterUser.tenDonVi3

		
		def roles = user.getAuthorities().authority
		def checkGDTT = false
		def checkGDTT_LEVEL2 = false
		def checkGDTT_LEVEL3 = false
				
		roles.each {
			if(it=='ROLE_GDTT'){
				checkGDTT = true
				
			}
			if(it=='ROLE_GDTT_LEVEL2'){
				checkGDTT_LEVEL2 = true
				
			}
			if(it=='ROLE_GDTT_LEVEL3'){
				checkGDTT_LEVEL3 = true
				
			}
		}
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
			if(checkGDTT)
				eq("tenDonVi3",errorMasterUser.tenDonVi3)			
			if(checkGDTT_LEVEL2)
				eq("tenDonVi2",errorMasterUser.tenDonVi2)
			if(checkGDTT_LEVEL3)
				eq("tenDonVi1",errorMasterUser.tenDonVi1)
							
		}		
		 
		def fromDate,toDate
		 
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck	
		
		def errorManagement=ErrorManagement.createCriteria().listDistinct{
			
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			
			
			if(params.LoaiNghiepVu!=null&&params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)

			if(params.PGD!=null && params.PGD!='')
				eq('tenDonViNhap3',params.PGD)
			//params.PGD=errorUser.tenDonvi1
			
		
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)
		
		
			if(params.LoiCap3!=null&&params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null&&params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
			if(params.TrangThai!=null && params.TrangThai!='')
				eq('trangThai',params.TrangThai.toInteger())
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			if(!params.search){
				maxResults(30)
				println "vao if"
			}
			order("id", "desc")
		}
		 
		def unitDepart
		if(checkGDTT_LEVEL2)
			unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.parent='+errorMasterUser.tenDonVi2+'')
		if(checkGDTT_LEVEL3){
			def unitD1 = UnitDepart.get(errorMasterUser.tenDonVi1)
			def unitD2 = UnitDepart.findAllByParent(unitD1)
			unitDepart = UnitDepart.createCriteria().listDistinct{
				parent{
					if(unitD2.size()>0){
						'in'('id',unitD2.id)	
					}else{
						eq('id','-1'.toLong())
					}
				}
			}			
		}
		if(params.exportExcel=="ExportExcel"){

			//def header = ['Ten Don Vi','Nhom loi muc 3','Mo ta loi','User loi','Cap do loi','Trang thai','Ngay say ra','Thoi han khac phuc','Ngay gio nhap']
			def header //= ['Mã','Tên Đơn Vị','Nhóm lỗi mức 3','Mô tả lỗi','User lỗi','Cấp độ lỗi','Trạng thái','Ngày sảy ra','Thời hạn khắc phục','Ngày giờ nhập']
			def listContent = []
			///listContent<<header
			String ID,tenDV,nhomLoi3,moTaLoi,userLoi='',capDoLoi='',trangThai,ngaySayRa,thoiHanKhacPhuc='',ngayGioNhap
			
			 
			errorManagement.each {
				//// // println it
				ID = it.id
				tenDV = (UnitDepart.get(it.tenDonVi3)?.code+'-'+UnitDepart.get(it.tenDonVi3)?.name)
				nhomLoi3 = (ErrorList.get(it.loiCap3)?.code+'-'+ErrorList.get(it.loiCap3)?.name)
				moTaLoi = it.motaChiTiet
				userLoi=''
				capDoLoi=''
				it.errorUserCreate.each {
					userLoi = userLoi + it?.userEmail + '\n'
					capDoLoi = capDoLoi + it?.levelError + '\n'
				}
				trangThai = ErrorStatus.get(it.trangThai)?.nameStatus
				
				ngaySayRa = DateUtil.formatDate(it.ngayXayRa )
				thoiHanKhacPhuc = DateUtil.formatDate( it.thoiHanKhacPhuc )
				ngayGioNhap = DateUtil.formatDate( it.thoiGianNhapVaoHeThong )
				header = [ID,tenDV,nhomLoi3,moTaLoi,userLoi,capDoLoi,trangThai,ngaySayRa,thoiHanKhacPhuc.toString(),ngayGioNhap]
				listContent<<header
			}
			def data
			data = exportExcelService.ErrorDisplayLevelAssign(listContent)
			writeExcel(data) 
				
		}
		
		render view:'/opError/getErrorDisplayLevelAssign', model:[unitDepart:unitDepart,errorManagement:errorManagement,NguoiNhap:params.NguoiNhap,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi3Loi:params.PGDLoi,NguoiGayLoi:params.NguoiGayLoi,TenDonVi3_GDTT:tendovi3_masterUserCreate ]
		}
	//Hien thi danh sach loi da nhap theo GDTT_Level1
	def getErrorDisplayLevelAllLevel2={
		
	
	def user = User.findByUsername(springSecurityService.principal.username)	
	def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
	def roles = user.getAuthorities().authority
	def checkGDTT_LEVEL2 = false
	def checkGDTT_LEVEL3 = false
	def checkGDTT_LEVEL4 = false

	roles.each {
		if(it=='ROLE_GDTT_LEVEL2'){
			checkGDTT_LEVEL2 = true
		}
		if(it=='ROLE_GDTT_LEVEL3'){
			checkGDTT_LEVEL3 = true			
		}
		if(it=='ROLE_GDTT_LEVEL4')
			checkGDTT_LEVEL4=true

	}
	
	
	def fromDate,toDate
	
	if(params.fromDate!=null)
	{
		fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
		toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
	}
	else
	{
		fromDate = new Date();
		fromDate.setMonth(fromDate.month-1);
		toDate=new Date();
	}
	
	def errorUser= ErrorUserCreate.withCriteria(){
		
		if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
			eq("userEmail",params.NguoiGayLoi)
		/*if(params.NHCDLoi!=null && params.NHCDLoi!='')
			eq("tenDonVi1",params.NHCDLoi)
		if(params.CNLoi!=null && params.CNLoi!='')
			eq("tenDonVi2",params.CNLoi)
		if(params.PGDLoi!=null && params.PGDLoi!='')
			eq("tenDonVi3",params.PGDLoi)*/
		if(params.IdNhanSu!=null&&params.IdNhanSu!='')
			eq("codeSalary",params.IdNhanSu)
	}
	
	
	
	
	def errorCategory
	if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
	{
			errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
	}
	def errorCheck
	if(params.HTPH != null && params.HTPH!='')
	{
		errorCheck = ErrorCheck.get(params.HTPH)
	}
	
	 
	def tenDonVi2,tenDonVi3,tenDonVi1
	def unitDepart2Level3
	def unitDepart3Level3
	def unitDepart3Level4
	def unitDepart3Level2
	def unitDepart2Level2
	def unitDepart1Level2
	def errorManagement = ErrorManagement.createCriteria().list{
		if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
		{
			errorUserCreate{
				if(errorUser.size()>0){
					'in'('id',errorUser.id)
				}else{
					eq('id','-1'.toLong())
				}
			}
		}

		if(params.HTPH!=null&&params.HTPH!='')
			eq('errorCheck',errorCheck)
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
			eq('errorCategory',errorCategory)
		
		//if(params.NHCD!=null&&params.NHCD!='')
			//eq('tenDonViNhap1',errorMasterUser.tenDonVi1)
		//if(params.CN!=null&&params.CN!='')
			//eq('tenDonViNhap2',errorMasterUser.tenDonVi2)
		//if(params.PGD!=null&&params.PGD!='')
		
		if(checkGDTT_LEVEL2){
			tenDonVi1 = errorMasterUser.tenDonVi1
			tenDonVi2 = errorMasterUser.tenDonVi2
			eq('tenDonViNhap2',errorMasterUser.tenDonVi2)
			 
			if(params.PGD!=null&&params.PGD!=''){
				eq('tenDonViNhap3', params.PGD)
				tenDonVi3 = params.PGD	
			}
			
			if(unitDepart3Level2==null){
				def error = UnitDepart.get(tenDonVi2)
				unitDepart3Level2 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 3 and e.status>=0 and parent = ? order by e.code+0',error)

			}
			unitDepart1Level2 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 1 and e.status>=0 ')
			unitDepart2Level2 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 ')
			
//			// // println ">>>> "+params.NHCD + ">>>>>>> "+errorMasterUser.tenDonVi2+">>>>> "+params.PGD+" >>>> "
		}
	
		if(checkGDTT_LEVEL3){
 
			tenDonVi1 = errorMasterUser.tenDonVi1
			eq('tenDonViNhap1',errorMasterUser.tenDonVi1)
			if(params.CN!=null&&params.CN!=''){
				eq('tenDonViNhap2', params.CN)
				tenDonVi2 = params.CN
			}
			if(params.PGD!=null&&params.PGD!=''){
				eq('tenDonViNhap3', params.PGD)
				tenDonVi3 = params.PGD
			}
			if(unitDepart2Level3==null){
				def error = UnitDepart.get(tenDonVi1)
				unitDepart2Level3 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 and e.parent= ? order by e.code+0',error)
			}
			
			if(unitDepart3Level3==null){
				def unitD1 = UnitDepart.get(errorMasterUser.tenDonVi1)
				def unitD2 = UnitDepart.findAllByParent(unitD1)
				unitDepart3Level3 = UnitDepart.createCriteria().listDistinct{
					parent{
						if(unitD2.size()>0){
							'in'('id',unitD2.id)
						}else{
							eq('id','-1'.toLong())
						}
					}
				}
			}
			
		}
		if(checkGDTT_LEVEL4)
		{
			tenDonVi1 = errorMasterUser.tenDonVi1
			tenDonVi2 = errorMasterUser.tenDonVi2
			tenDonVi3 = errorMasterUser.tenDonVi3
			if(unitDepart3Level4==null)
				unitDepart3Level4 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 3 and e.status>=0 order by e.code+0')
			
			if(params.NHCD!=null&&params.NHCD!='')
				eq('tenDonViNhap1',params.NHCD )
			if(params.CN!=null&&params.CN!='')
				eq('tenDonViNhap2', params.CN)
			if(params.PGD!=null&&params.PGD!='')
				eq('tenDonViNhap3', params.PGD)
				
			
		}
		
		if(params.NHCDLoi!=null && params.NHCDLoi!='')
			eq("tenDonVi1",params.NHCDLoi)
		if(params.CNLoi!=null && params.CNLoi!='')
			eq("tenDonVi2",params.CNLoi)
		if(params.PGDLoi!=null && params.PGDLoi!='')
			eq("tenDonVi3",params.PGDLoi)
		
		if(params.LoiCap1!=null && params.LoiCap1!='')
			eq('loiCap1',params.LoiCap1)
		
		if(params.LoiCap2!=null && params.LoiCap2!='')
			eq('loiCap2',params.LoiCap2)
			
		if(params.LoiCap3!=null && params.LoiCap3!='')
			eq('loiCap3',params.LoiCap3)
		if(params.NguoiNhap!=null && params.NguoiNhap!='')
			eq('nguoiNhap',params.NguoiNhap)
			
		//params.trangThai.toInterger()
			
		if(params.TrangThai!=null && params.TrangThai!='')
		{
			eq('trangThai',params.TrangThai.toInteger())
		}
					
		if(params.KieuNgay==null)
		{
			between('ngayXayRa',fromDate,toDate)
		}
		else if (params.KieuNgay=="1")
		{
				between('ngayXayRa',fromDate,toDate)
		}
		else if(params.KieuNgay=="2")
		{
			between('thoiHanKhacPhuc',fromDate,toDate)
		}
		else if(params.KieuNgay=="3")
			between('thoiGianNhapVaoHeThong',fromDate,toDate)
		if(!params.search)
			maxResults(30)
		order("id", "desc")
			
	}
	if (params.exportExcel=="ExportExcel"){
			def comments
			def header
			def listContent = []
//Thông tin mô tả			
			def Id,loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai
//Thông tin gây lỗi
			def userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi
//Thông tun nhập lỗi
			def userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap
//Thông tin khách hàng
			def maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo
//Thông tin khác												
			def NHCDKhoi,CN,idCN,idPGD,PGD,soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien			
			errorManagement.eachWithIndex{c,i ->
					//Thông tin mô tả  	
					Id=""+c.id+""
					NHCDKhoi= UnitDepart.get(c?.tenDonVi1)?.name
					idCN= UnitDepart.get(c?.tenDonVi2)?.code
					CN= UnitDepart.get(c?.tenDonVi2)?.name
					idPGD= UnitDepart.get(c?.tenDonVi3)?.code
					PGD = UnitDepart.get(c?.tenDonVi3)?.name
					//Người gây lỗi
					userOutLookLoi=''
					capDoLoi=''
					hoVaTenLoi=''
					chucDanhLoi=''
					NHCDKhoiLoi=''
					IdCNLoi=''
					CNLoi=''
					IdPGDLoi=''
					PGDLoi=''
					userHeThongLoi=''
					IDNhanSuLoi=''
					c.errorUserCreate.each{											
						
						userOutLookLoi = userOutLookLoi + it.userEmail  + '\n'
						capDoLoi = capDoLoi + it.levelError  + '\n'
						hoVaTenLoi = hoVaTenLoi + it.fullName + '\n'
						chucDanhLoi = chucDanhLoi + it.title + '\n'	
						NHCDKhoiLoi = NHCDKhoiLoi + UnitDepart.get(it.tenDonVi1)?.name + '\n'
						if (it.tenDonVi2.length()>3)
							CNLoi = CNLoi + '\n'
						else{
							IdCNLoi = IdCNLoi + UnitDepart.get(it.tenDonVi2)?.code + '\n'
							CNLoi = CNLoi + UnitDepart.get(it.tenDonVi2)?.name + '\n'
						}
						
						if (it.tenDonVi3.length()>3)
							PGDLoi = PGDLoi + '\n'
						else{
							IdPGDLoi = IdPGDLoi+UnitDepart.get(it.tenDonVi3)?.code + '\n'
							PGDLoi = PGDLoi + UnitDepart.get(it.tenDonVi3)?.name + '\n'
						}
						userHeThongLoi = userHeThongLoi + it.bDSUser + '\n'
						IDNhanSuLoi = IDNhanSuLoi + it.codeSalary + '\n'
					}
					
//					------------------------------------------
					loaiNghieoVu=c.errorCategory?.name					
					loiMuc1=ErrorList.get(c.loiCap1)?.name
					loiMuc2=ErrorList.get(c.loiCap2)?.name
					loiMuc3=ErrorList.get(c.loiCap3)?.name					
					hinhThucPH=c.errorCheck?.name
					ngaySayRa=DateUtil.formatDate(c.ngayXayRa)					
					moTaChiTietLoi=c.motaChiTiet
					moTaAnhHuong=c.moTaAnhHuong
					kienNghiKP=c.bienPhapKhacPhuc
					thoiHanKP=DateUtil.formatDate(c.thoiHanKhacPhuc)
					trangThai=ErrorStatus.get(c.trangThai).nameStatus
				

					
					//Người nhập lỗi
					userOutLookNhap=c.nguoiNhap
					hoVaTenNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.fullName?:''
					chucDanhNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.title?:''
					NHCDKhoiNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi1)?.name?:''
					CNNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi2)?.name?:''
					PGDNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi3)?.name?:''
					userHeThongNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.bDSUser?:''
					IDNhanSuNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.codeSalary?:''
					//Thông tin khách hàng
					maGiaoDich=c.maGiaoDich
					giaTriGiaoDich=c.giaTriGiaoDich
					loaiTien=c.loaiTien
					soCif=c.soCifKhachHang
					tenKhachHang=c.tenKhachHang
					hoSoTenHoSo=c.hoSoVaTenHoSo
					//Thông tin khác
//					NHCDKhoi=UnitDepart.get(c.tenDonVi1).name
//					CN=UnitDepart.get(c.tenDonVi2).name
//					PGD=UnitDepart.get(c.tenDonVi3).name
					soLuongSaiPham=c.soLuongKiemTra
					tongSoChonMau=c.tongSoChonMau
					fileDinhKem=c.fileName?c.fileName:''
					nguoiCapNhat=c.nguoiSua?c.nguoiSua:''
					if (c.thoiGianSua==null)
						GTCapNhat=c.thoiGianNhapVaoHeThong?DateUtil.formatDate(c.thoiGianNhapVaoHeThong):''
					else
						GTCapNhat=c.thoiGianSua?DateUtil.formatDate(c.thoiGianSua):''
					TGKhacPhuc=c.thoiGianCapNhapTrangThai?DateUtil.formatDate(c.thoiGianCapNhapTrangThai):''
					comments = ''
					c.errorsComments.each{
						comments = comments + "["+it.dateCreated+"]"+" "+"["+it.createdUserUpload+"]:"+" "+it.content + '\n\n'
					}
					
					YKien=comments
					header=[Id,NHCDKhoi,idCN,CN,idPGD,PGD,userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi,
						loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai,						
						userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap,
						maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo,
						soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien]
					
					listContent<<header
			}
			def data
			data =exportExcelService.errorList(listContent)	
			//File download
			writeExcel(data)
			
			
		}
			def unitDepart2
			if(params.CNLoi){
				def error = UnitDepart.get(params.NHCDLoi)
				unitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 and e.parent= ? order by e.code+0',error)
//				unitDepart2 = UnitDepart.findAllWhere(parent: error)
//				unitDepart2 = UnitDepart.findAllByParent(error)
				
			}
			def errorList2
			if(params.LoiCap2){
				def error = ErrorList.get(params.LoiCap1)
				errorList2 = ErrorList.executeQuery('from ErrorList e where e.ord =2 and e.status>=0 and parent = ? order by e.code+0',error)
//				errorList2 = ErrorList.findAllByParent(error)
//				errorList2 = ErrorList.findAllWhere(parent: error)
				 
			}
			def unitDepart2Level4
			if(checkGDTT_LEVEL4){
				
				if(params.CN){
					def error = UnitDepart.get(params.NHCD)
					unitDepart2Level4 = UnitDepart.executeQuery('from UnitDepart e where e.ord = 2 and e.status>=0 and parent = ? order by e.code+0',error)
	//				unitDepart2Level4 = UnitDepart.findAllWhere(parent: error)
	//				unitDepart2Level4.sort("code") 
	//				unitDepart2 = UnitDepart.findAllByParent(error)
					
				}
			}
	
	def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
	def errorStatus=ErrorStatus.getAll()
	def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')	
	render view:'/opError/getErrorDisplayLevelAllLevel2', model:[errorManagement:errorManagement,errorStatus:errorStatus,errorType:errorType,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:tenDonVi1,tenDonVi2:tenDonVi2,tenDonVi3:tenDonVi3,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,tenDonViNhap1:params.NHCD,tenDonViNhap2:params.CN,tenDonViNhap3:params.PGD,errorList2:errorList2,unitDepart2:unitDepart2,unitDepart3Level3:unitDepart3Level3,unitDepart3Level4:unitDepart3Level4,unitDepart2Level4:unitDepart2Level4,unitDepart3Level2:unitDepart3Level2,unitDepart1Level2:unitDepart1Level2,unitDepart2Level2:unitDepart2Level2,unitDepart2Level3:unitDepart2Level3]
	}
	def getErrorDisplayLevelAll={
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		
		def fromDate,toDate
		
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
		}
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
			/*if(params.NHCDLoi!=null && params.NHCDLoi!='')
				eq("tenDonVi1",params.NHCDLoi)
			if(params.CNLoi!=null && params.CNLoi!='')
				eq("tenDonVi2",params.CNLoi)
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)*/
			if(params.IdNhanSu!=null&&params.IdNhanSu!='')
				eq("codeSalary",params.IdNhanSu)
		}
		
		
		
		
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck
		if(params.HTPH != null && params.HTPH!='')
		{
			errorCheck = ErrorCheck.get(params.HTPH)
		}
		
		
		
		def errorManagement = ErrorManagement.createCriteria().list{
			if((params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')||(params.IdNhanSu!=null&&params.IdNhanSu!=''))
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}
				}
			}
	
			if(params.HTPH!=null&&params.HTPH!='')
				eq('errorCheck',errorCheck)
			if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
				eq('errorCategory',errorCategory)
			
			//if(params.NHCD!=null&&params.NHCD!='')
				//eq('tenDonViNhap1',errorMasterUser.tenDonVi1)
			//if(params.CN!=null&&params.CN!='')
				//eq('tenDonViNhap2',errorMasterUser.tenDonVi2)
			//if(params.PGD!=null&&params.PGD!='')
				eq('tenDonViNhap3',errorMasterUser.tenDonVi3)
			 
			if(params.NHCDLoi!=null && params.NHCDLoi!='')
				eq("tenDonVi1",params.NHCDLoi)
			if(params.CNLoi!=null && params.CNLoi!='')
				eq("tenDonVi2",params.CNLoi)
			if(params.PGDLoi!=null && params.PGDLoi!='')
				eq("tenDonVi3",params.PGDLoi)
			
			if(params.LoiCap1!=null && params.LoiCap1!='')
				eq('loiCap1',params.LoiCap1)
			
			if(params.LoiCap2!=null && params.LoiCap2!='')
				eq('loiCap2',params.LoiCap2)
				
			if(params.LoiCap3!=null && params.LoiCap3!='')
				eq('loiCap3',params.LoiCap3)
			if(params.NguoiNhap!=null && params.NguoiNhap!='')
				eq('nguoiNhap',params.NguoiNhap)
				
			//params.trangThai.toInterger()
				
			if(params.TrangThai!=null && params.TrangThai!='')
			{
				eq('trangThai',params.TrangThai.toInteger())
			}
						
			if(params.KieuNgay==null)
			{
				between('ngayXayRa',fromDate,toDate)
			}
			else if (params.KieuNgay=="1")
			{
					between('ngayXayRa',fromDate,toDate)
			}
			else if(params.KieuNgay=="2")
			{
				between('thoiHanKhacPhuc',fromDate,toDate)
			}
			else if(params.KieuNgay=="3")
				between('thoiGianNhapVaoHeThong',fromDate,toDate)
			if(!params.search)
				maxResults(30)
			order("id", "desc")
				
		}
		if (params.exportExcel=="ExportExcel"){
			def comments
			def header
			def listContent = []
//Thông tin mô tả			
			def Id,loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai
//Thông tin gây lỗi
			def userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi
//Thông tun nhập lỗi
			def userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap
//Thông tin khách hàng
			def maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo
//Thông tin khác												
			def NHCDKhoi,CN,idCN,idPGD,PGD,soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien			
			errorManagement.eachWithIndex{c,i ->
					//Thông tin mô tả  	
					Id=""+c.id+""
					NHCDKhoi= UnitDepart.get(c?.tenDonVi1)?.name
					idCN= UnitDepart.get(c?.tenDonVi2)?.code
					CN= UnitDepart.get(c?.tenDonVi2)?.name
					idPGD= UnitDepart.get(c?.tenDonVi3)?.code
					PGD = UnitDepart.get(c?.tenDonVi3)?.name
					//Người gây lỗi
					userOutLookLoi=''
					capDoLoi=''
					hoVaTenLoi=''
					chucDanhLoi=''
					NHCDKhoiLoi=''
					IdCNLoi=''
					CNLoi=''
					IdPGDLoi=''
					PGDLoi=''
					userHeThongLoi=''
					IDNhanSuLoi=''
					c.errorUserCreate.each{											
						
						userOutLookLoi = userOutLookLoi + it.userEmail  + '\n'
						capDoLoi = capDoLoi + it.levelError  + '\n'
						hoVaTenLoi = hoVaTenLoi + it.fullName + '\n'
						chucDanhLoi = chucDanhLoi + it.title + '\n'	
						NHCDKhoiLoi = NHCDKhoiLoi + UnitDepart.get(it.tenDonVi1)?.name + '\n'
						if (it.tenDonVi2.length()>3)
							CNLoi = CNLoi + '\n'
						else{
							IdCNLoi = IdCNLoi + UnitDepart.get(it.tenDonVi2)?.code + '\n'
							CNLoi = CNLoi + UnitDepart.get(it.tenDonVi2)?.name + '\n'
						}
						
						if (it.tenDonVi3.length()>3)
							PGDLoi = PGDLoi + '\n'
						else{
							IdPGDLoi = IdPGDLoi+UnitDepart.get(it.tenDonVi3)?.code + '\n'
							PGDLoi = PGDLoi + UnitDepart.get(it.tenDonVi3)?.name + '\n'
						}
						userHeThongLoi = userHeThongLoi + it.bDSUser + '\n'
						IDNhanSuLoi = IDNhanSuLoi + it.codeSalary + '\n'
					}
					
//					------------------------------------------
					loaiNghieoVu=c.errorCategory?.name					
					loiMuc1=ErrorList.get(c.loiCap1)?.name
					loiMuc2=ErrorList.get(c.loiCap2)?.name
					loiMuc3=ErrorList.get(c.loiCap3)?.name					
					hinhThucPH=c.errorCheck?.name
					ngaySayRa=DateUtil.formatDate(c.ngayXayRa)					
					moTaChiTietLoi=c.motaChiTiet
					moTaAnhHuong=c.moTaAnhHuong
					kienNghiKP=c.bienPhapKhacPhuc
					thoiHanKP=DateUtil.formatDate(c.thoiHanKhacPhuc)
					trangThai=ErrorStatus.get(c.trangThai).nameStatus
				

					
					//Người nhập lỗi
					userOutLookNhap=c.nguoiNhap
					hoVaTenNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.fullName?:''
					chucDanhNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.title?:''
					NHCDKhoiNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi1)?.name?:''
					CNNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi2)?.name?:''
					PGDNhap=UnitDepart.get(ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.tenDonVi3)?.name?:''
					userHeThongNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.bDSUser?:''
					IDNhanSuNhap=ErrorMasterUserCreate.findByUserEmail(c.nguoiNhap)?.codeSalary?:''
					//Thông tin khách hàng
					maGiaoDich=c.maGiaoDich
					giaTriGiaoDich=c.giaTriGiaoDich
					loaiTien=c.loaiTien
					soCif=c.soCifKhachHang
					tenKhachHang=c.tenKhachHang
					hoSoTenHoSo=c.hoSoVaTenHoSo
					//Thông tin khác
//					NHCDKhoi=UnitDepart.get(c.tenDonVi1).name
//					CN=UnitDepart.get(c.tenDonVi2).name
//					PGD=UnitDepart.get(c.tenDonVi3).name
					soLuongSaiPham=c.soLuongKiemTra
					tongSoChonMau=c.tongSoChonMau
					fileDinhKem=c.fileName?c.fileName:''
					nguoiCapNhat=c.nguoiSua?c.nguoiSua:''
					if (c.thoiGianSua==null)
						GTCapNhat=c.thoiGianNhapVaoHeThong?DateUtil.formatDate(c.thoiGianNhapVaoHeThong):''
					else
						GTCapNhat=c.thoiGianSua?DateUtil.formatDate(c.thoiGianSua):''
					TGKhacPhuc=c.thoiGianCapNhapTrangThai?DateUtil.formatDate(c.thoiGianCapNhapTrangThai):''
					comments = ''
					c.errorsComments.each{
						comments = comments + "["+it.dateCreated+"]"+" "+"["+it.createdUserUpload+"]:"+" "+it.content + '\n\n'
					}
					
					YKien=comments
					header=[Id,NHCDKhoi,idCN,CN,idPGD,PGD,userOutLookLoi,capDoLoi,hoVaTenLoi,chucDanhLoi,NHCDKhoiLoi,IdCNLoi,CNLoi,IdPGDLoi,PGDLoi,userHeThongLoi,IDNhanSuLoi,
						loaiNghieoVu,loiMuc1,loiMuc2,loiMuc3,hinhThucPH,ngaySayRa,moTaChiTietLoi,moTaAnhHuong,kienNghiKP,thoiHanKP,trangThai,						
						userOutLookNhap,hoVaTenNhap,chucDanhNhap,NHCDKhoiNhap,CNNhap,PGDNhap,userHeThongNhap,IDNhanSuNhap,
						maGiaoDich,giaTriGiaoDich,loaiTien,soCif,tenKhachHang,hoSoTenHoSo,
						soLuongSaiPham,tongSoChonMau,fileDinhKem,nguoiCapNhat,GTCapNhat,TGKhacPhuc,YKien]
					
					listContent<<header
			}
			def data
			data =exportExcelService.errorList(listContent)	
			//File download
			writeExcel(data)
			
			
		}
		 
		def unitDepart2
		if(params.CNLoi){
			def error = UnitDepart.get(params.NHCDLoi)
			unitDepart2 = UnitDepart.findAllWhere(parent: error)
//				unitDepart2 = UnitDepart.findAllByParent(error)
			
		}
		def errorList2
		if(params.LoiCap2){
			def error = ErrorList.get(params.LoiCap1)
//				errorList2 = ErrorList.findAllByParent(error)
			errorList2 = ErrorList.findAllWhere(parent: error)
			 
		}

		
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def errorStatus=ErrorStatus.getAll()
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		def unitDepart1Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status >=0 order by e.id')
		def unitDepart2Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status >=0 order by e.id')
		def unitDepart3Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status >=0 order by e.id')
		render view:'/opError/getErrorDisplayLevelAll', model:[errorManagement:errorManagement,errorStatus:errorStatus,errorType:errorType,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:errorMasterUser.tenDonVi1,tenDonVi2:errorMasterUser.tenDonVi2,tenDonVi3:errorMasterUser.tenDonVi3,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi,errorList2:errorList2,unitDepart2:unitDepart2,unitDepart1Nhap:unitDepart1Nhap,unitDepart2Nhap:unitDepart2Nhap,unitDepart3Nhap:unitDepart3Nhap]
		}
	//Bao cao nguoi gay loi
	def reportErrorUserCreateByLevel={
		
		def user = User.findByUsername( springSecurityService.principal.username)
		def masterUserCreate=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def role = user.getAuthorities().authority
		def checkGDTT = false
		role.each{
			if (it=='ROLE_GDTT'){
				checkGDTT = true
			}
		}
		def fromDate,toDate
		def sqlFromDate,sqlToDate		
		def sql = Sql.newInstance(sqlserverDataSource)			
		def sqlCommand="select   Teller_ID, Sum(Tong_GD) from LoiGD_GDV"
			sqlCommand +=" where '1'='1' "
						 

		 
		if(params.fromDate!=null)
		{
			
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
			
			sqlCommand +=" and ( [Date] between convert(datetime, '"+params.fromDate+"', 103) and convert(datetime, '"+params.toDate+"', 103)) "
			
		}
		else
		{
			
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-1);
			toDate=new Date();
			
			sqlCommand +=" and ( [Date] between convert(datetime, '"+  DateUtil.formatDate(fromDate)+"', 103) and convert(datetime, '"+DateUtil.formatDate(toDate)+"', 103)) "
		}
		sqlCommand +=" group by teller_id "
		//sqlCommand +=" and Teller_id= '"+errorUser.BDSUser+"' "
	
		 
		def rs  = sql.rows(sqlCommand)
		
		def ErrorM
		def ErrorUserC
		def tellerId
		 
		def result=[]
		
		def errorUserCreate = ErrorUserCreate.withCriteria(){
			if(params.NguoiGayLoi!=null && params.NguoiGayLoi!='')
				eq("userEmail",params.NguoiGayLoi)
				eq("tenDonVi3",masterUserCreate.tenDonVi3)
//			if(params.NHCDLoi!=null && params.NHCDLoi!='')
//				eq("tenDonVi1",params.NHCDLoi)
//			if(params.CNLoi!=null && params.CNLoi!='')
//				eq("tenDonVi2",params.CNLoi)
//			if(params.PGDLoi!=null && params.PGDLoi!='')
//				eq("tenDonVi3",params.PGDLoi)
//			if(params.IdNhanSu!=null&&params.IdNhanSu!='')
//				eq("codeSalary",params.IdNhanSu)
		}
		def errorCategory
		if(params.LoaiNghiepVu!=null && params.LoaiNghiepVu!='')
		{
				errorCategory=ErrorCategory.get(params.LoaiNghiepVu)
		}
		def errorCheck
		if(params.HTPH != null && params.HTPH!='')
		{
			errorCheck = ErrorCheck.get(params.HTPH)
		}
				
				ErrorM = ErrorManagement.createCriteria().listDistinct{
					if(params.NguoiGayLoi!=null&&params.NguoiGayLoi!='')
					{
						errorUserCreate{
							if(errorUser.size()>0){
								'in'('id',errorUser.id)
							}else{
								eq('id','-1'.toLong())
							}
						}
					}
					/*NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,
					trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,
					tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,
					tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,
					IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi*/
					
					if(params.LoiCap1!=null && params.LoiCap1!='')
						eq('loiCap1',params.LoiCap1)
					
					if(params.LoiCap2!=null && params.LoiCap2!='')
						eq('loiCap2',params.LoiCap2)
					if(params.LoiCap3!=null && params.LoiCap3!='')
						eq('loiCap3',params.LoiCap3)
						
					if(params.trangthai !=null && params.trangthai!='')
						eq('trangThai',params.trangthai.toInteger())
						
					
					if(params.LoaiNghiepVu !=null && params.LoaiNghiepVu!='')
					{
					def _errorCate=ErrorCategory.get(params.LoaiNghiepVu.toInteger())
						eq('errorCategory',_errorCate)
					}
					if(params.NHCD !=null && params.NHCD!='')
						eq('tenDonVi1',params.NHCD)
						
					if(params.CN !=null && params.CN!='')
						eq('tenDonVi2',params.CN)
					
					if(params.PGD !=null && params.PGD!='')
						eq('tenDonVi3',params.PGD)
						
						
					/*if(params.unitDepart !=null && params.unitDepart!='')
						eq('tenDonVi', params.unitDepart)*/
						
					if(params.KieuNgay==null)
						between('ngayXayRa',fromDate,toDate)
					else if (params.KieuNgay=="1")
						between('ngayXayRa',fromDate,toDate)
					else if(params.KieuNgay=="2")
					{
						between('thoiHanKhacPhuc',fromDate,toDate)
					}
					else if(params.KieuNgay=="3")
						between('thoiGianNhapVaoHeThong',fromDate,toDate)
				}
				def userCreate11=ErrorM.errorUserCreate
				//1. Lay ra danh sacu Nguoi tao loi theo Error
				//2. Lay id ErrorManagement Theo Id
				//3. Chay cau lenh query theo nguoi tao laoi
				 
				def idErrorM=""
				for(int i=0;i<ErrorM.size();i++)
				{
					idErrorM=idErrorM + ErrorM[i].id+","
				}
				idErrorM =idErrorM +"0"
				 
				
				def errorUserC
				
				if(params.nguoigayloi!=null && params.nguoigayloi!="")
					errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName, SUM(e.levelError)/COUNT(e.id), e.errorManagement,e.title,e.codeSalary,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.userEmail=:fullN GROUP BY e.tenDonVi1, e.userEmail ',[fullN:params.nguoigayloi])
				else
					errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName, SUM(e.levelError)/COUNT(e.id), e.errorManagement,e.title,e.codeSalary,e.tenDonVi1,e.tenDonVi2,e.tenDonVi3 FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') GROUP BY e.tenDonVi1, e.userEmail ')
				 
				def _bdsUser=""
				def tongGD=0;
				for(int i=0;i<errorUserC.size();i++){
					_bdsUser= errorUserC[i][0]
					tongGD=0
					 
					for(int j=0;j<rs.size;j++){
						if(rs[j][0].toString().trim()==_bdsUser.trim()){
							tongGD=rs[j][1]
							 
						}
					}
				
					result << [rs:tongGD,ErrorUserCreate:errorUserC[i]]
				}
		
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code')
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		
		
		
		def errorStatus=ErrorStatus.getAll()
		 
		if(params.typeReport!=null)
		{
			
			render view:'/opError/errorReportByUnit', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi]
		}
		else
		{
			def userErrorCreateList=ErrorUserCreate.executeQuery(" FROM ErrorUserCreate e where  e.userEmail!='' GROUP BY e.userEmail")
			
			render view:'/opError/errorReportUserCreate', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,NguoiNhap:params.NguoiNhap,LoiCap1:params.LoiCap1,LoiCap2:params.LoiCap2,LoiCap3:params.LoiCap3,trangthai:params.trangthai,kieuNgay:params.KieuNgay,tenDonVi1:params.NHCD,tenDonVi2:params.CN,tenDonVi3:params.PGD,TrangThai:params.TrangThai,LoaiNghiepVu:params.LoaiNghiepVu,tenDonVi1Loi:params.NHCDLoi,tenDonVi2Loi:params.CNLoi,tenDonVi3Loi:params.PGDLoi,HTPH:params.HTPH,IdNhanSu:params.IdNhanSu,NguoiGayLoi:params.NguoiGayLoi]
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
	def writeExcel(def data){
		response.setContentType("application/vnd.ms-excel")
		response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
		response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
	}
	 




}