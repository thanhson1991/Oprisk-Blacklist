import grails.converters.JSON
import groovy.sql.Sql
import java.text.*;
import java.util.*;
import msb.platto.fingerprint.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class SelfEvaluationController {
    def riskService
    def springSecurityService
    Role role

	//----------- THE CODE BELOW IS STABLE, BY LONGTD ------------------//
	def getRisks(def process = null){
            def user = User.findByUsername( springSecurityService.principal.username)
            def department = Department.get(user.prop1)
            def risks = []
            def risksL1 = Risk.createCriteria().list{
                or{
                    isNull('process')
                    eq('process',process)
                }
                eq('enabled',true)
                ge('status',0)
                eq('department',department)
                eq('ord',0)
                order('id','asc')
            }
        
            risksL1.each{ l1 ->
                    risks << l1
                    l1.children.each{ l2 ->                            
                            l2.children.each{ l3 ->
                                    if((l3.process == null || l3.process == process) && l3.status>=0 && l3.enabled==true){
                                            risks << l3
                                    }
                            }
                    }
            }

            return risks
	}
	def getIncompleteUserProcess(){
		def user = User.findByUsername( springSecurityService.principal.username)
                def today = Calendar.getInstance()
                def lastDayString = today.getActualMaximum(Calendar.DAY_OF_MONTH) + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
                def firstDayString = '1' + '/' + (today.get(Calendar.MONTH)+1) + '/' + today.get(Calendar.YEAR)
                def firstDay = DateUtil.parseInputDate(firstDayString + ' 00:00:00')
                def lastDay = DateUtil.parseInputDate(lastDayString + ' 23:59:59')
                def process = SelfEvaluationProcess.createCriteria().get{
                    eq('department',Department.get(user.prop1))
                    eq('createdBy',user)
                    between('dateCreated',firstDay,lastDay)
                    ge('status',0)            
                }
                
		if(!process){
			process = new SelfEvaluationProcess(createdBy:user,department:Department.get(user.prop1),branchName:user.prop2).save(flush:true)
		}                
		return process
	}
	def index = {
		def user = User.findByUsername( springSecurityService.principal.username)
		def incompleteActions = Action.createCriteria().list{
			lt('status',100)
			riskInstance{
				selfEvaluationProcess{
					eq('status',100)
					eq('createdBy',user)
				}
			}
		}
		if(incompleteActions){
			render view:'viewIncompleteAction',model:[actions:incompleteActions]
		}else{
			def process = getIncompleteUserProcess()
			if(!process.riskInstances)
				redirect action:'start'
			else
				redirect action:'viewEvaluationProcess',params:[id:process.id]
		}
		
	}
	def start = {
                def process = getIncompleteUserProcess()
                def department = Department.get(process.createdBy.prop1)
		if(params.addRisk){			
                    def risklv1 = Risk.get(params.riskL1Id)
                    def risklv2 = Risk.findByParentAndName(risklv1,"Others")
                    if (risklv2 == null){
                        risklv2 = new Risk(name:"Others",department:department,enabled:true,ord:1,parent:risklv1,process:process)
                        risklv1.addToChildren(risklv2)
                        risklv1.save(flush:true)
                    }
                    def risklv3 = new Risk(name:params.name,department:department,enabled:true,ord:1,parent:risklv2,process:process)
                    risklv2.addToChildren(risklv3)
                    risklv2.save(flush:true)
                    flash.message="Anh/chị đã thêm mới định nghĩa rủi ro thành công."
                    process = getIncompleteUserProcess()
		}                
		def risks = getRisks(process)                
                
		render view:'start',model:[risks:risks,riskL1:Risk.findAllByOrdAndDepartment(0,department)]
	}
    def actionManagement = {
		def user = User.findByUsername( springSecurityService.principal.username)
                def incompleteActions = Action.createCriteria().list{
			lt('status',100)
			riskInstance{
				selfEvaluationProcess{
					eq('status',100)
					eq('createdBy',user)
				}
			}
		}
			
		render view:'viewIncompleteAction',model:[actions:incompleteActions,management:1]
    }

    def listActions = {        
        def user = User.findByUsername( springSecurityService.principal.username)
                def actions = Action.createCriteria().list{
			riskInstance{
				selfEvaluationProcess{
					eq('status',100)
					eq('createdBy',user)
				}
			}
		}

		render view:'listActions',model:[actions:actions]

    }

	def getPastRisksJson = {
		def pastRiskObject = [
			"id": "pastsRisk",
		    "title": "",
		    "focus_date": new Date().format('yyyy-MM-dd HH:mm:ss') ,
		    "initial_zoom": "30",
		    "timezone": "+07:00",
			"events": []
		]
		
		def user = User.findByUsername( springSecurityService.principal.username)
		def pastRisks = RiskInstance.createCriteria().list{
			selfEvaluationProcess{
				eq('createdBy',user)
			}
		}
		pastRisks.eachWithIndex{ risk, i ->
			risk.riskAction.deadline = new Date() + i*7;
			pastRiskObject['events'] <<
				[
				"id": "risk-${risk.id}",
				      "title": "${risk.risk?.name}",
				      "description": "${risk.riskAction.description}",
				      "startdate": "${risk.riskAction.deadline?.format('yyyy-MM-dd 00:00:00')}",
				      "enddate": "${risk.riskAction.deadline?.format('yyyy-MM-dd 23:59:59')}",
				      "date_display": "day",
				      "link": "#risk-action-${risk.id}",
				      "importance": 50,
				      "icon":"triangle_orange.png"
				]
				
		}
		def l = [pastRiskObject]
		
		render l as JSON
		
	}
    
	def saveRiskInstance = {		
		if(!params.id) {
			render 0
			return
		}
		// check for binding data
		def riskInstance = RiskInstance.get(params.id)
//                def riskAction = riskInstance.riskAction
//                riskAction.description= params.actionDescription
//                riskAction.executor = params.actionExecutor
//                if (params.actionDeadline)
//                    riskAction.deadline = DateUtil.parseInputDate(params.actionDeadline + ' 00:00:00')
//                riskAction.save(flush:true)
		riskInstance.properties['controlEffect','risk','impact','possibility','description','control'] = params
                if(riskInstance.controlEffect != null && riskInstance.impact != null && riskInstance.possibility != null)
                    riskInstance.score = riskService.calculateScore(riskInstance)
                
		riskInstance.validate()
		if(!riskInstance.hasErrors() && riskInstance.save(flush:true))
			render riskInstance as JSON
		else {
			// println riskInstance.errors
			render "-1"
		}
	}

        def deleteRiskInstance = {            
		if(!params.id) {
			render 0
			return
		}
		// check for binding data
		def riskInstance = RiskInstance.get(params.id)
                def process = riskInstance.selfEvaluationProcess                
                riskInstance.riskAction.delete()
		riskInstance.delete(flush:true)
                //process.save(flush:true)
                flash.message="Anh/chị đã xóa rủi ro thành công."
                redirect controller:'selfEvaluation',action:'viewEvaluationProcess',params:[id:process.id,step:2]
	}

	def addRiskInstance = {
            def user = User.findByUsername( springSecurityService.principal.username)
            def process = SelfEvaluationProcess.get(params.id)
		def instance = new RiskInstance()
		process.addToRiskInstances(instance)
		instance.validate()
		if(instance.hasErrors()){
			// println instance.errors
			render "-1"
		}else{
			process.save(flush:true)
                        def newAction = new Action(riskInstance:instance,createdBy:user)
                        newAction.save(flush:true)
			render instance as JSON
		}
		
	}
    def viewEvaluationProcess = {
      	def user = User.findByUsername( springSecurityService.principal.username)
        def department = Department.get(user.prop1)
        def process = SelfEvaluationProcess.get(params.id)     
        if(!process.riskInstances){
			redirect action:'start'
        }

        def risklv1 = Risk.createCriteria().list{
            eq('enabled',true)
            ge('status',0)
            eq('department',department)
            eq('ord',0)
        }

        def risks = getRisks(process)

        

        def impacts = Impact.list()
        def possibilities = Possibility.list()
        def controlEffects = ControlEffect.list()

     
        render view:'selfEvaluationBySteps',model:[risks:risks,risklv1:risklv1,impacts:impacts,
                    possibilities:possibilities,controlEffects:controlEffects,process:process]


    }
	def createEvaluationProcess = {		
	    def user = User.findByUsername( springSecurityService.principal.username)
		
		def process = getIncompleteUserProcess()
		process.riskInstances.removeAll()
		params.list("risk").each{r->
                    if(!RiskInstance.findByRiskAndSelfEvaluationProcess(Risk.get(r),process)){
                        def newRiskInstance = new RiskInstance(risk:Risk.get(r))
                        process.addToRiskInstances(newRiskInstance)
                        process.save(flush:true)						
                        def newAction = new Action(riskInstance:newRiskInstance,createdBy:user)
                        newAction.save(flush:true)
                    }
		}   
            
        redirect controller:'selfEvaluation',action:'viewEvaluationProcess',params:[id:process.id]

    }

	//----------- THE CODE ABOVE IS STABLE, BY LONGTD ------------------//
      def updateIncompleteAction = {       
        def count = 0
        def action
        def actionIdList = params.list("actionId")
        def statusList = params.list("status")
        actionIdList.each{
            action = Action.get(it)
            action.status = statusList[count].toLong()
            action.save(flush:true)
            count ++            
        }
        if(params.save){
            flash.message = "Anh/chị đã cập nhật thành công biện pháp giảm rủi ro."
            if (params.management){
                redirect controller:'selfEvaluation',action:'actionManagement'
            }else
            redirect controller:'selfEvaluation',action:'index'

        }
        else if (params.proceed){
            def process = getIncompleteUserProcess()
                if(!process.riskInstances)
                        redirect action:'start'
                else
                        redirect action:'viewEvaluationProcess',params:[id:process.id]
        }
            
    }
    def saveEvaluateForm = {	
	
        def user = User.findByUsername( springSecurityService.principal.username)
        def process = SelfEvaluationProcess.get(params.processId)
        def riskInstance = RiskInstance.get(params.id.toLong())
        riskInstance.risk = Risk.get(params.risk.id)
        riskInstance.impact = Impact.get(params.impact.id)
        riskInstance.possibility= Possibility.get(params.possibility.id)
        riskInstance.controlEffect=ControlEffect.get(params.controlEffect.id)
        //riskInstance.control = params.control
        riskInstance.score = riskService.calculateScore(riskInstance)
        riskInstance.save(flush:true)
        redirect controller:'selfEvaluation',action:'viewEvaluationProcess',params:[id:process.id]

    }

    

    def evaluateForm = {        
        def user = User.findByUsername( springSecurityService.principal.username)
        def process = SelfEvaluationProcess.get(params.processId)
        def impacts = Impact.getAll()
        def possibilities = Possibility.getAll()
        def controlEffects = ControlEffect.getAll()                
        def currentInstance
        if (params.instanceId){
            currentInstance = RiskInstance.get(params.instanceId)
        }else
            currentInstance = process.riskInstances.first()
        //// println process.riskInstances.indexOf(process.riskInstances.first())
        if (params.saveInstance){            
            currentInstance.impact = Impact.get(params.getImpact)
            currentInstance.possibility = Possibility.get(params.getPossibility)
            currentInstance.controlEffect = ControlEffect.get(params.getControlEffect)
            currentInstance.score = riskService.calculateScore(currentInstance)
            currentInstance.control = params.control
            currentInstance.save(flush:true)
            if(currentInstance.hasErrors()) {
                currentInstance.errors.each {
                      // println it
                }
            }
            
            def nextInstance = RiskInstance.executeQuery('from RiskInstance r where r.id > ? and r.selfEvaluationProcess=? order by r.id',[params.instanceId.toLong(),process],[max:1])
            if (nextInstance.size()==1){
                currentInstance = nextInstance[0]
            }else{
                redirect controller:'selfEvaluation',action:'createAction',params:[processId:params.processId]
                
            }            
        }

       render view:'/selfEvaluation/evaluateForm',model:[user:user,process:process,currentInstance:currentInstance,impacts:impacts,possibilities:possibilities,controlEffects:controlEffects]

    }

    def createAction = {        
        def user = User.findByUsername( springSecurityService.principal.username)
        def process = SelfEvaluationProcess.get(params.processId)
        def pastRisks = process.riskInstances        
       
        render view:'/selfEvaluation/viewAction',model:[user:user,process:process,pastRisks:pastRisks]
    }

    def saveAction = {
        def action = Action.get(params.actionId)
        def processId = action.riskInstance.selfEvaluationProcess.id
        action.description=params.description
        action.status=params.status.toLong()
        action.executor=params.executor
        action.deadline=DateUtil.parseInputDate(params.deadline + ' 00:00:00')
        action.save(flush:true)
        redirect controller:'selfEvaluation',action:'createAction',params:[processId:processId]
    }

    def finishProcess = {
        def messageCode
        def riskAction		
		
        for(i in 0..params.list("actionId").size()-1){
			
            riskAction = Action.get(params.list("actionId")[i])
            riskAction.description = params.list("description")[i]
            riskAction.status = 10
            riskAction.executor = params.list("executor")[i]
            riskAction.deadline = DateUtil.parseInputDate(params.list("deadline")[i] + ' 00:00:00')
            riskAction.save(flush:true)
        }
        def process = SelfEvaluationProcess.get(params.processId)
        process.status=100
        process.save(flush:true)
        messageCode = 21
        redirect controller:'selfEvaluation',action:'createAction',params:[processId:process.id,messageCode:messageCode]
    }

//<<<<<<< .mine
//    def getControl = {
//        def risk = Risk.get(params.riskId.toLong())
//        // println risk
//        def control = risk.control
//        if (control)
//            render control
//        else render ''
//=======
    def getControl = {
        if(!params.id) {
			render ''
			return
		}
	def risk = Risk.get(params.id)
        def control = risk.control
        render control?:''
   }

   def getAction = {
       if(!params.id) {
			render ''
			return
		}
	def riskAction = Action.get(params.id)        
        def actionDetail = []
        actionDetail = [description:riskAction.description,executor:riskAction.executor,deadline:riskAction.deadline?DateUtil.formatDate(riskAction.deadline):'']        
        render actionDetail as JSON

   }


    def addRisk = {
        def process = SelfEvaluationProcess.get(params.processId)
        def department = Department.get(process.createdBy.prop1)
        def risklv1 = Risk.get(params.newRiskLevel1)
        //check lv2 risk
        def risklv2 = Risk.findByParentAndName(risklv1,"Others")
        if (risklv2 == null){
            risklv2 = new Risk(name:"Others",department:department,enabled:true,ord:1,parent:risklv1,process:process)
            risklv2.save(flush:true)
        }
        def risklv3 = new Risk(name:params.newRisk,department:department,enabled:true,ord:1,parent:risklv2,process:process)
        risklv3.save(flush:true)
        redirect controller:'selfEvaluation',action:'viewEvaluationProcess',params:[id:process.id]

    }    
  
}
