import msb.platto.commons.*
import msb.platto.fingerprint.*
import msb.platto.melanin.*
import org.springframework.security.core.context.SecurityContextHolder as SCH
class BootStrap {
    def riskService
	def grailsApplication
	def springSecurityService

    def init = { servletContext ->
		for (cc in grailsApplication.controllerClasses) {
			cc.metaClass.getAuthenticatedUser = { ->
			   if (!springSecurityService.isLoggedIn()) return null
			   User.findByUsername SCH.context.authentication.principal.username
			}
		 }
            // configuration
            if(!Conf.findByType('OP_RISK_SURVEY')){
                new Conf(type:'OP_RISK_SURVEY',value:'S001',label:'OP_RISK',dataType:ConfType.TEXT).save(flush:true)
            }
			if(!Conf.findByType('quiz_minutes')){
				new Conf(type:'quiz_minutes',value:'10',label:'quiz_minutes',dataType:ConfType.TEXT).save(flush:true)
			}
			if(!Conf.findByType('quiz_seconds')){
				new Conf(type:'quiz_seconds',value:'0',label:'quiz_seconds',dataType:ConfType.TEXT).save(flush:true)
			}
			
			if(!Conf.findByType('cc_email')){
				new Conf(type:'cc_email',value:'qlrr_oprisk@msb.com.vn',label:'cc_email',dataType:ConfType.TEXT).save(flush:true)
			}
			
            def welcome = Conf.findByType('welcome-text')
            if (welcome.value.equals('')){
                welcome.value='<fieldset>' +
                                    '<legend>Giới thiệu</legend>'+
                                                    '<h5>Chức năng chính của phần mềm</h5>'+
                                                    '<ul>' +
                                                            '<li>Báo cáo lỗi, báo cáo tổn thất</li>'+
                                                            '<li>Báo cáo baro, tự đánh giá rủi ro</li>'+
                                                            '<li>Xem bản tin rủi ro hoạt động</li>'+															
                                                    '</ul>'+
                                                    '<h5>Đối tượng sử dụng phần mềm</h5>'+
                                                    '<ul>'+
                                                            '<li>Cán bộ nhân viên các ĐVKD, Hỗ trợ và Kiểm soát</li>'+
                                                            '<li>Cán bộ Phòng Quản lý Rủi ro Hoạt động</li>'+
                                                    '</ul>'+
                                                    '<h5>Đầu mối liên hệ</h5>'+
                                                    '<ul>'+
                                                            '<li><strong>Nghiệp vụ:</strong> Bùi Mạnh Hưng – Phòng QLRRHĐ </li>' + '<li> 043. 771 8989 – Máy lẻ: 8002</li><br/>'+
                                                            '<li><strong>IT</strong>: ITService_Desk: 043.771 8989 – Máy lẻ: 8686</li>'+
                                                    '</ul>'+
                                                    '<h5>Các tài liệu liên quan</h5>'+
                                                    '<ul>'+
                                                            '<li><a href="docs/QC RR 005 Quan ly RR Hoat dong.pdf" target="_blank">Quy chế Quản lý RRHĐ</a></li>'+
                                                            '<li><a href="docs/QT RR 006 Bao cao su kien ton that.pdf" target="_blank">Quy trình Báo cáo sự kiện tổn thất</a></li>'+
                                                            '<li><a href="docs/QT RR 007 Tu danh gia rui ro va hieu qua KS.pdf" target="_blank">Quy trình Tự đánh giá rủi ro</a></li>'+
                                                            '<li><a href="docs/Huong dan phan mem OpRisk.pdf" target="_blank">Hướng dẫn sử dụng phần mềm</a></li>'+
                                                    '</ul>'+
                                                    '<br/>'+                                                    
                                            '</fieldset>';
            }
            // ROLE
            // new Conf(type:'ROLE',value:'100',label:'GDTT').save(flush:true)
            // new Conf(type:'ROLE',value:'200',label:'CVQLRR').save(flush:true)
            //new Conf(type:'ROLE',value:'1000',label:'ADMIN').save(flush:true)
            if(Cause.count() == 0 ){
                riskService.importCause()
            }
            if(Department.count()==0){
                def newDepartment = new Department (name:'Khách hàng cá nhân')
                newDepartment.save(flush:true)
                riskService.importRisk(newDepartment)
                newDepartment = new Department (name:'Khách hàng doanh nghiệp')
                newDepartment.save(flush:true)
                riskService.importRisk(newDepartment)
                newDepartment = new Department (name:'Trung tâm DSF')
                newDepartment.save(flush:true)
                riskService.importRisk(newDepartment)
            }
			
			if(!ErrorStatus.findByNameStatus('Chưa khắc phục')){
				new ErrorStatus(nameStatus:'Chưa khắc phục',code:'1',status:1).save(flush:true)
			}
			
			if(!ErrorStatus.findByNameStatus('Đã khắc phục')){
				new ErrorStatus(nameStatus:'Đã khắc phục',code:'2',status:1).save(flush:true)
			}


            if(!Role.findByAuthority('ROLE_CVQLRR')){
                new Role(authority:'ROLE_CVQLRR').save(flush:true)
            }
            if(!Role.findByAuthority('ROLE_GDTT')){
                new Role(authority:'ROLE_GDTT').save(flush:true)
            }
			
			if(!Role.findByAuthority('ROLE_GDTT_LEVEL2')){
				new Role(authority:'ROLE_GDTT_LEVEL2').save(flush:true)
			}
			if(!Role.findByAuthority('ROLE_GDTT_LEVEL3')){
				new Role(authority:'ROLE_GDTT_LEVEL3').save(flush:true)
			}
			if(!Role.findByAuthority('ROLE_GDTT_LEVEL4')){
				new Role(authority:'ROLE_GDTT_LEVEL4').save(flush:true)
			}
			if(!ErrorMail.findByCode('Check')){
				new ErrorMail(code:'Check',content:'Enable/Disable',enableSendEmail:'Y',status:'1',subject:'').save(flush:true)
			}
			if(!ErrorMail.findByCode('CR')){
				new ErrorMail(code:'CR',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">Nhập lỗi.</font><br>Phân loại lỗi: <font color="red">{0}</font><br>Mô tả lỗi:<font color="red"> {1} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {2}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) Nhập lỗi: {1}').save(flush:true)
			}
			if(!ErrorMail.findByCode('ED')){
				new ErrorMail(code:'ED',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">Sửa lỗi.</font><br>Phân loại lỗi: <font color="red">{0}</font><br>Mô tả lỗi:<font color="red"> {1} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {2}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) Sửa lỗi: {1}').save(flush:true)
			}
			if(!ErrorMail.findByCode('CM')){
				new ErrorMail(code:'CM',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">Gửi ý kiến.</font><br>Phân loại lỗi: <font color="red">{0}</font><br>Mô tả lỗi:<font color="red"> {1} </font> <br>Nội dung ý kiến: <font color="red">{2}</font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) Gửi ý kiến: {1}').save(flush:true)
			}
			if(!ErrorMail.findByCode('DTT')){
				new ErrorMail(code:'DTT',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">Đổi trạng thái.</font><br>Phân loại lỗi: <font color="red">{0}</font><br>Mô tả lỗi:<font color="red"> {1} </font><br>Mô tả trạng thái: <font color = "red">{2}</font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) Đổi trạng thái: {1}').save(flush:true)
			}
			if(!ErrorMail.findByCode('DEL')){
				new ErrorMail(code:'DEL',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">Xóa lỗi.</font> <br>Phân loại lỗi: <font color="red">{0}</font> <br>Mô tả lỗi:<font color="red"> {1} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {2}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) Xóa lỗi: {1}').save(flush:true)
			}
            if(!ErrorMail.findByCode('CALCAP')){
                new ErrorMail(code:'CALCAP',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả:<font color="red"> {1} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {2}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: {2}').save(flush:true)
            }
            if(!ErrorMail.findByCode('trackKRI')){
                new ErrorMail(code:'trackKRI',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tiêu đề KRI: <font color ="red">{0}.</font><br>Mô tả KRI:<font color="red"> {1} </font><br>Đơn vị đo lường:<font color="red"> {2} </font> <br>Giá trị KRI cập nhật gần nhất:<font color="red"> {3} </font> <br>Giá trị ngưỡng:<font color="red"> {4} </font> <br>Màu cảnh báo:<font color="red"> {5} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem KRI có ID là {6}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: {2}').save(flush:true)
            }
            if(!ErrorMail.findByCode('KRI')){
                new ErrorMail(code:'KRI',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả KRI:<font color="red"> {1} </font><br>{2}Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem KRI có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: {2}').save(flush:true)
            }
			if(!ErrorMail.findByCode('blackListCN')){
				new ErrorMail(code:'blackListCN',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: Họ tên:<font color="red"> {1} </font>,CMT:<font color="red"> {2} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: ').save(flush:true)
			}
			if(!ErrorMail.findByCode('blackListPN')){
				new ErrorMail(code:'blackListPN',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: Tên doanh nghiệp:<font color="red"> {1} </font>,Số DKKD:<font color="red"> {2} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}:').save(flush:true)
			}
			if(!ErrorMail.findByCode('blackListTSBD')){
				new ErrorMail(code:'blackListTSBD',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: Loại tài sản:<font color="red"> {1} </font>,Thông tin nhận diện:<font color="red"> {2} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}:').save(flush:true)
			}
			if(!ErrorMail.findByCode('SCRIPT')){
				new ErrorMail(code:'SCRIPT',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Phân loại sự kiện:<font color="red"> {1} </font> <br>Phân loại lĩnh vực kinh doanh:<font color="red"> {2} </font><br>Mô tả kịch bản:<font color="red"> {3} </font><br>Mô tả:<font color="red"> {4} </font> <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {5}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: {2}').save(flush:true)
			}
			if(!ErrorMail.findByCode('ACTION')){
				new ErrorMail(code:'ACTION',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Phân loại hành động:<font color="red"> {1} </font><br>Mô tả hành động:<font color="red"> {2} </font><br> {3} <br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem lỗi có ID là {4}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: {2}').save(flush:true)
			}
			
			// Send Email Upload
			if(!ErrorMail.findByCode('sendEmailBLCn')){
				new ErrorMail(code:'sendEmailBLCn',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: <font color="red"> {1} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}: ').save(flush:true)
			}
			if(!ErrorMail.findByCode('sendEmailBLPn')){
				new ErrorMail(code:'sendEmailBLPn',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: <font color="red"> {1} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}:').save(flush:true)
			}
			if(!ErrorMail.findByCode('sendEmailBLTsbd')){
				new ErrorMail(code:'sendEmailBLTsbd',content:'Kính gửi anh/chị,<br>Đây là email tự động từ hệ thống quản lý rủi ro hoạt động.<br><br>Tên thao tác: <font color ="red">{0}.</font><br>Mô tả Blacklist: <font color="red"> {1} </font><br>Để biết thông tin chi tiết về lỗi đã được ghi nhận anh/chị có thể click vào link dưới đây, đăng nhập và xem Blacklist có ID là {3}:<br><a href="http://oprisk.msb.com.vn/oprisk/">http://oprisk.msb.com.vn/oprisk</a><br><br>Trân trọng,<br>Phòng Quản lý Rủi ro Hoạt động',enableSendEmail:'Y',status:'1',subject:'(ID-{0}) {1}:').save(flush:true)
			}
			
			// Lý do thuộc danh sách : BlacklistCN, BlacklistPN
			if(!BlacklistCategory.findByName('Do gian lận (giả mạo, chỉnh sửa, lừa đảo, không trung thực...)'))
				new BlacklistCategory(name:'Do gian lận (giả mạo, chỉnh sửa, lừa đảo, không trung thực...)',code:'1',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistCategory.findByName('Do phát sinh nợ xấu'))
				new BlacklistCategory(name:'Do phát sinh nợ xấu',code:'2',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistCategory.findByName('Do không đạt được chỉ tiêu tối thiểu'))
				new BlacklistCategory(name:'Do không đạt được chỉ tiêu tối thiểu',code:'3',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistCategory.findByName('Do khách hàng có rủi ro cao'))
				new BlacklistCategory(name:'Do khách hàng có rủi ro cao',code:'4',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistCategory.findByName('Do các nguyên nhân khác'))
				new BlacklistCategory(name:'Do các nguyên nhân khác',code:'5',type:'0',status:'0').save(flush:true)
            
			// Lý do thuộc danh sách : BlacklistTSBD
			if(!BlacklistRiskTSBD.findByName('Do gian lận (giả mạo,chỉnh sửa,lừa đảo,không trung thực...)'))
				new BlacklistRiskTSBD(name:'Do gian lận (giả mạo,chỉnh sửa,lừa đảo,không trung thực...)',code:'1',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistRiskTSBD.findByName('Do không đạt yêu cầu là TSBĐ theo quy định'))
				new BlacklistRiskTSBD(name:'Do không đạt yêu cầu là TSBĐ theo quy định',code:'2',type:'0',status:'0',).save(flush:true)
				
			if(!BlacklistRiskTSBD.findByName('Do có tranh chấp hoặc liên quan đến pháp luật'))
				new BlacklistRiskTSBD(name:'Do có tranh chấp hoặc liên quan đến pháp luật',code:'3',type:'0',status:'0').save(flush:true)
				
			if(!BlacklistRiskTSBD.findByName('Do các nguyên nhân khác'))
				new BlacklistRiskTSBD(name:'Do các nguyên nhân khác',code:'4',type:'0',status:'0').save(flush:true)
				
			// Phân loại đối tượng 
			if(!BlacklistObject.findByName('Danh sách đen'))
				new BlacklistObject(name:'Danh sách đen',code:'1',status:'0').save(flush:true)
				
			if(!BlacklistObject.findByName('Danh sách cảnh báo'))
				new BlacklistObject(name:'Danh sách cảnh báo',code:'2',status:'0').save(flush:true)
				
			if(!BlacklistObject.findByName('Danh sách phong tỏa'))
				new BlacklistObject(name:'Danh sách phong tỏa',code:'3',status:'0').save(flush:true)
				
			// Loại tài sản đảm bảo
			if(!BlacklistTaiSan.findByName('Bất động sản'))
				new BlacklistTaiSan(name:'Bất động sản',code:'1',status:'0').save(flush:true)
				
			if(!BlacklistTaiSan.findByName('Phương tiện vận tải'))
				new BlacklistTaiSan(name:'Phương tiện vận tải',code:'2',status:'0').save(flush:true)
				
			if(!BlacklistTaiSan.findByName('Tiền gửi/Giấy tờ có giá'))
				new BlacklistTaiSan(name:'Tiền gửi/Giấy tờ có giá',code:'3',status:'0').save(flush:true)
				
			if(!BlacklistTaiSan.findByName('Công cụ chuyển nhượng'))
				new BlacklistTaiSan(name:'Công cụ chuyển nhượng',code:'4',status:'0').save(flush:true)
				
			if(!BlacklistTaiSan.findByName('Hàng hóa'))
				new BlacklistTaiSan(name:'Hàng hóa',code:'5',status:'0').save(flush:true)
				
			if(!BlacklistTaiSan.findByName('Bảo lãnh ngân hàng'))
				new BlacklistTaiSan(name:'Bảo lãnh ngân hàng',code:'6',status:'0').save(flush:true)
			
			if(!BlacklistTaiSan.findByName('TSBĐ khác (sạp chợ và các TSBĐ khác)'))
				new BlacklistTaiSan(name:'TSBĐ khác (sạp chợ và các TSBĐ khác)',code:'7',status:'0').save(flush:true)
				
			// Request map
            if(!RequestMap.findByUrl('/admin/**')){
                new RequestMap('url':'/admin/**',configAttribute:'ROLE_CVQLRR,ROLE_GDTT_LEVEL3').save(flush:true)
            }
            if(!RequestMap.findByUrl('/surveyAdmin/**')){
                new RequestMap('url':'/surveyAdmin/**',configAttribute:'ROLE_CVQLRR').save(flush:true)
            }
            if(!RequestMap.findByUrl('/opRisk/**')){
                new RequestMap('url':'/opRisk/**',configAttribute:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            }
			if(!RequestMap.findByUrl('/opError/**')){
				new RequestMap('url':'/opError/**',configAttribute:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
			}
            if(!RequestMap.findByUrl('/report/**')){
                new RequestMap('url':'/report/**',configAttribute:'ROLE_CVQLRR').save(flush:true)
            }
            if(!RequestMap.findByUrl('/selfEvaluation/**')){
                new RequestMap('url':'/selfEvaluation/**',configAttribute:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3').save(flush:true)
            }
			if(!RequestMap.findByUrl('/masterUserCreate/**')){
				new RequestMap('url':'/masterUserCreate/**',configAttribute:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
			}
			if(!RequestMap.findByUrl('/opError/getErrorDisplay/**')){
				new RequestMap('url':'/opError/getErrorDisplay/**',configAttribute:'ROLE_CVQLRR').save(flush:true)
			}
            if(!RequestMap.findByUrl('/capitalCal/**')){
                new RequestMap('url':'/capitalCal/**',configAttribute:'ROLE_CVQLRR').save(flush:true)
            }
            if(!RequestMap.findByUrl('/kris/**')){
                new RequestMap('url':'/kris/**',configAttribute:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            }
			
			/*if(!MenuItem.findByName('masterUserCreate'))
			new MenuItem(name:'masterUserCreate',controller:'masterUserCreate',action:'displayAll',
				title:'',label:'Quanr ly nguoi dung',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)*/
				
//level 	
			if(!MenuItem.findByName('error-management'))
				new MenuItem(name:'error-management',controller:'opError',action:'getErrorDisplay',
					title:'',label:'Báo cáo lỗi',roles:'ROLE_CVQLRR').save(flush:true)		
			if(!MenuItem.findByName('error-managementLevel1'))
				new MenuItem(name:'error-managementLevel1',controller:'opError',action:'getErrorDisplayLevel1',
					title:'',label:'Báo cáo lỗi',roles:'ROLE_GDTT').save(flush:true)
			if(!MenuItem.findByName('error-managementLevel2'))
				new MenuItem(name:'error-managementLevel2',controller:'opError',action:'getErrorDisplayLevel2',
					title:'',label:'Báo cáo lỗi',roles:'ROLE_GDTT_LEVEL2').save(flush:true)
			if(!MenuItem.findByName('error-managementLevel3'))
			 	new MenuItem(name:'error-managementLevel3',controller:'opError',action:'getErrorDisplayLevel3',
					title:'',label:'Báo cáo lỗi',roles:'ROLE_GDTT_LEVEL3').save(flush:true)
			if(!MenuItem.findByName('error-managementLevel4'))
				new MenuItem(name:'error-managementLevel4',controller:'opError',action:'getErrorDisplayLevel4',
					title:'',label:'Báo cáo lỗi',roles:'ROLE_GDTT_LEVEL4').save(flush:true)
			
			// Begin menuItem BlackList					
			if(!MenuItem.findByName('blacklist-management'))
				new MenuItem(name:'blacklist-management',controller:'blackList',action:'detailCaNhan',
					title:'',label:'Blacklist',roles:'ROLE_CVQLRR ,ROLE_GDTT ,ROLE_GDTT_LEVEL2 ,ROLE_GDTT_LEVEL3 ,ROLE_GDTT_LEVEL4').save(flush:true)			
					 		
			if(!MenuItem.findByName('incident'))
				new MenuItem(name:'incident',controller:'opRisk',action:'listIncident',
					title:'',label:'Báo cáo tổn thất',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('baro'))
			new MenuItem(name:'baro',controller:'opRisk',action:'create',
				title:'',label:'Báo cáo Baro',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)            
            if(!MenuItem.findByName('self-management'))
			new MenuItem(name:'self-management',controller:'selfEvaluation',action:'index',
				title:'',label:'Tự đánh giá RR',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('action-management'))
			new MenuItem(name:'action-management',controller:'selfEvaluation',action:'actionManagement',
				title:'',label:'Kế hoạch HĐ',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('view-response'))
			new MenuItem(name:'view-response',controller:'opRisk',action:'viewResponse',
				title:'',label:'Khuyến nghị',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('view-news'))
			new MenuItem(name:'view-news',controller:'opRisk',action:'viewNews',
				title:'',label:'Bản tin RR',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
			if(!MenuItem.findByName('quiz-management'))
				new MenuItem(name:'quiz-management',controller:'quizAdmin',action:'index',
					title:'',label:'Kiểm tra',roles:'ROLE_CVQLRR').save(flush:true)
            if(!MenuItem.findByName('baro-management'))
			new MenuItem(name:'baro-management',controller:'surveyAdmin',action:'index',
				title:'',label:'Quản lý báo cáo RR',roles:'ROLE_CVQLRR').save(flush:true)
            if(!MenuItem.findByName('report'))
			new MenuItem(name:'report',controller:'opRisk',action:'incidentReport',
				title:'',label:'Quản lý báo cáo tổn thất',roles:'ROLE_CVQLRR').save(flush:true)
            if(!MenuItem.findByName('self-evaluation-management'))
			new MenuItem(name:'self-evaluation-management',controller:'report',action:'instancesReport',
				title:'',label:'Quản lý đánh giá RR',roles:'ROLE_CVQLRR').save(flush:true)
            if(!MenuItem.findByName('response-management'))
			new MenuItem(name:'response-management',controller:'opRisk',action:'listResponse',
				title:'',label:'Quản lý khuyến nghị hành động',roles:'ROLE_CVQLRR').save(flush:true)
				
			
					
            if(!MenuItem.findByName('news-management'))
			new MenuItem(name:'news-management',controller:'opRisk',action:'listNews',
				title:'',label:'Quản lý bản tin RR',roles:'ROLE_CVQLRR').save(flush:true)
            if(!MenuItem.findByName('management'))
			new MenuItem(name:'management',controller:'admin',action:'userManagement',
				title:'',label:'Quản lý hệ thống',roles:'ROLE_CVQLRR,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('created-reports'))
			new MenuItem(name:'created-reports',controller:'opRisk',action:'getReport',
				title:'',label:'Báo cáo cũ',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
//            if(!MenuItem.findByName('admin-management'))
//			new MenuItem(name:'admin-management',controller:'surveyAdmin',action:'index',
//				title:'',label:'Quản lý hệ thống',roles:'ROLE_CVQLRR').save(flush:true)
			if(!MenuItem.findByName('quiz'))
			new MenuItem(name:'quiz',controller:'opRisk',action:'quizIndex',
				title:'',label:'Kiểm tra',roles:'ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
            if(!MenuItem.findByName('update-information'))
			new MenuItem(name:'update-information',controller:'opRisk',action:'updateInformation',
				title:'',label:'Đổi thông tin',roles:' ').save(flush:true)
            if(!MenuItem.findByName('kris_menu'))
            new MenuItem(name:'kris_menu',controller:'kris',action:'krisDisplay',
                    title:'',label:'KRIs',roles:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
			if(!MenuItem.findByName('capitalCal_menu'))
            new MenuItem(name:'capitalCal_menu',controller:'bi',action:'biListDisplay',
                    title:'',label:'Tính toán vốn',roles:'ROLE_CVQLRR').save(flush:true)
					
			if(!MenuItem.findByName('riskAction'))
			new MenuItem(name:'riskAction',controller:'riskAction',action:'list',
					title:'',label:'Giám sát HĐ',roles:'ROLE_CVQLRR,ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4').save(flush:true)
					
			if(!MenuItem.findByName('riskScript'))
			new MenuItem(name:'riskScript',controller:'opRisk',action:'listScript',
				title:'',label:'Phân tích kịch bản',roles:'ROLE_CVQLRR').save(flush:true)

/*            if(!MenuItem.findByName('bi_menu'))
            new MenuItem(name:'bi_menu',controller:'bi',action:'biDisplay',
                    title:'',label:'Tính toán vốn theo BI',roles:'ROLE_CVQLRR').save(flush:true)*/
//TGL				
			if(!UnitDepart.findByName('Horizontal Tree'))
				new UnitDepart(name:'Horizontal Tree',code:'1',ord:'0',status:'0',parent:null).save(flush:true)
			if(!ErrorList.findByName('Horizontal Tree'))
				new ErrorList(name:'Horizontal Tree',code:'1',ord:'0',status:'0',parent:null).save(flush:true)
			if(!ErrorCheck.findByName('Trực tiếp'))
				new ErrorCheck(name:'Trực tiếp ',code:'1',status:'1').save(flush:true)
			if(!ErrorCheck.findByName('Giám sát từ xa'))
				new ErrorCheck(name:'Giám sát từ xa ',code:'2',status:'1').save(flush:true)
			if(!ErrorCheck.findByName('Khác'))
				new ErrorCheck(name:'Khác',code:'3',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Dịch vụ khách hàng'))
				new ErrorCategory(name:'Dịch vụ khách hàng',code:'1',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Tín dụng'))
				new ErrorCategory(name:'Tín dụng',code:'2',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Kế toán'))
				new ErrorCategory(name:'Kế toán',code:'3',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Vận hành'))
				new ErrorCategory(name:'Vận hành',code:'4',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Định chế tài chính'))
				new ErrorCategory(name:'Định chế tài chính',code:'5',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Quản lý rủi ro'))
				new ErrorCategory(name:'Quản lý rủi ro',code:'6',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Nhân sự'))
				new ErrorCategory(name:'Nhân sự',code:'7',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('Công nghệ thông tin'))
				new ErrorCategory(name:'Công nghệ thông tin',code:'8',status:'1').save(flush:true)
			if(!ErrorCategory.findByName('khác'))
				new ErrorCategory(name:'Khác',code:'9',status:'1').save(flush:true)
				
//TGL
				
//			if(!User.findByUsername('cuongtv15'))
//				new User(fullname:'Bùi Minh Đức',username:'cuongtv1',password:'1',enabled:true,accountExpired:true,accountLocked:true,passwordExpired:true)
            if(Impact.count() == 0 ){
                new Impact(description:'- Tổn thất trực tiếp nếu xảy ra < 1 triệu đồng <br> - Hoặc có khả năng gây ra chi phí thấp và không gây ảnh hưởng đến uy tín và hình ảnh của Ngân hàng, không có yếu tố cấu thành hành vi phạm tội, không gây ra rắc rối pháp lý cho ngân hàng, dễ dàng khắc phục hậu quả.'
                    ,level:'Không ảnh hưởng',score:'1').save(flush:true)
                new Impact(description:'- Tổn thất trực tiếp nếu xảy ra từ 1 đến 10 triệu đồng <br>- Hoặc có khả năng gây ra chi phí tương đối và/hoặc ảnh hưởng đến uy tín của Ngân hàng hoặc có ảnh hưởng một chút tới vấn đề pháp lý, có khả năng một số quyết định được đưa ra chống lại ngân hàng, tương đối dễ khắc phục hậu quả.'
                    ,level:'Nhỏ',score:'2').save(flush:true)
                new Impact(description:'- Tổn thất trực tiếp nếu xảy ra từ >10 đến 50 triệu đồng<br>- Hoặc có khả năng gây ra chi phí đáng kể và/hoặc ảnh hưởng đến uy tín của Ngân hàng hoặc xảy ra kiện tụng dân sự tuy nhiên có thể hòa giải mà không cần ra tòa án, tương đối khó khắc phục hậu quả.'
                    ,level:'Tương đối',score:'3').save(flush:true)
                new Impact(description:'- Tổn thất trực tiếp nếu xảy ra từ >50 đến 1 tỷ đồng <br>- Hoặc có khả năng gây ra chi phí kinh tế lớn và/hoặc ảnh hưởng đến uy tín của ngân hàng hoặc xảy ra kiện tụng dân sự bất lợi cho ngân hàng và ít có khả năng có thể hòa giải nhanh chóng, khó khắc phục hậu quả.'
                    ,level:'Lớn',score:'4').save(flush:true)
                new Impact(description:'- Tổn thất trực tiếp nếu xảy ra từ > 1 tỷ đồng<br>- Hoặc có khả năng gây ra chi phí kinh tế rất lớn (bao gồm cả thiệt hại về giảm giá trị cổ phiếu và ảnh hưởng đến uy tín của ngân hàng) hoặc xảy ra kiện tụng bất lợi cho ngân hàng do có những vi phạm lớn, khó khắc phục hậu quả'
                    ,level:'Rất Lớn',score:'5').save(flush:true)
            }
            if(Possibility.count() == 0 ){
                new Possibility(description:'- Trong quá khứ, rủi ro này không xuất hiện tại đơn vị <br>- Khả năng xảy ra không đáng kể, chỉ xảy ra trong những trường hợp rất đặc biệt.'
                    ,level:'Rất ít xảy ra',score:'1').save(flush:true)
                new Possibility(description:'- Trong quá khứ, xảy ra mỗi năm 1 lần hoặc hơn <br>- Có thể xảy ra một vài trường hợp; Nhỏ hơn 25% khả năng có thể xảy ra.'
                    ,level:'Ít xảy ra',score:'2').save(flush:true)
                new Possibility(description:'- Trong quá khứ, xảy ra mỗi năm khoảng 2,3 lần <br>- Rất có khả năng xảy ra trong một số trường hợp; 25-50% khả năng có thể xảy ra.'
                    ,level:'Có khả năng',score:'3').save(flush:true)
                new Possibility(description:'- Trong quá khứ, xảy ra hàng tháng <br>- Hoàn toàn có thể xảy ra trong nhiều trường hợp ; 50-75% khả năng có thể xảy ra.'
                    ,level:'Khả năng lớn',score:'4').save(flush:true)
                new Possibility(description:'- Trong quá khứ, xảy ra nhiều lần trong tháng <br>- Sẽ xảy ra trong hầu hết các trường hợp; Lớn hơn 75% khả năng có thể xảy ra.'
                    ,level:'Khả năng rất lớn',score:'5').save(flush:true)
            }
            if(ControlEffect.count() == 0 ){
                new ControlEffect(description:'- Quy trình kiểm tra kiểm soát được cập nhật đầy đủ trong vòng 12 tháng gần nhất <br> - Vai trò và trách nhiệm được phân cấp đến từng mảng hoạt động cụ thể <br>- Các vấn đề quan trọng được kiểm tra cẩn thận <br>- Có ít sự thay đổi được cập nhật vào quy trình hiện hành <br>- Rủi ro được chuyển giao toàn bộ cho bên thứ ba, còn lại rất ít rủi ro'
                    ,level:'Rất nhỏ',score:'1').save(flush:true)
                new ControlEffect(description:'- Quy trình bao trùm các khu vực quan trọng và một số chi tiết được cập nhật trong vòng 12 tháng gần nhất <br>- Phân rõ vai trò và trách nhiệm cho hầu hết các chức năng <br>- Quá trình áp dụng thực tế có sự hỗ trợ từ cấp quản lý nhưng cho phép sự biến đổi trong cách thức áp dụng của nhân viên <br>- Có ít sự thay đổi trong phương thức kinh doanh trong vòng sáu tháng gần nhất, việc thích nghi với thay đổi được dựa trên kinh nghiệm của các nhân viên <br>- Phần lớn rủi ro được chuyển giao cho bên thứ ba hoặc được trích lập dự phòng'
                    ,level:'Nhỏ',score:'2').save(flush:true)
                new ControlEffect(description:'- Từng xảy ra một số ngoại lệ thể hiện sự hạn chế của việc thiết kế chốt kiểm soát <br>- Quy trình bao trùm các khu vực quan trọng nhưng có điểm hở nhất định, phân lớn công việc được định nghĩa chung chung, có một số lỗi nhỏ không được theo sát <br>- Nhân viên áp dụng các bước trong quy trình một cách không đầy đủ tuy nhiên có sự giám sát quản lý phù hợp, từ đó có thể ngăn chặn được những lỗi nghiêm trọng <br>- Các dự án và quy trình mới được thực hiện hoặc các nhân viên mới có ảnh hưởng đển hoạt động <br>- Một phần rủi ro được chuyển giao cho bên thứ ba hoặc đã được trích lập dự phòng'
                    ,level:'Trung bình',score:'3').save(flush:true)
                new ControlEffect(description:'- Sai sót trong kiểm soát tại cấp cơ sở đang diễn ra và kiểm soát cấp trên không kịp thời nhận ra sai sót <br>- Phân cấp quản lý không rõ ràng cộng thêm xuất hiện các điểm yếu trong quản lý dẫn đến các lỗi không được phát hiện kịp thời <br>- Phần lớn quản lý thủ công và theo tính phát hiện <br>- Có sự thay đổi cơ bản trong phương pháp làm việc hoặc sản phẩm/dịch vụ trong vài tháng tiếp theo hoặc quy trình vận hành mới cho phần lớn hoạt động kinh doanh. Nhân viên có ít kinh nghiệm <br>- Rủi ro tối thiếu được chuyển sang bên thứ ba hoặc được trích lập dự phòng'
                    ,level:'Đáng kể',score:'4').save(flush:true)
                new ControlEffect(description:'- Hệ thống kiểm soát rất yếu hoặc không có <br>- Rất ít hoặc là không có quy trình <br>- Bộ máy kiểm soát yếu, cấp bậc và trách nhiệm kiểm soát không được xác định rõ ràng <br>- Phương thức kinh doanh thay đổi nhanh chóng và không chắc chắn. Thu nhập của Nhân viên quá cao hoặc sự thăng tiến quá nhanh làm giảm đi quá trình tích lũy kinh nghiệm và văn hóa <br>- Chỉ xử lý vấn đề một cách bị động dựa trên quan điểm cá nhân'
                    ,level:'Nghiêm trọng',score:'5').save(flush:true)
            }
			
			
			if(!BusinessField.findByName('Lĩnh vực kinh doanh tài chính doanh nghiệp'))
				new BusinessField(name:'Lĩnh vực kinh doanh tài chính doanh nghiệp',code:'1',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực kinh doanh thị trường tài chính'))
				new BusinessField(name:'Lĩnh vực kinh doanh thị trường tài chính',code:'2',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực bán lẻ'))
				new BusinessField(name:'Lĩnh vực bán lẻ',code:'3',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực ngân hàng thương mại'))
				new BusinessField(name:'Lĩnh vực ngân hàng thương mại',code:'4',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực thanh toán'))
				new BusinessField(name:'Lĩnh vực thanh toán',code:'5',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực kinh doanh dịch vụ đại lý'))
				new BusinessField(name:'Lĩnh vực kinh doanh dịch vụ đại lý',code:'6',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực quản lý tài sản'))
				new BusinessField(name:'Lĩnh vực quản lý tài sản',code:'7',status:0).save(flush:true)
			if(!BusinessField.findByName('Lĩnh vực kinh doanh môi giới bán lẻ'))
				new BusinessField(name:'Lĩnh vực kinh doanh môi giới bán lẻ',code:'8',status:0).save(flush:true)
				
			if(!ActionType.findByName('Hành động từ Hội đồng'))
				new ActionType(name:'Hành động từ Hội đồng',code:'1',status:0).save(flush:true)
			if(!ActionType.findByName('Hành động từ báo cáo rủi ro'))
				new ActionType(name:'Hành động từ báo cáo rủi ro',code:'2',status:0).save(flush:true)
			if(!ActionType.findByName('Hành động từ kịch bản'))
				new ActionType(name:'Hành động từ kịch bản',code:'3',status:0).save(flush:true)
			if(!ActionType.findByName('Hành động tự định nghĩa'))
				new ActionType(name:'Hành động tự định nghĩa',code:'4',status:0).save(flush:true)
			if(!ActionType.findByName('Hành động cho rủi ro đã có'))
				new ActionType(name:'Hành động cho rủi ro đã có',code:'5',status:0).save(flush:true)
			if(!ActionType.findByName('Khác'))
				new ActionType(name:'Khác',code:'6',status:0).save(flush:true)
				
            if(Survey.count()==0){

                Survey s = new Survey(reference:'1',title:'Trung tâm KHDN1',department:Department.get(1))

                def i = 0
                //1
                Question q = new Question(reference:'Q01',
                title:"Toàn bộ nhân viên được đào tạo và vượt qua bài test (Đúng từ 10 câu trở lên) về quản lý rủi ro hoạt động",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1.Toàn bộ nhân viên đã đi học và đã vượt qua bài test. Tất cả có thể kể tên và phân biệt 4 loại rủi ro chính.",
                "1. Trên 50% nhưng không phải toàn bộ nhân viên đã đi học và vượt qua bài test. Một số nhân viên có thể kể tên và phân biết 4 loại rủi ro chính.",
                "1. Dưới 50% nhân viên đã đi học và vượt qua bài test. Một số nhân viên có thể kể tên và phân biệt 4 loại rủi ro chính.",
                "1. Không có nhân viên nào đã tham gia đào tạo về quản lý rủi ro hoạt động"]''',
                weight:6.45/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //2
                q = new Question(reference:'Q02',
                title:"Tài liệu RRHĐ (Cẩm nang, thẻ ghi nhớ, nền máy tính) để đúng theo vị trí hướng dẫn",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1.Trung tâm có tất cả tài liệu RRHĐ (1 cuốn cẩm nang, một thẻ nhớ cho mỗi nhân viên, hình nền được cài đặt trên mọi máy tính). Tài liệu để ở nơi dễ thấy và dễ lấy đối với nhân viên, VÀ nằm ngoài tầm với và tầm mắt của KH.",
                "1. Trung tâm có một số nhưng không có tất cả tài liệu quản lý rủi ro hoạt động. Tài liệu để ở nơi dễ thấy và dễ lấy đối với nhân viên. VÀ nằm ngoài tầm với và tầm mắt của KH.",
                "1. Trung tâm có đủ hoắc có một số tài liệu RRHĐ. Tuy nhiên tài liệu KHÔNG để ở nơi dễ thấy và dễ lấy đối với nhân viên, VÀ/HOẶC năm trong tầm với và tầm mắt của KH.",
                "1. Trung tâm không có tài liệu RRHĐ."]''',
                weight:0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //3
                        q = new Question(reference:'Q03',
                title:"Nhân viên có nhận thức về các biện pháp an toàn thông tin và áp dụng các biện pháp đó (khóa máy tính, để hồ sơ trong tủ khóa, không trao đổi mật khẩu, không xử lý số PIN của KH",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Toàn bộ nhân viên có thể kể tên ít nhất ba biện pháp an toàn thông tin. Toàn bộ nân viên áp dụng những biện pháp này và không phát hiện thấy sự vi phạm nào.",
                "1. Toàn bộ nhân viên có thể kể tin ít nhất ba biện pháp an toàn thông tin. Không phải nhân viên nào cũng áp dụng những biện pháp này, nghĩa là đã phát hiện trường hợp vi phạm.",
                "1. Một số nhân viên (không phải tất cả) có thể kể tên ít nhất ba biện pháp an toàn thông tin. Không phải nhân viên nào cũng áp dụng những biện pháp này, nghĩa là đã phát hiện trường hợp vi phạm.",
                "1.Không có nhân viên nào có thể kể tên ba biện pháp an toàn thông tin. <br> HOẶC Không có nhân viên nào áp dụng những biện pháp này và đã phát hiện nhiều trường hợp vi phạm."]''',
                weight:9.19/100.0,
                survey:s,
                ord:i++)
                        s.addToQuestions(q)


                //4
                q = new Question(reference:'Q04',
                title:"Toàn bộ nhân viên hiểu rõ tất cả các sản phẩm mà trung tâm cung cấp",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. GĐ TT tập huấn định kỳ cho nhân viên về sản phẩm. GĐ TT biết nhân viên nào chưa được tập huấn và có kế hoạch tập huấn cho họ.",
                "1. GĐ TT cung cấp thông tin khi được hỏi nhưng không chủ động kiểm tra/ tập huấn cho nhân viên về sản phẩm. GĐ TT biết nhân viên nào chưa được tập huấn và có kế hoạch tập huấn cho họ.",
                "1. GĐ TT cung cấp thông tin khi được hỏi nhưng không chủ động kiểm tra/ tập huấn cho nhân viên về sản phẩm. GĐ TT không biết nhân viên nào chưa được tập huấn.",
                "1. GĐ TT không có kế hoạch tập huấn, kiểm tra hay nâng cao năng lực cho nhân viên."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //5
                q = new Question(reference:'Q05',
                title:"Năng lực nhân viên bảo vệ",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Có đủ nhân viên bảo vệ để bảo đảm an ninh trọn thời gian tại trung tâm. Nhật ký bảo vệ được ký và được điền đầy đủ.",
                "1. Có đủ nhân viên bảo vệ để bảo đảm an ninh trọn thời gian tại trung tâm. Một số phần nhật ký bảo vệ không được ký và điền đầy đủ.",
                "1. Trung tâm thiếu bảo vệ. Tuy nhiên nhật ký bảo vệ được ký và được điền đầy đủ.",
                "1.Trung tâm thiếu bảo vệ. Một số phần nhật ký bảo vệ không được ký và điền đầy đủ."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //6
                q = new Question(reference:'Q06',
                title:"Năng lực phòng tránh tiền giả",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Trung tâm có hướng dẫn mới nhất về tiền giả và toàn bộ nhân viên biết về hướng dẫn này. Toàn bộ nhân viên đã được tập huấn về cách phát hiện tiền giả.",
                "1. Trung tâm có hướng dẫn mới nhất về tiền giả nhưng không phải toàn bộ nhân viên biết về hướng dẫn này. Toàn bộ nhân viên đã được tập huấn/ có kỹ năng phát hiện tiền giả.",
                "1. Trung tâm có hướng dẫn mới nhất về tiền giả nhưng không phải toàn bộ nhân viên không biết về hướng dẫn. Chỉ một số nhân viên đã được tập huấn và có kỹ năng phát hiện tiền giả.",
                "1. Trung tâm không có hướng dẫn mới nhất. Không có nhân viên nào đã được tập huấn hoặc có kỹ năng phát hiện tiền giả."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //7
                q = new Question(reference:'Q07',
                title:"Lỗi mạng và lỗi máy tính",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Trong vòng 1 tháng qua đơn vị của anh/chị không xảy ra lỗi mạng hoặc lỗi máy tính; hoặc nếu xảy ra thì chỉ 1-2 lần và được khắc phục ngay trong vòng 30 phút.",
                "1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng hoặc lỗi máy tính 1-2 lần và không được khắc phục trong vòng 30 phút.",
                "1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng, lỗi máy tính từ 3-10 lần.",
                "1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng, lỗi máy tính quá 10 lần."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                //8
                q = new Question(reference:'Q08',
                title:"Trao đổi mật khẩu",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Tất cả các trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu (KSV làm việc của GDV, Tư vấn KH làm việc của GDV...)được ghi chép đầy đủ. Toàn bộ nhân viên biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
                "1. Một số trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu không được ghi lại. Toàn bộ nhân viên biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
                "1. Một số trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu không được ghi lại. Một số nhân viên (không phải tất cả) biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
                "1. Không có ghi chép về các trường hợp trao đổi mật khâu nhưng nhân viên cho biết đã từng trao đổi mật khẩu<br>HOẶC Không có nhân viên nào biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)


                //9
                q = new Question(reference:'Q09',
                title:"Kiểm tra và thường xuyên cập nhật thông tin khách hàng trong quá trình giải ngân",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Các nhân viên tại đơn vị thực hiện cập nhật kịp thời, đầy đủ và chính xác.",
                "1. Một số trường hợp (không phải là tất cả) thực hiện cập nhật thông tin khách hàng đầy đủ và chính xác nhưng chưa kịp thời.",
                "1. Một số trường hợp (không phải là tất cả) thực hiện cập nhật thông tin khách hàng kịp thời nhưng chưa đầy đủ.",
                "1. Một số trường hợp (không phải là tất cả) không cập nhật thông tin khách hàng khi có thay đổi."]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)

                        //10
                q = new Question(reference:'Q10',
                 title:"Sẵn sàng trong trường hợp khẩn cấp (cháy, mất điện, cướp, động đất...)",
                descriptions:'',
                evaluation:'answer',
                answerType:'List',
                validation:'''["1. Toàn bộ nhân viên biết phải làm gì trong trường hợp khẩn cấp.",
                "1. Toàn bộ nhân viên được đào tạo và biết phải làm gì trong trường hợp khẩn cấp mức thấp (ví dụ: cháy, mất điện), tuy nhiên không được chuẩn bị cho các trường hợp khẩn cấp mức cao (như trộm cướp, động đất, sóng thần, ...)",
                "1. GĐ TT và một số nhân viên có nhận biết về các kế hoạch đối phó với trường hợp khẩn cấp, tuy nhiên chưa có đào tạo chính thức.",
                "1. GĐ TT và các nhân viên không nhận biết, không quan tâm và không có kế hoạch đối phó với các trường hợp khẩn cấp"]''',
                weight:4.17/100.0,
                survey:s,
                ord:i++)

                s.addToQuestions(q)
                s.save(flush:true)
            }
			
			//QUIZ DUMD DATA
			if(QuizSurvey.count()==0){
				
								QuizSurvey s = new QuizSurvey(reference:'1',title:'Trung tâm KHDN1',department:Department.get(1))
				
								def i = 0
								//1
								QuizQuestion q = new QuizQuestion(reference:'Q01',
								title:"Toàn bộ nhân viên được đào tạo và vượt qua bài test (Đúng từ 10 câu trở lên) về quản lý rủi ro hoạt động",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1.Toàn bộ nhân viên đã đi học và đã vượt qua bài test. Tất cả có thể kể tên và phân biệt 4 loại rủi ro chính.",
								"1. Trên 50% nhưng không phải toàn bộ nhân viên đã đi học và vượt qua bài test. Một số nhân viên có thể kể tên và phân biết 4 loại rủi ro chính.",
								"1. Dưới 50% nhân viên đã đi học và vượt qua bài test. Một số nhân viên có thể kể tên và phân biệt 4 loại rủi ro chính.",
								"1. Không có nhân viên nào đã tham gia đào tạo về quản lý rủi ro hoạt động"]''',
								weight:6.45/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//2
								q = new QuizQuestion(reference:'Q02',
								title:"Tài liệu RRHĐ (Cẩm nang, thẻ ghi nhớ, nền máy tính) để đúng theo vị trí hướng dẫn",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1.Trung tâm có tất cả tài liệu RRHĐ (1 cuốn cẩm nang, một thẻ nhớ cho mỗi nhân viên, hình nền được cài đặt trên mọi máy tính). Tài liệu để ở nơi dễ thấy và dễ lấy đối với nhân viên, VÀ nằm ngoài tầm với và tầm mắt của KH.",
								"1. Trung tâm có một số nhưng không có tất cả tài liệu quản lý rủi ro hoạt động. Tài liệu để ở nơi dễ thấy và dễ lấy đối với nhân viên. VÀ nằm ngoài tầm với và tầm mắt của KH.",
								"1. Trung tâm có đủ hoắc có một số tài liệu RRHĐ. Tuy nhiên tài liệu KHÔNG để ở nơi dễ thấy và dễ lấy đối với nhân viên, VÀ/HOẶC năm trong tầm với và tầm mắt của KH.",
								"1. Trung tâm không có tài liệu RRHĐ."]''',
								weight:0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//3
										q = new QuizQuestion(reference:'Q03',
								title:"Nhân viên có nhận thức về các biện pháp an toàn thông tin và áp dụng các biện pháp đó (khóa máy tính, để hồ sơ trong tủ khóa, không trao đổi mật khẩu, không xử lý số PIN của KH",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Toàn bộ nhân viên có thể kể tên ít nhất ba biện pháp an toàn thông tin. Toàn bộ nân viên áp dụng những biện pháp này và không phát hiện thấy sự vi phạm nào.",
								"1. Toàn bộ nhân viên có thể kể tin ít nhất ba biện pháp an toàn thông tin. Không phải nhân viên nào cũng áp dụng những biện pháp này, nghĩa là đã phát hiện trường hợp vi phạm.",
								"1. Một số nhân viên (không phải tất cả) có thể kể tên ít nhất ba biện pháp an toàn thông tin. Không phải nhân viên nào cũng áp dụng những biện pháp này, nghĩa là đã phát hiện trường hợp vi phạm.",
								"1.Không có nhân viên nào có thể kể tên ba biện pháp an toàn thông tin. <br> HOẶC Không có nhân viên nào áp dụng những biện pháp này và đã phát hiện nhiều trường hợp vi phạm."]''',
								weight:9.19/100.0,
								survey:s,
								ord:i++)
										s.addToQuestions(q)
				
				
								//4
								q = new QuizQuestion(reference:'Q04',
								title:"Toàn bộ nhân viên hiểu rõ tất cả các sản phẩm mà trung tâm cung cấp",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. GĐ TT tập huấn định kỳ cho nhân viên về sản phẩm. GĐ TT biết nhân viên nào chưa được tập huấn và có kế hoạch tập huấn cho họ.",
								"1. GĐ TT cung cấp thông tin khi được hỏi nhưng không chủ động kiểm tra/ tập huấn cho nhân viên về sản phẩm. GĐ TT biết nhân viên nào chưa được tập huấn và có kế hoạch tập huấn cho họ.",
								"1. GĐ TT cung cấp thông tin khi được hỏi nhưng không chủ động kiểm tra/ tập huấn cho nhân viên về sản phẩm. GĐ TT không biết nhân viên nào chưa được tập huấn.",
								"1. GĐ TT không có kế hoạch tập huấn, kiểm tra hay nâng cao năng lực cho nhân viên."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//5
								q = new QuizQuestion(reference:'Q05',
								title:"Năng lực nhân viên bảo vệ",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Có đủ nhân viên bảo vệ để bảo đảm an ninh trọn thời gian tại trung tâm. Nhật ký bảo vệ được ký và được điền đầy đủ.",
								"1. Có đủ nhân viên bảo vệ để bảo đảm an ninh trọn thời gian tại trung tâm. Một số phần nhật ký bảo vệ không được ký và điền đầy đủ.",
								"1. Trung tâm thiếu bảo vệ. Tuy nhiên nhật ký bảo vệ được ký và được điền đầy đủ.",
								"1.Trung tâm thiếu bảo vệ. Một số phần nhật ký bảo vệ không được ký và điền đầy đủ."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//6
								q = new QuizQuestion(reference:'Q06',
								title:"Năng lực phòng tránh tiền giả",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Trung tâm có hướng dẫn mới nhất về tiền giả và toàn bộ nhân viên biết về hướng dẫn này. Toàn bộ nhân viên đã được tập huấn về cách phát hiện tiền giả.",
								"1. Trung tâm có hướng dẫn mới nhất về tiền giả nhưng không phải toàn bộ nhân viên biết về hướng dẫn này. Toàn bộ nhân viên đã được tập huấn/ có kỹ năng phát hiện tiền giả.",
								"1. Trung tâm có hướng dẫn mới nhất về tiền giả nhưng không phải toàn bộ nhân viên không biết về hướng dẫn. Chỉ một số nhân viên đã được tập huấn và có kỹ năng phát hiện tiền giả.",
								"1. Trung tâm không có hướng dẫn mới nhất. Không có nhân viên nào đã được tập huấn hoặc có kỹ năng phát hiện tiền giả."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//7
								q = new QuizQuestion(reference:'Q07',
								title:"Lỗi mạng và lỗi máy tính",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Trong vòng 1 tháng qua đơn vị của anh/chị không xảy ra lỗi mạng hoặc lỗi máy tính; hoặc nếu xảy ra thì chỉ 1-2 lần và được khắc phục ngay trong vòng 30 phút.",
								"1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng hoặc lỗi máy tính 1-2 lần và không được khắc phục trong vòng 30 phút.",
								"1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng, lỗi máy tính từ 3-10 lần.",
								"1. Trong vòng 1 tháng qua tại đơn vị có xảy ra lỗi mạng, lỗi máy tính quá 10 lần."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
								//8
								q = new QuizQuestion(reference:'Q08',
								title:"Trao đổi mật khẩu",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Tất cả các trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu (KSV làm việc của GDV, Tư vấn KH làm việc của GDV...)được ghi chép đầy đủ. Toàn bộ nhân viên biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
								"1. Một số trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu không được ghi lại. Toàn bộ nhân viên biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
								"1. Một số trường hợp trao đổi vai trò đòi hỏi trao đổi mật khẩu không được ghi lại. Một số nhân viên (không phải tất cả) biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép.",
								"1. Không có ghi chép về các trường hợp trao đổi mật khâu nhưng nhân viên cho biết đã từng trao đổi mật khẩu<br>HOẶC Không có nhân viên nào biết họ không được phép trao đổi mật khẩu nếu không được GĐ cho phép."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
				
								//9
								q = new QuizQuestion(reference:'Q09',
								title:"Kiểm tra và thường xuyên cập nhật thông tin khách hàng trong quá trình giải ngân",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Các nhân viên tại đơn vị thực hiện cập nhật kịp thời, đầy đủ và chính xác.",
								"1. Một số trường hợp (không phải là tất cả) thực hiện cập nhật thông tin khách hàng đầy đủ và chính xác nhưng chưa kịp thời.",
								"1. Một số trường hợp (không phải là tất cả) thực hiện cập nhật thông tin khách hàng kịp thời nhưng chưa đầy đủ.",
								"1. Một số trường hợp (không phải là tất cả) không cập nhật thông tin khách hàng khi có thay đổi."]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
				
										//10
								q = new QuizQuestion(reference:'Q10',
								 title:"Sẵn sàng trong trường hợp khẩn cấp (cháy, mất điện, cướp, động đất...)",
								descriptions:'',
								evaluation:'answer',
								answerType:'List',
								validation:'''["1. Toàn bộ nhân viên biết phải làm gì trong trường hợp khẩn cấp.",
								"1. Toàn bộ nhân viên được đào tạo và biết phải làm gì trong trường hợp khẩn cấp mức thấp (ví dụ: cháy, mất điện), tuy nhiên không được chuẩn bị cho các trường hợp khẩn cấp mức cao (như trộm cướp, động đất, sóng thần, ...)",
								"1. GĐ TT và một số nhân viên có nhận biết về các kế hoạch đối phó với trường hợp khẩn cấp, tuy nhiên chưa có đào tạo chính thức.",
								"1. GĐ TT và các nhân viên không nhận biết, không quan tâm và không có kế hoạch đối phó với các trường hợp khẩn cấp"]''',
								weight:4.17/100.0,
								survey:s,
								ord:i++)
				
								s.addToQuestions(q)
								s.save(flush:true)
							}
    }
    def destroy = {
    }
}
