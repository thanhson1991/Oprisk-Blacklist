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

class UnitDepartmentController {

   def index = {
		render view:'/admin/unitDepartment'
	}
	
	/*def importTree = {
		//vertical tree
		UnitDepartImporter importer = new UnitDepartImporter('/tmp/vt.xls')
		def nodes = importer.getTree()
		def vt = UnitDepart.findByName('Vertical Tree')
		def lv1, lv2, lv3
		String txtLv1,txtLv2,txtLv3
		def newlv1, newlv2
		nodes.each{nodeData->
			if (nodeData['lv1']){
				txtLv1 = nodeData['lv1'].trim()
			}
			if (nodeData['lv2']){
				txtLv2 = nodeData['lv2'].trim()
			}
			newlv1 = UnitDepart.findByName(txtLv1)
			if (!newlv1){
				newlv1 = new UnitDepart(name:txtLv1,parent:vt).save(flush:true)
				lv1 = newlv1
			}
			newlv2 = UnitDepart.findByNameAndOrd(txtLv2,2)
			if (!newlv2){
				newlv2 = new UnitDepart(name:txtLv2,parent:lv1).save(flush:true)
				lv2 = newlv2
			}
			if (nodeData['lv3']){
				lv3 = new UnitDepart(name:nodeData['lv3'].trim(),parent:lv2).save(flush:true)
			}
		}
		
		//horizontal tree
		importer = new UnitDepartImporter('/tmp/ht.xls')
		nodes = importer.getTree()
		def ht = UnitDepart.findByName('Horizontal Tree')
		nodes.each{nodeData->
			if (nodeData['lv1']){
				txtLv1 = nodeData['lv1'].trim()
			}
			if (nodeData['lv2']){
				txtLv2 = nodeData['lv2'].trim()
			}
			newlv1 = UnitDepart.findByName(txtLv1)
			if (!newlv1){
				newlv1 = new UnitDepart(name:txtLv1,parent:ht).save(flush:true)
				lv1 = newlv1
			}
			newlv2 = UnitDepart.findByNameAndOrd(txtLv2,2)
			if (!newlv2){
				newlv2 = new UnitDepart(name:txtLv2,parent:lv1).save(flush:true)
				lv2 = newlv2
			}
			if (nodeData['lv3']){
				lv3 = new UnitDepart(name:nodeData['lv3'].trim(),parent:lv2).save(flush:true)
			}
		}
		
		render 'Ã„ï¿½ÃƒÂ£ import thÃƒÂ nh cÃƒÂ´ng!'
	}*/
	
	/*def vertical = {
		def vt = UnitDepart.findByName('Vertical Tree')
		def nodes = UnitDepart.executeQuery(' from UnitDepart t where (t.ord = 1 or t.ord = 2) and (t.parent = ? or t.parent.parent = ?) order by t.id ',vt, vt)
		render view:'/m-atrack-hierarchy/m-atrack-hierarchy-vertical',model:[nodes:nodes]
	}*/
   def findParent={
	   def unitDepart=UnitDepart.get(params.AddChildrenId);
	   def idPrarent=1
	   if(unitDepart!=null)
	   {
		   if(unitDepart.ord==3 )
		   		idPrarent=unitDepart.parent.id
			else
				idPrarent=unitDepart.id				
	   }
	   render idPrarent;
   }
   
   def findCodeParent={
	   def unitDepart=UnitDepart.get(params.AddChildrenId);
	   def codeParent=0
	   if(unitDepart!=null)
	   {
		   if(unitDepart.ord==3)
		   		codeParent=unitDepart.parent.code
			else
			codeParent=unitDepart.code
		   
	   }
	   if (codeParent=='99990092')
		   codeParent=0;
	   render codeParent;
   }
	def horizontal = {
		def vt = UnitDepart.findByName('Horizontal Tree')
		
		//def nodes = UnitDepart.executeQuery(' from UnitDepart t where (t.ord = 1 or t.ord = 2) and (t.parent = ? or t.parent.parent = ?) and status>=0 order by t.id ',vt, vt)
		
		def nodes = UnitDepart.executeQuery(' from UnitDepart t where (t.ord = 1 or t.ord = 2) and (t.parent = ? or t.parent.parent = ?) and t.status>=0 order by t.id ',vt, vt)
		
		
		//def childNodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.parent = ? ', node)
		
		def nodesLevel1 = UnitDepart.executeQuery(' from UnitDepart t where t.status>=0 and  t.ord = 1 order by t.code+0')
		
		String htmlRes='<select class=\"e-xxl\" name=\"parent\">'
		
		htmlRes +=  '<option></option>' + "\n"
		nodesLevel1.each {
			htmlRes += '<option value="' + it.id + '">' + it.name + '</option>' + "\n"
			
			def childNodes = UnitDepart.executeQuery(' from UnitDepart t where t.status>=0 and  t.parent = ? order by t.code+0', it)
			childNodes.each{
				htmlRes += '<option value="' + it.id + '">|--' + it.code + '-'+ it.name + '</option>' + "\n"
			 
			}
			
		}
		render view:'/admin/unitDepartment',model:[nodes:nodes,htmlResControl:htmlRes]		
		
			
	//	render view:'/admin/unitDepartment',model:[nodes:nodes]
	}
	
