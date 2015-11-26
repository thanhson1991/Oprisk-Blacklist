import grails.converters.JSON
import groovy.sql.Sql
import java.text.*;
import java.util.*;
import msb.platto.commons.Conf
import java.util.logging.ErrorManager;
import grails.util.Environment
//import msb.ldap.LdapUser
import msb.platto.fingerprint.User
import msb.platto.fingerprint.UserRole
import msb.platto.fingerprint.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

class OpRiskController {
    def riskService
    def springSecurityService
    Role role
	def dataSource
	def sqlserverDataSource
	def exportExcelService
    def importCause = {
        
        riskService.importCause()
    }

    def importRisk = {       
        def newDepartment = new Department (name:'KHDN')
        newDepartment.save(flush:true)
        riskService.importRisk(newDepartment)
        
    }
	
	def updateBranch = {
		//update opriskProcessG
		def opriskProcess = OpRiskProcess.getAll()
		if (opriskProcess.size()>0){
			opriskProcess.each{
				it.branchName = it.employee.prop2
				it.save(flush:true)
			}
		}
		
		//update selfEvaluationProcess
		def selfEvaluationProcess = SelfEvaluationProcess.getAll()
		if (selfEvaluationProcess.size()>0){
			selfEvaluationProcess.each{
				it.branchName = it.createdBy.prop2
				it.save(flush:true)
			}
		}
	}


    def updateInformation = {
	
		
		def department
		def user = User.findByUsername( springSecurityService.principal.username)
		def masterUser=ErrorMasterUserCreate.findByUserEmail( springSecurityService.principal.username)
		def unitDepart=UnitDepart.executeQuery('from UnitDepart e where e.ord=1 and e.status>=0 order by e.code+0')
		def unit1=UnitDepart.get(masterUser.tenDonVi1)
		def unitDepart2=UnitDepart.findAllByParent(unit1)
		
		def unit2=UnitDepart.get(masterUser.tenDonVi2)
		def unitDepart3=UnitDepart.findAllByParent(unit2)
//		if(params.AddNewUnitDepart)
//		{
//			unitDepart=new UnitDepart()			
//			unitDepart.name=params.otherUnitDepart
//			unitDepart.code='100'
//			unitDepart.save(flush:true)
//			//flash.message = "Anh/chá»‹ Ä‘Ã£ cáº­p nháº­t thÃ´ng tin thÃ nh cÃ´ng."			
//			def temp=new UnitDepart()
//			temp=UnitDepart.findByName(params.otherUnitDepart)
//			user.prop4=temp.id
//			
//			if (masterUser){
//				department = Department.get(params.departmentId)
//				masterUser.department = department
//				masterUser.unitDepart = unitDepart
//				masterUser.save(flush:true)
//			}
//			
//			/*masterUser=new ErrorMasterUserCreate()
//			masterUser.userEmail=params.userOutlook
//			masterUser.fullName=params.name
//			masterUser.bDSUser=params.bdsUser
//			masterUser.codeSalary=params.IdNhanSu
//			masterUser.title=params.title
//			
//			masterUser.unitDepart=UnitDepart.get(params.unitDepartmentId)
//			masterUser.department=Department.get(params.departmentId)			
//			masterUser.save(flush:true)	*/
//			
//			user.save(flush:true)
//			flash.message = "Anh/chị đã cập nhật thông tin thành công."
//		}			
		def departments = Department.findAllByStatusGreaterThanEquals(0)
		def unitDepartments=UnitDepart.findAllByStatusGreaterThanEquals(0,[sort:"name", order:"desc"])
		
        if(params.save){
           
                user.fullname = params.name
                user.prop1 = params.departmentId
                user.prop2 = params.branch
				user.prop3 = params.branchName
				user.prop4=params.unitDepartmentId				
				
				if (masterUser){
					//department = Department.get(params.departmentId)
					//unitDepart = UnitDepart.get(params.unitDepartmentId)
					//masterUser.department = department
					//masterUser.unitDepart = unitDepart
					masterUser.userEmail=user.username
					masterUser.fullName=params.name
					masterUser.bDSUser=params.bdsUser
					masterUser.codeSalary=params.IdNhanSu
					masterUser.title=params.title
					
		/*			masterUser.unitDepart=UnitDepart.get(params.TenDonVi)
					masterUser.department=Department.get(params.NHCD)*/
					masterUser.tenDonVi1=params.NHCD
					masterUser.tenDonVi2=params.CN
					masterUser.tenDonVi3=params.PGD
					masterUser.save(flush:true)
				}
				/*// println "Dsfsdfsadfsad"
				if(masterUser==null)
				
				masterUser=new ErrorMasterUserCreate()
				masterUser.userEmail=params.userOutlook
				masterUser.fullName=params.name
				masterUser.bDSUser=params.bdsUser
				masterUser.codeSalary=params.IdNhanSu
				masterUser.title=params.title				
				masterUser.unitDepart=UnitDepart.get(params.unitDepartmentId)
				masterUser.department=Department.get(params.departmentId)
				masterUser.save(flush:true)*/
				
					
				
							
                user.save(flush:true)
                flash.message = "Anh/chị đã cập nhật thông tin thành công."
        }
		
		def allUnitDepart3 = UnitDepart.executeQuery('from UnitDepart e where e.ord =3 and e.status>=0 order by e.code+0')
        render view:'/opRisk/updateInformation',model:[user:user,masterUser:masterUser,departments:departments,unitDepartments:unitDepartments,unitDepart:unitDepart,unitDepart2:unitDepart2,unitDepart3:unitDepart3,allUnitDepart3:allUnitDepart3]
    }

    

    def index = {
		session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new Locale("vi", "VN")
    }
    def create = { 
        def user = User.findByUsername( springSecurityService.principal.username)        
        def messageCode
		def answerWeight
        def model = [:]
        def process
        def today = Calendar.getInstance()
        def lastDayString = today.getActualMaximum(Calendar.DAY_OF_MONTH) + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
        def firstDayString = '1' + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
        def firstDay = DateUtil.parseInputDate(firstDayString + ' 00:00:00')
        def lastDay = DateUtil.parseInputDate(lastDayString + ' 23:59:59')
        
        if (params.id==null){
            process = OpRiskProcess.createCriteria().list{
                eq('employee',user)
                between('dateCreated',firstDay,lastDay)
                ge('status',0)
            }

            if (process.size==0){
                //should be checked
                //def surveyType = Survey.get(session.userType.id)
                def department = Department.get(user.prop1)
                def surveyType = Survey.findByDepartmentAndReferenceBetween(department,1,300)
				// println "Department:"+ department
               // println "surveyType:"+ surveyType
                //*** no survey ??????
                if (!surveyType){                    
                    render view:'noBaroSurvey'
                    return;
                }
                

                //surveyType = session.userType
                process = new OpRiskProcess()
                process.employee = user
				process.branchName = user.prop2
                SurveyInstance surveyInstance
                if (!params.save && !params.proceed)
                    surveyInstance = SurveyInstance.createSurveyInstance(surveyType)
                else
                    surveyInstance = SurveyInstance.get(params.surveyInstanceId)


                process.surveyInstance = surveyInstance
                if (params.save || params.proceed)
                    process.save(flush:true)

            }else{
                process = process[0]
            }
        }else {
			
            process = OpRiskProcess.get(params.id.toInteger())
			// println"3434>>>>>>"+ process
        }
        if(params.save || params.proceed){

//            user.fullname = params.empName
//            user.prop2 = params.branch
//            user.save(flush:true)			
            params.each{ key,value ->
                            if(key.startsWith("_")){
                                //split it in 3 segment: _43_Q123: [,43,Q123]
                                def s = key.split('_');
                                def a = Answer.get(s[1])
                                    if(key.endsWith("comments")){
                                        a.comments = value
                                    }else if(s.length == 3){																			
										a.answer = value										
                                    }
                                    a.save(flush:true)


                            }
                        }
            messageCode = 1
            if (params.proceed){
                if (params.dateIncident){
                    params.dateIncident = DateUtil.parseInputDate(params.dateIncident + ' 00:00:00')
                    params.reason = Cause.get(params.reason)
                    params.event = Event.get(params.event)
                    params.retrieval = FormatUtil.stripNumber(params.retrieval)
                    params.financialLoss = FormatUtil.stripNumber(params.financialLoss)
                    def incident= new Incident(params)
                    process.addToIncidents(incident)
                    process.save(flush:true)
                }


                process.status = 100
                process.save(flush:true)
                messageCode = 3
            }

        }

        if(params.saveDetails){
            process.employee.fullname = params.empName
            process.employee.prop2 = params.branch
			process.branchName = params.branch
            process.save(flush:true)
            messageCode = 9
        }

        if(params.deny){
            process.status = 0
            process.save(flush:true)
            messageCode = 5
        }

        if(params.delete){
            process.delete(flush:true)
            redirect action:'reportList'
        }

        if(params.approve){
            process.comments = params.comments
            process.status = 200
            process.save(flush:true)
            messageCode = 4
        }

        if(params.saveComments){
            process.comments = params.comments
            process.save(flush:true)
            messageCode = 8
        }        

//        if (params.deleteIncident){
//            def id = params.deleteId
//            def incident= Incident.get(id)
//            if (incident)
//                incident.delete(flush:true)
//            process = OpRiskProcess.get(params.processId.toInteger())
//            messageCode = 7
//
//        }

        def causes = Cause.findAllByOrd('0')
        def events = Event.findAllByOrd('0')
        model << [causes:causes,events:events,instance:process.surveyInstance,process:process,incidents:process.incidents,messageCode:messageCode,user:user]
		// println "instance?.answers:"+ process.surveyInstance
		
        render view:'/opRisk/survey', model:model

    }
	
