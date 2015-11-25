import msb.platto.fingerprint.*;
import msb.platto.utils.DateUtil;
import msb.platto.commons.Conf;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils;
import java.text.MessageFormat

class RiskActionController {
	def springSecurityService
	def riskService
	def exportExcelService
    def index = {
				
	}
	
	def list = {	
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def fromDate = new Date();
		fromDate.setMonth(fromDate.month-1);
		def toDate=new Date();		
		def today = new Date()		
		//def riskActions = RiskAction.findAllByDateCreatedBetween(fromDate,toDate)
		def listActionType = ActionType.findAllByStatusGreaterThanEquals(0)			
		def riskActionsTemp = RiskAction.createCriteria().listDistinct  {
			
			if (params.search) {	
				if (params.responsible_donvi1 || params.responsible_donvi2 || params.responsible_donvi3) 	
					createAlias("responsibleUsers","r")
					
				if (params.supervisor_donvi1 || params.supervisor_donvi2 || params.supervisor_donvi3)
						createAlias("supervisors","u")
							
				if (params.fromDate && params.toDate) {
					fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
					toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
				}
				if (params.actionDueDate)
					eq("actionDueDate", DateUtil.parseInputDate(params.actionDueDate+ ' 00:00:00'))
					
				if (params.actionType)
					eq("actionType",ActionType.get(params.actionType))
					
				if (params.actionStatus)
					eq("actionStatus",params.actionStatus)
				if (params.responsible_donvi1) 	
					eq("r.tenDonVi1",params.responsible_donvi1)
				if (params.responsible_donvi2)
					eq("r.tenDonVi2",params.responsible_donvi2)
				if (params.responsible_donvi3)
					eq("r.tenDonVi3",params.responsible_donvi3)
				
				if (params.supervisor_donvi1)
					eq("u.tenDonVi1",params.supervisor_donvi1)
				if (params.supervisor_donvi2)
					eq("u.tenDonVi2",params.supervisor_donvi2)
				if (params.supervisor_donvi3)
					eq("u.tenDonVi3",params.supervisor_donvi3)
				if (params.dueDateStatus) {
					if (params.dueDateStatus=='Trong hạn')
						ge("actionDueDate", today-1)
					else if (params.dueDateStatus=='Quá hạn')
						lt("actionDueDate", today-1)
				}
				
			}
			between("dateCreated",fromDate,toDate)

			ge("status",0)
			
		}
		def riskActions = []
        def currentDV3 = UnitDepart.get(errorMasterUser.tenDonVi3)
        if(currentUserRole[0] != "ROLE_CVQLRR"){
            riskActionsTemp.each {RiskAction r_action ->
                def list_r_action_department_re = []
                r_action.responsibleUsers.each {ErrorMasterUserCreate emc1 ->
                    list_r_action_department_re << UnitDepart.get(emc1.tenDonVi3)
                }
                def list_r_action_department_super = []
                r_action.supervisors.each {ErrorMasterUserCreate emc2 ->
                    list_r_action_department_super << UnitDepart.get(emc2.tenDonVi3)
                }
                if(currentDV3 in list_r_action_department_re ||
                        currentDV3 in list_r_action_department_super ||
                        currentUser == r_action.createdBy){
                    riskActions << r_action
                }
            }
        }else{
            riskActions = riskActionsTemp
        }


		if(params.exportExcel=="ExportExcel"){
			
						def header //= ['Mã KRI','Mã/Tên rủi ro','Tiêu đề KRI','Tấn suất theo dõi','Loại KRI','NHCD/Khối','CN/TT/Phòng','PGD/Phòng ban/Tổ nhóm','Trạng thái','Nguồn số liệu']
						def listContent = []
						//listContent<<header
						def maHD,mota,tenrr,mucdorr,trachnhiem,cn_tn,giamsat,cn_gs,thoihan,trangthai
			
			
						riskActions.each{
							trachnhiem=""
							cn_tn = ""
							giamsat = ""
							cn_gs = ""
							maHD=it.id
							mota = it.description
							tenrr = it.riskName
							mucdorr = it.riskLevel
							it.responsibleUsers.each { t->
								trachnhiem = trachnhiem+ t.userEmail + ';' 
								cn_tn =cn_tn + UnitDepart.get(t.tenDonVi2).code+' - '+UnitDepart.get(t.tenDonVi2).name + ';'
							}
							trachnhiem = trachnhiem
							cn_tn = cn_tn
							
							it.supervisors.each { t->
								giamsat = giamsat+ t.userEmail + ';'
								cn_gs =cn_gs + UnitDepart.get(t.tenDonVi2).code+' - '+UnitDepart.get(t.tenDonVi2).name + ';'
							}
							trachnhiem = trachnhiem
							cn_gs = cn_gs
							thoihan = DateUtil.formatDate(it.actionDueDate)
							trangthai = it.actionStatus
							
							header = [maHD,mota,tenrr,mucdorr,trachnhiem,cn_tn,giamsat,cn_gs,thoihan,trangthai]
							listContent<<header
						}
			
			
						def data
						data = exportExcelService.actionDisplay(listContent)
			//			// // println "DATA:"+data
			
			
						//File download
						response.setContentType("application/vnd.ms-excel")
						response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
						response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
					}
		
		def unitDepart1Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status >=0 order by e.id')
		def unitDepart2Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status >=0 order by e.id')
		def unitDepart3Nhap = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status >=0 order by e.id')
		def errorStatus=ErrorStatus.getAll()
		render view:'/riskAction/listRiskAction', model:[riskActions:riskActions,listActionType:listActionType,errorStatus:errorStatus,donvi1:unitDepart1Nhap,donvi2:unitDepart2Nhap,donvi3:unitDepart3Nhap]
	}
	
