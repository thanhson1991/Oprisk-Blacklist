import grails.converters.JSON
import groovy.sql.Sql

import java.awt.Desktop.Action;
import java.text.*;
import java.util.*;
import java.util.ResourceBundle.Control;

import msb.platto.commons.Conf
import java.util.logging.ErrorManager;

import grails.plugins.springsecurity.SpringSecurityService;
import grails.util.Environment
//import msb.ldap.LdapUser
import msb.platto.fingerprint.*
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

class MasterUserCreateController {
	def springSecurityService
    def index = { }
	Role role
	def displayAll=	{		
		def masterUserCreate=ErrorMasterUserCreate.list(sort: "id",order: "desc")
		def messageCode=params.message
		render (view:'errorMasterUserCreateDisplay',model:[masterUserCreate:masterUserCreate,messageCode:messageCode])
		 
	}
	//Insert
	def viewInsert={
		
		def unitDepart1 = UnitDepart.findAllByParentAndStatusGreaterThan(UnitDepart.findByName('Horizontal Tree'),-1)
		def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.parent !=null and  e.status >=0 order by e.code+0 ')		
		//def department=Department.executeQuery(' from Department e where e.status >=0 order by e.code+0')
		def departments = Department.findAllByStatusGreaterThanEquals(0)
		def allUnitDepart = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
		def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
		render (view:'insert',model:[unitDepart:unitDepart,departments:departments,allUnitDepart:allUnitDepart,unitDepart1:unitDepart1,allUnitDepart2:allUnitDepart2])
	}
	def insert={

		if(params.userOutlook==null)
			redirect (action:"displayAll")
						
		def checkMasterUser=ErrorMasterUserCreate.findByUserEmail(params.userOutlook)
		def user = User.findByUsername(params.userOutlook)
	
		if(checkMasterUser==null)
		{
			def masterUser=new ErrorMasterUserCreate()
			masterUser.userEmail=params.userOutlook
			masterUser.fullName=params.fullName
			masterUser.bDSUser=params.bdsUser
			masterUser.codeSalary=params.IdNhanSu
			masterUser.title=params.title
			
/*			masterUser.unitDepart=UnitDepart.get(params.TenDonVi)
			masterUser.department=Department.get(params.NHCD)*/
			// println ">>>>>>>>>>>>N: "+ params.NHCD
			// println ">>>>>>>>>>>>C: "+ params.CN
			// println ">>>>>>>>>>>>OP: "+ params.PGD
			masterUser.tenDonVi1=params.NHCD
			masterUser.tenDonVi2=params.CN
			masterUser.tenDonVi3=params.PGD
			masterUser.nguoiNhap = springSecurityService.principal.username
			masterUser.ngayNhap = new Date()
			masterUser.trangThai = 'Mới khởi tạo'
			
			if(User.findByUsername(params.userOutlook)){
				flash.error="Username đã tồn tại trong hệ thống, vui lòng chọn tên khác."				
			}
			
			if(user==null){
				user = new User()
				user.fullname=params.fullName
				user.username=params.userOutlook
				user.prop1=params.department
				user.prop2=''
				user.prop3=''
				user.prop4=params.TenDonVi
				if (!params.password){
					user.password = '1'
				}
				user.enabled=true
				user.save(flush:true)
				Role role
				UserRole.create user, Role.findByAuthority("ROLE_GDTT")
			
			
			if (params.roles){
				if (params.roles.class.name.equals('java.lang.String')){
					UserRole.create user, Role.findByAuthority("ROLE_GDTT")
				} else{
					params.roles.each{
						UserRole.create user, Role.findByAuthority(it)
					}
				}
			}
			
			}else{
				user.fullname=params.fullName
				user.username=params.userOutlook
				user.prop1=params.department
				user.prop3=''
				user.prop4=params.TenDonVi
				if (!params.password){
					user.password = '1'
				}
				user.save(flush:true)
			
			}
			
			masterUser.save(flush:true)
			flash.message = "Anh/chị đã cập nhập thành công!"
		}
		else
		{
			
			flash.message="<span style='color:red'> Thêm mới không thành công.OutLook đã tồn tại</span>"
		}
		
		
		redirect (controller:'masterUserCreate', action:'displayAll')
	}
	def getUnitDepart2={
		
		def unitDepart2=["-1"]
		
			if(params.parent_id ){
				unitDepart2=UnitDepart.executeQuery(' from UnitDepart e where e.parent!=null and e.parent='+params.parent_id+' and e.status >=0 order by e.code+0')
				
			}
		render unitDepart2 as JSON
		 
	}
	def getDisplayName ={
		
		def username=params.username
		def fullNameOutlook=["",""]		
		//def user
		//def user = LdapUser.find(directory: "msb",filter: "(sAMAccountName=${username})")
		def user = LdapUser.find(directory: "msb",filter: "(|(mail=${username})(mail=${username}@msb.com.vn))")		
		if(user!=null)
		{
		
			
			String dName=user?.displayName;
			// println "dName:" + dName
			String[] parts = dName.split("\\(");
			def uName=parts[0];
			def uChucDanh=parts[1].substring(0, parts[1].length()-1);
					
			fullNameOutlook = [uName,uChucDanh]
		}
		render fullNameOutlook as JSON
		
		
		
		
	   }
	
