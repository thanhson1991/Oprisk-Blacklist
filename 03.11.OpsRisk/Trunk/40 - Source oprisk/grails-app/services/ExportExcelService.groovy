import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import jxl.*
import jxl.write.*

 import java.util.Formatter.DateTime;
import java.util.Locale;
import org.springframework.context.i18n.LocaleContextHolder as LCH

class ExportExcelService {
	
	
    static transactional = true
	def messageSource
	
//Báo cáo loại lỗi
	def reportErrorLevel(ArrayList<String> content){	
		def tempContent=''
		def subcontent=''
		def date = new Date()
		content.each{
			//Ma-LoaiLoiCap1 - LoaiLoi Cap 2- Loi Loi Cap 3 - So Luong Loi
			
			tempContent=messageSource.getMessage('opError.ReportErrorLevel.SubContent',[it[0],it[1],it[2],it[3],it[4]].toArray(),LCH.getLocale())
			subcontent +=tempContent
		}
		def header=messageSource.getMessage('opError.Template.Header', ["5","BÁO CÁO LOẠI LỖI","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('opError.ReportErrorLevel.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())
		
		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());
		
		return [file: "BaoCaoLoaiLoi.xls", data:html]
	}
//Báo cáo KRI
    def kriDisplay(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            subcontent += messageSource.getMessage('opError.ErrorDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH KRI","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('kris.kriDisplay.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "DanhSachKRI.xls", data: html]
    }
	
// Blacklist Cá nhân
	def blacklistCnDisplay(ArrayList<String> content){
		println 'anc' + content
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlackIndividual.blacklistCnDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22],it[23]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH BLACKLIST CÁ NHÂN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlackIndividual.blacklistCnDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

		return [file: "Danh sách Blacklist Ca nhan.xls", data: html]
	}
	
// Blacklist Pháp nhân
	def blacklistPnDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlacklistCorporation.blacklistPnDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH BLACKLIST PHÁP NHÂN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlacklistCorporation.blacklistPnDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

		return [file: "Danh sách Blacklist Phap nhan.xls", data: html]
	}
	
// Blacklist Tài sản bảo đảm
	def blacklistTsbdDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlacklistTSBD.blacklistTsbdDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH BLACKLIST TÀI SẢN BẢO ĐẢM","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlacklistTSBD.blacklistTsbdDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

		return [file: "Danh sách Blacklist Tai san bao dam.xls", data: html]
	}
	