	def quizIndex = {
		def user = User.findByUsername( springSecurityService.principal.username)
		def process, minutes, seconds
		def model = [:]
		def today = Calendar.getInstance()
		def lastDayString = today.getActualMaximum(Calendar.DAY_OF_MONTH) + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDayString = '1' + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDay = DateUtil.parseInputDate(firstDayString + ' 00:00:00')
		def lastDay = DateUtil.parseInputDate(lastDayString + ' 23:59:59')
		def department = Department.get(user.prop1)
		process = QuizProcess.createCriteria().get{
			eq('employee',user)
			between('dateCreated',firstDay,lastDay)
			ge('status',0)
		}
		def surveyType = QuizSurvey.findByDepartmentAndReferenceBetween(department,1,300)
		
		 //*** no survey ??????
		 if (!surveyType){
			 render view:'noQuizSurvey'
			 return;
		 }
		if(process){
			if (process.status == 0){				
				process.status = 100				
			}else if (process.status ==50){
				process.status = 0
				def time = process.timeLeft.split(":")				
				minutes = time[0]
				seconds = time[1]
			}
			process.save(flush:true)
			redirect(action:"createQuiz",params:[seconds:seconds,minutes:minutes])
		}
		
		model << [surveyType:surveyType]
		render view:'/opRisk/quizIndex', model:model
		
	}
	
	def createQuiz = {
		def user = User.findByUsername( springSecurityService.principal.username)
		def messageCode,minutes,seconds
		def answerWeight
		def model = [:]
		def process
		def today = Calendar.getInstance()
		def lastDayString = today.getActualMaximum(Calendar.DAY_OF_MONTH) + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDayString = '1' + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDay = DateUtil.parseInputDate(firstDayString + ' 00:00:00')
		def lastDay = DateUtil.parseInputDate(lastDayString + ' 23:59:59')
		
		
		if (params.id==null){
			process = QuizProcess.createCriteria().list{
				eq('employee',user)
				between('dateCreated',firstDay,lastDay)
				ge('status',0)
			}

			if (process.size==0){
				//should be checked
				//def surveyType = Survey.get(session.userType.id)
				def department = Department.get(user.prop1)
				def surveyType = QuizSurvey.findByDepartmentAndReferenceBetween(department,1,300)
				minutes = params.minutes?params.minutes:surveyType.minutes
				seconds = params.seconds?params.seconds:0
				//*** no survey ??????
				if (!surveyType){
					render view:'noBaroSurvey'
					return;
				}
				

				//surveyType = session.userType
				process = new QuizProcess()
				process.employee = user
				process.branchName = user.prop2
				QuizSurveyInstance surveyInstance
				if (!params.save && !params.proceed)
					surveyInstance = QuizSurveyInstance.createSurveyInstance(surveyType)
				else
					surveyInstance = QuizSurveyInstance.get(params.surveyInstanceId)


				process.surveyInstance = surveyInstance
				if (params.save || params.proceed)
					process.save(flush:true)

			}else{
				process = process[0]
			}
		}else {
			process = QuizProcess.get(params.id.toInteger())
		}
		if(params.save || params.proceed){

//            user.fullname = params.empName
//            user.prop2 = params.branch
//            user.save(flush:true)			
			params.each{ key,value ->
							if(key.startsWith("_")){
								//split it in 3 segment: _43_Q123: [,43,Q123]
								def s = key.split('_');
								def a = QuizAnswer.get(s[1])
									if(key.endsWith("comments")){
										a.comments = value
									}else if(s.length == 3){
										a.answer = value
									}
									a.save(flush:true)


							}
						}
			messageCode = 1
			if (params.proceed){			


				process.status = 100
				process.save(flush:true)
				messageCode = 3
			}

		}

		if(params.saveDetails){
			process.employee.fullname = params.empName
			//process.employee.prop2 = params.branch
			process.branchName = params.branch
			process.save(flush:true)
			messageCode = 9
		}

		if(params.deny){
			process.status = 50
			process.save(flush:true)
			messageCode = 5
		}

		if(params.delete){
			process.delete(flush:true)
			redirect action:'quizReportList'
		}

		if(params.approve){
			process.comments = params.comments
			process.status = 200
			process.save(flush:true)
			messageCode = 4
		}

		if(params.saveComments){
			process.comments = params.comments
			process.save(flush:true)
			messageCode = 8
		}

//        if (params.deleteIncident){
//            def id = params.deleteId
//            def incident= Incident.get(id)
//            if (incident)
//                incident.delete(flush:true)
//            process = OpRiskProcess.get(params.processId.toInteger())
//            messageCode = 7
//
//        }


		model << [instance:process.surveyInstance,process:process,messageCode:messageCode,user:user,minutes:minutes,seconds:seconds]
		render view:'/opRisk/quizSurvey', model:model

	}
	
