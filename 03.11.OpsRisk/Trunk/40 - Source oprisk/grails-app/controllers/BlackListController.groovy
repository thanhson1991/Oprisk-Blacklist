import org.apache.jasper.compiler.Node.ParamsAction;
import org.hibernate.sql.Update;

import java.text.MessageFormat;
import java.text.SimpleDateFormat

import msb.platto.fingerprint.*;
import groovy.sql.Sql

import org.apache.naming.factory.SendMailFactory;
import org.apache.tools.ant.taskdefs.SendEmail;



class BlackListController {
	def dataSource
	def springSecurityService
	def CommonService
	def today = Calendar.getInstance()
	def riskService
	def exportExcelService
	Role role

	/*- Modul: Bkaclist Quản lý danh sách */
	def detailQLDanhSach ={
		println 'detailQLDanhSach' + new Date() + params
		def toDate,fromDate
		def today = new Date()
		toDate = DateUtil.formatDate(today)
		toDate = DateUtil.parseInputDate(toDate+ ' 23:59:59')
		today.setMonth(today.month-1)
		fromDate = DateUtil.formatDate(today)
		fromDate = DateUtil.parseInputDate(fromDate+ ' 00:00:00')
		def currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.authentication.getName())
		def listObject = BlacklistObject.get(params.phanloaiDsBl)
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		println 'detailQLDanhSach : '+ new Date() + params
		if(params.search){
			if(params.loaiDsBL == '1' ){
				def listDsCN = BlackIndividual.createCriteria().list{
					if(listObject){
						"eq" ("doituongCnBL",BlacklistObject.get(listObject.id))
					}else {
						"eq" ("status",-1)
					}
					if(params.donvi1 && currentUserRole[0] in ['ROLE_GDTT_LEVEL3', 'ROLE_GDTT_LEVEL4', 'ROLE_CVQLRR']){
						"eq" ("donvi_1",UnitDepart.get(params.donvi1))
					}
					if(params.donvi2 && currentUserRole[0] != "ROLE_GDTT"){
						"eq" ("donvi_2",UnitDepart.get(params.donvi2))
					}
					if(params.fromDate){
						"ge" ("ngaynhapCnBL",fromDate)
					}
					if(params.fromDate){
						"le" ("ngaynhapCnBL",toDate)
					}
					if (params.usernhapDsBL) {
						"eq"("usernhapCnBL", params.usernhapDsBL)
					}
				}
				// Hàm xuất ra file excel
				if(params.exportExcel=="ExportExcel" && params.loaiDsBL == '1'){
					def importDsCN = BlackIndividual.findAllByStatusGreaterThanEquals(0)
					def header
					def listContent = []
					//listContent<<header
					def tenCnBL,ngaysinhCnBL,cmndCnBL,ngaycapCnBL,noicapCnBl,cmnd2CnBL,ngaycap2CnBL,noicap2CnBl,diachiCnBL,sdtCnBl,danhsachCnBL,lydochitietCnBL,
					doituongCnBL,thoihanCnBL,dulieuCnBl,tochucCnBL,masothueCnBL,lydoCnBl,ghichuCnBL,ngaynhapCnBL,donvi_1,phongbanCnBl,usernhapCnBL,nguoisua,ngaysua
					importDsCN.each{
						tenCnBL=it.tenCnBL?it.tenCnBL:""
						ngaysinhCnBL =it.ngaysinhCnBL?DateUtil.formatDate(it.ngaysinhCnBL):""
						cmndCnBL = it.cmndCnBL?it.cmndCnBL:""
						ngaycapCnBL =it.ngaycapCnBL?DateUtil.formatDate(it.ngaycapCnBL):""
						noicapCnBl =it.noicapCnBl?it.noicapCnBl:""
						cmnd2CnBL = it.cmnd2CnBL?it.cmnd2CnBL:""
						ngaycap2CnBL =it.ngaycap2CnBL?DateUtil.formatDate(it.ngaycap2CnBL):""
						noicap2CnBl = it.noicap2CnBl?it.noicap2CnBl:""
						diachiCnBL = it.diachiCnBL?it.diachiCnBL:""
						sdtCnBl = it.sdtCnBl?it.sdtCnBl:""
						danhsachCnBL = it.danhsachCnBL?it.danhsachCnBL.name:""
						lydochitietCnBL =it.lydochitietCnBL?it.lydochitietCnBL:""
						doituongCnBL = it.doituongCnBL?it.doituongCnBL.name:""
						thoihanCnBL =it.thoihanCnBL?DateUtil.formatDate(it.thoihanCnBL):""
						dulieuCnBl = it.dulieuCnBl?it.dulieuCnBl:""
						tochucCnBL = it.tochucCnBL?it.tochucCnBL:""
						masothueCnBL = it.masothueCnBL?it.masothueCnBL:""
						lydoCnBl = it.lydoCnBl?it.lydoCnBl:""
						ghichuCnBL = it.ghichuCnBL?it.ghichuCnBL:""
						ngaynhapCnBL =it.ngaynhapCnBL?DateUtil.formatDate(it.ngaynhapCnBL):""
						donvi_1 = it.donvi_1.name?it.donvi_1.name:""
						phongbanCnBl = it.phongbanCnBl?it.phongbanCnBl:""
						usernhapCnBL = it.usernhapCnBL?it.usernhapCnBL:""
						nguoisua = it.nguoisua?it.nguoisua:""
						ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

						header = [tenCnBL, ngaysinhCnBL, cmndCnBL, ngaycapCnBL, noicapCnBl, cmnd2CnBL, ngaycap2CnBL, noicap2CnBl, diachiCnBL, sdtCnBl, danhsachCnBL, lydochitietCnBL, doituongCnBL, thoihanCnBL, dulieuCnBl, tochucCnBL, masothueCnBL, lydoCnBl, ghichuCnBL, ngaynhapCnBL, donvi_1, phongbanCnBl, usernhapCnBL, nguoisua, ngaysua]
						// << = add từng row vào listcontent
						listContent<<header
					}
					def data
					data = exportExcelService.blacklistQldsCnDisplay(listContent)
					//File download
					response.setContentType("application/vnd.ms-excel")
					response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
					response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
				}
				render view:'/blacklist/searchQldsBlacklist', model:[dsBlacklist:listDsCN,loaiDsBL:params.loaiDsBL,phanloaiDsBl:params.phanloaiDsBl]
				return
			}
			if (params.loaiDsBL == '2'){
				def listDsPN = BlacklistCorporation.createCriteria().list{
					if(listObject){
						"eq" ("doituongPnBL",BlacklistObject.get(listObject.id))
					}else {
						"eq" ("status",-1)
					}
					if(params.donvi1 && currentUserRole[0] in ['ROLE_GDTT_LEVEL3', 'ROLE_GDTT_LEVEL4', 'ROLE_CVQLRR']){
						"eq" ("donvi_1",UnitDepart.get(params.donvi1))
					}
					if(params.donvi2 && currentUserRole[0] != "ROLE_GDTT" ){
						"eq" ("donvi_2",UnitDepart.get(params.donvi2))
					}
					if(params.fromDate){
						"ge" ("ngaynhapPnBL",fromDate)
					}
					if(params.fromDate){
						"le" ("ngaynhapPnBL",toDate)
					}
					if (params.usernhapDsBL) {
						"eq"("usernhapPnBL", params.usernhapDsBL)
					}
				}
				// Hàm xuất ra file excel
				if(params.exportExcel=="ExportExcel"){
					def importDsPN = BlacklistCorporation.findAllByStatusGreaterThanEquals(0)
					def header
					def listContent = []
					//listContent<<header
					def tenPnBL,giayphepPnBL,ngaycapPnBL,noicapPnBL,diachiPnBL,masothuePnBL,phapluatPnBL,danhsachPnBL='',lydoPnBL,doituongPnBL='',thoihanPnBL,dulieuPnBL,
					tochucPnBL,hochieuPnBL,lydoLqPnBL,ghichuPnBL,ngaynhapPnBL,phongbanPnBL,donvi_1,usernhapPnBL,nguoisua,ngaysua
					importDsPN.each{
						tenPnBL=it.tenPnBL?it.tenPnBL:""
						giayphepPnBL =it.giayphepPnBL?it.giayphepPnBL:""
						ngaycapPnBL =it.ngaycapPnBL?DateUtil.formatDate(it.ngaycapPnBL):""
						noicapPnBL =it.noicapPnBL?it.noicapPnBL:""
						diachiPnBL = it.diachiPnBL?it.diachiPnBL:""
						masothuePnBL = it.masothuePnBL?it.masothuePnBL:""
						phapluatPnBL = it.phapluatPnBL?it.phapluatPnBL:""
						danhsachPnBL = it.danhsachPnBL?it.danhsachPnBL.name:""
						lydoPnBL =it.lydoPnBL?it.lydoPnBL:""
						doituongPnBL = it.doituongPnBL?it.doituongPnBL.name:""
						thoihanPnBL =it.thoihanPnBL?DateUtil.formatDate(it.thoihanPnBL):""
						dulieuPnBL = it.dulieuPnBL?it.dulieuPnBL:""
						tochucPnBL = it.tochucPnBL?it.tochucPnBL:""
						hochieuPnBL = it.hochieuPnBL?it.hochieuPnBL:""
						lydoLqPnBL = it.lydoLqPnBL?it.lydoLqPnBL:""
						ghichuPnBL = it.ghichuPnBL?it.ghichuPnBL:""
						ngaynhapPnBL =it.ngaynhapPnBL?DateUtil.formatDate(it.ngaynhapPnBL):""
						donvi_1 = it.donvi_1.name?it.donvi_1.name:""
						phongbanPnBL = it.phongbanPnBL?it.phongbanPnBL:""
						usernhapPnBL = it.usernhapPnBL?it.usernhapPnBL:""
						nguoisua = it.nguoisua?it.nguoisua:""
						ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

						header = [tenPnBL, giayphepPnBL, ngaycapPnBL, noicapPnBL, diachiPnBL, masothuePnBL, phapluatPnBL, danhsachPnBL='', lydoPnBL, doituongPnBL='', thoihanPnBL, dulieuPnBL, tochucPnBL, hochieuPnBL, lydoLqPnBL, ghichuPnBL, ngaynhapPnBL, phongbanPnBL, donvi_1, usernhapPnBL, nguoisua, ngaysua]
						// << = add từng row vào listcontent
						listContent<<header
					}
					def data
					data = exportExcelService.blacklistQldsPnDisplay(listContent)
					//File download
					response.setContentType("application/vnd.ms-excel")
					response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
					response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
				}
				render view:'/blacklist/searchQldsBlacklist', model:[dsBlacklist:listDsPN,loaiDsBL:params.loaiDsBL,phanloaiDsBl:params.phanloaiDsBl]
				return
			}
			if (params.loaiDsBL == '3'){
				def listDsTsbd = BlacklistTSBD.createCriteria().list{
					if(listObject){
						"eq" ("doituongTsBL",BlacklistObject.get(listObject.id))
					}else {
						"eq" ("status",-1)
					}
					if(params.donvi1 && currentUserRole[0] in ['ROLE_GDTT_LEVEL3', 'ROLE_GDTT_LEVEL4', 'ROLE_CVQLRR']){
						"eq" ("donvi_1",UnitDepart.get(params.donvi1))
					}
					if(params.donvi2 && currentUserRole[0] != "ROLE_GDTT" ){
						"eq" ("donvi_2",UnitDepart.get(params.donvi2))
					}
					if(params.fromDate){
						"ge" ("ngaynhapTsBL",fromDate)
					}
					if(params.fromDate){
						"le" ("ngaynhapTsBL",toDate)
					}
					if (params.usernhapDsBL) {
						"eq"("usernhapTsBL", params.usernhapDsBL)
					}
				}
				if(params.exportExcel=="ExportExcel"){
					def importDsTSBD = BlacklistTSBD.findAllByStatusGreaterThanEquals(0)
					def header
					def listContent = []
					//listContent<<header
					def loaiTsBL,thongtinTsBL,motaTsBL,sohuuTsBL,cmtcshTsBL,masothueTsBL,canhanTsBL,cmtlqTsBL,lydoTsBL,giatriTsBL,
					lichsuGdTsBL,riskTsdbTsBL,doituongTsBL,lydoCtTsBL,thoihanTsBL,dulieuTsBL,ghichuTsBL,ngaynhapTsBL,phongbanTsBl,donvi_1,usernhapTsBL,nguoisua,ngaysua
					importDsTSBD.each{
						loaiTsBL=it.loaiTsBL?it.loaiTsBL.name:""
						thongtinTsBL =it.thongtinTsBL?it.thongtinTsBL:""
						motaTsBL =it.motaTsBL?it.motaTsBL:""
						sohuuTsBL = it.sohuuTsBL?it.sohuuTsBL:""
						cmtcshTsBL = it.cmtcshTsBL?it.cmtcshTsBL:""
						masothueTsBL = it.masothueTsBL?it.masothueTsBL:""
						canhanTsBL = it.canhanTsBL?it.canhanTsBL:""
						cmtlqTsBL =it.cmtlqTsBL?it.cmtlqTsBL:""
						lydoTsBL = it.lydoTsBL?it.lydoTsBL:""
						giatriTsBL = it.giatriTsBL?it.giatriTsBL:""
						lichsuGdTsBL = it.lichsuGdTsBL?it.lichsuGdTsBL:""
						riskTsdbTsBL = it.riskTsdbTsBL?it.riskTsdbTsBL.name:""
						doituongTsBL = it.doituongTsBL?it.doituongTsBL.name:""
						lydoCtTsBL = it.lydoCtTsBL?it.lydoCtTsBL:""
						thoihanTsBL =it.thoihanTsBL?DateUtil.formatDate(it.thoihanTsBL):""
						dulieuTsBL = it.dulieuTsBL?it.dulieuTsBL:""
						ghichuTsBL = it.ghichuTsBL?it.ghichuTsBL:""
						ngaynhapTsBL =it.ngaynhapTsBL?DateUtil.formatDate(it.ngaynhapTsBL):""
						donvi_1 = it.donvi_1.name?it.donvi_1.name:""
						phongbanTsBl = it.phongbanTsBl?it.phongbanTsBl:""
						usernhapTsBL = it.usernhapTsBL?it.usernhapTsBL:""
						nguoisua = it.nguoisua?it.nguoisua:""
						ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

						header = [loaiTsBL, thongtinTsBL, motaTsBL, sohuuTsBL, cmtcshTsBL, masothueTsBL, canhanTsBL, cmtlqTsBL, lydoTsBL, giatriTsBL, lichsuGdTsBL, riskTsdbTsBL, doituongTsBL, lydoCtTsBL, thoihanTsBL, dulieuTsBL, ghichuTsBL, ngaynhapTsBL, phongbanTsBl, donvi_1, usernhapTsBL, nguoisua, ngaysua]
						// << = add từng row vào listcontent
						listContent<<header
					}
					def data
					data = exportExcelService.blacklistQldsTsbdDisplay(listContent)
					//File download
					response.setContentType("application/vnd.ms-excel")
					response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
					response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
				}
				render view:'/blacklist/searchQldsBlacklist', model:[dsBlacklist:listDsTsbd,loaiDsBL:params.loaiDsBL,phanloaiDsBl:params.phanloaiDsBl]
				return
			}
		}
		render view:'/blacklist/searchQldsBlacklist'
	}

	/*- Modul: Bkaclist Cá Nhân */

	def detailCaNhan = {
		println 'detailCaNhan' + new Date() + params
		def unitDepart
		def today = Calendar.getInstance()
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def blackListCn = BlackIndividual.createCriteria().list{
			ge('status',0)
			if(params.search){
				if(params.cmndCnBL)
					eq("cmndCnBL",params.cmndCnBL)

				if(params.cmnd2CnBL)
					eq("cmnd2CnBL",params.cmnd2CnBL)

				if(params.tenCnBL)
					eq("tenCnBL",params.tenCnBL,[ignoreCase: true])
				if(params.ngaysinhCnBL)
					eq("ngaysinhCnBL",Date.parse("dd/MM/yyyy",params.ngaysinhCnBL))
			}else{
				if(params.cmndCnBL)
					eq("cmndCnBL",params.cmndCnBL)

				if(params.cmnd2CnBL)
					eq("cmnd2CnBL",params.cmnd2CnBL)

				if(params.tenCnBL)
					eq("tenCnBL",params.tenCnBL,[ignoreCase: true])
				if(params.ngaysinhCnBL)
					eq("ngaysinhCnBL",Date.parse("dd/MM/yyyy",params.ngaysinhCnBL))
					
				if(currentUserRole[0] =='ROLE_GDTT'){
					eq('usernhapCnBL',currentUser.username)

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL2'){
					eq('donvi_3',UnitDepart.get(errorMasterUser.tenDonVi3))

				}
				if(currentUserRole[0] == 'ROLE_GDTT_LEVEL3'){
					eq('donvi_2',UnitDepart.get(errorMasterUser.tenDonVi2))

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL4'){
					eq('donvi_1',UnitDepart.get(errorMasterUser.tenDonVi1))

				}
			}
		}
		println 'blackListCn' +blackListCn
		// Hàm xuất ra file excel
		if(params.exportExcel=="ExportExcel"){
			def listBLCn = blackListCn
			println 'listBLCn' +listBLCn
			def header
			def listContent = []
			//listContent<<header
			def tenCnBL,ngaysinhCnBL,cmndCnBL,ngaycapCnBL,noicapCnBl,cmnd2CnBL,ngaycap2CnBL,noicap2CnBl,diachiCnBL,sdtCnBl,danhsachCnBL = '',lydochitietCnBL,
			doituongCnBL = '',thoihanCnBL,dulieuCnBl,tochucCnBL,masothueCnBL,lydoCnBl,ghichuCnBL,ngaynhapCnBL,usernhapCnBL,phongbanCnBl,nguoisua,ngaysua

			listBLCn.each{
				println 'it :' +it
				tenCnBL=it.tenCnBL?it.tenCnBL:""
				ngaysinhCnBL =it.ngaysinhCnBL?DateUtil.formatDate(it.ngaysinhCnBL):""
				cmndCnBL = it.cmndCnBL?it.cmndCnBL:""
				ngaycapCnBL =it.ngaycapCnBL?DateUtil.formatDate(it.ngaycapCnBL):""
				noicapCnBl =it.noicapCnBl?it.noicapCnBl:""
				cmnd2CnBL = it.cmnd2CnBL?it.cmnd2CnBL:""
				ngaycap2CnBL =it.ngaycap2CnBL?DateUtil.formatDate(it.ngaycap2CnBL):""
				noicap2CnBl = it.noicap2CnBl?it.noicap2CnBl:""
				diachiCnBL = it.diachiCnBL?it.diachiCnBL:""
				sdtCnBl = it.sdtCnBl?it.sdtCnBl:""
				danhsachCnBL = it.danhsachCnBL?it.danhsachCnBL.name:""
				lydochitietCnBL =it.lydochitietCnBL?it.lydochitietCnBL:""
				doituongCnBL = it.doituongCnBL?it.doituongCnBL.name:""
				thoihanCnBL =it.thoihanCnBL?DateUtil.formatDate(it.thoihanCnBL):""
				dulieuCnBl = it.dulieuCnBl?it.dulieuCnBl:""
				tochucCnBL = it.tochucCnBL?it.tochucCnBL:""
				masothueCnBL = it.masothueCnBL?it.masothueCnBL:""
				lydoCnBl = it.lydoCnBl?it.lydoCnBl:""
				ghichuCnBL = it.ghichuCnBL?it.ghichuCnBL:""
				ngaynhapCnBL =it.ngaynhapCnBL?DateUtil.formatDate(it.ngaynhapCnBL):""
				usernhapCnBL = it.usernhapCnBL?it.usernhapCnBL:""
				phongbanCnBl = it.phongbanCnBl?it.phongbanCnBl:""
				nguoisua = it.nguoisua?it.nguoisua:""
				ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

				header = [tenCnBL, ngaysinhCnBL, cmndCnBL, ngaycapCnBL, noicapCnBl, cmnd2CnBL, ngaycap2CnBL, noicap2CnBl, diachiCnBL, sdtCnBl, danhsachCnBL, lydochitietCnBL, doituongCnBL, thoihanCnBL, dulieuCnBl, tochucCnBL, masothueCnBL, lydoCnBl, ghichuCnBL, ngaynhapCnBL, usernhapCnBL, phongbanCnBl, nguoisua, ngaysua]
				// << = add từng row vào listcontent
				listContent<<header
			}
			def data
			data = exportExcelService.blacklistCnDisplay(listContent)
			println 'date' +data
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}

		render (view:'/blacklist/searchCnBlacklist',model:[blackListCn:blackListCn,search:params])
	}

	
	def searchCnBL = {
		def unitDepart
		def today = Calendar.getInstance()
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def blackListCn = BlackIndividual.createCriteria().list{
			ge('status',0)
			if(params.search){
				if(params.cmndCnBL)
					eq("cmndCnBL",params.cmndCnBL)

				if(params.cmnd2CnBL)
					eq("cmnd2CnBL",params.cmnd2CnBL)

				if(params.tenCnBL)
					eq("tenCnBL",params.tenCnBL,[ignoreCase: true])
				if(params.ngaysinhCnBL)
					eq("ngaysinhCnBL",Date.parse("dd/MM/yyyy",params.ngaysinhCnBL))
			}else{
				if(currentUserRole[0] =='ROLE_GDTT'){
					eq('usernhapCnBL',currentUser.username)

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL2'){
					eq('donvi_3',UnitDepart.get(errorMasterUser.tenDonVi3))

				}
				if(currentUserRole[0] == 'ROLE_GDTT_LEVEL3'){
					eq('donvi_2',UnitDepart.get(errorMasterUser.tenDonVi2))

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL4'){
					eq('donvi_1',UnitDepart.get(errorMasterUser.tenDonVi1))

				}
			}
		}
	
		// Hàm xuất ra file excel
		if(params.exportExcel=="ExportExcel"){
			def listBLCn = blackListCn
			
			def header
			def listContent = []
			//listContent<<header
			def tenCnBL,ngaysinhCnBL,cmndCnBL,ngaycapCnBL,noicapCnBl,cmnd2CnBL,ngaycap2CnBL,noicap2CnBl,diachiCnBL,sdtCnBl,danhsachCnBL = '',lydochitietCnBL,
			doituongCnBL = '',thoihanCnBL,dulieuCnBl,tochucCnBL,masothueCnBL,lydoCnBl,ghichuCnBL,ngaynhapCnBL,usernhapCnBL,phongbanCnBl,nguoisua,ngaysua

			listBLCn.each{
				println 'it :' +it
				tenCnBL=it.tenCnBL?it.tenCnBL:""
				ngaysinhCnBL =it.ngaysinhCnBL?DateUtil.formatDate(it.ngaysinhCnBL):""
				cmndCnBL = it.cmndCnBL?it.cmndCnBL:""
				ngaycapCnBL =it.ngaycapCnBL?DateUtil.formatDate(it.ngaycapCnBL):""
				noicapCnBl =it.noicapCnBl?it.noicapCnBl:""
				cmnd2CnBL = it.cmnd2CnBL?it.cmnd2CnBL:""
				ngaycap2CnBL =it.ngaycap2CnBL?DateUtil.formatDate(it.ngaycap2CnBL):""
				noicap2CnBl = it.noicap2CnBl?it.noicap2CnBl:""
				diachiCnBL = it.diachiCnBL?it.diachiCnBL:""
				sdtCnBl = it.sdtCnBl?it.sdtCnBl:""
				danhsachCnBL = it.danhsachCnBL?it.danhsachCnBL.name:""
				lydochitietCnBL =it.lydochitietCnBL?it.lydochitietCnBL:""
				doituongCnBL = it.doituongCnBL?it.doituongCnBL.name:""
				thoihanCnBL =it.thoihanCnBL?DateUtil.formatDate(it.thoihanCnBL):""
				dulieuCnBl = it.dulieuCnBl?it.dulieuCnBl:""
				tochucCnBL = it.tochucCnBL?it.tochucCnBL:""
				masothueCnBL = it.masothueCnBL?it.masothueCnBL:""
				lydoCnBl = it.lydoCnBl?it.lydoCnBl:""
				ghichuCnBL = it.ghichuCnBL?it.ghichuCnBL:""
				ngaynhapCnBL =it.ngaynhapCnBL?DateUtil.formatDate(it.ngaynhapCnBL):""
				usernhapCnBL = it.usernhapCnBL?it.usernhapCnBL:""
				phongbanCnBl = it.phongbanCnBl?it.phongbanCnBl:""
				nguoisua = it.nguoisua?it.nguoisua:""
				ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

				header = [tenCnBL, ngaysinhCnBL, cmndCnBL, ngaycapCnBL, noicapCnBl, cmnd2CnBL, ngaycap2CnBL, noicap2CnBl, diachiCnBL, sdtCnBl, danhsachCnBL, lydochitietCnBL, doituongCnBL, thoihanCnBL, dulieuCnBl, tochucCnBL, masothueCnBL, lydoCnBl, ghichuCnBL, ngaynhapCnBL, usernhapCnBL, phongbanCnBl, nguoisua, ngaysua]
				// << = add từng row vào listcontent
				listContent<<header
			}
			def data
			data = exportExcelService.blacklistCnDisplay(listContent)
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}

		render (view:'/blacklist/searchCnRutgonBL',model:[blackListCn:blackListCn,search:params])
	}
	
	

	def viewBlacklistCn = {
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blackListCn
		if (params.blacklistId){
			blackListCn = BlackIndividual.get(params.blacklistId)
		}
		def listBlacklistCategory = BlacklistCategory.findAllByStatusGreaterThanEquals(0)
		render view:'/blacklist/detailBlackCN',model:[blackListCn:blackListCn,currentUser:currentUser.username]
	}


	def addCnBlacklist = {
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blackListCn
		if(params.blackListId){
			blackListCn = BlackIndividual.get(params.blackListId)
			blackListCn.status = 0
		}
		def listBlacklistCategory = BlacklistCategory.findAllByStatusGreaterThanEquals(0)
		render (view:'/blacklist/detailBlackCN',model:[blackListCn:blackListCn,currentUser:currentUser.username,params:params])
	}


	def saveCnBlacklist = {
		println 'saveCnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def userBLCN = ErrorMasterUserCreate.findByUserEmail(params.usernhapCnBL)
		def blackListCn = new BlackIndividual()
		if (params.saveEdit){
			redirect(action:'editCnBlacklist',params:params)
		}else if (params.deleteError == 'deleteCnBl') {
			redirect(action:'deleteCnBlacklist',params:params)
		}else if (BlackIndividual.findByCmndCnBL(params.cmndCnBL)){
			flash.error = "CMTND đã tồn tại. Mời Anh/chị nhập lại!"
			redirect(action:'addCnBlacklist',params:params)
			return
		}else if (BlackIndividual.findByCmnd2CnBL(params.cmnd2CnBL)?.cmnd2CnBL){
			flash.error = "CMTND2 đã tồn tại. Mời Anh/chị nhập lại!"
			redirect(action:'addCnBlacklist',params:params)
			return
		}else{
			blackListCn.tenCnBL = params.tenCnBL
			blackListCn.ngaysinhCnBL = params.ngaysinhCnBL?Date.parse("dd/MM/yyyy",params.ngaysinhCnBL):null
			blackListCn.cmndCnBL = params.cmndCnBL
			blackListCn.ngaycapCnBL = params.ngaycapCnBL?Date.parse("dd/MM/yyyy",params.ngaycapCnBL):null
			blackListCn.noicapCnBl = params.noicapCnBl
			blackListCn.cmnd2CnBL = params.cmnd2CnBL
			blackListCn.ngaycap2CnBL = params.ngaycap2CnBL?Date.parse("dd/MM/yyyy",params.ngaycap2CnBL):null
			blackListCn.noicap2CnBl = params.noicap2CnBl
			blackListCn.diachiCnBL = params.diachiCnBL
			blackListCn.ghichuCnBL = params.ghichuCnBL
			blackListCn.lydochitietCnBL = params.lydochitietCnBL
			blackListCn.sdtCnBl = params.sdtCnBl
			blackListCn.dulieuCnBl = params.dulieuCnBl
			blackListCn.tochucCnBL = params.tochucCnBL
			blackListCn.masothueCnBL = params.masothueCnBL
		//	blackListCn.lydoCnBl = params.lydoCnBl
			blackListCn.thoihanCnBL = Date.parse("dd/MM/yyyy",params.thoihanCnBL)
			blackListCn.ngaynhapCnBL = Date.parse("dd/MM/yyyy",params.ngaynhapCnBL)
			blackListCn.usernhapCnBL = currentUser.username
			blackListCn.phongbanCnBl = params.phongbanCnBl
			blackListCn.danhsachCnBL = BlacklistCategory.get(params.danhsachCnBL)
			blackListCn.doituongCnBL = BlacklistObject.get(params.doituongCnBL)
			blackListCn.status = 0
			blackListCn.donvi_1 = UnitDepart.get(userBLCN.tenDonVi1)
			blackListCn.donvi_2 = UnitDepart.get(userBLCN.tenDonVi2)
			blackListCn.donvi_3 = UnitDepart.get(userBLCN.tenDonVi3)
			blackListCn.save(flush:true)

			flash.message = "Anh/chị đã tạo mới thành công!"
			def allBlacklistCn = BlackIndividual.findAllByStatusGreaterThanEquals(0)
			//	render (view:'/blacklist/searchCnBlacklist',model:[blackListCn:allBlacklistCn])
			redirect(action:'detailCaNhan')
		}
	}


	def editCnBlacklist = {
		println 'editCnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blackListCn = BlackIndividual.get(params.blacklistId)
		if (BlackIndividual.findByCmnd2CnBLAndIdNotEqual(params.cmnd2CnBL,params.blacklistId)?.cmnd2CnBL){
			flash.error = "CMTND2 đã tồn tại. Mời Anh/chị nhập lại!"
			redirect(action:'addCnBlacklist',params:params)
			return
		}else{
			blackListCn.tenCnBL = params.tenCnBL
			blackListCn.ngaysinhCnBL = params.ngaysinhCnBL?Date.parse("dd/MM/yyyy",params.ngaysinhCnBL):null
			blackListCn.cmndCnBL = params.cmndCnBL
			blackListCn.ngaycapCnBL = params.ngaycapCnBL?Date.parse("dd/MM/yyyy",params.ngaycapCnBL):null
			blackListCn.noicapCnBl = params.noicapCnBl
			blackListCn.cmnd2CnBL = params.cmnd2CnBL
			blackListCn.ngaycap2CnBL =params.ngaycap2CnBL?Date.parse("dd/MM/yyyy",params.ngaycap2CnBL):null
			blackListCn.noicap2CnBl = params.noicap2CnBl
			blackListCn.diachiCnBL = params.diachiCnBL
			blackListCn.ghichuCnBL = params.ghichuCnBL
			blackListCn.lydochitietCnBL = params.lydochitietCnBL
			blackListCn.sdtCnBl = params.sdtCnBl
			blackListCn.dulieuCnBl = params.dulieuCnBl
			blackListCn.tochucCnBL = params.tochucCnBL
			blackListCn.masothueCnBL = params.masothueCnBL
		//	blackListCn.lydoCnBl = params.lydoCnBl
			blackListCn.thoihanCnBL = Date.parse("dd/MM/yyyy",params.thoihanCnBL)
			blackListCn.ngaynhapCnBL = Date.parse("dd/MM/yyyy",params.ngaynhapCnBL)
			blackListCn.danhsachCnBL = BlacklistCategory.get(params.danhsachCnBL)
			blackListCn.doituongCnBL = BlacklistObject.get(params.doituongCnBL)
			blackListCn.nguoisua = currentUser.username
			blackListCn.ngaysua = new Date()
			if(blackListCn.save(flush:true)){
				//				def arrTo=[]
				//				def arrCc=[]
				//				if(blackListCn.usernhapCnBL.contains('@')){
				//					arrTo += blackListCn.usernhapCnBL
				//				}else{
				//					arrTo += blackListCn.usernhapCnBL+'@msb.com.vn'
				//				}
				//	sendMailBlackList("blackListCN", arrTo, arrCc, ""+blackListCn.id+"", "Cập nhập Blacklist cá nhân",blackListCn.tenCnBL, blackListCn.cmndCnBL)
				def allBlacklistCn = BlackIndividual.findAllByStatusGreaterThanEquals(0)
				flash.message = "Anh/chị đã cập nhật thành công!"
				render (view:'/blacklist/searchCnBlacklist',model:[blackListCn:allBlacklistCn,currentUser:currentUser.username])
			}
		}
	}


	def deleteCnBlacklist = {
		println 'deleteCnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def blackListCn = BlackIndividual.get(params.blacklistId)
		blackListCn.status = -1
		if(blackListCn.save(flush:true)){
			//			def arrTo=[]
			//			def arrCc=[]
			//			if(blackListCn.usernhapCnBL.contains('@')){
			//				arrTo += blackListCn.usernhapCnBL
			//			}else{
			//				arrTo += blackListCn.usernhapCnBL+'@msb.com.vn'
			//			}
			//			sendMailBlackList("blackListCN", arrTo, arrCc, ""+blackListCn.id+"", "Xóa Blacklist cá nhân",blackListCn.tenCnBL, blackListCn.cmndCnBL)
			def allBlacklistCn = BlackIndividual.findAllByStatusGreaterThanEquals(0)
			flash.message = "Anh/chị đã xóa thành công!"
			render view:'/blacklist/searchCnBlacklist',model:[blackListCn:allBlacklistCn]
		}
	}

	/*- Modul Bkaclist : Pháp Nhân */


	def addPnBlacklist = {
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blackListPn
		if(params.blackListId){
			blackListPn = BlacklistCorporation.get(params.blackListId)
			blackListPn.status = 0
		}
		def listBlacklistCategory = BlacklistCategory.findAllByStatusGreaterThanEquals(0)
		render (view:'/blacklist/detailBlacklistPN',model:[blackListPn:blackListPn,currentUser:currentUser.username])
	}


	def detailPhapNhan ={
		def today = Calendar.getInstance()
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def blackListPn = BlacklistCorporation.createCriteria().list{

			// ge: lấy status >= 0 (g:greater, e:equal)
			ge('status',0)
			if(params.search){
				if(params.giayphepPnBL)
					eq("giayphepPnBL",params.giayphepPnBL)
				if(params.tenPnBL)
					eq("tenPnBL",params.tenPnBL,[ignoreCase: true])
				if(params.ngaycapPnBL)
					eq("ngaycapPnBL",Date.parse("dd/MM/yyyy",params.ngaycapPnBL))

				if(params.phapluatPnBL)
					eq("phapluatPnBL",params.phapluatPnBL)

				if(params.cmndPnBL)
					eq("cmndPnBL",params.cmndPnBL)

			}else {
				if(currentUserRole[0] =='ROLE_GDTT'){
					eq('usernhapPnBL',currentUser.username)

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL2'){
					eq('donvi_3',UnitDepart.get(errorMasterUser.tenDonVi3))

				}
				if(currentUserRole[0] == 'ROLE_GDTT_LEVEL3'){
					eq('donvi_2',UnitDepart.get(errorMasterUser.tenDonVi2))

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL4'){
					eq('donvi_1',UnitDepart.get(errorMasterUser.tenDonVi1))

				}
			}
		}
		// Hàm xuất ra file excel
		if(params.exportExcel=="ExportExcel"){
			def listBLPn = blackListPn
			def header
			def listContent = []
			//listContent<<header
			def tenPnBL,giayphepPnBL,ngaycapPnBL,noicapPnBL,diachiPnBL,masothuePnBL,phapluatPnBL,danhsachPnBL='',lydoPnBL,doituongPnBL='',thoihanPnBL,dulieuPnBL,
			tochucPnBL,hochieuPnBL,lydoLqPnBL,ghichuPnBL,ngaynhapPnBL,usernhapPnBL,phongbanPnBL,nguoisua,ngaysua

			listBLPn.each{
				println '>>>>>' +listBLPn
				tenPnBL=it.tenPnBL?it.tenPnBL:""
				giayphepPnBL =it.giayphepPnBL?it.giayphepPnBL:""
				ngaycapPnBL =it.ngaycapPnBL?DateUtil.formatDate(it.ngaycapPnBL):""
				noicapPnBL =it.noicapPnBL?it.noicapPnBL:""
				diachiPnBL = it.diachiPnBL?it.diachiPnBL:""
				masothuePnBL = it.masothuePnBL?it.masothuePnBL:""
				phapluatPnBL = it.phapluatPnBL?it.phapluatPnBL:""
				danhsachPnBL = it.danhsachPnBL?it.danhsachPnBL.name:""
				lydoPnBL =it.lydoPnBL?it.lydoPnBL:""
				doituongPnBL = it.doituongPnBL?it.doituongPnBL.name:""
				thoihanPnBL =it.thoihanPnBL?DateUtil.formatDate(it.thoihanPnBL):""
				dulieuPnBL = it.dulieuPnBL?it.dulieuPnBL:""
				tochucPnBL = it.tochucPnBL?it.tochucPnBL:""
				hochieuPnBL = it.hochieuPnBL?it.hochieuPnBL:""
				lydoLqPnBL = it.lydoLqPnBL?it.lydoLqPnBL:""
				ghichuPnBL = it.ghichuPnBL?it.ghichuPnBL:""
				ngaynhapPnBL =it.ngaynhapPnBL?DateUtil.formatDate(it.ngaynhapPnBL):""
				usernhapPnBL = it.usernhapPnBL?it.usernhapPnBL:""
				phongbanPnBL = it.phongbanPnBL?it.phongbanPnBL:""
				nguoisua = it.nguoisua?it.nguoisua:""
				ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

				header = [tenPnBL, giayphepPnBL, ngaycapPnBL, noicapPnBL, diachiPnBL, masothuePnBL, phapluatPnBL, danhsachPnBL='', lydoPnBL, doituongPnBL='', thoihanPnBL, dulieuPnBL, tochucPnBL, hochieuPnBL, lydoLqPnBL, ghichuPnBL, ngaynhapPnBL, usernhapPnBL, phongbanPnBL, nguoisua, ngaysua]
				// << = add từng row vào listcontent
				listContent<<header
			}
			def data
			data = exportExcelService.blacklistPnDisplay(listContent)
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}
		render (view:'/blacklist/searchPnBlacklist',model:[blackListPn:blackListPn])
	}


	def viewBlacklistPn = {
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blackListPn
		if (params.blacklistId){
			blackListPn = BlacklistCorporation.get(params.blacklistId)
		}
		def listBlacklistCategory = BlacklistCategory.findAllByStatusGreaterThanEquals(0)
		render view:'/blacklist/detailBlacklistPN',model:[blackListPn:blackListPn,currentUser:currentUser.username]
	}


	def savePnBlacklist = {
		println 'savePnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def userBLPn = ErrorMasterUserCreate.findByUserEmail(params.usernhapPnBL)
		def blackListPn = new BlacklistCorporation()
		if (params.saveEdit){
			redirect(action:'editPnBlacklist',params:params)
		}else if (params.deleteError == 'deletePnBl') {
			redirect(action:'deletePnBlacklist',params:params)
		}else if (BlacklistCorporation.findByGiayphepPnBL(params.giayphepPnBL)){
			flash.error = "ĐKKD/Giấy phép đầu tư đã tồn tại. Mời Anh/chị nhập lại!"
			redirect(action:'addPnBlacklist',params:params)
			return
		}else{
			blackListPn.tenPnBL = params.tenPnBL
			blackListPn.giayphepPnBL = params.giayphepPnBL
			blackListPn.ngaycapPnBL = Date.parse("dd/MM/yyyy", params.ngaycapPnBL)
			blackListPn.noicapPnBL = params.noicapPnBL
			blackListPn.diachiPnBL = params.diachiPnBL
			blackListPn.masothuePnBL = params.masothuePnBL
			blackListPn.phapluatPnBL = params.phapluatPnBL
			blackListPn.cmndPnBL = params.cmndPnBL
			blackListPn.lydoPnBL = params.lydoPnBL
			blackListPn.ghichuPnBL = params.ghichuPnBL
			blackListPn.dulieuPnBL = params.dulieuPnBL
			blackListPn.tochucPnBL = params.tochucPnBL
			blackListPn.hochieuPnBL = params.hochieuPnBL
			blackListPn.lydoLqPnBL = params.lydoLqPnBL
			blackListPn.thoihanPnBL = Date.parse("dd/MM/yyyy",params.thoihanPnBL)
			blackListPn.ngaynhapPnBL = Date.parse("dd/MM/yyyy",params.ngaynhapPnBL)
			blackListPn.usernhapPnBL = currentUser.username
			blackListPn.phongbanPnBL = params.phongbanPnBL
			blackListPn.danhsachPnBL = BlacklistCategory.get(params.danhsachPnBL)
			blackListPn.doituongPnBL = BlacklistObject.get(params.doituongPnBL)
			blackListPn.status = 0
			blackListPn.donvi_1 = UnitDepart.get(userBLPn.tenDonVi1)
			blackListPn.donvi_2 = UnitDepart.get(userBLPn.tenDonVi2)
			blackListPn.donvi_3 = UnitDepart.get(userBLPn.tenDonVi3)
			blackListPn.save()
			flash.message = "Anh/chị đã thêm mới thành công!"
			def allBlacklistPn = BlacklistCorporation.findAllByStatusGreaterThanEquals(0)
			render (view:'/blacklist/searchPnBlacklist',model:[blackListPn:allBlacklistPn])
		}
	}


	def editPnBlacklist = {
		println 'editPnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def allBlacklistPn = BlacklistCorporation.findAllByStatusGreaterThanEquals(0)
		def blackListPn = BlacklistCorporation.get(params.blacklistId)
		if (blackListPn){
			if (BlacklistCorporation.findByGiayphepPnBLAndIdNotEqual(params.giayphepPnBL, params.blacklistId)?.giayphepPnBL){
				flash.error = "ĐKKD/mã số thuế tổ chức liên quan đã tồn tại. Mời Anh/chị nhập lại!"
				redirect(action:'addPnBlacklist',params:params)
				return
			}else{
				blackListPn.tenPnBL = params.tenPnBL
				blackListPn.giayphepPnBL = params.giayphepPnBL
				blackListPn.ngaycapPnBL = Date.parse("dd/MM/yyyy", params.ngaycapPnBL)
				blackListPn.noicapPnBL = params.noicapPnBL
				blackListPn.diachiPnBL = params.diachiPnBL
				blackListPn.masothuePnBL = params.masothuePnBL
				blackListPn.phapluatPnBL = params.phapluatPnBL
				blackListPn.cmndPnBL = params.cmndPnBL
				blackListPn.lydoPnBL = params.lydoPnBL
				blackListPn.ghichuPnBL = params.ghichuPnBL
				blackListPn.dulieuPnBL = params.dulieuPnBL
				blackListPn.tochucPnBL = params.tochucPnBL
				blackListPn.hochieuPnBL = params.hochieuPnBL
				blackListPn.lydoLqPnBL = params.lydoLqPnBL
				blackListPn.thoihanPnBL = Date.parse("dd/MM/yyyy",params.thoihanPnBL)
				blackListPn.ngaynhapPnBL = Date.parse("dd/MM/yyyy",params.ngaynhapPnBL)
				blackListPn.danhsachPnBL = BlacklistCategory.get(params.danhsachPnBL)
				blackListPn.doituongPnBL = BlacklistObject.get(params.doituongPnBL)
				blackListPn.nguoisua = currentUser.username
				blackListPn.ngaysua = new Date()
				blackListPn.status = 0
				if(blackListPn.save(flush:true)){
					//					def arrTo=[]
					//					def arrCc=[]
					//					if(blackListPn.usernhapPnBL.contains('@')){
					//						arrTo += blackListPn.usernhapPnBL
					//					}else{
					//						arrTo += blackListPn.usernhapPnBL+'@msb.com.vn'
					//					}
					//					sendMailBlackList("blackListPN", arrTo, arrCc, ""+blackListPn.id+"", "Cập nhập Blacklist pháp nhân",blackListPn.tenPnBL, blackListPn.giayphepPnBL)

					flash.message = "Anh/chị đã cập nhập thành công!"
					render view:'/blacklist/searchPnBlacklist',model:[blackListPn:allBlacklistPn,currentUser:currentUser.username]
				}
			}
		}

	}


	def deletePnBlacklist = {
		println 'deletePnBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def blackListPn = BlacklistCorporation.get(params.blacklistId)
		blackListPn.status = -1
		if(blackListPn.save(flush:true)){
			//			def arrTo=[]
			//			def arrCc=[]
			//			if(blackListPn.usernhapPnBL.contains('@')){
			//				arrTo += blackListPn.usernhapPnBL
			//			}else{
			//				arrTo += blackListPn.usernhapPnBL+'@msb.com.vn'
			//			}
			//			sendMailBlackList("blackListPN", arrTo, arrCc, ""+blackListPn.id+"", "Xóa Blacklist pháp nhân",blackListPn.tenPnBL, blackListPn.giayphepPnBL)
			flash.mesage = "Anh/chị đã xóa thành công!"
			def allBlacklistPn = BlacklistCorporation.findAllByStatusGreaterThanEquals(0)
			render view:'/blacklist/searchPnBlacklist',model:[blackListPn:allBlacklistPn]
		}
	}

	/*- Modul Bkaclist : Tài sản bảo đảm */


	def detailQLTaiSan ={
		def listloaiTsBL = BlacklistTaiSan.get(params.loaiTsBL)
		def today = Calendar.getInstance()
		def currentUserRole = springSecurityService.authentication.getAuthorities()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def errorMasterUser=ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def blacklistTsbd = BlacklistTSBD.createCriteria().list{
			// ge: lấy status >= 0 (g:greater, e:equal)
			ge('status',0)
			if(params.search){
				if(listloaiTsBL)
					eq('loaiTsBL',BlacklistTaiSan.get(listloaiTsBL.id))
				if(params.thongtinTsBL)
					eq("thongtinTsBL",params.thongtinTsBL)
				if(params.motaTsBL)
					eq("motaTsBL",params.motaTsBL)
				if(params.sohuuTsBL)
					eq("sohuuTsBL",params.sohuuTsBL,[ignoreCase: true])

				if(params.cmtcshTsBL)
					eq("cmtcshTsBL",params.cmtcshTsBL)

			}else {
				if(currentUserRole[0] =='ROLE_GDTT'){
					eq('usernhapTsBL',currentUser.username)

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL2'){
					eq('donvi_3',UnitDepart.get(errorMasterUser.tenDonVi3))

				}
				if(currentUserRole[0] == 'ROLE_GDTT_LEVEL3'){
					eq('donvi_2',UnitDepart.get(errorMasterUser.tenDonVi2))

				}

				if(currentUserRole[0] =='ROLE_GDTT_LEVEL4'){
					eq('donvi_1',UnitDepart.get(errorMasterUser.tenDonVi1))

				}
			}
		}

		// Hàm xuất ra file excel
		if(params.exportExcel=="ExportExcel"){
			def listBLTsbd = BlacklistTSBD.findAllByStatusGreaterThanEquals(0)
			def header
			def listContent = []
			//listContent<<header
			def loaiTsBL,thongtinTsBL,motaTsBL,sohuuTsBL,cmtcshTsBL,masothueTsBL,canhanTsBL,cmtlqTsBL,lydoTsBL,giatriTsBL,
			lichsuGdTsBL,riskTsdbTsBL,doituongTsBL,lydoCtTsBL,thoihanTsBL,dulieuTsBL,ghichuTsBL,ngaynhapTsBL,usernhapTsBL,phongbanTsBl,nguoisua,ngaysua

			listBLTsbd.each{

				loaiTsBL=it.loaiTsBL?it.loaiTsBL.name:""
				thongtinTsBL =it.thongtinTsBL?it.thongtinTsBL:""
				motaTsBL =it.motaTsBL?it.motaTsBL:""
				sohuuTsBL = it.sohuuTsBL?it.sohuuTsBL:""
				cmtcshTsBL = it.cmtcshTsBL?it.cmtcshTsBL:""
				masothueTsBL = it.masothueTsBL?it.masothueTsBL:""
				canhanTsBL = it.canhanTsBL?it.canhanTsBL:""
				cmtlqTsBL =it.cmtlqTsBL?it.cmtlqTsBL:""
				lydoTsBL = it.lydoTsBL?it.lydoTsBL:""
				giatriTsBL = it.giatriTsBL?it.giatriTsBL:""
				lichsuGdTsBL = it.lichsuGdTsBL?it.lichsuGdTsBL:""
				riskTsdbTsBL = it.riskTsdbTsBL?it.riskTsdbTsBL.name:""
				doituongTsBL = it.doituongTsBL?it.doituongTsBL.name:""
				lydoCtTsBL = it.lydoCtTsBL?it.lydoCtTsBL:""
				thoihanTsBL =it.thoihanTsBL?DateUtil.formatDate(it.thoihanTsBL):""
				dulieuTsBL = it.dulieuTsBL?it.dulieuTsBL:""
				ghichuTsBL = it.ghichuTsBL?it.ghichuTsBL:""
				ngaynhapTsBL =it.ngaynhapTsBL?DateUtil.formatDate(it.ngaynhapTsBL):""
				usernhapTsBL = it.usernhapTsBL?it.usernhapTsBL:""
				phongbanTsBl = it.phongbanTsBl?it.phongbanTsBl:""
				nguoisua = it.nguoisua?it.nguoisua:""
				ngaysua =it.ngaysua?DateUtil.formatDate(it.ngaysua):""

				header = [loaiTsBL, thongtinTsBL, motaTsBL, sohuuTsBL, cmtcshTsBL, masothueTsBL, canhanTsBL, cmtlqTsBL, lydoTsBL, giatriTsBL, lichsuGdTsBL, riskTsdbTsBL, doituongTsBL, lydoCtTsBL, thoihanTsBL, dulieuTsBL, ghichuTsBL, ngaynhapTsBL, usernhapTsBL, phongbanTsBl, nguoisua, ngaysua]
				// << = add từng row vào listcontent
				listContent<<header
			}
			def data
			data = exportExcelService.blacklistTsbdDisplay(listContent)
			//File download
			response.setContentType("application/vnd.ms-excel")
			response.setHeader("Content-disposition", "attachment;filename=${data['file']}")
			response.outputStream << ( new ByteArrayInputStream(data['data'].getBytes("UTF-8")) )
		}
		render (view:'/blacklist/searchTsBlacklist',model:[blacklistTsbd:blacklistTsbd])
	}


	def addTsbdBlacklist = {
		def blacklistTsbd
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		if (params.blacklistId){
			blacklistTsbd = BlacklistTSBD.get(params.blacklistId)
		}
		def listBlacklistRiskTSBD = BlacklistRiskTSBD.findAllByStatusGreaterThanEquals(0)
		render (view:'/blacklist/detailBlacklistTSDB',model:[blacklistTsbd:blacklistTsbd,currentUser:currentUser.username])
	}


	def viewBlacklistTSBD = {
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blacklistTsbd
		if (params.blacklistId){
			blacklistTsbd = BlacklistTSBD.get(params.blacklistId)
		}
		def listBlacklistRiskTSBD = BlacklistRiskTSBD.findAllByStatusGreaterThanEquals(0)
		render view:'/blacklist/detailBlacklistTSDB',model:[blacklistTsbd:blacklistTsbd,currentUser:currentUser.username]
	}


	def saveTsbdBlacklist = {
		println 'saveTsbdBlacklist' + new Date() + params
		def today = Calendar.getInstance()

		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def userBLTsbd = ErrorMasterUserCreate.findByUserEmail(params.usernhapTsBL)
		def blacklistTsbd = new BlacklistTSBD()
		if (params.saveEdit){
			redirect(action:'editTsbdBlacklist',params:params)
		}else if (params.deleteError == 'deleteTsbdBl') {
			redirect(action:'deleteTsbdBlacklist',params:params)
		}else if (BlacklistTSBD.findByThongtinTsBL(params.thongtinTsBL)){
			flash.error = "Thông tin nhân diện tài sản đã tồn tại. Mời Anh/chị nhập lại!"
			redirect(action:'addTsbdBlacklist',params:params)
			return
		}else{
			blacklistTsbd.loaiTsBL = BlacklistTaiSan.get(params.loaiTsBL)
			blacklistTsbd.thongtinTsBL = params.thongtinTsBL
			blacklistTsbd.sohuuTsBL = params.sohuuTsBL
			blacklistTsbd.cmtcshTsBL = params.cmtcshTsBL
			blacklistTsbd.masothueTsBL = params.masothueTsBL
			blacklistTsbd.canhanTsBL = params.canhanTsBL
			blacklistTsbd.cmtlqTsBL = params.cmtlqTsBL
		//	blacklistTsbd.lydoTsBL = params.lydoTsBL
			blacklistTsbd.diachiTsBL = params.diachiTsBL
			blacklistTsbd.ngaynhapTsBL = params.ngaynhapTsBL?Date.parse("dd/MM/yyyy",params.ngaynhapTsBL):null
			blacklistTsbd.ngaycapTsBL = params.ngaycapTsBL?Date.parse("dd/MM/yyyy",params.ngaycapTsBL):null
			blacklistTsbd.motaTsBL = params.motaTsBL
			blacklistTsbd.giatriTsBL  = params.giatriTsBL
			blacklistTsbd.lichsuGdTsBL = params.lichsuGdTsBL
			blacklistTsbd.lydoCtTsBL = params.lydoCtTsBL
			blacklistTsbd.thoihanTsBL = Date.parse("dd/MM/yyyy",params.thoihanTsBL)
			blacklistTsbd.dulieuTsBL = params.dulieuTsBL
			blacklistTsbd.ghichuTsBL = params.ghichuTsBL
			blacklistTsbd.usernhapTsBL = currentUser.username
			blacklistTsbd.phongbanTsBl = params.phongbanTsBl
			blacklistTsbd.riskTsdbTsBL = BlacklistRiskTSBD.get(params.riskTsdbTsBL)
			blacklistTsbd.doituongTsBL = BlacklistObject.get(params.doituongTsBL)
			blacklistTsbd.status = 0
			blacklistTsbd.donvi_1 = UnitDepart.get(userBLTsbd.tenDonVi1)
			blacklistTsbd.donvi_2 = UnitDepart.get(userBLTsbd.tenDonVi2)
			blacklistTsbd.donvi_3 = UnitDepart.get(userBLTsbd.tenDonVi3)
			blacklistTsbd.save(flush:true)

			flash.message = "Anh/chị đã tạo mới thành công!"
			def allBlacklistTsbd = BlacklistTSBD.findAllByStatusGreaterThanEquals(0)
			render view:'/blacklist/searchTsBlacklist',model:[blacklistTsbd:allBlacklistTsbd]
			//		}
		}
	}

	def editTsbdBlacklist = {
		println 'editTsbdBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def currentUser = User.findByUsername(springSecurityService.authentication.getName())
		def blacklistTsbd = BlacklistTSBD.get(params.blacklistId)
		if(blacklistTsbd){
			if (BlacklistTSBD.findByThongtinTsBLAndIdNotEqual(params.thongtinTsBL, params.blacklistId)?.thongtinTsBL){
				flash.error = "Thông tin nhân diện tài sản đã tồn tại. Mời Anh/chị nhập lại!"
				redirect(action:'addTsbdBlacklist',params:params)
				return
			}
			blacklistTsbd.loaiTsBL = BlacklistTaiSan.get(params.loaiTsBL)
			blacklistTsbd.thongtinTsBL = params.thongtinTsBL
			blacklistTsbd.sohuuTsBL = params.sohuuTsBL
			blacklistTsbd.cmtcshTsBL = params.cmtcshTsBL
			blacklistTsbd.masothueTsBL = params.masothueTsBL
			blacklistTsbd.canhanTsBL = params.canhanTsBL
			blacklistTsbd.cmtlqTsBL = params.cmtlqTsBL
	//		blacklistTsbd.lydoTsBL = params.lydoTsBL
			blacklistTsbd.diachiTsBL = params.diachiTsBL
			blacklistTsbd.ngaynhapTsBL = params.ngaynhapTsBL?Date.parse("dd/MM/yyyy",params.ngaynhapTsBL):null
			blacklistTsbd.ngaycapTsBL = params.ngaycapTsBL?Date.parse("dd/MM/yyyy",params.ngaycapTsBL):null
			blacklistTsbd.motaTsBL = params.motaTsBL
			blacklistTsbd.giatriTsBL  = params.giatriTsBL
			blacklistTsbd.lichsuGdTsBL = params.lichsuGdTsBL
			blacklistTsbd.lydoCtTsBL = params.lydoCtTsBL
			blacklistTsbd.thoihanTsBL = Date.parse("dd/MM/yyyy",params.thoihanTsBL)
			blacklistTsbd.dulieuTsBL = params.dulieuTsBL
			blacklistTsbd.ghichuTsBL = params.ghichuTsBL
			blacklistTsbd.riskTsdbTsBL = BlacklistRiskTSBD.get(params.riskTsdbTsBL)
			blacklistTsbd.doituongTsBL = BlacklistObject.get(params.doituongTsBL)
			blacklistTsbd.nguoisua = currentUser.username
			blacklistTsbd.ngaysua = new Date()
			blacklistTsbd.status = 0
			if(blacklistTsbd.save(flush:true)){
				//				def arrTo=[]
				//				def arrCc=[]
				//				if(blacklistTsbd.usernhapTsBL.contains('@')){
				//					arrTo += blacklistTsbd.usernhapTsBL
				//				}else{
				//					arrTo += blacklistTsbd.usernhapTsBL+'@msb.com.vn'
				//				}
				//				sendMailBlackList("blackListTSBD", arrTo, arrCc, ""+blacklistTsbd.id+"", "Cập nhập Blacklist tài sản đảm bảo",blacklistTsbd.loaiTsBL.name, blacklistTsbd.thongtinTsBL)
				flash.message = "Anh/chị đã cập nhập thành công!"
				def allBlacklistTsbd = BlacklistTSBD.findAllByStatusGreaterThanEquals(0)
				render view:'/blacklist/searchTsBlacklist',model:[blacklistTsbd:allBlacklistTsbd,currentUser:currentUser.username]
			}
		}
	}


	def deleteTsbdBlacklist = {
		println 'deleteTsbdBlacklist' + new Date() + ":" + params
		def today = Calendar.getInstance()
		def blacklistTsbd = BlacklistTSBD.get(params.blacklistId)
		blacklistTsbd.status = -1
		if(blacklistTsbd.save(flush:true)){
			//			def arrTo=[]
			//			def arrCc=[]
			//			if(blacklistTsbd.usernhapTsBL.contains('@')){
			//				arrTo += blacklistTsbd.usernhapTsBL
			//			}else{
			//				arrTo += blacklistTsbd.usernhapTsBL+'@msb.com.vn'
			//			}
			//			sendMailBlackList("blackListTSBD", arrTo, arrCc, ""+blacklistTsbd.id+"", "Xóa Blacklist tài sản đảm bảo",blacklistTsbd.loaiTsBL.name, blacklistTsbd.thongtinTsBL)
			def allBlacklistTsbd = BlacklistTSBD.findAllByStatusGreaterThanEquals(0)
			flash.message = "Anh/chị đã xóa thành công!"
			render view:'/blacklist/searchTsBlacklist',model:[blacklistTsbd:allBlacklistTsbd]
		}
	}

	//	def sendMailBlackList(String code,def to, def cc, String Id,String action ,String nameBl,String cmtBl){
	//		if(ErrorMail.findByCode('Check').enableSendEmail=='Y'){
	//			def to2 = [],to3 = []
	//			def cc2 = [],cc3 = []
	//			cc2 = cc
	//			to2 = to
	//
	//			for(int i=0;i<to2.size();i++){
	//				to3[i] = riskService.convertEmail(to2[i])
	//			}
	//			for(int i=0;i<cc2.size();i++){
	//				cc3[i] = riskService.convertEmail(cc2[i])
	//			}
	//			def errorMail = ErrorMail.findByCode(code)
	//			if (errorMail.enableSendEmail=='Y' && code == "blackListCN" || code == "blackListPN" || code == "blackListTSBD"){
	//				def content = MessageFormat.format(errorMail.content, [action, nameBl, cmtBl, Id].toArray())
	//				def subject = MessageFormat.format(errorMail.subject, [Id, action].toArray())
	//				sendMail(to3,content,cc3,subject)
	//				//sendMail(["sonnt9@m1tech.com.vn"], content, ["sonnt9@m1tech.com.vn"], subject)
	//			}
	//		}
	//	}


	//	def sendMail(def toEmail, String htmlContent,def ccEmail,String sub){
	//		sendMail {
	//			multipart true
	//			from new String("qlrr_oprisk@msb.com.vn")
	//			//to new String(toEmail)
	//			to toEmail.toArray()
	//			//cc toEmail
	//			cc ccEmail.toArray()
	//			subject new String(sub)
	//			html htmlContent
	//		}
	//	}


	def validateAndSave(def saveObj,String name){
		if (!saveObj.validate()) {
			saveObj.errors.each {
				println "ERROR WHEN VALIDATING "+name
				println it
			}
		}else{
			if (!saveObj.save(flush:true)) {
				saveObj.errors.each {
					println "ERROR WHEN SAVING "+name
					println it
				}
			}
		}
	}
}
