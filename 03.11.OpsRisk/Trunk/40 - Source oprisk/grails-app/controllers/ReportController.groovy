import grails.converters.JSON
import groovy.sql.Sql
import java.text.*;
import java.util.*;
import msb.platto.fingerprint.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import java.sql.Connection
import java.sql.DriverManager
import javax.sql.DataSource


class ReportController {

	def sqlDataSource
    def index = { }

    def getFinalResult(def result){
        def finalResult = []
        result.each{t->
            def flag =false
             for(e in finalResult){
                if (e.risk.name == t.risk.name && e.risk.id != t.risk.id){
                    ['A','B','C','D'].each {
                        e.scores.it = t.scores.it + e.scores.it
                    }
                    flag = true
                }
            }

            if (flag==false){
                finalResult << [risk:t.risk,scores:t.scores]
            }
        }
        return finalResult
    }

    def searchFunction(def search,def departmentId,def fromDate,def toDate){        
        def department
        def result = []
        if(search){
            if (departmentId){
                department = Department.get(departmentId)
            }
                fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')
                toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
        }else{
            
            def today = new Date()
            toDate = DateUtil.formatDate(today)
            toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
            today.setMonth(today.month-2)
            fromDate = DateUtil.formatDate(today)
            fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')
        }        
        result << department
        result << fromDate
        result << toDate
        return result
    }