	def saveQuiz={
		def user = User.findByUsername( springSecurityService.principal.username)
		def today = Calendar.getInstance()
		def lastDayString = today.getActualMaximum(Calendar.DAY_OF_MONTH) + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDayString = '1' + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
		def firstDay = DateUtil.parseInputDate(firstDayString + ' 00:00:00')
		def lastDay = DateUtil.parseInputDate(lastDayString + ' 23:59:59')
		
		
		def	process = QuizProcess.createCriteria().get{
				eq('employee',user)
				between('dateCreated',firstDay,lastDay)
				ge('status',0)
		}
		if (!process){
			process = new QuizProcess()
			process.employee = user
			process.branchName = user.prop2
			QuizSurveyInstance surveyInstance
			surveyInstance = QuizSurveyInstance.get(params.surveyInstanceId)
			process.surveyInstance = surveyInstance
		}
		process.timeLeft = params.minutes + ':' + params.seconds
		params.each{ key,value ->
			if(key.startsWith("_")){
				//split it in 3 segment: _43_Q123: [,43,Q123]
				def s = key.split('_');
				def a = QuizAnswer.get(s[1])
					if(key.endsWith("comments")){
						a.comments = value
					}else if(s.length == 3){
						a.answer = value
					}
					a.save(flush:true)


			}
		}			
		process.save(flush:true)		
		render '1'
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
            today.setMonth(today.month-2)
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
		
		// println "process"+process
        
        model << [process:process,departmentId:departmentId,departments:departments]
        render view:'/opRisk/report', model:model

    }
	
	
	def quizReport = {
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
			today.setMonth(today.month-12)
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
			process = QuizProcess.createCriteria().list{
				ge('status',0)
				between('dateCreated',fromDate,toDate)
				'in'('employee',users)
				order("id", "desc")
			}
		}
        model << [process:process,departmentId:departmentId,departments:departments]
		render view:'/opRisk/quizReport', model:model

	}
	
    def incidentReport = {
        def model = [:]
        def process,file,fileName
        def fromDate
        def toDate
        def department,users,departmentId,incidents
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
            today.setMonth(today.month-12)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

        }
        if(department){
            users= User.findAllByProp1(department.id)
            departmentId = department.id
        }
        else
            users=User.list()

        if(params.saveincident){              

                def incidentID = params.saveEditIncident
                def incident = Incident.get(incidentID)
                params.reason = Cause.get(params.reason)
                params.basel2 = BusinessField.get(params.basel2)
                params.dateIncident = DateUtil.parseInputDate(params.dateIncident + ' 00:00:00')
                params.event = Event.get(params.event)
                params.retrieval = FormatUtil.stripNumber(params.retrieval)
                params.financialLoss = FormatUtil.stripNumber(params.financialLoss)
                params.dateReport = DateUtil.parseInputDate(params.dateReport + ' 00:00:00')
            if(params.fromInsurance) {
                params.fromInsurance = FormatUtil.stripNumber(params.fromInsurance)
            }
            if(params.fromAnother){
                params.fromAnother = FormatUtil.stripNumber(params.fromAnother)
            }
            if(params.dateFnCal){
                params.dateFnCal = DateUtil.parseInputDate(params.dateFnCal + ' 00:00:00')
            }
                incident.properties = params
				file = request.getFile('file')
				if(!file.empty){
					fileName = file.getOriginalFilename()
					String absolutePath = getServletContext().getRealPath("incidentFiles/"+ fileName)
					File fileOut = new File(absolutePath)
					file.transferTo(fileOut)
					incident.fileName = fileName
				}
                incident.save(flush:true)
                flash.message="Anh chị đã lưu sự kiện thành công"
        }

          if(params.addIncident){
                params.reason = Cause.get(params.reason)
                params.basel2 = BusinessField.get(params.basel2)
                params.dateIncident = DateUtil.parseInputDate(params.dateIncident + ' 00:00:00')
                params.event = Event.get(params.event)
                params.retrieval = FormatUtil.stripNumber(params.retrieval)
                params.financialLoss = FormatUtil.stripNumber(params.financialLoss)
                params.dateReport = DateUtil.parseInputDate(params.dateReport + ' 00:00:00')
              if(params.fromInsurance) {
                  params.fromInsurance = FormatUtil.stripNumber(params.fromInsurance)
              }
              if(params.fromAnother){
                  params.fromAnother = FormatUtil.stripNumber(params.fromAnother)
              }
              if(params.dateFnCal){
                  params.dateFnCal = DateUtil.parseInputDate(params.dateFnCal + ' 00:00:00')
              }
                def newIncident = new Incident(params)
				file = request.getFile('file')
				if(!file.empty){
					fileName = file.getOriginalFilename()
					String absolutePath = getServletContext().getRealPath("incidentFiles/"+ fileName)
					File fileOut = new File(absolutePath)
					file.transferTo(fileOut)
					newIncident.fileName = fileName
				}
                newIncident.save(flush:true)                
                flash.message="Anh/chị đã thêm sự kiện thành công"

        }

        if (params.deleteIncident){
            def id = params.deleteId
            def incident= Incident.get(id)
            if (incident)
                incident.delete(flush:true)
            
            flash.message="Anh/chị đã xóa sự kiện thành công"

        }
		if (params.deleteFileEditIncident){
			def id = params.saveEditIncident
			def incident= Incident.get(id)
			if (incident)
				incident.fileName = null
				
			flash.message="Anh/chị đã xóa hồ sơ đính kèm thành công"
		}
		
        if (users.size()>0){
            process = OpRiskProcess.createCriteria().list{
                ge('status',0)
                order('employee','desc')
                'in'('employee',users)
                order("id", "desc")
            }
        }
        
        incidents = Incident.createCriteria().list{
            between('dateIncident',fromDate,toDate)
                or{
                    if (users.size()>0)
                         'in'('createdBy',users)
                    if(process)
                        'in'('opRiskProcess',process)
                    if (!params.department)
                        isNull('opRiskProcess')
                }
            order("dateIncident", "desc")
        }
        
        def causes = Cause.findAllByOrd('0')
        def events = Event.findAllByOrd('0')
        model << [causes:causes,events:events,incidents:incidents,process:process,departmentId:departmentId,departments:departments]
        render view:'/opRisk/incidentReport', model:model
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
            today.setMonth(today.month-2)
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
	
	def quizReportList = {
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
			today.setMonth(today.month-12)
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
			process = QuizProcess.createCriteria().list{
				ge('status',0)
				between('dateCreated',fromDate,toDate)
				'in'('employee',users)
				order("id", "desc")
			}
		}
		model << [process:process,departments:departments,departmentId:departmentId]
		render view:'/opRisk/quizReportList', model:model

	}

    def getReport = {
        def model = [:]
        def process
        def user = User.findByUsername( springSecurityService.principal.username)
        process = OpRiskProcess.createCriteria().list{
                eq('employee',user)

            }
        model << [process:process]
        render view:'/opRisk/getReport', model:model
    }

    def getSelfReport = {
        def model = [:]
        def process
        def user = User.findByUsername( springSecurityService.principal.username)
        process = SelfEvaluationProcess.createCriteria().list{
                eq('department',Department.get(user.prop1))
                eq('createdBy',user)
                order("id","desc")
            }
        model << [process:process]
        render view:'/opRisk/getSelfReport', model:model
    }

    def dashboard = {
        def user = User.findByUsername( springSecurityService.principal.username)
		def masterUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)        
        render view:'/opRisk/dashboard', model:[user:user,masterUser:masterUser]
    }

    def listIncident = {
        def messageCode,file,fileName
        def user = User.findByUsername( springSecurityService.principal.username)
        def process = OpRiskProcess.findAllByEmployee(user)
        
        if(params.saveincident){
            params.dateIncident = DateUtil.parseInputDate(params.dateIncident+" 00:00:00")
            params.retrieval = FormatUtil.stripNumber(params.retrieval)
            params.financialLoss = FormatUtil.stripNumber(params.financialLoss)
            def incident= new Incident(params)
            incident.createdBy = user
			file = request.getFile('file')
			if(!file.empty){
				fileName = file.getOriginalFilename()
				String absolutePath = getServletContext().getRealPath("incidentFiles/"+ fileName)				
				File fileOut = new File(absolutePath)
				file.transferTo(fileOut)
				incident.fileName = fileName
			}
            incident.save(flush:true)
            messageCode = 6
        }
        def incidents = Incident.createCriteria().list{
            or{
                eq('createdBy',user)
                if(process){
                    'in'('opRiskProcess',process)
                }

            }
            order('dateIncident','desc')
        }

        render view:'/opRisk/listIncident', model:[incidents:incidents,messageCode:messageCode]
    }

    def listNews = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def fromDate
        def toDate
        def department,departmentId
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
            today.setMonth(today.month-12)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

        }
        if(department){
            departmentId = department.id
        }
        def news = RiskNews.createCriteria().list{
            if(department)
                eq('department',Department.get(department.id))
            between('dateCreated',fromDate,toDate)
            order('dateCreated','desc')
        }		

        render view:'/opRisk/listNews', model:[news:news,departments:departments,departmentId:departmentId]
    }

    def detailNews = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def news,department,departmentId
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def comments
        if(params.newsId){
            news = RiskNews.get(params.newsId)
            comments = news.newsComments
        }
        render view:'/opRisk/detailNews', model:[user:user,comments:comments,news:news,departments:departments,departmentId:departmentId]
    }

    def saveNews = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def newsDetail        
        if (params.newsId){
            params.department = Department.get(params.department)
            params.createdBy = User.findByUsername(params.createdBy)
            newsDetail = RiskNews.get(params.newsId)
			params.dateCreated = DateUtil.parseInputDate(params.dateCreated+ ' 00:00:00')
            newsDetail.properties = params
            
        }else{
            params.department = Department.get(params.department)
            newsDetail = new RiskNews(params)
            newsDetail.createdBy = user

        }
        newsDetail.save(flush:true)
        if(newsDetail.hasErrors()) {
            newsDetail.errors.each {
                  // println it
            }
        }
        flash.message="Anh/chị lưu bản tin thành công"
        redirect (controller:'opRisk',action:'listNews')
    }

    def deleteNews = {
        def news = RiskNews.get(params.newsId)
        news.delete(flush:true)
        redirect (controller:'opRisk',action:'listNews')
    }

    def deleteNewsComment = {        
        def comment = NewsComment.get(params.deleteId)
        def news = comment.riskNews
        news.removeFromNewsComments(comment)        
        flash.message="Anh/chị đã xóa ý kiến thành công"
        redirect (controller:'opRisk',action:'detailNews',params:[newsId:news.id])
    }

    def viewNews = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def fromDate
        def toDate
        def department,departmentId,allNews,currentNews
        def departments = Department.get(user.prop1)
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
            today.setMonth(today.month-12)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

        }
        if(params.newsId){
            currentNews = RiskNews.get(params.newsId)
            if (params.fromDate && params.toDate){
                fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
                toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
            }
            if (params.departmentId)
                department = Department.get(params.departmentId)
        }
        if(department){
            departmentId = department.id
        }
        allNews = RiskNews.createCriteria().list{
            if(department)
                eq('department',Department.get(department.id))
            between('dateCreated',fromDate,toDate)			
            order('dateCreated','desc')
        }		
        if (allNews.size()>0){
            if (!currentNews)
                currentNews = allNews[0]
        }
        
        
        render view:'/opRisk/viewNews', model:[fromDate:params.fromDate,toDate:params.toDate,currentNews:currentNews,allNews:allNews,departments:departments,departmentId:departmentId]
    }

    def addNewsComment = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def news = RiskNews.get(params.newsId)
        def comment = new NewsComment(params)
        comment.createdBy = user
        news.addToNewsComments(comment)
        news.save(flush:true)
        
        redirect (controller:'opRisk',action:'viewNews',params:[fromDate:params.addFromDate,toDate:params.addToDate,departmentId:params.addDepartmentId,newsId:params.newsId])
    }


    def listResponse = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def fromDate
        def toDate
        def department,departmentId
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
            today.setMonth(today.month-12)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

        }
        if(department){
            departmentId = department.id
        }
        def response = RiskResponse.createCriteria().list{
            if(department)
                eq('department',Department.get(department.id))
            between('dateCreated',fromDate,toDate)
            order('dateCreated','desc')
        }


        render view:'/opRisk/listResponse', model:[riskResponse:response,departments:departments,departmentId:departmentId]
    }

    def detailResponse = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def response,department,departmentId
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def comments
        if(params.responseId){
            response = RiskResponse.get(params.responseId)
            comments = response.responseComments
        }
        render view:'/opRisk/detailResponse', model:[user:user,comments:comments,riskResponse:response,departments:departments,departmentId:departmentId]
    }

    def saveResponse = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def responseDetail
        if (params.responseId){
            params.department = Department.get(params.department)
            params.createdBy = User.findByUsername(params.createdBy)
            responseDetail = RiskResponse.get(params.responseId)
            responseDetail.properties = params

        }else{
            params.department = Department.get(params.department)
            responseDetail = new RiskResponse(params)
            responseDetail.createdBy = user

        }
        responseDetail.save(flush:true)
        if(responseDetail.hasErrors()) {
            responseDetail.errors.each {
                  // println it
            }
        }
        flash.message="Anh/chị đã khuyến nghị tin thành công"
        redirect (controller:'opRisk',action:'listResponse')
    }

    def deleteResponse = {
        def response = RiskResponse.get(params.responseId)
        response.delete(flush:true)
        redirect (controller:'opRisk',action:'listResponse')
    }

    def deleteResponseComment = {
        def comment = ResponseComment.get(params.deleteId)
        def response = comment.riskResponse
        response.removeFromResponseComments(comment)
        flash.message="Anh/chị đã xóa ý kiến thành công"
        redirect (controller:'opRisk',action:'detailResponse',params:[responseId:response.id])
    }

    def viewResponse = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def fromDate
        def toDate
        def department,departmentId,allResponse,currentResponse
        def departments = Department.get(user.prop1)
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
            today.setMonth(today.month-12)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')

        }
        if(params.responseId){
            currentResponse = RiskResponse.get(params.responseId)
            if (params.fromDate && params.toDate){
                fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
                toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
            }
            if (params.departmentId)
                department = Department.get(params.departmentId)
        }
        if(department){
            departmentId = department.id
        }
        allResponse = RiskResponse.createCriteria().list{
            if(department)
                eq('department',Department.get(department.id))
            between('dateCreated',fromDate,toDate)
            order('dateCreated','desc')
        }
        if (allResponse.size()>0){
            if (!currentResponse)
                currentResponse = allResponse[0]
        }


        render view:'/opRisk/viewResponse', model:[fromDate:params.fromDate,toDate:params.toDate,currentResponse:currentResponse,allResponse:allResponse,departments:departments,departmentId:departmentId]
    }

    def addResponseComment = {
        def user = User.findByUsername( springSecurityService.principal.username)
        def response = RiskResponse.get(params.responseId)
        def comment = new ResponseComment(params)
        comment.createdBy = user
        response.addToResponseComments(comment)
        response.save(flush:true)

        redirect (controller:'opRisk',action:'viewResponse',params:[fromDate:params.addFromDate,toDate:params.addToDate,departmentId:params.addDepartmentId,responseId:params.responseId])
    }
	//Error
	def errorManagementList={
		
		def user = User.findByUsername( springSecurityService.principal.username)
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code+0')						
		def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		
		def today = DateUtil.formatDate(new Date())
		
		def errorStatus=ErrorStatus.getAll()
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
		def errorCheck=ErrorCheck.getAll()
		def errorCategory = ErrorCategory.getAll()
		render view:'/opRisk/errorManaList',model:[errorlist1:errorlist1,unitDepart:unitDepart,department:department,currDate:today,user:user,errorStatus:errorStatus,errorType:errorType,errorCheck:errorCheck,errorCategory:errorCategory]
	}
	
	def getErrorList2={
		def errorList2=["-1"]
		
			if(params.parent_id ){
			//program=ErrorList.findAllWhere(parent:Integer.valueOf(params.productType))
				errorList2=ErrorList.executeQuery(' from ErrorList e where e.parent='+params.parent_id+' and e.status >=0 order by e.id')
			
			}		

		render errorList2 as JSON

	}
	
	
	
	//Save ErrorManageemtnList - Add New
	def saveErrorManaList={
		
		// println "Params:"+ params
		def errorManagement=new ErrorManagement()
		
		errorManagement.bienPhapKhacPhuc=params.BienPhapKhacPhuc
		if(params.ThoiHanKhacPhuc!=null && params.ThoiHanKhacPhuc.length()>4)
			errorManagement.thoiHanKhacPhuc=DateUtil.parseInputDate(params.ThoiHanKhacPhuc +' 00:00:00')
		
		//errorManagement.yKienCacDonViKhac=params.YKienCacDonViKhac
		errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
		errorManagement.motaChiTiet=params.description
		errorManagement.moTaAnhHuong = params.MoTaAnhHuong
		errorManagement.soLuongKiemTra = params.SoLuongKiemTra.toInteger()
		errorManagement.tongSoChonMau = params.TongSoChonMau.toInteger()
		errorManagement.nguoiNhap=params.NguoiNhap
		errorManagement.nHCD=params.NHCD
		
		if(params.TenDonVi!=null && params.TenDonVi!=""){
			errorManagement.tenDonVi=params.TenDonVi
		}
		else
			errorManagement.tenDonVi=params.hiddenFieldDonVi
		
		
		
		errorManagement.loiCap1=params.LoiCap1
		errorManagement.loiCap2=params.LoiCap2
		errorManagement.thoiGianNhapVaoHeThong=new Date()
		errorManagement.department =Department.get(params.NHCD)
		if(params.TenDonVi!=null && params.TenDonVi!=""){		
			errorManagement.unitDepart=UnitDepart.get(params.TenDonVi)
		}
		else
		{		
			errorManagement.unitDepart=UnitDepart.get(params.hiddenFieldDonVi.toInteger())
		}
//		getErrorDetail
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
							
			
				_d=Department.get(params.('NHCD_Id_'+i).toInteger())
				_ud=UnitDepart.get(params.('TenDonVi_Id_'+i).toInteger())
				userCreate.department=_d;
				userCreate.unitDepart=_ud;
				userCreate.unitDepartError=params.TenDonVi
			
			
			//
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
		flash.message = "Lỗi mới đã được thêm vào hệ thống. Xin nhập thêm thông tin về lỗi khác"
		flash.messageType = "message info"
		if(errorManagement.hasErrors()){
			errorManagement.errors.each{
				// println it
				flash.message = "Lỗi xảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ"
				flash.messageType = "message info"
			}
		}
		
		redirect (controller:'opRisk', action:'getErrorDisplay')
	}
	
	
	
	def getDisplayName ={
		
		def username=params.username
		def fullNameOutlook=["",""]
		def user = ErrorMasterUserCreate.findByUserEmail(username) 
		
		// println "params:"+ params
		if(user!=null)
		{
		
			
			def fullName=user.fullName
			def title=user.title
			def bDsUser=user.bDSUser
			def codeSalary=user.codeSalary
			def unitDepart=user.unitDepart.name	
			def department=user.department.name
					
			fullNameOutlook = [fullName,title,bDsUser,codeSalary,unitDepart,department,user.department.id,user.unitDepart.id]
		}
		render fullNameOutlook as JSON
		
	   }
	

	

	//Hien thi danh sach loi
	def getErrorDisplay={
		
		def errorManagement
		def user = User.findByUsername( springSecurityService.principal.username)
		
		if(user.prop4=="" ||user.prop4==null)
			redirect (controller:'opRisk', action:'updateInformation')
		
		
		
		def roleList = UserRole.findByUser(user).role
		def unitD
		//def unitD=user.prop4
		
		def fromDate,toDate
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code')
		
		if(params.fromDate!=null)
		{
					
			//errorManagement=ErrorManagement.getAll()
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-6);
			toDate=new Date();
		}
		//Check role to determide display
		def role = user.getAuthorities().authority
		def check = false
		role.each{
			if (it=='ROLE_GDTT'){
				check = true
			}
		}
		

		
		def currUnitDepart
		if(params.unitDepart!=null)
		{
			unitD=params.unitDepart
			if(params.unitDepart!="")
				currUnitDepart=UnitDepart.get(params.unitDepart)
		}
		else
		{			
			currUnitDepart=UnitDepart.get(user.prop4)			
		}
		// println "prams:"+params

		errorManagement= ErrorManagement.createCriteria().list{
			
						
			if(check)
			{
				eq('unitDepart',currUnitDepart)
			}
			else if (params.unitDepart!=null && params.unitDepart!="")
			{
				eq('unitDepart',currUnitDepart)
				}
			if(params.hiddenUnitDepart==null)
			{
				//eq('unitDepart',currUnitDepart)
			}
				
			between('thoiGianNhapVaoHeThong',fromDate,toDate)
			
			order("id", "desc")			
		}
		// println errorManagement
		render view:'/opRisk/errorManaDisplayAllError', model:[errorManagement:errorManagement,unitDepart:unitDepart,unitD:unitD,currUnitDepart:currUnitDepart]
	}

	
	def viewErrorDetail={
				
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code+0')
		def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		def today = DateUtil.formatDate(new Date())
		def errorManagement=ErrorManagement.get(params.id.toInteger())
		def user = User.findByUsername( springSecurityService.principal.username)
		def errorCheck = ErrorCheck.getAll()
		def errorCategory = ErrorCategory.getAll()
		
		def countErrorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement).size()
		
		if(countErrorUsers==0)
			countErrorUsers=1
		
		def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
		def errorStatus=ErrorStatus.getAll()
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
		def isSave="NoSave"
		// println "userName:"+user
		
		if(errorManagement.nguoiNhap== springSecurityService.principal.username)
			isSave="Save"		
			
		def role = user.getAuthorities().authority
		def check = false
		role.each{
			if (it=='ROLE_GDTT'){
				check = true				
			}
			else
				isSave="Save"
		}
		def isSaveStatus="No"
		def userCreate=errorManagement.errorUserCreate
		def userC
		errorManagement.errorUserCreate.each{
			
			if(it.userEmail==springSecurityService.principal.username)
			{
				isSaveStatus="Yes"
			}
			
		}

		// println "isSaveStatus:"+isSaveStatus			
		render view:'/opError/viewErrorManaDetail',model:[errorType:errorType,errorManagement:errorManagement,errorlist1:errorlist1,unitDepart:unitDepart,department:department,currDate:today,countErrorUsers:countErrorUsers,errorComment:errorComment,user:user,errorStatus:errorStatus,isSave:isSave,errorType:errorType,isSaveStatus:isSaveStatus,errorCheck:errorCheck,errorCategory:errorCategory]
		
	}
	//Delete all Error Delete
	
	def deleteAllErrorManagement={
		
		def allError=ErrorManagement.getAll()		
		allError.each{
			def errorManagement=ErrorManagement.get(it.id)
			def errorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement)
			
			errorUsers.each{
				errorManagement.removeFromErrorUserCreate(it)
				it.delete(flush:true)
			}
			def errorComment=ErrorsComment.findAllByErrorsManagements(errorManagement)
			// println "errorComment:"+ errorComment
			errorComment.each{
				errorManagement.removeFromErrorsComments(it)
				it.delete(flush:true)
			}
			errorManagement.delete(flush:true)
		}
		
	
		redirect (controller:'opRisk', action:'getErrorDisplay')
	}
	
	//Update ErrorManagement
	def updateErrorManaList={
		
		// println "params:"+ params
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
			// println "errorComment:"+ errorComment
			errorComment.each{
				errorManagement.removeFromErrorsComments(it)
				it.delete(flush:true)
			}
			errorManagement.delete(flush:true)
			flash.message="Anh/chị đã xóa thành công"
			
		}
		else if (params.actionButton=="updateStatus")
		{
			def errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())			
			errorManagement.trangThai=  params.TrangThai.toInteger()			
					
			flash.message = "Trạng thái lỗi đã được cập nhật."
			flash.messageType = "message info"
			errorManagement.save(flush:true)
			if(errorManagement.hasErrors()){
				errorManagement.errors.each{
					// println it
					flash.message = "Lỗi xảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ"
					flash.messageType = "message info"
				}
			}
			
		}
		else if(params.actionButton=="dupplicateError")
		{
			def errorManagement=new ErrorManagement()
			//
			errorManagement.bienPhapKhacPhuc=params.BienPhapKhacPhuc
			if(params.ThoiHanKhacPhuc!=null && params.ThoiHanKhacPhuc.length()>4)
			errorManagement.thoiHanKhacPhuc=DateUtil.parseInputDate(params.ThoiHanKhacPhuc +' 00:00:00')
			errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
			errorManagement.motaChiTiet=params.description
			//errorManagement.nguoiNhap=params.NguoiNhap
			errorManagement.nHCD=params.NHCD	
			if(params.TenDonVi!=null && params.TenDonVi!=""){
				errorManagement.tenDonVi=params.TenDonVi
			}
			else
				errorManagement.tenDonVi=params.hiddenFieldDonVi
			
				
			errorManagement.thoiGianNhapVaoHeThong=new Date()
			errorManagement.nguoiNhap=params.NguoiNhap
			errorManagement.loiCap1=params.LoiCap1
			errorManagement.loiCap2=params.LoiCap2
			//errorManagement.thoiGianNhapVaoHeThong=new Date()
			errorManagement.department =Department.get(params.NHCD)
			
			
			
			if(params.TenDonVi!=null && params.TenDonVi!=""){
				errorManagement.unitDepart=UnitDepart.get(params.TenDonVi)
			}
			else
			{
				errorManagement.unitDepart=UnitDepart.get(params.hiddenFieldDonVi.toInteger())
			}
			
			
			
			errorManagement.giaTriGiaoDich=params.GiaTriGiaoDich
			errorManagement.hoSoVaTenHoSo=params.HoSoVaTenHoSo
			errorManagement.maGiaoDich=params.MaGiaoDich
			errorManagement.soCifKhachHang=params.SoCifKhachHang
			errorManagement.tenKhachHang=params.TenKhachHang
			errorManagement.trangThai=  params.TrangThai.toInteger()
			errorManagement.loaiTien=params.LoaiTien			
			/*errorManagement.errorType=ErrorType.get(params.errorType)*/
			// println "params.uploadFile"+params.uploadFile
			if(params.uploadFile!=null && params.uploadFile!="")
			{
				def file = request.getFile('uploadFile')
			
				if(!file.empty){
				
					// println "Khong empty roi, uplod file"
					def fileName = file.getOriginalFilename()
					String absolutePath = getServletContext().getRealPath("errorFiles/"+ fileName)
					File fileOut = new File(absolutePath)
					file.transferTo(fileOut)
					errorManagement.fileName = fileName
				}
			}
		
			
			
			
			
			
			def _d=new Department();
			def _ud=new UnitDepart();
			
			
			def userCreate=new ErrorUserCreate()
			def userEmailParam
		
			
			
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
								
				
					_d=Department.get(params.('NHCD_Id_'+i).toInteger())
					_ud=UnitDepart.get(params.('TenDonVi_Id_'+i).toInteger())
					userCreate.department=_d;
					userCreate.unitDepart=_ud;
					userCreate.unitDepartError=params.TenDonVi
				
					errorManagement.addToErrorUserCreate(userCreate)
				}
			}
			flash.message = "Lỗi đã được lưu vào hệ thống."
			flash.messageType = "message info"
			errorManagement.save(flush:true)
			if(errorManagement.hasErrors()){
				errorManagement.errors.each{
					// println it
					flash.message = "Lỗi xảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ"
					flash.messageType = "message info"
				}
			}
		
