import grails.converters.JSON
import groovy.sql.Sql
import java.text.*;
import msb.platto.fingerprint.*

import org.apache.poi.hssf.record.formula.ErrPtg;
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class AdminController {
    def riskService
    def springSecurityService
    Role role
	Boolean Enable,Disable
	def index = {
		redirect action:'viewDepartment'
	}

    //****Department Management******
    def viewDepartment = {        
        def nodes = Department.executeQuery(' from Department d where d.status >=0 order by d.id ')
        render view:'/admin/viewDepartment',model:[nodes:nodes]
    }   
    def getDepartmentTree = {        
            //def vt = Department.findByName('MSB')
            def lv1 = []
            def tree = []
            //if (!vt){
            //        return null
            //}
            def lv1nodes = Department.findAllByStatusGreaterThanEquals(0)
            def lv2nodes, lv3nodes
            lv1nodes.each{lv1node->                   
                    lv1 << [data:lv1node.name,attr:['code':lv1node.code,'id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
            }

            tree = [data:'MSB',children:lv1,attr:['id':'m-oprisk-tree-root']]
            render tree as JSON
    }
    def addDepartment = {
            if (params.nodeId){
                    redirect controller:'admin',action:'editDepartment',params:params
                    return
            }
            Department node = new Department()            
            if(Department.findByName(params.name.trim())){
                flash.message="Tên loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn tên loại nghiệp vụ khác."
            }else if(Department.findByCode(params.code)){
                flash.message="Mã loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn mã loại nghiệp vụ khác."
            }
            else{
                node.name = params.name.trim()
                node.code = params.code
                node.save(true)
                riskService.importRisk(node)
                flash.message="Cập nhật thành công."
            }
            redirect controller:'admin',action:'viewDepartment'
    }
     def editDepartment = {
            Department node = Department.get(params.nodeId.toLong()) 
            
            if(Department.findByNameAndIdNotEqual(params.name.trim(),params.nodeId)){
                flash.message="Tên loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn tên loại nghiệp vụ khác."
            }
            else if(Department.findByCodeAndIdNotEqual(params.code,params.nodeId)){
                flash.message="Mã loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn mã loại nghiệp vụ khác."

            }else{
                node.name = params.name.trim()
                node.code = params.code
                node.save(flush:true)
                flash.message="Cập nhật thành công."
            }

            redirect controller:'admin',action:'viewDepartment'
    }

    def deleteDepartment = {
            Department node = Department.get(params.id.toLong())                     
            node.status = -1 
			node.code = 'deleted'
            node.save(flush:true)
            flash.message="Xóa thành công."
            redirect controller:'admin',action:'viewDepartment'
    }
    def getDepartment = {
		def result = [:]
		def department = Department.get(params.id)
		result << [department:department]
		render result as JSON
    }
//    def getChildNodes = {
//            String source = params.id
//            int ord = Integer.parseInt(params.id.substring(params.id.length()-1))
//            TreeNode node = TreeNode.findByNameAndOrd(params[source],ord)
//            def childNodes = TreeNode.executeQuery(' from TreeNode t where t.parent = ? ', node)
//            String htmlRes = '<option></option>' + "\n"
//            childNodes.each{n->
//                    htmlRes += '<option value="' + n.name + '">' + n.name + '</option>' + "\n"
//            }
//            render htmlRes
//    }

      //*****Risk Management********
   
    def viewRisk = {
        def department
        def nodes
        def departments = Department.findAllByStatusGreaterThanEquals(0)
        if (params.departmentId){
            department = Department.get(params.departmentId)
            nodes = Risk.executeQuery(' from Risk r where r.status >=0 and r.department=? and r.process is null order by r.id',department)
        }
        render view:'/admin/viewRisk',model:[nodes:nodes,departments:departments,d:department]
    }

    def getRiskTree = {
            def department = Department.get(params.departmentId)
            def lv1 = []
            def tree = []

            def lv1nodes = Risk.executeQuery(' from Risk r where r.ord=0 and r.status >=0 and r.department=?',department)
            def lv2nodes, lv3nodes
            lv1nodes.each{lv1node->
                    def lv2 = []
                    lv2nodes = Risk.executeQuery(' from Risk r where r.parent = ? and r.status >=0 and r.process is null',lv1node)
                    lv2nodes.each{lv2node->
                            def lv3 = []
                            lv3nodes = Risk.executeQuery(' from Risk r where r.parent = ? and r.status >=0 and r.process is null',lv2node)
                            lv3nodes.each{lv3node->
                                    lv3 << [data:lv3node.name,attr:['control':lv3node.control,'id':'m-oprisk-tree-node-'+lv3node.id,class:'m-melanin-hierarchu-tree-lv3']]
                            }
                            lv2 << [data:lv2node.name,children:lv3,attr:['id':'m-oprisk-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2']]
                    }
                    lv1 << [data:lv1node.name,children:lv2,attr:['id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
            }

            tree = [data:'Rủi ro',children:lv1,attr:['id':'m-oprisk-tree-root']]
            render tree as JSON
    }

    def addRisk = {       
           if (params.nodeId){
                    redirect controller:'admin',action:'editRisk',params:params
                    return
           }
           def department = Department.get(params.departmentId)
           Risk node = new Risk()
           node.name = params.name
           node.department = department
            if (params.parentlv2){
                    node.parent = Risk.get(params.parentlv2.toLong())
                    node.ord=2
                    node.control=params.control

            }else if (params.parentlv1){
                node.parent = Risk.get(params.parentlv1.toLong())
                node.ord=1
            }else{
                node.ord=0
            }
            node.save(true)
            flash.message="Cập nhật thành công."
            redirect (controller:'admin',action:'viewRisk',params:[departmentId:department.id])
    }

    def editRisk = {
            Risk node = Risk.get(params.nodeId.toLong())
            node.name = params.name
            node.control = params.control
            if (params.parentlv2){
                    node.parent = Risk.get(params.parentlv2.toLong())
            } else  if (params.parentlv1){
                    node.parent = Risk.get(params.parentlv1.toLong())                    
            }
            node.save(flush:true)
            flash.message="Cập nhật thành công."
            redirect (controller:'admin',action:'viewRisk',params:[departmentId:node.department.id])
    }

    def deleteRisk = {
            Risk node = Risk.get(params.id.toLong())
            def departmentId = node.department.id
            def childrenNodes = Risk.executeQuery(' from Risk r where r.parent = ? ',node)
            def childrenNodesL3
            childrenNodes.each{child->
                    childrenNodesL3 = Risk.executeQuery(' from Risk r where r.parent = ? ',child)
                    childrenNodesL3.each{
                            it.status = -1
                            it.save(flush:true)
                    }
                    child.status = -1
                    child.save(flush:true)
            }
            node.status = -1
            node.save(flush:true)
            flash.message="Xóa thành công."
            redirect (controller:'admin',action:'viewRisk',params:[departmentId:departmentId])
    }

    def getChildRisks = {        
            def parent,children,risk
            if (params.id)
                 parent = Risk.get(params.id)
            else
                parent = Risk.get(params.parentlv1)
                
            if(params.parentlv2)
                risk = Risk.get(params.parentlv2)
            
            children = Risk.createCriteria().list{
                eq('parent',parent)
                ge('status',0)
            }
            
            String htmlRes = '<option></option>' + "\n"
            children.each{n->
                if (risk?.id == n.id)
                    htmlRes += '<option value="' + n.id + '" selected>' + n.name + '</option>' + "\n"
                else
                    htmlRes += '<option value="' + n.id + '">' + n.name + '</option>' + "\n"
            }
            
            render htmlRes
    }      


    //*****Cause Management********

    def viewCause = {
        def nodes
        nodes = Cause.executeQuery(' from Cause c where c.ord=0 and c.status >=0 order by c.id')

        render view:'/admin/viewCause',model:[nodes:nodes]
    }
	
	def viewError = {
		def nodes		
		nodes = ErrorList.executeQuery(' from ErrorList e where e.ord=0 and e.status >=0 order by e.id')
		
		render view:'/admin/viewError',model:[nodes:nodes]
	}

    def getCauseTree = {
            def lv1 = []
            def tree = []

            def lv1nodes = Cause.executeQuery(' from Cause c where c.ord=0 ')
            def lv2nodes, lv3nodes
            lv1nodes.each{lv1node->
                    def lv2 = []
                    lv2nodes = Cause.executeQuery(' from Cause c where c.parent = ? ',lv1node)
                    lv2nodes.each{lv2node->
                                    lv2 << [data:lv2node.name,attr:['id':'m-oprisk-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2']]
                            }
                    lv1 << [data:lv1node.name,children:lv2,attr:['id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
            }

            tree = [data:'Nguyên nhân',children:lv1,attr:['id':'m-oprisk-tree-root']]
            render tree as JSON
    }
	
	def getErrorTree = {
		def lv1 = []
		def tree = []

		def lv1nodes = ErrorList.executeQuery(' from ErrorList c where c.ord=0 ')
		def lv2nodes, lv3nodes
		lv1nodes.each{lv1node->
				def lv2 = []
				lv2nodes = Cause.executeQuery(' from ErrorList c where c.parent = ? ',lv1node)
				lv2nodes.each{lv2node->
								lv2 << [data:lv2node.name,attr:['id':'m-oprisk-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2']]
						}
				lv1 << [data:lv1node.name,children:lv2,attr:['id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
		}

		tree = [data:'Loại lỗi',children:lv1,attr:['id':'m-oprisk-tree-root']]
		render tree as JSON
}

	def addError = {
		if (params.nodeId){
				redirect controller:'admin',action:'editError',params:params
				return
		}

	   ErrorList node = new ErrorList()
	   node.name = params.name

		if (params.parent){
			node.parent = ErrorList.get(params.parent.toLong())
			node.ord=1
		}else{
			node.ord=0
		}
		node.save(true)
		 flash.message="Cập nhật thành công."
		redirect controller:'admin',action:'viewError'
}
	
    def addCause = {
            if (params.nodeId){
                    redirect controller:'admin',action:'editCause',params:params
                    return
            }

           Cause node = new Cause()
           node.name = params.name

            if (params.parent){
                node.parent = Cause.get(params.parent.toLong())
                node.ord=1
            }else{
                node.ord=0
            }
            node.save(true)
             flash.message="Cập nhật thành công"
            redirect controller:'admin',action:'viewCause'
    }

    def editCause = {
            Cause node = Cause.get(params.nodeId.toLong())
            node.name = params.name
            if (params.parent){
                    node.parent = Cause.get(params.parent.toLong())
            }            
            node.save(flush:true)
             flash.message="Cập nhật thành công."
            redirect controller:'admin',action:'viewCause'
    }
	
	def editError = {
		ErrorList node = ErrorList.get(params.nodeId.toLong())
		node.name = params.name
		if (params.parent){
				node.parent = ErrorList.get(params.parent.toLong())
		}
		node.save(flush:true)
		 flash.message="Cập nhật thành công."
		redirect controller:'admin',action:'viewError'
}
	def deleteError = {
		ErrorList node = ErrorList.get(params.id.toLong())		
		ErrorManagement errorManagements = ErrorManagement.createCriteria().list{
			or{
				eq('loiCap1',params.id)
				eq('loiCap2',params.id)
			}
		}
		if (errorManagements.size()>0){
			flash.message="Xóa không thành công. Tồn tại lỗi gắn với loại lỗi này"
			redirect controller:'admin',action:'viewError'
		}else{
			def childrenNodes = ErrorList.executeQuery(' from ErrorList r where r.parent = ? ',node)
			def childrenNodesL3
			childrenNodes.each{child->
					childrenNodesL3 = Cause.executeQuery(' from ErrorList r where r.parent = ? ',child)
					childrenNodesL3.each{
							it.delete(flush:true)
					}
					child.delete(flush:true)
			}
			node.delete(flush:true)
			flash.message="Xóa thành công."
			redirect controller:'admin',action:'viewError'
		}
}

    def deleteCause = {
            Cause node = Cause.get(params.id.toLong())
            def childrenNodes = Cause.executeQuery(' from Cause r where r.parent = ? ',node)
            def childrenNodesL3
            childrenNodes.each{child->
                    childrenNodesL3 = Cause.executeQuery(' from Cause r where r.parent = ? ',child)
                    childrenNodesL3.each{
                            it.delete(flush:true)
                    }
                    child.delete(flush:true)
            }
            node.delete(flush:true)
            flash.message="Xóa thành công."
            redirect controller:'admin',action:'viewCause'
    }

//    def getChildCauses = {
//            String source = params.id
//            int ord = Integer.parseInt(params.id.substring(params.id.length()-1))
//            Risk node = Risk.findByNameAndOrd(params[source],ord)
//            def childNodes = Risk.executeQuery(' from Risk r where r.parent = ? ', node)
//            String htmlRes = '<option></option>' + "\n"
//            childNodes.each{n->
//                    htmlRes += '<option value="' + n.id + '">' + n.name + '</option>' + "\n"
//            }
//            render htmlRes
//    }

    //*****Event Management********

    def viewEvent = {
        def nodes
        nodes = Event.executeQuery(' from Event e where e.ord=0 and e.status >=0 order by e.id')

        render view:'/admin/viewEvent',model:[nodes:nodes]
    }

    def getEventTree = {
            def lv1 = []
            def tree = []

            def lv1nodes = Event.executeQuery(' from Event e where e.ord=0 ')
            def lv2nodes
            lv1nodes.each{lv1node->
                    def lv2 = []
                    lv2nodes = Event.executeQuery(' from Event e where e.parent = ? ',lv1node)
                    lv2nodes.each{lv2node->
                                    lv2 << [data:lv2node.name,attr:['id':'m-oprisk-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2']]
                            }
                    lv1 << [data:lv1node.name,children:lv2,attr:['id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
            }

            tree = [data:'Sự kiện',children:lv1,attr:['id':'m-oprisk-tree-root']]
            render tree as JSON
    }

    def addEvent = {
            if (params.nodeId){
                    redirect controller:'admin',action:'editEvent',params:params
                    return
            }
            Event node = new Event()
            node.name = params.name

            if (params.parent){
                node.parent = Event.get(params.parent.toLong())
                node.ord=1
            }else{
                node.ord=0
            }
            node.save(true)
             flash.message="Cập nhật thành công."
            redirect controller:'admin',action:'viewEvent'
    }

    def editEvent = {
            Event node = Event.get(params.nodeId.toLong())
            node.name = params.name
            if (params.parent){
                    node.parent = Event.get(params.parent.toLong())
            }
            node.save(flush:true)
             flash.message="Cập nhật thành công."
            redirect controller:'admin',action:'viewEvent'
    }

    def deleteEvent = {
            Event node = Event.get(params.id.toLong())
            def childrenNodes = Event.executeQuery(' from Event r where r.parent = ? ',node)
            def childrenNodesL3
            childrenNodes.each{child->
                    childrenNodesL3 = Event.executeQuery(' from Event r where r.parent = ? ',child)
                    childrenNodesL3.each{
                            it.delete(flush:true)
                    }
                    child.delete(flush:true)
            }
            node.delete(flush:true)
             flash.message="Xóa thành công."
            redirect controller:'admin',action:'viewEvent'
    }

//    def getChildEvents = {
//            String source = params.id
//            int ord = Integer.parseInt(params.id.substring(params.id.length()-1))
//            Risk node = Risk.findByNameAndOrd(params[source],ord)
//            def childNodes = Risk.executeQuery(' from Risk r where r.parent = ? ', node)
//            String htmlRes = '<option></option>' + "\n"
//            childNodes.each{n->
//                    htmlRes += '<option value="' + n.name + '">' + n.name + '</option>' + "\n"
//            }
//            render htmlRes
//    }


    //***** Impact Management *******
    def viewImpact = {        
        def impacts = Impact.getAll()        
        if (params.impactId){
            def impact = Impact.get(params.impactId)
            if (params.save){
                if(params.description.trim()==''){
                     flash.message="Lỗi: Dữ liệu không hợp lệ"
                }else{
                    impact.description = params.description
                    impact.save(flush:true)
                     flash.message="Cập nhật thành công."
                }
               
            }
        }
        render view:'/admin/viewImpact',model:[impacts:impacts]
    }


    //***** Possibility Management *****
    def viewPossibility = {
        def possibilities = Possibility.getAll()
        if (params.possibilityId){
            def possibility = Possibility.get(params.possibilityId)
            if (params.save){
                if(params.description.trim()==''){
                    flash.message="Lỗi: Dữ liệu không hợp lệ"
                }else{
                    possibility.description = params.description
                    possibility.save(flush:true)
                      flash.message="Cập nhật thành công."
                }
            }
        }
        render view:'/admin/viewPossibility',model:[possibilities:possibilities]

    }


    //***** ControlEffect Management *****
    def viewControlEffect = {        
        def controlEffects = ControlEffect.getAll()
        if (params.controlEffectId){
            def controlEffect = ControlEffect.get(params.controlEffectId)
            if (params.save){                
                if(params.description.trim()==''){
                     flash.message="Lỗi: Dữ liệu không hợp lệ"
                }else{
                    controlEffect.description = params.description
                    controlEffect.save(flush:true)
                     flash.message="Cập nhật thành công."
                }
            }
        }
        render view:'/admin/viewControlEffect',model:[controlEffects:controlEffects]


    }
    




   //******* Self-evaluation Management ********
   def evaluationManagement ={       
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate
        def toDate
        def department
        def departmentId
        def users
        def process
        if (params.search){
            if (params.department){
                department = Department.get(params.department)
                departmentId = department.id
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
        process = SelfEvaluationProcess.createCriteria().list{            
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }
            order("id", "desc")
        }        

        render view:'/admin/evaluationManagement', model:[process:process,departments:departments,departmentId:departmentId]

   }

   def processDetail = {
       def process = SelfEvaluationProcess.get(params.id)       
       def user = process.createdBy
       def messageCode
       def instances = process.riskInstances
       if (params.save){
           user.fullname=params.empName
           user.prop2=params.branch
		   process.branchName = params.branch
           user.save(flush:true)
           messageCode = 9
       }
       if (params.deny){
           process.status = 0
           process.save(flush:true)
           messageCode = 5
       }
       if (params.delete){
           //delete actions
           process.riskInstances.each{
               it.riskAction.delete()
           }

           def risks = Risk.findAllByProcess(process)
           if (risks.size() > 0){
               risks.each{                   
                    it.delete()
               }
           }
           process.delete(flush:true)
           redirect action:'evaluationManagement'
       }
       
       render view:'/admin/processDetail', model:[process:process,user:user,instances:instances,messageCode:messageCode]

   }

   def overallReport = {
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        def fromDate,toDate
        def department, departmentId
        def users, process
        if (params.search){
            if (params.department){
                department = Department.get(params.department)
                departmentId = department.id
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
        process = SelfEvaluationProcess.createCriteria().list{
            between('dateCreated',fromDate,toDate)
            if (department){
                users = User.findAllByProp1(department.id)
                if (users.size()>0)
                    'in'('createdBy',users)
                else
                    eq('status',-100)
            }            
        }
        
        def instances
        if (process.size()>0){
            instances = RiskInstance.createCriteria().list{
                'in'('selfEvaluationProcess',process)
                order("id", "desc")
            }
        }
        render view:'/admin/overallReport', model:[process:process,instances:instances,departments:departments,departmentId:departmentId]

   }

   def riskManagement={
       def departments = Department.findAllByStatusGreaterThanEquals('0')
       def department, departmentId
       def risklv1, risklv2
       if(params.departmentId){
           department = Department.get(params.departmentId)           
       }else{
           department = departments[0]
       }
       departmentId = department.id
       risklv1 = Risk.createCriteria().list{
           eq('department',department)
           eq('enabled',true)
           ge('status',0)
           eq('ord',0)
       }
       def risklv3 = []
       risklv1.each{ l1 ->
                    l1.children.each{ l2 ->
                            l2.children.each{ l3 ->
                                    if(l3.process == null &&l3.status>=0 && l3.enabled==true){
                                            risklv3 << l3
                                    }
                            }
                    }
            }
         
       render view:'/admin/riskManagement', model:[risklv3:risklv3,risklv1:risklv1,departments:departments,departmentId:departmentId,department:department]
        
   }
   def deleteRiskManagement = {      
       def risk = Risk.get(params.id)
       risk.enabled = false
       risk.save(flush:true)
       redirect controller:'admin',action:'riskManagement',params:[departmentId:params.departmentId]
   }

    def getChildRiskManagement = {

        def parent,children
        if (params.id =='1'){
            parent = Risk.get(params.risklv1)
            children = Risk.createCriteria().list{
                eq('parent',parent)
                ge('status',0)
            }
        }else if (params.id =='2'){
            parent = Risk.get(params.risklv2)
            children = Risk.createCriteria().list{
                eq('parent',parent)
                ge('status',0)
                eq('enabled',false)
            }
        }

        String htmlRes = '<option selected="selected" value="">--Vui lòng chọn--</option>' + "\n"
        children.each{r->
                htmlRes += '<option value="' + r.id + '">' + r.name + '</option>' + "\n"
        }
        render htmlRes
    }
    def addRiskManagement = {
       def risk = Risk.get(params.risklv3)
       risk.enabled = true
       risk.save(flush:true)
       redirect controller:'admin',action:'riskManagement',params:[departmentId:risk.department.id]
    }

    def userManagement = {
        def users,departmentId,department
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        if(params.search && params.department){
            department = Department.get(params.department)
            users= User.findAllByProp1(department.id)
            departmentId = department.id
            
        }else{
            //users = UserRole.findAllByRole(Role.findByAuthority('ROLE_GDTT'))?.user
			users = User.getAll()
        }
        render view:'/admin/userManagement', model:[users:users,departmentId:departmentId,departments:departments]
    }
	
	
	
	//****Unit Department Management******
	def viewUnitDepartment = {
		def nodes = UnitDepart.executeQuery(' from UnitDepart d where d.status >=0 order by d.id ')
		render view:'/admin/viewUnitDepartment',model:[nodes:nodes]
	}
	def getUnitDepartmentTree = {
			//def vt = Department.findByName('MSB')
			def lv1 = []
			def tree = []
			//if (!vt){
			//        return null
			//}
			def lv1nodes = UnitDepart.findAllByStatusGreaterThanEquals(0)
			def lv2nodes, lv3nodes
			lv1nodes.each{lv1node->
					lv1 << [data:lv1node.name,attr:['code':lv1node.code,'id':'m-oprisk-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1']]
			}

			tree = [data:'MSB',children:lv1,attr:['id':'m-oprisk-tree-root']]
			render tree as JSON
	}
	def addUnitDepartment = {
			if (params.nodeId){
					redirect controller:'admin',action:'editUnitDepartment',params:params
					return
			}
			UnitDepart node = new UnitDepart()
			if(UnitDepart.findByName(params.name.trim())){
				flash.message="Tên loại nghiệp vụ này đã tồi tại. Xin vui lòng chọn tên loại nghiệp vụ khác."
			}else if(UnitDepart.findByCode(params.code)){
				flash.message="Mã loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn mã loại nghiệp vụ khác."
			}
			else{
				node.name = params.name.trim()
				node.code = params.code
				node.save(true)
				//riskService.importRisk(node)
				flash.message="Cập nhật thành công."
			}
			redirect controller:'admin',action:'viewUnitDepartment'
	}
	def editUnitDepartment = {
			UnitDepart node = UnitDepart.get(params.nodeId.toLong())
			
			if(UnitDepart.findByNameAndIdNotEqual(params.name.trim(),params.nodeId)){
				flash.message="Tên loại nghiệp vụ này đã tồi tại. Xin vui lòng chọn tên loại nghiệp vụ khác."
			}
			else if(UnitDepart.findByCodeAndIdNotEqual(params.code,params.nodeId)){
				flash.message="Mã loại nghiệp vụ này đã tồn tại. Xin vui lòng chọn mã loại nghiệp vụ khác."

			}else{
				node.name = params.name.trim()
				node.code = params.code
				node.save(flush:true)
				flash.message="Cập nhật thành công."
			}

			redirect controller:'admin',action:'viewUnitDepartment'
	}

	def deleteUnitDepartment = {
			UnitDepart node = UnitDepart.get(params.id.toLong())
			node.status = -1
			node.name=""
			node.code=0
			node.save(flush:true)
			flash.message="Xóa thành công."
			redirect controller:'admin',action:'viewUnitDepartment'
	}
	def getUnitDepartment = {
		def result = [:]
		def unitDepart = UnitDepart.get(params.id)
		result << [department:unitDepart]
		render result as JSON
	}
	
	def errorCheckList = {		
		def errorCheck = ErrorCheck.executeQuery('from ErrorCheck e where status>=0 order by e.code+0')
		render view:'errorCheck', model:[errorCheck:errorCheck]		
	}
	def viewErrorCheckInsert = {
		render view:'insertErrorCheck'		
	}
	
	def saveCheck = {
		def insertcheck = new ErrorCheck()
		insertcheck.name = params.checkName
		insertcheck.code = params.checkCode
		insertcheck.status = 1
		insertcheck.save(flush:true)	
		redirect (controller:'admin',action:'errorCheckList')	
	}
	def viewErrorCheckUpdate = {
//		println "Paramas:"+ params.id
		def errorCheck=ErrorCheck.get(params.id)
		
//		println "errorCheck:"+ errorCheck
		
		render view:'updateErrorCheck', model:[errorCheck:errorCheck]
	}
	
	def errorCheckUpdateDelete = {		
		if(params.deleteError=="delete")
		{
			//Xoa
//			println "1111111"
			def errorCheck = ErrorCheck.findById(params.errorCheckId)
			errorCheck.status = -1
			
		}
		else
		{
			//Update
			def errorCheck = ErrorCheck.findById(params.errorCheckId)
			errorCheck.name = params.checkName
			errorCheck.code = params.checkCode
		}
		redirect (controller:'admin',action:'errorCheckList')
		
	}
	def errorCategory ={
		def errorCate = ErrorCategory.executeQuery('from ErrorCategory e where status>=0 order by e.code+0')
		render view:'viewErrorCategory',model:[errorCate:errorCate]			
	}
		
	def SaveCategory={
		
		if(params.buttonNew=="saveCategory"){		
			def errorCate = new ErrorCategory()		
			errorCate.name = params.CategoryName
			errorCate.code = params.CategoryCode
			errorCate.status = 1
			errorCate.save(flush:true)
		}
		else{
//			println "params:>>"+ params
			if(params.deleteCategory=="Xoa"){
//				println"params.buttonDelete: "+params.deleteCategory
				def errorCate = ErrorCategory.findById(params.idCategory)
				errorCate.status = -1
			}
			else{

				def errorCate = ErrorCategory.findById(params.idCategory)
				errorCate.name = params.ChangeCategoryName
				errorCate.code = params.ChangeCategoryCode
				
			}
			
		}
		redirect(controller:'admin',action:'errorCategory')
	}
	
	//	def viewUpdateCategory={
	
//		def errorCate=ErrorCategory.get(params.id)
//		def check=1
//		render view:'insertErrorCategory',model:[errorCate:errorCate,check:check]
//	}
	
	def errorStatus={
		def status = ErrorStatus.executeQuery('from ErrorStatus e where status>=0 order by e.code+0')
		render view:'viewErrorStatus',model:[status:status]
	}
	def changeStatus={
		if(params.newStatus == "new"){
			render view:"insertErrorStatus",model:[Change:params.Change]
		}
		else{
			def status = ErrorStatus.get(params.id)
			def check=1
			render view:'insertErrorStatus',model:[status:status,check:check]
		}
	}	
	def saveStatus={
		if(params.buttonNew=="SaveStatus"){			
			def status = new ErrorStatus()
				status.nameStatus = params.StatusName
				status.code = params.StatusCode
				status.status = 1
				status.save(flush:true)
		}
		else{
	
			if(params.deleleStatus=="Xoa"){
				def errorManagement = ErrorManagement.findAll()
				 
				def deleteStatus = ErrorStatus.findById(params.idStatus)
				deleteStatus.status = -1
  
			}else{
				def editStatus = ErrorStatus.findById(params.idStatus)
				editStatus.nameStatus = params.ChangeNameStatus
				editStatus.code = params.ChangeCodeStatus
			}			
		}
		redirect (controller:'admin',action:'errorStatus')
	}
	def viewSelectSendEmail={
		 
		if(ErrorMail.findByCode('Check').enableSendEmail=='Y'){
			Enable = true
			Disable =false
		}else{
			Enable = false
			Disable =true
		}
		
		def restrictEmail=ErrorRestrictEmail.getAll()
		
		
		render view:'viewSendEmail',model:[restrictEmail:restrictEmail,iEnable:Enable,iDisable:Disable]
	}
	def addRestricEmail={
		
//		println params
		def restricEmail=new ErrorRestrictEmail()
		restricEmail.userEmail=params.AddNewEmail
		restricEmail.save(flush:true);
		
		flash.message="Thêm mới thành công"		
		redirect(action:'viewSelectSendEmail')
	}
	
	def getOutlookById={		
		def restricEmail=ErrorRestrictEmail.get(params.outLookId);
		def result=""
		if(restricEmail!=null)
			if(restricEmail.userEmail!=null)
				result= restricEmail.userEmail
		
		render result
	}
	
	def updateRestricEmail={
//		println params;
		if(params.currAction=="Delete")
		{
			def restricEmail=ErrorRestrictEmail.get(params.outLookId)
			restricEmail.delete(flush:true)
			
		}
		else
		{
			def restricEmail=ErrorRestrictEmail.get(params.outLookId)
			restricEmail.userEmail=params.editOutLook
			restricEmail.save(flush:true)
		}
		
		redirect(action:'viewSelectSendEmail')
	}
	
	
	def checkSendEmail={
//		println params
		def errormail = ErrorMail.findByCode('Check')
		
		if(params.check=='1'){
			errormail.enableSendEmail='Y'
		 
		}
		if(params.check=='2'){
			
			errormail.enableSendEmail='N'
		 
		}
		errormail.save(flush:true)
		flash.message = "Anh/chị đã thay đổi thành công."
		redirect(controller:'admin',action:'viewSelectSendEmail')
 
	}
	
	//Quan ly linh vưc kinh doanh
	
	def listBusinessField = {
		def allFields = BusinessField.findAllByStatusGreaterThanEquals(0)
		
		render view:'listBusinessField',model:[allFields:allFields]
	}
	
	def detailBusinessField = {
		def businessField
		if (params.businessFieldId)
			businessField = BusinessField.get(params.businessFieldId)
			
		render view:'detailBusinessField',model:[businessField:businessField]
	}
	
	def saveBusinessField = {		
		def businessField
		if (params.businessFieldId)
			businessField = BusinessField.get(params.businessFieldId)
		else 
			businessField = new BusinessField()
		if (params.saveField) {
			businessField.properties = params
			businessField.status = 0
			businessField.save(flush:true)
		} else if (params.deleteField) {
			businessField.status = -10
			businessField.save(flush:true)
		}
		
		redirect (controller:'admin',action:'listBusinessField')
	}
	
	
	// Quản lý danh sách rủi ro cá nhân/pháp nhân Blacklist
	
	def viewBlacklist = {
		def allBlacklist = BlacklistCategory.findAllByStatusGreaterThanEquals(0)
		
		render view:'viewBlacklist',model:[allBlacklist:allBlacklist]
	}
	
	def detailBlacklist = {
		def blackList
		if (params.blId)
			blackList = BlacklistCategory.get(params.blId)
			
		render view:'detailBlackList',model:[blackList:blackList]
	}
	
	def saveBlackList = {
		def blackList
		if (params.blId)
			blackList = BlacklistCategory.get(params.blId)
		else 
			blackList = new BlacklistCategory()
		if (params.savebl) {
			blackList.properties = params
			blackList.type = 0
			blackList.status = 0
			blackList.save(flush:true)
		} else if (params.deletebl) {
			blackList.status = -10
			blackList.save(flush:true)
		}
		
		redirect (controller:'admin',action:'viewBlacklist')
	}
	
	// Phân loại đối tượng blacklist
	
	def viewObjectBlacklist = {
		
		// khởi tạo đối tượng objectBlacklist : tìm kiếm toàn bộ những thằng nào có status >= 0
		def allObjectBlacklist = BlacklistObject.findAllByStatusGreaterThanEquals(0)
		
		render view:'viewObjectBlacklist',model:[allObjectBlacklist:allObjectBlacklist]
	}
	
	def addObjectBlacklist = {
			def objectBlacklist
		if (params.blId)
			objectBlacklist = BlacklistObject.get(params.blId)
			
		render view:'addObjectBlackList',model:[objectBlacklist:objectBlacklist]
	}
	
	def saveObjectBlacklist = {
		def objectBlacklist
		if (params.blId)
			objectBlacklist = BlacklistObject.get(params.blId)
		else 
			objectBlacklist = new BlacklistObject()
		if (params.savebl) {
			objectBlacklist.properties = params
			objectBlacklist.status = 0
			objectBlacklist.save(flush:true)
		} else if (params.deletebl) {
			objectBlacklist.status = -10
			objectBlacklist.save(flush:true)
		}
		
		redirect (controller:'admin',action:'viewObjectBlacklist')
	}
	
	// Quản lý loại tài sản đảm bảo Blacklist
	
	def viewTaiSandbBlacklist = {
		
		// khởi tạo đối tượng objectBlacklist : tìm kiếm toàn bộ những thằng nào có status >= 0
		def allTaiSanBlacklist = BlacklistTaiSan.findAllByStatusGreaterThanEquals(0)
		
		render view:'viewTaiSandbBlacklist',model:[allTaiSanBlacklist:allTaiSanBlacklist]
	}
	
	def addTaiSandbBlacklist = {
			def taisanBlacklist
		if (params.blId)
			taisanBlacklist = BlacklistTaiSan.get(params.blId)
			
		render view:'addTaiSandbBlackList',model:[taisanBlacklist:taisanBlacklist]
	}
	
	def saveTaiSanBlacklist = {
		def taisanBlacklist
		if (params.blId)
			taisanBlacklist = BlacklistTaiSan.get(params.blId)
		else
			taisanBlacklist = new BlacklistTaiSan()
		if (params.savebl) {
			taisanBlacklist.properties = params
			taisanBlacklist.status = 0
			taisanBlacklist.save(flush:true)
		} else if (params.deletebl) {
			taisanBlacklist.status = -10
			taisanBlacklist.save(flush:true)
		}
		
		redirect (controller:'admin',action:'viewTaiSandbBlacklist')
	}
	
	// Quản lý danh sách rủi ro tài sản bảo đảm Blacklist
	
	def viewRiskTsdbBlacklist = {
		
		// khởi tạo đối tượng RiskTsdbBlacklist : tìm kiếm toàn bộ những thằng nào có status >= 0
		def RiskTsdbBlacklist = BlacklistRiskTSBD.findAllByStatusGreaterThanEquals(0)
		
		render view:'viewRiskTsdbBlacklist',model:[RiskTsdbBlacklist:RiskTsdbBlacklist]
	}
	
	def addRiskTsbdBlacklist = {
		def riskTsdbBlacklist
			if (params.blId)
				riskTsdbBlacklist = BlacklistRiskTSBD.get(params.blId)
			
		render view:'addRiskTsbdBlacklist',model:[riskTsdbBlacklist:riskTsdbBlacklist]
	}
	
	def saveRiskTsbdBlacklist = {
		def riskTsdbBlacklist
		if (params.blId)
			riskTsdbBlacklist = BlacklistRiskTSBD.get(params.blId)
		else
			riskTsdbBlacklist = new BlacklistRiskTSBD()
		if (params.savebl) {
			riskTsdbBlacklist.properties = params
			riskTsdbBlacklist.status = 0
			riskTsdbBlacklist.save(flush:true)
		} else if (params.deletebl) {
			riskTsdbBlacklist.status = -10
			riskTsdbBlacklist.save(flush:true)
		}
		
		redirect (controller:'admin',action:'viewRiskTsdbBlacklist')
	}
	
	//Quan ly loai hanh dong
	
	def listActionType = {
		def allFields = ActionType.findAllByStatusGreaterThanEquals(0)
		
		render view:'listActionType',model:[allFields:allFields]
	}
	
	def detailActionType = {
		def actionType
		if (params.actionTypeId)
			actionType = ActionType.get(params.actionTypeId)
			
		render view:'detailActionType',model:[actionType:actionType]
	}
	
	def saveActionType = {		
		def actionType
		if (params.actionTypeId)
			actionType = ActionType.get(params.actionTypeId)
		else
			actionType = new ActionType()
		if (params.saveField) {
			actionType.properties = params
			actionType.status = 0
			actionType.save(flush:true)
		} else if (params.deleteField) {
			actionType.status = -10
			actionType.save(flush:true)
		}
		
		redirect (controller:'admin',action:'listActionType')
	}
}

