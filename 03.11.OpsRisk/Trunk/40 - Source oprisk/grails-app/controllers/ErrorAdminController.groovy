import grails.converters.JSON
import groovy.sql.Sql

import java.text.*;
import java.util.*;

import msb.platto.commons.Conf

import java.util.logging.ErrorManager;

import javax.xml.transform.ErrorListener;

import grails.util.Environment
//import msb.ldap.LdapUser
import msb.platto.fingerprint.*

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

class ErrorAdminController {

   def index = {
		render view:'/admin/errorAdmin'
	}
	
	/*def importTree = {
		//vertical tree
		ErrorListImporter importer = new ErrorListImporter('/tmp/vt.xls')
		def nodes = importer.getTree()
		def vt = ErrorList.findByName('Vertical Tree')
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
			newlv1 = ErrorList.findByName(txtLv1)
			if (!newlv1){
				newlv1 = new ErrorList(name:txtLv1,parent:vt).save(flush:true)
				lv1 = newlv1
			}
			newlv2 = ErrorList.findByNameAndOrd(txtLv2,2)
			if (!newlv2){
				newlv2 = new ErrorList(name:txtLv2,parent:lv1).save(flush:true)
				lv2 = newlv2
			}
			if (nodeData['lv3']){
				lv3 = new ErrorList(name:nodeData['lv3'].trim(),parent:lv2).save(flush:true)
			}
		}
		
		//horizontal tree
		importer = new ErrorListImporter('/tmp/ht.xls')
		nodes = importer.getTree()
		def ht = ErrorList.findByName('Horizontal Tree')
		nodes.each{nodeData->
			if (nodeData['lv1']){
				txtLv1 = nodeData['lv1'].trim()
			}
			if (nodeData['lv2']){
				txtLv2 = nodeData['lv2'].trim()
			}
			newlv1 = ErrorList.findByName(txtLv1)
			if (!newlv1){
				newlv1 = new ErrorList(name:txtLv1,parent:ht).save(flush:true)
				lv1 = newlv1
			}
			newlv2 = ErrorList.findByNameAndOrd(txtLv2,2)
			if (!newlv2){
				newlv2 = new ErrorList(name:txtLv2,parent:lv1).save(flush:true)
				lv2 = newlv2
			}
			if (nodeData['lv3']){
				lv3 = new ErrorList(name:nodeData['lv3'].trim(),parent:lv2).save(flush:true)
			}
		}
		
		render 'Ä�Ã£ import thÃ nh cÃ´ng!'
	}*/
	
	/*def vertical = {
		def vt = ErrorList.findByName('Vertical Tree')
		def nodes = ErrorList.executeQuery(' from ErrorList t where (t.ord = 1 or t.ord = 2) and (t.parent = ? or t.parent.parent = ?) order by t.id ',vt, vt)
		render view:'/m-atrack-hierarchy/m-atrack-hierarchy-vertical',model:[nodes:nodes]
	}*/
	def findParent={
		def errorList=ErrorList.get(params.AddChildrenId);
		def idPrarent=1		
		if(errorList!=null)
		{
			if(errorList.ord==3)
				idPrarent=errorList.parent.id
			else
				idPrarent=errorList.id
		}
						
		
		render idPrarent;
	}
	
	def findCodeParent={
		def errorList=ErrorList.get(params.AddChildrenId);
		def codeParent=0
		if(errorList!=null)
		{
			if(errorList.ord==3)
				codeParent=errorList.parent.code
			else
				codeParent=errorList.code
		}	
		if (codeParent=='99990092')
			codeParent=0;
		render codeParent;
	}
	
	def horizontal = {
		def vt = ErrorList.findByName('Horizontal Tree')
		def nodes = ErrorList.executeQuery(' from ErrorList t where (t.ord = 1 or t.ord = 2) and (t.parent = ? or t.parent.parent = ?) and t.status>=0 order by t.id ',vt, vt)
		
		
		//def childNodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.parent = ? ', node)
		
		def nodesLevel1 = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.ord = 1 order by t.code+0')
		
		String htmlRes='<select class=\"e-xxl\" name=\"parent\">' 
		
		htmlRes +=  '<option></option>' + "\n"
		nodesLevel1.each {
			htmlRes += '<option value="' + it.id + '">' + it.name + '</option>' + "\n"
			def childNodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.parent = ? order by t.code+0', it)
			childNodes.each{
				htmlRes += '<option value="' + it.id + '">|--'+ it.code+'-'+ it.name + '</option>' + "\n"
			}
			
		}					
		render view:'/admin/errorAdmin',model:[nodes:nodes,htmlResControl:htmlRes]
	}
	
	def getTree = {
		def vt
		/*if (params.id.equals('vertical')){
			vt = ErrorList.findByName('Vertical Tree')
		} else {
			vt = ErrorList.findByName('Horizontal Tree')
		}*/
		vt=ErrorList.findByName('Horizontal Tree')
		def lv1 = []
		def tree = []
		
		if (!vt){
		
			return null
		}
	
		def lv1nodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and t.parent = ? order by t.code+0',vt)
		def lv2nodes, lv3nodes
		lv1nodes.each{lv1node->
			def lv2 = []
			lv2nodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and t.parent = ? order by t.code+0',lv1node)
			lv2nodes.each{lv2node->
				def lv3 = []
				lv3nodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.parent = ? order by t.code+0',lv2node)
				lv3nodes.each{lv3node->
					lv3 << [data:lv3node.code+'-'+lv3node.name,attr:['id':'m-atrack-tree-node-'+lv3node.id,class:'m-melanin-hierarchu-tree-lv3','tid':lv3node.code]]
				}
				lv2 << [data:lv2node.code+'-'+lv2node.name,children:lv3,attr:['id':'m-atrack-tree-node-'+lv2node.id,class:'m-melanin-hierarchu-tree-lv2','tid':lv2node.code]]
			}
			lv1 << [data:lv1node.code+'-'+lv1node.name,children:lv2,attr:['id':'m-atrack-tree-node-'+lv1node.id,class:'m-melanin-hierarchu-tree-lv1','tid':lv1node.code]]
		}
		
		tree = [data:'MSB',children:lv1,attr:['id':'m-atrack-tree-root']]
		render tree as JSON
	}
	