/*			def errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())
			
			
			
			def err=new ErrorManagement()			
			err.nHCD=errorManagement.nHCD
			err.tenDonVi=errorManagement.tenDonVi
			err.ngayXayRa=errorManagement.ngayXayRa
			err.loiCap1=errorManagement.loiCap1
			err.loiCap2=errorManagement.loiCap2
			err.motaChiTiet=errorManagement.motaChiTiet
			err.maGiaoDich=errorManagement.maGiaoDich
			err.giaTriGiaoDich=errorManagement.giaTriGiaoDich
			err.soCifKhachHang=errorManagement.soCifKhachHang
			err.tenKhachHang=errorManagement.tenKhachHang
			err.hoSoVaTenHoSo=errorManagement.hoSoVaTenHoSo
			err.bienPhapKhacPhuc=errorManagement.bienPhapKhacPhuc
			err.thoiHanKhacPhuc=errorManagement.thoiHanKhacPhuc
			err.nguoiNhap=errorManagement.nguoiNhap
			err.thoiGianNhapVaoHeThong=errorManagement.thoiGianNhapVaoHeThong
			err.trangThai=errorManagement.trangThai
			err.department=errorManagement.department
			err.unitDepart=errorManagement.unitDepart
			err.fileName=errorManagement.fileName
			err.tenDonVi=errorManagement.tenDonVi
			err.loaiTien=errorManagement.loaiTien
			err.errorType=errorManagement.errorType
		
			def _d=new Department();
			def _ud=new UnitDepart();
			def userCreate=new ErrorUserCreate()
			// println "params.dateCount:"+params.dateCount
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
				_d=Department.get(params.('NHCD_Id_'+i).toInteger())
				_ud=UnitDepart.get(params.('TenDonVi_Id_'+i).toInteger())
				userCreate.department=_d;
				userCreate.unitDepart=_ud;
				userCreate.unitDepartError=params.TenDonVi
				
				
				
				
				//
				err.addToErrorUserCreate(userCreate)
				}
			}
			
			err.save(flush:true)*/
			
			
		}
		else
		{
				//Do phia nghiep vu yeu cau lang ngoang nen lam theo cach sau:
				//1. Tim ErrorManagement update
				//2. Xoa het du lieu trong ban errorUser roi insert vao lai
				// println "params:"+ params.idErrorManagement
				def errorManagement=ErrorManagement.get(params.idErrorManagement.toInteger())
				//// println params
				errorManagement.bienPhapKhacPhuc=params.BienPhapKhacPhuc
				if(params.ThoiHanKhacPhuc!=null && params.ThoiHanKhacPhuc.length()>4)
				errorManagement.thoiHanKhacPhuc=DateUtil.parseInputDate(params.ThoiHanKhacPhuc +' 00:00:00')
				
				//errorManagement.yKienCacDonViKhac=params.YKienCacDonViKhac
				errorManagement.ngayXayRa=DateUtil.parseInputDate(params.dateNgayXayRa + ' 00:00:00')
				errorManagement.motaChiTiet=params.description
				//errorManagement.nguoiNhap=params.NguoiNhap
				errorManagement.nHCD=params.NHCD
				
				
				if(params.TenDonVi!=null && params.TenDonVi!=""){
					errorManagement.tenDonVi=params.TenDonVi
				}
				else
					errorManagement.tenDonVi=params.hiddenFieldDonVi
				
					
					
				errorManagement.loiCap1=params.LoiCap1
				errorManagement.loiCap2=params.LoiCap2
				//errorManagement.thoiGianNhapVaoHeThong=new Date()
				errorManagement.department =Department.get(params.NHCD)
				
				
				
				if(params.TenDonVi!=null && params.TenDonVi!=""){
					errorManagement.unitDepart=UnitDepart.get(params.TenDonVi)
				}
				else
				{
					errorManagement.unitDepart=UnitDepart.get(params.hiddenFieldDonVi.toInteger())
				}
				
				errorManagement.soLuongKiemTra = params.SoLuongKiemTra.toInteger()
				errorManagement.tongSoChonMau = params.TongSoChonMau.toInteger()
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
				/*errorManagement.errorType=ErrorType.get(params.errorType)*/
				// println "params.uploadFile"+params.uploadFile
				if(params.uploadFile!=null && params.uploadFile!="")
				{
					def file = request.getFile('uploadFile')
				
					if(!file.empty){
					
						// println "Khong empty roi, uplod file"
						def fileName = file.getOriginalFilename()
						String absolutePath = getServletContext().getRealPath("errorFiles/"+ fileName)
						File fileOut = new File(absolutePath)
						file.transferTo(fileOut)
						errorManagement.fileName = fileName
					}
				}
				
				if(params.hfDeleteFile=="deleteFile")
				{
					// println "xoas xoa s xoas"
					errorManagement.fileName =null
				}
				def errorUsers = ErrorUserCreate.findAllByErrorManagement(errorManagement)
				
				errorUsers.each{
					errorManagement.removeFromErrorUserCreate(it)
					it.delete(flush:true)
				}
				
				
				def _d=new Department();
				def _ud=new UnitDepart();
				def userCreate=new ErrorUserCreate()
				// println "params.dateCount:"+params.dateCount
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
					_d=Department.get(params.('NHCD_Id_'+i).toInteger())
					_ud=UnitDepart.get(params.('TenDonVi_Id_'+i).toInteger())
					userCreate.department=_d;
					userCreate.unitDepart=_ud;
					userCreate.unitDepartError=params.TenDonVi
					
					
					
					
					//
					errorManagement.addToErrorUserCreate(userCreate)
					}
				}
				flash.message = "Lỗi đã được lưu vào hệ thống."
				flash.messageType = "message info"
				errorManagement.save(flush:true)
				if(errorManagement.hasErrors()){
					errorManagement.errors.each{
						// println it
						flash.message = "Lỗi xảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ"
						flash.messageType = "message info"
					}
				}
				
		
		
		}
		redirect (controller:'opRisk', action:'getErrorDisplay')
	}

