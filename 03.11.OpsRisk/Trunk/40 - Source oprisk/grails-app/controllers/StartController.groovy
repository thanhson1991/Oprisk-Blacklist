import grails.converters.JSON
import groovy.sql.Sql
import java.text.*;
import java.util.*;
import msb.platto.fingerprint.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class StartController {
    def riskService
    def springSecurityService
    Role role

    def index = { }

    def checkAndAddRole = {        
        def model = [:]
		//springSecurityService.reauthenticate ('cic_msb')
		def loginname = springSecurityService.principal.username		
		if (loginname.contains('@msb.com.vn')) {
		      springSecurityService.principal.username = loginname.replace("@msb.com.vn", "")
			  springSecurityService.reauthenticate springSecurityService.principal.username			  
		}
		
        def user = User.findByUsername( springSecurityService.principal.username)
		
 		def unitDepartments=UnitDepart.findAllByStatusGreaterThanEquals(0,[sort:"name", order:"desc"])
		def masterUser=ErrorMasterUserCreate.findByUserEmail( springSecurityService.principal.username)
				 
        if(!user || !masterUser){			 
            if(params.save){
			
                def department = Department.get(params.department)
				if(!user){
	                user = new User(username:springSecurityService.principal.username,fullname:params.name,enabled:true,
	                accountExpired:false,accountLocked:false,password:'',prop1:department.id,prop2:params.branch,prop3:params.branchName,prop4:params.unitDepartmentId	)
	                user.save(flush:true)
				}else{
					user.fullname = params.name
					user.enabled = true
					user.accountExpired = false
					user.accountLocked = false
					user.prop1 = department.id
					user.prop2 = params.branch
					user.prop3 = params.branchName
					user.prop4 = params.unitDepartmentId
					user.save(flush:true)
				}
				if(!masterUser){				
					masterUser=new ErrorMasterUserCreate()
				}
				masterUser.userEmail=springSecurityService.principal.username
				masterUser.fullName=params.name
				masterUser.bDSUser=params.bdsUser
				masterUser.codeSalary=params.IdNhanSu
				masterUser.title=params.title
				
	/*			masterUser.unitDepart=UnitDepart.get(params.TenDonVi)
				masterUser.department=Department.get(params.NHCD)*/
//				// println ">>>>>>>>>>>>N: "+ params.NHCD
//				// println ">>>>>>>>>>>>C: "+ params.CN
//				// println ">>>>>>>>>>>>OP: "+ params.PGD
				
				masterUser.tenDonVi1=params.NHCD
				masterUser.tenDonVi2=params.CN
				masterUser.tenDonVi3=params.PGD
				masterUser.save(flush:true)
				def userRole=UserRole.findAllByUser(user)
				role = Role.findByAuthority('ROLE_GDTT')
				if(!userRole)				
                	UserRole.create(user, role)
                springSecurityService.reauthenticate user.username				
                redirect controller:'melanin',action:'switchDashboard'

            }else{
				
                def departments = Department.findAllByStatusGreaterThanEquals(0)
				def allUnitDepart3 = UnitDepart.executeQuery('from UnitDepart e where e.ord =3 and e.status>=0 order by e.code+0')
				def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord =2 and e.status>=0 order by e.code+0')
				def allUnitDepart1 = UnitDepart.executeQuery('from UnitDepart e where e.ord =1 and e.status>=0 order by e.code+0')
                render view:'/start/updateUserInformation',model:[user:user,departments:departments,unitDepartments:unitDepartments,allUnitDepart3:allUnitDepart3,allUnitDepart1:allUnitDepart1,userName:springSecurityService.principal.username,allUnitDepart2:allUnitDepart2]

            }
        }else{
			def userRole=UserRole.findAllByUser(user)
			role = Role.findByAuthority('ROLE_GDTT')
			if(!userRole){
				UserRole.create(user, role)
				springSecurityService.reauthenticate user.username
				
			}
			redirect controller:'melanin',action:'switchDashboard'
		}
        
    }
}