    def riskReport = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users
        def process
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            users= User.findAllByProp1(department.id)
            departmentId = department.id
        }
        else
            users=User.list()
        def scores = [:]
        if(users){
            users.each{ user ->
                scores = [:]
                process = SelfEvaluationProcess.createCriteria().list{
                    eq('status',100)
                    between('dateCreated',fromDate,toDate)
                    eq('createdBy',user)
                }
                process.each{ p->
                    p.riskInstances.each{ rInstance ->
                        scores[rInstance.score] = scores[rInstance.score]!=null ?scores[rInstance.score]+1:1
                    }
                }
                if (process.size()>0){
                    result << [user:user,scores:scores]
                }
            }
        }
        render view:'/report/riskReport', model:[result:result,departments:departments,departmentId:departmentId]
    }

    def risklv1Report = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate,department,departmentId
        def users,process,riskInstances
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            departmentId = department.id
        }
        def risklv1 = Risk.createCriteria().list{
            ge('status',0)
                if (department)
                eq('department',department)
            eq('ord',0)            
        }        
        process = SelfEvaluationProcess.createCriteria().list{
            eq('status',100)
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }
        }
        risklv1.each{r->
            scores = [A:0,B:0,C:0,D:0]
            def risklv3 =[]
            r.children.each{child->
                child.children.each{
                    risklv3 << it
                }
            }
            riskInstances = RiskInstance.createCriteria().list{
                if(process.size()>0)
                    'in'('selfEvaluationProcess',process)
                if(risklv3.size()>0)
                    'in'('risk',risklv3)
            }
            riskInstances.each{ rInstance ->
                 scores[rInstance.score] = scores[rInstance.score]!=null ?scores[rInstance.score]+1:1
            }
            result << [risk:r,scores:scores]
        }               
        def finalResult = getFinalResult(result)

        render view:'/report/risklv1Report', model:[result:finalResult,departments:departments,departmentId:departmentId]


    }

    def risklv2Report = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users,process
        def riskInstances
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            departmentId = department.id
        }
        def risklv2 = Risk.createCriteria().list{
            ge('status',0)
                if (department)
                eq('department',department)
            eq('ord',1)
        }
        process = SelfEvaluationProcess.createCriteria().list{
            eq('status',100)
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }
        }
        risklv2.each{r->
            scores = [A:0,B:0,C:0,D:0]
            def risklv3 =[]
            r.children.each{
               risklv3 << it                
            }            
            riskInstances = RiskInstance.createCriteria().list{
                if(process.size()>0)
                    'in'('selfEvaluationProcess',process)
                if(risklv3.size()>0)
                    'in'('risk',risklv3)
            }
           
            riskInstances.each{ rInstance ->
                 scores[rInstance.score] = scores[rInstance.score]!=null ?scores[rInstance.score]+1:1
            }
            result << [risk:r,scores:scores]
        }
        def finalResult = getFinalResult(result)

        render view:'/report/risklv2Report', model:[result:finalResult,departments:departments,departmentId:departmentId]


    }

    def risklv3Report = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users,process
        def riskInstances
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            departmentId = department.id
        }
        def risklv3 = Risk.createCriteria().list{
            ge('status',0)
                if (department)
                eq('department',department)
            eq('ord',2)
        }
        process = SelfEvaluationProcess.createCriteria().list{
            eq('status',100)
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }
        }
        risklv3.each{r->
            scores = [A:0,B:0,C:0,D:0]

            riskInstances = RiskInstance.createCriteria().list{
                if(process.size()>0)
                    'in'('selfEvaluationProcess',process)
                eq('risk',r)
            }
            riskInstances.each{ rInstance ->
                 scores[rInstance.score] = scores[rInstance.score]!=null ?scores[rInstance.score]+1:1
            }
            result << [risk:r,scores:scores]
        }
        def finalResult = getFinalResult(result)

        render view:'/report/risklv3Report', model:[result:finalResult,departments:departments,departmentId:departmentId]



    }

    def instancesReport = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users,process,riskInstances
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            departmentId = department.id
        }
        process = SelfEvaluationProcess.createCriteria().list{
            eq('status',100)
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }
        }
        def instances = RiskInstance.createCriteria().list{
           order('id','desc')
           if(process.size()>0)
                    'in'('selfEvaluationProcess',process)
        }
   
        render view:'/report/instancesReport', model:[instances:instances,departments:departments,departmentId:departmentId]


    }

    def incidentReport = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users, process, incidents
        def riskInstances
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        if(department){
            users= User.findAllByProp1(department.id)
            departmentId = department.id
        }
        else{   
            users = UserRole.findAllByRole(Role.findByAuthority('ROLE_GDTT'))?.user            
        }
            
        def loss = 0
        def retrieval = 0
        def count = 0
        if(users){
            users.each{ user ->
                loss = retrieval = count = 0
                scores = [:]
                process = OpRiskProcess.createCriteria().list{
                    ge('status',0)
                    between('dateCreated',fromDate,toDate)
                    eq('employee',user)
                }
                incidents = Incident.createCriteria().list{
                    eq('createdBy',user)
                    between('dateIncident',fromDate,toDate)
                }
                process.each{ p->
                    p.incidents.each{ incident ->
                        loss = loss + (incident.financialLoss?incident.financialLoss.toLong():0)
                        retrieval = retrieval + (incident.retrieval?incident.retrieval.toLong():0)
                        count = count + 1
                    }
                }
                incidents.each{i->
                    loss = loss + (i.financialLoss?i.financialLoss.toLong():0)
                    retrieval = retrieval + (i.retrieval?i.retrieval.toLong():0)
                    count = count + 1
                }

                
                    result << [user:user,loss:loss,retrieval:retrieval,count:count]
               
            }
        }
        render view:'/report/incidentReport', model:[result:result,departments:departments,departmentId:departmentId]
    }

    def eventReport = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users,process,riskInstances,incidents
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        def events = Event.findAllByOrd('1')
        if(department){
            users= User.findAllByProp1(department.id)
            departmentId = department.id
        }
        else
            users=User.list()       
        def loss = 0
        def retrieval = 0
        def count = 0
        if(users.size()>0){
            process = OpRiskProcess.createCriteria().list{
                ge('status',0)
                between('dateCreated',fromDate,toDate)
                'in'('employee',users)
            }
            incidents = Incident.createCriteria().list{
                if(department){
                    'in'('createdBy',users)
                }else{
                    or{
                        'in'('createdBy',users)
                        isNull('createdBy')
                    }
                }
                between('dateIncident',fromDate,toDate)


            }            
        }
        events.each{ e ->
                loss = retrieval = count = 0
                scores = [:]     
                process.each{ p->
                    p.incidents.each{ incident ->
                        if (incident.event?.id == e.id){
                            loss = loss + (incident.financialLoss?incident.financialLoss.toLong():0)
                            retrieval = retrieval + (incident.retrieval?incident.retrieval.toLong():0)
                            count = count + 1
                        }
                    }
                }
                incidents.each{i->
                    if (i.event?.id == e.id){
                        loss = loss + (i.financialLoss?i.financialLoss.toLong():0)
                        retrieval = retrieval + (i.retrieval?i.retrieval.toLong():0)
                        count = count + 1                        
                    }
                }

                    result << [event:e,loss:loss,retrieval:retrieval,count:count]
            }        
       
        render view:'/report/eventReport', model:[result:result,departments:departments,departmentId:departmentId]

    }

    def causeReport = {
        def result= []
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department,departmentId
        def users, process, riskInstances,incidents
        def scores = [:]
        def searchResult = searchFunction(params.search,params.department,params.fromDate,params.toDate)
        department = searchResult[0]
        fromDate = searchResult[1]
        toDate = searchResult[2]
        def causes = Cause.findAllByOrd('1')
        if(department){
            users= User.findAllByProp1(department.id)
            departmentId = department.id
        }
        else
            users=User.list()

        def loss = 0
        def retrieval = 0
        def count = 0

        if(users.size()>0){
            process = OpRiskProcess.createCriteria().list{
                ge('status',0)
                between('dateCreated',fromDate,toDate)
                'in'('employee',users)
            }
            incidents = Incident.createCriteria().list{
                if(department){
                    'in'('createdBy',users)
                }else{
                    or{
                        'in'('createdBy',users)
                        isNull('createdBy')
                    }
                }
                between('dateIncident',fromDate,toDate)
            }
        }
        causes.each{ e ->
                loss = retrieval = count = 0
                scores = [:]                
                process.each{ p->
                    p.incidents.each{ incident ->
                        if (incident.reason?.id == e.id){                            
                            loss = loss + (incident.financialLoss?incident.financialLoss.toLong():0)
                            retrieval = retrieval + (incident.retrieval?incident.retrieval.toLong():0)
                            count = count + 1
                        }
                    }
                }
                incidents.each{i->
                    if (i.reason?.id == e.id){                        
                        loss = loss + (i.financialLoss?i.financialLoss.toLong():0)                        
                        retrieval = retrieval + (i.retrieval?i.retrieval.toLong():0)
                        count = count + 1
                    }
                }

                    result << [cause:e,loss:loss,retrieval:retrieval,count:count]

            }

        render view:'/report/causeReport', model:[result:result,departments:departments,departmentId:departmentId]

    }
	
	//Bao cao nguoi gay loi
	def reportErrorUserCreate={
		def fromDate,toDate
		
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-2);
			toDate=new Date();
		}
		
		
		def errorUser= ErrorUserCreate.withCriteria(){
			
			if(params.nguoigayloi!='')
			{
				eq("userEmail",params.nguoigayloi)
			}
		}
		
		def errorManagement = ErrorManagement.createCriteria().listDistinct{
			errorUserCreate{
				if(errorUser.size()>0){
					'in'('id',errorUser.id)
				}else{
					eq('id','-1'.toLong())
				}
			}
			if(params.LoiCap1!='')
				eq('loiCap1',params.LoiCap1)
			
			if(params.LoiCap2!='')
				eq('loiCap2',params.LoiCap2)
			if(params.trangthai!='')
				eq('trangThai',params.trangthai)
			if(params.unitDepart!='')
				eq('tenDonVi', params.unitDepart)
			
			between('thoiGianNhapVaoHeThong',fromDate,toDate)
				
		}
		
		
		def unitDepart=UnitDepart.getAll()
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		render view:'/opRisk/errorReportUserCreate', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1]
	}
	def reportErrorLevel={
		def fromDate,toDate
		
		if(params.fromDate!=null)
		{
			fromDate = DateUtil.parseInputDate(params.fromDate+ ' 00:00:00')
			toDate = DateUtil.parseInputDate(params.toDate+ ' 23:59:59')
		}
		else
		{
			fromDate = new Date();
			fromDate.setMonth(fromDate.month-2);
			toDate=new Date();
			
		}
		
		def db = new Sql(dataSource)
		String strSQL="SELECT Loi_cap1,Loi_cap2,COUNT(*) FROM error_management WHERE thoi_gian_nhap_vao_he_thong BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'   "
		
		if(params.nguoigayloi!='' )
		{
			strSQL="SELECT DISTINCT error_management.`loi_cap1`,error_management.`loi_cap2` , COUNT('loi_cap2') FROM error_user_create INNER JOIN error_management ON error_management.`id`=error_user_create.error_management_id "
			strSQL= strSQL+ " WHERE thoi_gian_nhap_vao_he_thong BETWEEN '"+fromDate.format('yyyy-MM-dd')+"' AND '"+toDate.format('yyyy-MM-dd')+" 23:59:00'  and error_user_create.`user_email`='"+params.nguoigayloi+"'"
		}
		// println params
		if(params.unitDepart!='')
			strSQL =strSQL + " and unit_depart_id ="+ params.unitDepart
		if(params.trangthai!='')
			strSQL =strSQL + " and trang_thai ='"+ params.trangthai+"'"
		if(params.LoiCap1!='')
			strSQL = strSQL +" and loi_cap1="+ params.LoiCap1
		
		if(params.LoiCap2!='')
			strSQL = strSQL +" and loi_cap2="+ params.LoiCap2
		
			
		strSQL =strSQL + " GROUP BY Loi_cap2 "
		
		// println "SQL:"+strSQL
		def errorManagement = db.rows(strSQL)
		
		
			

		
		
		def unitDepart=UnitDepart.getAll()
		def errorlist1=ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		render view:'/opRisk/errorReportLevel', model:[errorManagement:errorManagement,unitDepart:unitDepart,errorlist1:errorlist1]
	}
	
	

}