	def detail = {
		def riskAction
		if (params.riskActionId) {
			riskAction = RiskAction.get(params.riskActionId)
		}
		def listActionType = ActionType.findAllByStatusGreaterThanEquals(0)
		render view:'/riskAction/detailRiskAction',model:[riskAction:riskAction]
	}
	
	def save = {
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def riskAction	
		def oldRisk	= new RiskAction()
		def oldResponsibility=[]
		def oldSupervisors=[]
		if (params.riskActionId) {
			riskAction = RiskAction.get(params.riskActionId)
			oldRisk.properties = riskAction.properties
			riskAction.responsibleUsers.each {
				oldResponsibility<<it
			}
			riskAction.supervisors.each { 
				oldSupervisors<<it
			}
			
		} else {
			riskAction = new RiskAction()
			riskAction.createdBy = currentUser
		}
		if (params.save) {
			//remove related users			
			if (params.riskActionId) {
				riskAction.supervisors.clear()
				riskAction.responsibleUsers.clear()
				riskAction.save(flush:true)
			}
			if(params.actionType)
				params.actionType = ActionType.get(params.actionType)			
			riskAction.properties = params
			params.actionDueDate = DateUtil.parseInputDate(params.actionDueDate + ' 00:00:00')
			['responsible_','supervisor_'].each {
				
				for(int i=1;i<=params.(it+'dateCount').toInteger();i++)
				{	
					if(params.(it+'HoVaTen_'+i)!=null && params.(it+'HoVaTen_'+i).trim()!="")
					{
						def user = ErrorMasterUserCreate.findByUserEmail(params.(it+'OutLook_'+i))
						if (it.equals('responsible_'))
							riskAction.addToResponsibleUsers(user)
						else
							riskAction.addToSupervisors(user)
					}					
				}
			}
			
			if(params.hfDeleteFile=="deleteFile")
			{
				riskAction.fileName =null
			}
			
			if(params.uploadFile!=null && params.uploadFile!="")
			{
				def file = request.getFile('uploadFile')
			
				if(!file.empty){
					
					def fileName = file.getOriginalFilename()
					String absolutePath = getServletContext().getRealPath("riskActionFiles/"+ fileName)
					File fileOut = new File(absolutePath)
					file.transferTo(fileOut)
					riskAction.fileName = fileName
					
				}
			}
			
			if(params.YKienCacDonViKhac!=null && params.YKienCacDonViKhac!="")
			{
				def comment=new RiskActionComment()
				def user = User.findByUsername( springSecurityService.principal.username)
				comment.createdBy=user
				comment.content=params.YKienCacDonViKhac
				comment.dateCreated=new Date()
				
				riskAction.addToActionComments(comment)
			}
			
			riskAction.save(flush:true)
			if (riskAction.hasErrors()) {
				riskAction.errors.each {
					println it
				}
			}
			if (params.riskActionId) {
				flash.message = 'Anh/chị đã cập nhật thành công!' 
			} else {
				flash.message = 'Anh/chị đã tạo mới thành công!'
			}
			//send email
			def arrTo=[]
			def arrCc=[]
			def toEmail
			
			if (params.riskActionId) {	
				def flag = 0
				def riskDescription = ""
				 
				if (oldRisk.actionStatus != riskAction.actionStatus) {
					riskDescription +="Trạng thái hành động: "+ riskAction.actionStatus +"<br>"
					flag = 1
				}
				if (oldRisk.actionType.name != riskAction.actionType.name) {
					riskDescription += "Loại hành động: "+ riskAction.actionType.name +"<br>"
					flag = 0
				}
				if (oldRisk.riskName != riskAction.riskName) {
					riskDescription +="Tên rủi ro: "+ riskAction.riskName +"<br>"
					flag = 0
				}
				if (oldRisk.riskLevel != riskAction.riskLevel) {
					riskDescription +="Mức độ rủi ro: "+ riskAction.riskLevel +"<br>"
					flag = 0
				}
				if (oldRisk.description != riskAction.description) {
					riskDescription +="Mô tả hành động: "+ riskAction.description +"<br>"
					flag = 0
				}				
				
				if (oldRisk.actionDueDate != riskAction.actionDueDate) { 
					riskDescription +="Thời hạn hành động: "+ DateUtil.formatDate(riskAction.actionDueDate) +"<br>"
					flag = 0
				}
				
				def newResponsibility=[]
				def newSupervisors=[]				
				riskAction.responsibleUsers.each {
					newResponsibility<<it
				}
				riskAction.supervisors.each {
					newSupervisors<<it
				}
				
				if (!oldResponsibility.equals(newResponsibility)) {
					riskDescription += "Người chịu trách nhiệm hành động: "					
					riskAction.responsibleUsers.eachWithIndex  { v, i ->
						println v.userEmail
						riskDescription += v.userEmail + (i==riskAction.responsibleUsers.size()-1?"":", ")
					}
					riskDescription += "<br>"
					
				}
				
				if (!oldSupervisors.equals(newSupervisors)) {
					riskDescription += "Người giám sát hành động: "
					riskAction.supervisors.eachWithIndex  { v, i ->
						riskDescription += v.userEmail + (i==riskAction.supervisors.size()-1?"":", ")
					}
					riskDescription += "<br>"
					
				}
				/*riskAction.responsibleUsers.eachWithIndex  { v, i ->
					riskDescription += "Người chịu trách nhiệm hành động "+(i+1)+ ":<br>"
					riskDescription +="UserOutlook:" + v.userEmail +"<br>"
					riskDescription +="Họ và tên:" + v.fullName +"<br>"
					riskDescription +="Chức danh:" + v.title +"<br>"
					riskDescription +="User hệ thống:" + v.bDSUser +"<br>"
					riskDescription +="ID nhân sự:" + v.codeSalary +"<br>"
					riskDescription +="NH Chuyên doanh/Khối:" + UnitDepart.get(v.tenDonVi1)?.name +"<br>"
					riskDescription +="CN/Trung tâm/Phòng:" + UnitDepart.get(v.tenDonVi2)?.name +"<br>"
					riskDescription +="PGD/Phòng ban/Tổ Nhóm:" + UnitDepart.get(v.tenDonVi3)?.name +"<br>"
				}
				
				riskAction.supervisors.eachWithIndex  { v, i ->
					riskDescription += "Người giám sát hành động "+(i+1)+ ":<br>"
					riskDescription +="UserOutlook:" + v.userEmail +"<br>"
					riskDescription +="Họ và tên:" + v.fullName +"<br>"
					riskDescription +="Chức danh:" + v.title +"<br>"
					riskDescription +="User hệ thống:" + v.bDSUser +"<br>"
					riskDescription +="ID nhân sự:" + v.codeSalary +"<br>"
					riskDescription +="NH Chuyên doanh/Khối:" + UnitDepart.get(v.tenDonVi1)?.name +"<br>"
					riskDescription +="CN/Trung tâm/Phòng:" + UnitDepart.get(v.tenDonVi2)?.name +"<br>"
					riskDescription +="PGD/Phòng ban/Tổ Nhóm:" + UnitDepart.get(v.tenDonVi3)?.name +"<br>"
				}		*/					 
				
				if(riskDescription == ''){
				}else{
					riskDescription = "Mô tả:<font color='red'>"+riskDescription+"</font>"
				}
				arrTo=[]
				arrCc=[]
				//arrCc += Conf.findByType('cc_email').value
                arrCc += riskService.convertEmail(currentUser.username)
				riskAction.responsibleUsers.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}
				
				oldResponsibility.each {
					toEmail = riskService.convertEmail(it.userEmail)
					if (!(toEmail in arrCc)) {
                        arrCc += toEmail
					}
				}
				
				riskAction.supervisors.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}
				
				oldSupervisors.each {
					toEmail = riskService.convertEmail(it.userEmail)
					if (!(toEmail in arrCc)) {
						arrCc += toEmail
					}
				}
				
				if (flag == 0)				 
					sendEmailRiskAction("ACTION",arrTo,arrCc,riskDescription,""+riskAction.id+"","Sửa hành động",riskAction)
				else if (flag == 1)
					sendEmailRiskAction("ACTION",arrTo,arrCc,riskDescription,""+riskAction.id+"","Đổi trạng thái hành động",riskAction)
			}
			else {
				arrTo=[]
				arrCc=[]
                arrCc += riskService.convertEmail(currentUser.username)
				riskAction.responsibleUsers.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}				
				riskAction.supervisors.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}			
				sendEmailRiskAction("ACTION",arrTo,arrCc,"",""+riskAction.id+"","Tạo mới hành động",riskAction)
			}
			
		} else if (params.clone) {	
			def newRiskAction = new RiskAction()			
			def actionTypeId = params.actionType?params.actionType:params.actionType_hidden
			params.actionType = ActionType.get(actionTypeId)
			newRiskAction.createdBy = currentUser
			newRiskAction.properties = params
			params.actionDueDate = DateUtil.parseInputDate(params.actionDueDate + ' 00:00:00')
			['responsible_','supervisor_'].each {
				
				for(int i=1;i<=params.(it+'dateCount').toInteger();i++)
				{
			
					if(params.(it+'HoVaTen_'+i)!=null && params.(it+'HoVaTen_'+i).trim()!="")
					{
						def user = ErrorMasterUserCreate.findByUserEmail(params.(it+'OutLook_'+i))
						if (it.equals('responsible_'))
							newRiskAction.addToResponsibleUsers(user)
						else
							newRiskAction.addToSupervisors(user)
					}					
				}
			}
			
			if(params.uploadFile!=null && params.uploadFile!="")
			{
				def file = request.getFile('uploadFile')
			
				if(!file.empty){
					
					def fileName = file.getOriginalFilename()
					String absolutePath = getServletContext().getRealPath("riskActionFiles/"+ fileName)
					File fileOut = new File(absolutePath)
					file.transferTo(fileOut)
					newRiskAction.fileName = fileName
					
				}
			}
			
			if(params.YKienCacDonViKhac!=null && params.YKienCacDonViKhac!="")
			{
				def comment=new RiskActionComment()
				def user = User.findByUsername( springSecurityService.principal.username)
				comment.createdBy=user
				comment.content=params.YKienCacDonViKhac
				comment.dateCreated=new Date()
				
				newRiskAction.addToActionComments(comment)
			}
			
			newRiskAction.save(flush:true)
			if (newRiskAction.hasErrors()) {
				newRiskAction.errors.each {
					println it
				}
			}
			flash.message = 'Anh/chị đã tạo mới thành công!'
			def arrTo=[]
			def arrCc=[]
			def toEmail

            arrCc += riskService.convertEmail(currentUser.username)
			newRiskAction.responsibleUsers.each {
				toEmail = riskService.convertEmail(it.userEmail)
                arrTo += toEmail
			}
			
			newRiskAction.supervisors.each {
				toEmail = riskService.convertEmail(it.userEmail)
                arrTo += toEmail
			}
			sendEmailRiskAction("ACTION",arrTo,arrCc,"",""+newRiskAction.id+"","Thêm mới hành động",riskAction)
		
		} else if (params.delete) {
			if (params.riskActionId) {
				riskAction.status = -10
				riskAction.save(flush:true)
				flash.message = 'Anh/chị đã xóa thành công!'
				def arrTo=[]
				def arrCc=[]
				def toEmail
				//arrCc += Conf.findByType('cc_email').value
                arrCc += riskService.convertEmail(currentUser.username)
				riskAction.responsibleUsers.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}
				
				riskAction.supervisors.each {
					toEmail = riskService.convertEmail(it.userEmail)
                    arrTo += toEmail
				}
				sendEmailRiskAction("ACTION",arrTo,arrCc,"",""+riskAction.id+"","Xóa hành động",riskAction)
			} else
				flash.message = 'Lỗi không xóa được hành động rủi ro: ' + e
		
		}
		redirect (action: 'list')
		return
	}	
	
	def deleteComment = {
		def comment = RiskActionComment.get(params.deleteId)
		def riskAction = comment.riskAction		
		riskAction.removeFromActionComments(comment)
		riskAction.save(flush:true)
		flash.message="Anh/chị đã xóa thành công!"
		redirect (controller:'riskAction',action:'detail',params:['riskActionId':riskAction.id])
	}
	
	def addComment = {		
		def user = User.findByUsername( springSecurityService.principal.username)
		def riskAction = RiskAction.get(params.commentAction)
		def comment=new RiskActionComment()
		
		comment.createdBy=user
		comment.content=params.YKienCacDonViKhac
		comment.dateCreated=new Date()
		
		riskAction.addToActionComments(comment)
		riskAction.save(flush:true)
		if (riskAction.hasErrors()){
			riskAction.errors.each {
				println it
			}
		}
		flash.message="Anh/chị đã thêm ý kiến thành công."
		redirect (action:'detail',params:['riskActionId':riskAction.id])
		
	}
	
	def sendEmailRiskAction(String code,def to, def cc,String CTLoi,String Id,String action, def riskAction){		
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
				def content = MessageFormat.format(errorMail.content, [action,riskAction.actionType.name,riskAction.description,CTLoi,Id].toArray())				
				def subject = MessageFormat.format(errorMail.subject, [Id,action,riskAction.riskName].toArray())				
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