	def addNode = {
		if (params.nodeId){
			redirect action:'editNode',params:params
			return
		}
		ErrorList node = new ErrorList()
		node.name = params.name
		node.code=params.code
//		println "parent:"+ params.parent
		if (params.parent){
			node.parent = ErrorList.get(params.parent.toLong())
		} else{
			node.parent = ErrorList.findByName('Horizontal Tree')
		}
		node.save(true)
		redirect action:params.currentAction
	}
	
	def editNode = {
//		println "params.nodeId:"+ params.nodeId
		ErrorList node = ErrorList.get(params.nodeId.toLong())
		
		ErrorList nodeCheck = ErrorList.get(params.nodeId.toLong())
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
				
					def errorManagement3=ErrorManagement.findByLoiCap3(nodeCheck.id)
					def errorManagement2=ErrorManagement.findByLoiCap2(nodeCheck.id)
					def errorManagement1=ErrorManagement.findByLoiCap1(nodeCheck.id)
							
					
					if(errorManagement3!=null || errorManagement2!=null || errorManagement1)
					{
						
						flash.message="<span style=\" color:red \"> Lưu không thành công do đơn vị đã được sử dụng trong module Báo Cáo Lỗi </span>"						
						redirect action:params.currentAction
					}
				}
			}
		}	
		
		node.name = params.name
		node.code=params.code
		if (params.parent){
			
				node.parent = ErrorList.get(params.parent.toLong())
			
		} else {
			if (node.parent.parent){
				node.parent = node.parent.parent
			}
		}
//		node.save(flush:true)
		redirect action:params.currentAction
	}
	
	def deleteNode = {
		ErrorList node = ErrorList.get(params.id.toLong())
		def childrenNodes = ErrorList.executeQuery(' from ErrorList t where t.parent = ? order by t.code+0',node)
		def childrenNodesL3
		childrenNodes.each{child->
			childrenNodesL3 = ErrorList.executeQuery(' from ErrorList t where t.parent = ? order by t.code+0',child)
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
	def updateStatus(ErrorList node){
		node.status=-1
		node.save(flush:true)
	}
	def getChildNodes = {	
		String source = params.id
//		println source
//		println "params:"+params				
		def err=ErrorList.get(params[source])			
		int ord = Integer.parseInt(params.id.substring(params.id.length()-1))
//		ErrorList node = ErrorList.findByNameAndOrd(err.name,ord)
//		println "node:"+ node
		//ErrorList node = ErrorList.findByNameAndOrd("Triển khai",ord)
		def childNodes = ErrorList.executeQuery(' from ErrorList t where t.status>=0 and  t.parent = ? order by t.code+0', err)
		String htmlRes = '<option></option>' + "\n"
		childNodes.each{n->
			htmlRes += '<option value="' + n.id + '">'+n.code+'-'+ n.name + '</option>' + "\n"
		}
//		println "htmlRes"+htmlRes
		render htmlRes
	}
	def getParentNodes = {
		String source = params.id
		//Dua vao DonVi3, suy ra don vi 2, roi don vi 1.
		//Dua vao don vi 1, lay tat ca thang 2 theo 1
		ErrorList node = ErrorList.get(params[source])
		
//		println "node:"+ node
				
		def parentNode=ErrorList.get(node.parent.id)
		def fristNode=ErrorList.get(parentNode.parent.id)
		
//		println "fristNode:"+ fristNode
		def parentAllNodes=ErrorList.executeQuery(' from ErrorList t where t.status>=0 and t.parent=? order by t.code+0',fristNode)
		String htmlRes = '<option></option>' + "\n"
	
		
		parentAllNodes.each{n->
			if(n.id== node.parent.id)
			{
				htmlRes += '<option selected="selected"  value="' + n.id + '">' +n.code+'-'+ n.name + '</option>' + "\n"
			}
			else
				htmlRes += '<option value="' + n.id + '">' +n.code+'-'+ n.name + '</option>' + "\n"
		}
//		println "htmlRes:"+htmlRes
		render htmlRes
	}
	
	def getFirstNodesFromLevel2 = {
		String source = params.id

		ErrorList node = ErrorList.get(params[source])
		
		def parentAllNodes=ErrorList.executeQuery(' from ErrorList t where t.status>=0 and t.ord = 1 order by t.code+0')
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
	
	def getFirstNodes = {
		String source = params.id
		ErrorList node = ErrorList.get(params[source])
		def parentAllNodes=ErrorList.executeQuery(' from ErrorList t where t.status>=0 and t.ord = 1 order by t.code+0')
		def firstNode=ErrorList.get(node.parent.id)
		String htmlRes = '<option></option>' + "\n"
		parentAllNodes.each{n->
			if(n.id== firstNode.parent.id)
			{
				htmlRes += '<option selected="selected"  value="' + n.id + '">' +n.code+'-'+ n.name + '</option>' + "\n"
			}
			else
				htmlRes += '<option value="' + n.id + '">'+n.code+'-'+ n.name + '</option>' + "\n"
		}
//		println "htmlRes:"+ htmlRes
		render htmlRes
	}
	
	
	
	
}