// Blacklist quản lý danh sách cá nhân
	def blacklistQldsCnDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlackIndividual.blacklistQldsCnDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22],it[23],it[24]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","QUẢN LÝ DANH SÁCH BLACKLIST CÁ NHÂN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlackIndividual.blacklistQldsCnDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

	return [file: "Quan ly danh sach ca nhan.xls", data: html]
	}
	
	// Blacklist quản lý danh sách pháp nhân
	def blacklistQldsPnDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlacklistCorporation.blacklistQldsPnDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","QUẢN LÝ DANH SÁCH BLACKLIST PHÁP NHÂN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlacklistCorporation.blacklistQldsPnDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

	return [file: "Quan ly danh sach phap nhan.xls", data: html]
	}
	
	// Blacklist quản lý danh sách tài sản bảo đảm
	def blacklistQldsTsbdDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('BlacklistTSBD.blacklistQldsTsbdDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","QUẢN LÝ DANH SÁCH BLACKLIST TÀI SẢN BẢO ĐẢM","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('BlacklistTSBD.blacklistQldsTsbdDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

	return [file: "Quan ly danh sach tai san bao dam.xls", data: html]
	}
		
    //Báo cáo tính toán vốn
    def capitalCalDisplay(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            subcontent += messageSource.getMessage('capitalCal.capitalCalDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["5","BÁO CÁO TÍNH TOÁN VỐN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('capitalCal.capitalCalDisplay.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "DanhSachTinhtoanvon.xls", data: html]
    }
    def calBIDisplay(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            subcontent += messageSource.getMessage('bi.biDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["7","BÁO CÁO TÍNH TOÁN VỐN THEO BI","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('bi.biDisplay.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "DanhSachTinhtoanvontheoBI.xls", data: html]
    }
    def calBIDetails(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            subcontent += messageSource.getMessage('bi.biDetailsDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22],it[23],it[24],it[25],it[26],it[27],it[28],it[29]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["5","BÁO CÁO TÍNH TOÁN VỐN THEO BI CHI TIẾT","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('bi.biDetail.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "TinhToanVonBI.xls", data: html]
    }
	//Báo cáo hành động rủi ro
	def actionDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('action.riskActionDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH HÀNH ĐỘNG RỦI RO","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('action.riskActionDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

		return [file: "DanhSachHanhDongRuiRo.xls", data: html]
	}
	
	//Báo cáo phân tích kịch bản
	def scriptDisplay(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			subcontent += messageSource.getMessage('kris.trackKriDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["7","BÁO CÁO PHÂN TÍCH KỊCH BẢN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('script.scriptActionDisplay.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

		return [file: "DanhSachKichBan.xls", data: html]
		
		
	}
//Báo cáo theo dõi KRI
    def trackKriDisplay(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            subcontent += messageSource.getMessage('kris.trackKriDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["7","DANH SÁCH THEO DÕI KRI","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('kris.trackKriDisplay.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "DanhSachTheoDoiKRI.xls", data: html]
    }
//Báo cáo lỗi rút gọn
    def errorDisplay(ArrayList<String> content){
        def subcontent=''
        def date = new Date()
        content.each{
            //Ma-Ten Don Vi - Nhom Muc Loi 3- Mo ta loi - User Loi - Cap do loi - Trang Thai - Ngay xay ra - Ngay Khac phuc - Ngay gio nhap
            subcontent += messageSource.getMessage('opError.ErrorDisplay.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9]].toArray(),LCH.getLocale())
        }
        def header=messageSource.getMessage('opError.Template.Header', ["10","DANH SÁCH LỖI RÚT GỌN","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
        def title=messageSource.getMessage('opError.ErrorDisplay.Title',null,LCH.getLocale())
        def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())

        def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());

        return [file: "DanhSachLoiRutGon.xls", data: html]
    }

//Báo cáo đơn vị	
	def reportErrorUnit(ArrayList<String> content){
	  def tempContent=''
	  def subcontent=''
	  def date = new Date()
	  content.each{
	   //Ma-Ten Don Vi - Nhom Muc Loi 3- Mo ta loi - User Loi - Cap do loi - Trang Thai - Ngay xay ra - Ngay Khac phuc - Ngay gio nhap
	   
	   tempContent=messageSource.getMessage('opError.ReportErrorUnit.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9]].toArray(),LCH.getLocale())
	   subcontent +=tempContent
	  }
	  //def contents=messageSource.getMessage('opError.ReportErrorUnit.Content',[subcontent].toArray(),LCH.getLocale())
	  
	  def header=messageSource.getMessage('opError.Template.Header', ["6","BÁO CÁO THEO ĐƠN VỊ","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
	  def title=messageSource.getMessage('opError.ReportErrorUnit.Title',null,LCH.getLocale())
	  def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())
	  
	  def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());
	  //def html=messageSource.getMessage('opError.templateExcel',['header',title,'',''].toArray(),LCH.getLocale());
	  return [file: "BaoCaoTheoDonVi.xls", data: html]
	 }
//Báo cáo người gây lỗi
	def errorUserCreate(ArrayList<String> content){
		def SubContent=''
		def date = new Date()
		content.each {
			SubContent += messageSource.getMessage('opError.reportErrorUserCreate.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15]].toArray(),LCH.getLocale())
		}
		def header = messageSource.getMessage('opError.Template.Header',["16","BÁO CÁO NGƯỜI GÂY LỖI","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(),LCH.getLocale())
		def title = messageSource.getMessage('opError.reportErrorUserCreate.Title',null,LCH.getLocale())
		def footer = messageSource.getMessage('opError.footer',null,LCH.getLocale())
		def html = messageSource.getMessage('opError.Template.EportExcel',[header,title,SubContent,footer].toArray(),LCH.getLocale())
		return [file:"BaoCaoNguoiGayLoi.xls",data:html]
	}
//Báo cáo lỗi đầy đủ	
	def errorList(ArrayList<String> content)
	{
		def tempContent=''
		def subcontent=''
		def date = new Date()
		content.each{
			//Ma-Ten Don Vi - Nhom Muc Loi 3- Mo ta loi - User Loi - Cap do loi - Trang Thai - Ngay xay ra - Ngay Khac phuc - Ngay gio nhap
			
			tempContent=messageSource.getMessage('opError.ErrorList.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10],it[11],it[12],it[13],it[14],it[15],it[16],it[17],it[18],it[19],it[20],it[21],it[22],it[23],it[24],it[25],it[26],it[27],it[28],it[29],it[30],it[31],it[32],it[33],it[34],it[35],it[36],it[37],it[38],it[39],it[40],it[41],it[42],it[43],it[44],it[45],it[46],it[47],it[48]].toArray(),LCH.getLocale())
			subcontent +=tempContent
		}
		def header=messageSource.getMessage('opError.Template.Header', ["49","BÁO CÁO LỖI ĐẦY ĐỦ","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('opError.ErrorList.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())
		
		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());
		
		return [file: "BaoCaoloidaydu.xls", data: html]
		
	}
//Báo cáo lỗi bị nhập
	def ErrorDisplayLevelAssign(ArrayList<String> content){
		def subcontent=''
		def date = new Date()
		content.each{
			//Ma-Ten Don Vi - Nhom Muc Loi 3- Mo ta loi - User Loi - Cap do loi - Trang Thai - Ngay xay ra - Ngay Khac phuc - Ngay gio nhap
			subcontent += messageSource.getMessage('opError.getErrorDisplayLevelAssign.SubContent',[it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9]].toArray(),LCH.getLocale())
		}
		def header=messageSource.getMessage('opError.Template.Header', ["10","BÁO CÁO LỖI BỊ NHẬP","(Ngày giờ tạo: "+date.format("dd/MM/yyyy HH:mm:ss")+")"].toArray(), LCH.getLocale())
		def title=messageSource.getMessage('opError.getErrorDisplayLevelAssign.Title',null,LCH.getLocale())
		def footer=messageSource.getMessage('opError.footer',null,LCH.getLocale())
		
		def html=messageSource.getMessage('opError.Template.EportExcel',[header,title,subcontent,footer].toArray(),LCH.getLocale());
		
		return [file: "DanhSachLoiBiNhap.xls", data: html]
	}
		
}