	def getTree = {
		def vt
		/*if (params.id.equals('vertical')){
			vt = UnitDepart.findByName('Vertical Tree')
		} else {
			vt = UnitDepart.findByName('Horizontal Tree')
		}*/
		vt=UnitDepart.findByName('Horizontal Tree')
		def lv1 = []
		def tree = []
		
		if (!vt){
		
			return null
		}
	
		def lv1nodes = UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.parent = ? order by t.code+0',vt)
		def lv2nodes, lv3nodes
		lv1nodes.each{lv1node->
			def lv2 = []
			lv2nodes = UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.parent = ? order by t.code+0',lv1node)
			lv2nodes.each{lv2node->
				def lv3 = []
				lv3nodes = UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.parent = ? order by t.code+0',lv2node)
				lv3nodes.each{lv3node->
					lv3 << [data: lv3node.code +' - '+ lv3node.name ,attr:['id':'m-atrack-tree-node-'+lv3node.id,class:'m-melanin-hierarchu-tree-lv3','tid':lv3node.code]]
				}
				lv2 << [data: lv2node.code +' - '+ lv2node.name,children:lv3,attr:['id':'m-atrack-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2','tid':lv2node.code]]
			}
			lv1 << [data: lv1node.code +' - '+ lv1node.name,children:lv2,attr:['id':'m-atrack-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1','tid':lv1node.code]]
		}
		
		tree = [data:'Đơn vị',children:lv1,attr:['id':'m-atrack-tree-root']]
		render tree as JSON
	}
	
	def addNode = {
		if (params.nodeId){
			redirect action:'editNode',params:params
			return
		}
		
		UnitDepart node = new UnitDepart()
		node.name = params.name
		node.code=params.code
		node.status=1
		 
		if (params.parent){
			node.parent = UnitDepart.get(params.parent.toLong())
		} else{
			node.parent = UnitDepart.findByName('Horizontal Tree')
			
		}
		node.save(true)
		redirect action:params.currentAction
	}
	
	def editNode = {
		
		UnitDepart node = UnitDepart.get(params.nodeId.toLong())
		UnitDepart nodeCheck = UnitDepart.get(params.nodeId.toLong())
		if (params.parent)
		{
			 
		
			if(nodeCheck.id==params.parent.toLong())
			{			
				redirect action:params.currentAction
			}
			else
			{
				if(nodeCheck.parent.id!=null && nodeCheck.parent.id!=params.parent.toLong())
				{
					def errorManagement3=ErrorManagement.findByTenDonVi3(nodeCheck.id)
					def errorManagement2=ErrorManagement.findByTenDonVi2(nodeCheck.id)
					def errorManagement1=ErrorManagement.findByTenDonVi1(nodeCheck.id)
					def masterUserCreate3=ErrorManagement.findByTenDonVi3(nodeCheck.id)
					def masterUserCreate2=ErrorManagement.findByTenDonVi2(nodeCheck.id)
					def masterUserCreate1=ErrorManagement.findByTenDonVi1(nodeCheck.id)
					
					
				
					
					
					if(errorManagement3!=null || errorManagement2!=null ||masterUserCreate3!=null || masterUserCreate2 !=null || masterUserCreate1 !=null || errorManagement1 !=null)
					{
						//redirect(action:"show")
						flash.message="<span style=\" color:red \"> LÆ°u khÃ´ng thÃ nh cÃ´ng do Ä‘Æ¡n vá»‹ Ä‘Ã£ Ä‘Æ°á»£c sá»­ dá»¥ng trong module BÃ¡o CÃ¡o Lá»—i <span>"
						redirect action:params.currentAction
					}
				}
			}
			
		}
		
		
		node.name = params.name
		node.code=params.code		
		if (params.parent){					
				node.parent = UnitDepart.get(params.parent.toLong())	
			
		} else {
			if (node.parent.parent){
				node.parent = node.parent.parent
			}
		}
		
		/*node.save(flush:true)*/
		redirect action:params.currentAction
	}
	