	//Update
	def viewUpdate={
		
	
		//def unitDepart=UnitDepart.executeQuery(' from UnitDepart e where e.parent !=null and e.status >=0 order by e.id')
		 
			 
			def unitDepart=UnitDepart.findAllByParentAndStatusGreaterThan(UnitDepart.findByName('Horizontal Tree'),-1)
			def master=ErrorMasterUserCreate.get(params.id.toInteger())		
			def user =User.findByUsername(master.userEmail)
			def unit1=UnitDepart.get(master.tenDonVi1)
			def unitDepart2=UnitDepart.findAllByParentAndStatusGreaterThanEquals(unit1,0)
			
			// println ">>>>>>>1: "+master.tenDonVi3
			def unit2=UnitDepart.get(master.tenDonVi2)
			def unitDepart3=UnitDepart.findAllByParentAndStatusGreaterThanEquals(unit2,0)
			def departments = Department.findAllByStatusGreaterThanEquals(0)
			def allUnitDepart = UnitDepart.executeQuery('from UnitDepart e where e.ord=3 and e.status>=0 order by e.code+0')
			def allUnitDepart2 = UnitDepart.executeQuery('from UnitDepart e where e.ord=2 and e.status>=0 order by e.code+0')
			//def unitDepart3= ErrorMasterUserCreate.findAllByTenDonVi3(ErrorMasterUserCreate.get(unit1.tenDonVi2))
			render view:'update',model:[master:master,unitDepart:unitDepart,unitDepart2:unitDepart2,unitDepart3:unitDepart3,departments:departments,user:user,allUnitDepart:allUnitDepart,allUnitDepart2:allUnitDepart2]
	 
	}
	def update={
//		def masterUser=ErrorMasterUserCreate.findByUserEmail( springSecurityService.principal.username)
 
		def message
		if(params.deleteError=='delete')
		{
			def master=ErrorMasterUserCreate.get(params.idMaster.toInteger())			
			master.delete(flush:true)
			
			def user =User.findByUsername(params.userOutlook)
			if(user!=null){
				
				//user.enabled=false
				//user.save(flush:true)
				
								
				UserRole.removeAll user
			}
			
			message='3'
		}
		else
		{
			if(params.userOutlook==null){ 
				redirect (action:"displayAll")
				// println "3333"
			}
			def checkMasterUser=ErrorMasterUserCreate.findByUserEmail(params.userOutlook)
			def master=ErrorMasterUserCreate.get(params.idMaster.toInteger())
			if(checkMasterUser ==null)
			{
			 
				master.userEmail=params.userOutlook
				master.fullName=params.fullName
				master.bDSUser=params.bdsUser
				master.codeSalary=params.IdNhanSu
				master.title=params.title		
//				master.unitDepart=UnitDepart.get(params.TenDonVi)
//				master.department=Department.get(params.NHCD)
				master.tenDonVi1 = params.TenDonVi1
				master.tenDonVi2 = params.TenDonVi2
				master.tenDonVi3 = params.TenDonVi3
//				master.nguoiSua = springSecurityService.principal.username
//				master.ngaySua = new Date()
				master.save(flush:true)
				
				def user =User.findByUsername(params.userOutlook)
				if(user==null){
					user = new User()
					user.fullname=params.fullName
					user.username=params.userOutlook
					user.prop1='1'
					user.prop2=''
					user.prop3=''
					user.prop4=params.TenDonVi
					if (!params.password){
						user.password = '1'
					}
					user.enabled=true
					user.save(flush:true)
					Role role
					UserRole.create user, Role.findByAuthority("ROLE_GDTT")
				
				
				if (params.roles){
					if (params.roles.class.name.equals('java.lang.String')){
						UserRole.create user, Role.findByAuthority("ROLE_GDTT")
					} else{
						params.roles.each{
							UserRole.create user, Role.findByAuthority(it)
						}
					}
				}
				
				}else{
					user.fullname=params.fullName
					user.username=params.userOutlook
					user.prop1=params.department
					user.prop3=''
					user.prop4=params.TenDonVi
					if (!params.password){
						user.password = '1'
					}
					user.save(flush:true)
				
				}
			
				
				master.save(flush:true)

				message='1'

			}
			else
			{
				if(checkMasterUser.id==master.id)
				{
					
					master.userEmail=params.userOutlook
					master.fullName=params.fullName
					master.bDSUser=params.bdsUser
					master.codeSalary=params.IdNhanSu
					master.title=params.title
//					master.unitDepart=UnitDepart.get(params.TenDonVi)
//					master.department=Department.get(params.NHCD)
					master.tenDonVi1 = params.TenDonVi1
					master.tenDonVi2 = params.TenDonVi2
					master.tenDonVi3 = params.TenDonVi3
					master.trangThai = 'Đã cập nhật'
					master.nguoiSua = springSecurityService.principal.username
					master.ngaySua = new Date()
					master.save(flush:true)

					message='1'

					
					
					User user =User.findByUsername(params.userOutlook)
					if(user){
						user.fullname=params.fullName
						user.username=params.userOutlook
						user.prop1=params.department
						user.prop3=params.fullName
						user.prop4=params.TenDonVi
						user.save(flush:true)
					}

				}
				else
					message='2'
			}
		}		
		redirect (controller:'masterUserCreate', action:'displayAll',params:[message:message])
		
		
	}
}