///Bao cao
	def reportError={		
		def errorManagement = null
			
		def unitDepart=UnitDepart.getAll()
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		render view:'/opRisk/rList', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1,typeReport:typeReport]
	}
	
	def preloadReport={
		
		
		
    }
		//Bao cao liet ke danh sach loi
	def reportErrorList={
		def fromDate,toDate
		// println "params:"+params
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-6);
			toDate=new Date();
		}
		
		
		
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.nguoigayloi!=null && params.nguoigayloi!='')
			{
				// println "DSFsdfsdfsadf"
				eq("userEmail",params.nguoigayloi)
			}
		}
		// println "errorUser:"+errorUser
		// println "Params:1111"+params
		def errorManagement = ErrorManagement.createCriteria().list{
			if(params.nguoigayloi!=null && params.nguoigayloi!='')
			{
				errorUserCreate{
					if(errorUser.size()>0){
						'in'('id',errorUser.id)
					}else{
						eq('id','-1'.toLong())
					}			
				}
			}
			if(params.LoiCap1!=null && params.LoiCap1!='')
				eq('loiCap1',params.LoiCap1)
			
			if(params.LoiCap2!=null && params.LoiCap2!='')
				eq('loiCap2',params.LoiCap2)
			if(params.trangthai!=null && params.trangthai!='')
			{
				
				eq('trangThai',params.trangthai.toInteger())
			}
			if(params.unitDepart!=null && params.unitDepart!='')
				eq('tenDonVi', params.unitDepart)
			
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
			
					order("id", "desc")
				
		}
		// println "errorManagement:"+ errorManagement
		
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code  ')
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		
		def errorStatus=ErrorStatus.getAll()
		def errorType=ErrorType.executeQuery(' from ErrorType e  order by e.id')
		
		render view:'/opRisk/errorReportList', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1,errorStatus:errorStatus,nguoigayloi:params.nguoigayloi,loicap1:params.LoiCap1,loicap2:params.LoiCap2,trangthai:params.trangthai,unitD:params.unitDepart,kieuNgay:params.KieuNgay,errorType:errorType]
	}
	//Bao cao nguoi gay loi
	def reportErrorUserCreate={
		
		// println params
		def fromDate,toDate
		def sqlFromDate,sqlToDate
		
		def sql = Sql.newInstance(sqlserverDataSource)
		
		
		def sqlCommand="select   Teller_ID, Sum(Tong_GD) from LoiGD_GDV"			
			sqlCommand +=" where '1'='1' "
						   

		// println "params:"+params
		if(params.fromDate!=null)
		{
			
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
			
			sqlCommand +=" and ( [Date] between convert(datetime, '"+params.fromDate+"', 103) and convert(datetime, '"+params.toDate+"', 103)) "
			
		}
		else
		{
			
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-6);
			toDate=new Date();
			
			sqlCommand +=" and ( [Date] between convert(datetime, '"+  DateUtil.formatDate(fromDate)+"', 103) and convert(datetime, '"+DateUtil.formatDate(toDate)+"', 103)) "
		}
		sqlCommand +=" group by teller_id "
		//sqlCommand +=" and Teller_id= '"+errorUser.BDSUser+"' "		
	
		// println sqlCommand
		def rs  = sql.rows(sqlCommand)
		
		def ErrorM
		def ErrorUserC
		def tellerId
		// println "KieuNgay:"+ params.KieuNgay	
		def result=[]				
				// println "params.trangthai:"+ params.trangthai
				ErrorM = ErrorManagement.createCriteria().listDistinct{
					
					if(params.LoiCap1!=null && params.LoiCap1!='')
						eq('loiCap1',params.LoiCap1)
					
					if(params.LoiCap2!=null && params.LoiCap2!='')
						eq('loiCap2',params.LoiCap2)
					if(params.trangthai !=null && params.trangthai!='')
						eq('trangThai',params.trangthai.toInteger())
					
					if(params.unitDepart !=null && params.unitDepart!='')
						eq('tenDonVi', params.unitDepart)
						
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
				// println userCreate11
				def idErrorM=""
				for(int i=0;i<ErrorM.size();i++)
				{
					idErrorM=idErrorM + ErrorM[i].id+","
				}
				idErrorM =idErrorM +"0"
				// println "idErrorM"+idErrorM
				
				def errorUserC
				// println "def params:"+params
				if(params.nguoigayloi!=null && params.nguoigayloi!="")
					errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName, SUM(e.levelError), e.errorManagement,e.title,e.codeSalary,e.department FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') and e.userEmail=:fullN GROUP BY e.unitDepartError, e.userEmail ',[fullN:params.nguoigayloi])
				else
					errorUserC=ErrorUserCreate.executeQuery('SELECT e.bDSUser, COUNT(e.id), e.userEmail,e.fullName, SUM(e.levelError), e.errorManagement,e.title,e.codeSalary,e.department FROM ErrorUserCreate e where e.errorManagement  in ('+idErrorM+') GROUP BY e.unitDepartError, e.userEmail ')
				// println "errorUserC:"+errorUserC
				def _bdsUser=""
				def tongGD=0;
				for(int i=0;i<errorUserC.size();i++){
					_bdsUser= errorUserC[i][0]
					tongGD=0
					// println "_bdsUser:"+_bdsUser
					for(int j=0;j<rs.size;j++){						
						if(rs[j][0].toString().trim()==_bdsUser.trim()){
							tongGD=rs[j][1]
							// println "tongGD:"+rs[j][1]
						}
					}
				
					result << [rs:tongGD,ErrorUserCreate:errorUserC[i]]
				}
		
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code')
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		
		
		
		def errorStatus=ErrorStatus.getAll()
		// println "params.typeReport:"+params.typeReport
		if(params.typeReport!=null)
		{
			
			render view:'/opRisk/errorReportByUnit', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,nguoigayloi:params.nguoigayloi,loicap1:params.LoiCap1,loicap2:params.LoiCap2,trangthai:params.trangthai,unitD:params.unitDepart,kieuNgay:params.KieuNgay]
		}
		else
		{
			def userErrorCreateList=ErrorUserCreate.executeQuery(" FROM ErrorUserCreate e where  e.userEmail!='' GROUP BY e.userEmail")
			
			render view:'/opRisk/errorReportUserCreate', model:[unitDepart:unitDepart,errorlist1:errorlist1,result:result,errorStatus:errorStatus,errorStatus:errorStatus,nguoigayloi:params.nguoigayloi,loicap1:params.LoiCap1,loicap2:params.LoiCap2,trangthai:params.trangthai,unitD:params.unitDepart,kieuNgay:params.KieuNgay]
		}
	}
	/*def reportErrorLevel={
		def fromDate,toDate
		// println "SDDDDDDĐ===>>>>>>>>"
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-6);
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
			
		
		
		
		if(params.nguoigayloi!=null && params.nguoigayloi!='' )
		{
			strSQL="SELECT DISTINCT error_management.`loi_cap1`,error_management.`loi_cap2` , COUNT('loi_cap2') FROM error_user_create INNER JOIN error_management ON error_management.`id`=error_user_create.error_management_id "
			strSQL= strSQL+ " WHERE ngay_xay_ra BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'  and error_user_create.`user_email`='"+params.nguoigayloi+"'"
		}
		
		if(params.unitDepart!=null && params.unitDepart!='')
			strSQL =strSQL + " and unit_depart_id ="+ params.unitDepart
		if(params.trangthai!=null && params.trangthai!=null && params.trangthai!='')
			strSQL =strSQL + " and trang_thai ='"+ params.trangthai+"'"
		if(params.LoiCap1!=null && params.LoiCap1!='')
			strSQL = strSQL +" and loi_cap1="+ params.LoiCap1
		
		if(params.LoiCap2!=null && params.LoiCap2!='')
			strSQL = strSQL +" and loi_cap2="+ params.LoiCap2
		
			
		strSQL =strSQL + " GROUP BY Loi_cap3 "
		
		// println "SDFD:"+strSQL
		
		def errorManagement = db.rows(strSQL)
		
				
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.status >=0 order by e.code')
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		def errorStatus=ErrorStatus.getAll()
		
		render view:'/opRisk/errorReportLevel', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1,errorStatus:errorStatus,errorStatus:errorStatus,nguoigayloi:params.nguoigayloi,loicap1:params.LoiCap1,loicap2:params.LoiCap2,trangthai:params.trangthai,unitD:params.unitDepart]
	}*/
	//Xoa Comment o Error
	def deleteErrorComment = {
		def comment = ErrorsComment.get(params.deleteId)		
		def errorManagement = comment.errorsManagements			
		
		errorManagement.removeFromErrorsComments(comment)
		flash.message="Anh/chị đã xóa ý kiến thành công"
		redirect (controller:'opRisk',action:'getErrorDetail',params:['id':errorManagement.id])
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
		
		if(errorManagement.hasErrors()){
			errorManagement.errors.each{
				// println it
			}
		}
		
		redirect (controller:'opRisk',action:'viewErrorDetail',params:['id':errorManagement.id])
	}
	def viewErrorUserCreate={
		def userErrorCreate=ErrorUserCreate.executeQuery(" FROM ErrorUserCreate e where  e.userEmail!='' GROUP BY e.userEmail")

		//SELECT  * FROM error_user_create GROUP BY user_email
		//// println "userError"+ userError
		render view:'/opRisk/errorManaUser', model:[userErrorCreate:userErrorCreate]
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
		
		// println params
		String contentError=''
		Long currCif=0
		Long currgiaTriGiaoDich=0
		String currDescription
		try{
			// println 'xxxxxxxxx'
			def file = request.getFile('file')
			// println "sdfasdfas"+ file
			if(file){
			 
			// println "me cai file eo ton tai"
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
									// println it
									flash.message = "Lỗi xảy ra: Xin vui lòng gửi thông tin lên IT Service Desk để được hỗ trợ"
									flash.messageType = "message info"
									
								}
							}
						}
						else
						{
							
							

							contentError +="<br> Lỗi tại dòng " +i+":"
	
							if (department ==null)
								contentError +=" Không tìm thấy [Tên NHCD/Khối]-"
							if(unitDepartment ==null)
								contentError +=" Không tìm thấy [Tên đơn vị]-"
							if (loiCap1 ==null)
								contentError +=" Không tìm thấy [Loại lỗi cấp 1]-"
							if (loiCap2 ==null)
								contentError +=" Không tìm thấy [Loại lỗi cấp 2]-"
							if (trangthai==null)

								contentError +=" Không tìm thấy [Trạng Thái]-"
//							if(currDescription==null && currDescription.trim().length()<1)
//								contentError +=" Không tìm thấy [Mô tả chi tiết]"

						}
					
						
					}					
					else

					{
						contentError +="<br> Lỗi tại dòng " +i+":"

						if(isValidDate1==false)
						contentError +=" Sai định dạng ngày tháng [Ngay xay ra]"
												
						if(isValidDate2==false)
							contentError +=" Sai định dạng ngày tháng [Thoi Gian Nhap]"
							
						if(isValidDate3==false)
						contentError +=" Sai định dạng ngày tháng [Thoi Gian Khac Phuc]"
						
						if(data['TenNH']==null || data['TenNH']=='')
							contentError +=" Không tìm thấy [Tên NHCD/Khối]-"
							
						if(data['TenDonVi']==null || data['TenDonVi']=='')
							contentError +=" Không tìm thấy [Tên Đơn Vị]-"
						if(data['LoaiLoiCap1']==null)
							contentError +=" Không tìm thấy [Loại Lỗi Cấp 1]"
						if(data['LoaiLoiCap2']==null)
							contentError +=" Không tìm thấy [Loại Lỗi Cấp 2]"
//						if(currDescription==null || currDescription.trim().length()<1)
//							contentError +=" Không tìm thấy [Mô tả chi tiết]"
					}

					
					
					
				}
				
			 }
			if (contentError!="")
			{
				flash.message = contentError
				flash.messageType = "message info"
			}
		
		
			}catch(Exception e){}
			
		
		render view:'/opRisk/errorImportExcel'
	}
	
	/*** MODULE PHAN TICH KICH BAN ***/
	def listScript = {
		def allScripts
		def businessFields = BusinessField.findAllByStatusGreaterThanEquals(0,[sort: "code"])		
		def actionStatus = ErrorStatus.findAllByStatusGreaterThanEquals(0)
		def events = Event.findAllByOrd(0)	
		def possibilities = Possibility.getAll() 
		def possibility
		def fromDate = new Date();
		fromDate.setMonth(fromDate.month-1);
		def toDate=new Date();		
					
		allScripts = RiskScript.createCriteria().list {
			ge("status",0)
			if (params.search) {			
				if (params.fromDate && params.toDate) {
					fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
					toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')					
				}
				if (params.businessField) 
					eq("businessField",BusinessField.get(params.businessField))
				if (params.event)
					eq("event",Event.get(params.event))
				if (params.possibility)
					eq("possibility",Possibility.get(params.possibility))
				if (params.financialLoss)
					eq("financialLoss",params.financialLoss)
				if (params.actionStatus)
					eq("actionStatus",ErrorStatus.get(params.actionStatus))
				
			}
			between("dateCreated",fromDate,toDate)
			order("id","desc")			
		}
		
		if(params.exportExcel=="ExportExcel"){
			
						def header //= ['Mã KRI','Mã/Tên rủi ro','Tiêu đề KRI','Tấn suất theo dõi','Loại KRI','NHCD/Khối','CN/TT/Phòng','PGD/Phòng ban/Tổ nhóm','Trạng thái','Nguồn số liệu']
						def listContent = []
						//listContent<<header
						def maKB,linhvuc,sukien,khanang,tonthat,kehoach,trangthai
			
			
						allScripts.each{
							maKB=it.id
							linhvuc = it.businessField
							sukien=it.event
							khanang = it.possibility
							tonthat = FormatUtil.stripNumber(it.financialLoss)
							kehoach = it.actionPlan							
							trangthai = it.actionStatus
							
							header = [maKB,linhvuc,sukien,khanang,tonthat,kehoach,trangthai]
							listContent<<header
						}
			
			
						def data
						data = exportExcelService.scriptDisplay(listContent)
			//			// // println "DATA:"+data
			
			
						//File download
						response.setContentType("application/vnd.ms-excel")
						response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
						response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}
		
		render view:'/opRisk/listScript', model:[allScripts:allScripts,businessFields:businessFields,actionStatus:actionStatus,possibilities:possibilities,events:events]
	}
	
	def detailScript = {
		def user = User.findByUsername( springSecurityService.principal.username)
		def script
		def businessFields = BusinessField.findAllByStatusGreaterThanEquals(0)		
		def actionStatus = ErrorStatus.findAllByStatusGreaterThanEquals(0)
		def events = Event.findAllByOrd(0)	
		def possibilities = Possibility.getAll() 
		
		if(params.scriptId){
			script = RiskScript.get(params.scriptId)
		}
		render view:'/opRisk/detailScript', model:[user:user,businessFields:businessFields,script:script,actionStatus:actionStatus,possibilities:possibilities,events:events]
	}
	
	def saveScript = {		
			def arrTo=[]
			def arrCc=[]
			def toEmail
			arrTo += Conf.findByType('cc_email').value
			def user = User.findByUsername( springSecurityService.principal.username)
			def script
			if (params.scriptId) {				
				script = RiskScript.get(params.scriptId)
			}
			else {
				script = new RiskScript()
				script.createdBy = user				
			}
			
			if (params.save) {				
				params.businessField =BusinessField.get(params.businessField)
				params.possibility = Possibility.get(params.possibility)
				params.event = Event.get(params.event)
				params.actionStatus = ErrorStatus.get(params.actionStatus)
				
				script.properties = params				
				
				script.status = 0
				script.save(flush:true)				
				if (params.scriptId) {
					def scriptDescription = ""
					scriptDescription += "Tên lĩnh vực kinh doanh: "+ script.businessField.name +"<br>"
					scriptDescription += "Mô tả kịch bản: "+ script.description +"<br>"
					scriptDescription += "Tên loại sự kiện: "+ script.event.name +"<br>"
					scriptDescription += "Đánh giá khả năng xảy ra: "+ script.possibility.description +"<br>"
					scriptDescription += "Tổn thất xảy ra (nếu có): "+ script.financialLoss +"<br>"
					scriptDescription += "Kế hoạch hành động: "+ script.actionPlan +"<br>"
					scriptDescription += "Trạng thái hành động: "+ script.actionStatus.nameStatus +"<br>"
					
					//sendEmailRiskScript("SCRIPT",arrTo,arrCc,scriptDescription,""+script.id+"","Cập nhật kịch bản",script)
					flash.message = 'Anh/chị đã cập nhật thành công!'
				} else {
					//sendEmailRiskScript("SCRIPT",arrTo,arrCc,"",""+script.id+"","Tạo mới kịch bản",script)
					flash.message = 'Anh/chị đã tạo mới thành công!'
				}
			}
			
			if (params.delete) {
				script.status = -10		
				script.save(flush:true)
				flash.message = 'Anh/chị đã xóa thành công!'							
				//sendEmailRiskScript("SCRIPT",arrTo,arrCc,"",""+script.id+"","Xóa kịch bản",script)
			}
			
			if (params.clone) {
				params.businessField =BusinessField.get(params.businessField)
				params.possibility = Possibility.get(params.possibility)
				params.event = Event.get(params.event)
				params.actionStatus = ErrorStatus.get(params.actionStatus)
				script = new RiskScript(params)				
				script.createdBy = user
				script.status = 0
				script.save(flush:true)
				flash.message = 'Anh/chị đã tạo mới thành công!'
				//sendEmailRiskScript("SCRIPT",arrTo,arrCc,"",""+script.id+"","Thêm mới kịch bản",script)
			}
			
			
			if(script.hasErrors()){
				script.errors.each{
					 println it
				}
			}
		
		redirect (controller:'opRisk',action:'listScript')		
	}
	
	def sendEmailRiskScript(String code,def to, def cc,String CTLoi,String Id,String action, def actionScript){
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
				def content = MessageFormat.format(errorMail.content, [action,actionScript.event,actionScript.businessField,actionScript.description,CTLoi,Id].toArray())			
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