	def deleteNode = {
		UnitDepart node = UnitDepart.get(params.id.toLong())
		def childrenNodes = UnitDepart.executeQuery(' from UnitDepart t where t.parent = ? ',node)
		def childrenNodesL3
		childrenNodes.each{child->
			childrenNodesL3 = UnitDepart.executeQuery(' from UnitDepart t where t.parent = ? ',child)
			childrenNodesL3.each{
				//it.delete(flush:true)
				updateStatus(it)
			}
			//child.delete(flush:true)
			updateStatus(child)
		}
		//node.delete(flush:true)
		updateStatus(node)
		redirect action:params.currentAction
	}
	def updateStatus(UnitDepart node){
		node.status=-1
		node.save(flush:true)
	}
	
	def getChildNodes = {		
		String source = params.id		
		UnitDepart node = UnitDepart.get(params[source])	
		def childNodes = UnitDepart.executeQuery(' from UnitDepart t where t.status>=0 and t.parent = ? order by t.code+0', node)
		String htmlRes = '<option></option>' + "\n"
		childNodes.each{n->
			htmlRes += '<option value="' + n.id + '">' +n.code +'-'+n.name + '</option>' + "\n"
		}
		render htmlRes
	}
	
	def getParentNodes = {
		String source = params.id
		//Dua vao DonVi3, suy ra don vi 2, roi don vi 1.
		//Dua vao don vi 1, lay tat ca thang 2 theo 1
 
		UnitDepart node = UnitDepart.get(params[source])
		// println "node>>>"+node
		// println "node.parent.id>>>"+node.parent.id
		def parentNode=UnitDepart.get(node.parent.id)
 
		
		def fristNode=UnitDepart.get(parentNode.parent.id)
	 
		def parentAllNodes=UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.parent=? order by t.code+0',fristNode)
		String htmlRes = '<option></option>' + "\n"
	
		
		parentAllNodes.each{n->
			if(n.id== node.parent.id)
			{
				htmlRes += '<option selected="selected"  value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
			}
			else
				htmlRes += '<option value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
		}		
		render htmlRes
	}
	def getFirstNodes = {
		String source = params.id

		UnitDepart node = UnitDepart.get(params[source])
		def parentAllNodes=UnitDepart.executeQuery(' from UnitDepart t where t.status>0 and t.ord = 1 order by t.code+0')		
		def firstNode=UnitDepart.get(node.parent.id)		
		String htmlRes = '<option></option>' + "\n"
		parentAllNodes.each{n->
			if(n.id== firstNode.parent.id)
			{
				htmlRes += '<option selected="selected"  value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
			}
			else
				htmlRes += '<option value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
		}
		render htmlRes
	}
	
	def getFirstNodesFromLevel2 = {
		String source = params.id

		UnitDepart node = UnitDepart.get(params[source])
	
		def parentAllNodes=UnitDepart.executeQuery(' from UnitDepart t where t.status>=0 and t.ord = 1 order by t.code+0')
		//def firstNode=UnitDepart.get(node.id)
		String htmlRes = '<option></option>' + "\n"
		parentAllNodes.each{n->
			if(n.id== node.parent.id)
			{
				
				htmlRes += '<option selected="selected"  value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
			}
			else
				htmlRes += '<option value="' + n.id + '">' + n.code +" - "+ n.name + '</option>' + "\n"
		}
		render htmlRes
	}
	
	def getUnitDepart2={
		
		def unitDepart2=["-1"]
		 
			if(params.parent_id ){
				unitDepart2=UnitDepart.executeQuery(' from UnitDepart e where e.parent!=null and e.parent='+params.parent_id+' and e.status >=0 order by e.code+0')
				
			}
		render unitDepart2 as JSON
	}
}
