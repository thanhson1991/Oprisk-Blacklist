import msb.platto.fingerprint.User

import org.apache.poi.ss.usermodel.Cell
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook

class ImportExcelController {
    def springSecurityService
	def riskService
    def index = { }
    def showImportCN = {
        ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
        def importCN = BlackListCNImport.findAllByUsernhapCnBLAndStatus(springSecurityService.principal.username,'PENDING')
        render (view:'/blacklist/importExcelCN',model: [importCN:importCN])
    }
    def doUploadCN = {
        ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
        def uploadFile = request.getFile('uploadField')
        XSSFWorkbook workbook = new XSSFWorkbook(uploadFile.getInputStream())
        Sheet sheet = workbook.getSheetAt(0);
        def listimportCN = []
        def tempBlackLítCN

        // skip first row (row 0) by starting from 1

        if(sheet.getPhysicalNumberOfRows()<=1){
            flash.error = "File excel không có dữ liệu"
        }
        else if(sheet.getPhysicalNumberOfRows()>5001){
            flash.error = "File excel có quá 5000 dòng dữ liệu , đề nghị anh/chị chia nhỏ file"
        }
        else{
            try{
                for (int row = 1; row < sheet.getPhysicalNumberOfRows(); row++) {
                    Cell tenCnBL = sheet.getRow(row).getCell(0)
                    Cell ngaysinhCnBL = sheet.getRow(row).getCell(1)
                    Cell cmndCnBL = sheet.getRow(row).getCell(2)
                    Cell ngaycapCnBL = sheet.getRow(row).getCell(3)
                    Cell noicapCnBl = sheet.getRow(row).getCell(4)
                    Cell cmnd2CnBL = sheet.getRow(row).getCell(5)
                    Cell ngaycap2CnBL = sheet.getRow(row).getCell(6)
                    Cell noicap2CnBl = sheet.getRow(row).getCell(7)
                    Cell diachiCnBL = sheet.getRow(row).getCell(8)
                    Cell sdtCnBl = sheet.getRow(row).getCell(9)
                    Cell danhsachCnBL = sheet.getRow(row).getCell(10)
                    Cell lydochitietCnBL = sheet.getRow(row).getCell(11)
                    Cell doituongCnBL = sheet.getRow(row).getCell(12)
                    Cell thoihanCnBL = sheet.getRow(row).getCell(13)
                    Cell dulieuCnBl = sheet.getRow(row).getCell(14)
                    Cell tochucCnBL = sheet.getRow(row).getCell(15)
                    Cell masothueCnBL = sheet.getRow(row).getCell(16)
                    Cell lydoCnBl = sheet.getRow(row).getCell(17)
                    Cell ghichuCnBL = sheet.getRow(row).getCell(18)

                    println('ket thuc doc cell')
                    tempBlackLítCN = new BlackListCNImport()
                    if(tenCnBL && getCellValue(tenCnBL)){
                        tempBlackLítCN.tenCnBL = getCellValue(tenCnBL)
                    }else{
                        flash.error = "Dòng "+(row+1)+" cột Họ Tên lỗi dữ liệu"
                        redirect(action: "showImportCN")
                        return
                    }
                    if(ngaysinhCnBL){
                        try{
                            tempBlackLítCN.ngaysinhCnBL = ngaysinhCnBL.getDateCellValue()
                        }catch (e){
                            flash.error = "Dòng "+(row+1)+" cột Ngày sinh lỗi dữ liệu"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        tempBlackLítCN.ngaysinhCnBL = null
                    }
                    if(cmndCnBL && getCellValue(cmndCnBL)){
                        tempBlackLítCN.cmndCnBL = getCellValue(cmndCnBL)
                    }else{
                        flash.error = "Dòng "+(row+1)+" cột CMND/Hô chiếu lỗi dữ liệu"
                        redirect(action: "showImportCN")
                        return
                    }
                    if(ngaycapCnBL){
                        try{
                            tempBlackLítCN.ngaycapCnBL = ngaycapCnBL.getDateCellValue()
                        }catch (e){
                            flash.error = "Dòng "+(row+1)+" cột Ngày cấp thứ nhất lỗi dữ liệu"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        tempBlackLítCN.ngaycapCnBL = null
                    }
                    if(noicapCnBl && getCellValue(noicapCnBl)){
                        tempBlackLítCN.noicapCnBl = getCellValue(noicapCnBl)
                    }else{
                        tempBlackLítCN.noicapCnBl = ''
                    }
                    if(cmnd2CnBL && getCellValue(cmnd2CnBL)){
                        tempBlackLítCN.cmnd2CnBL = getCellValue(cmnd2CnBL)
                    }else{
                        tempBlackLítCN.cmnd2CnBL = ''
                    }
                    if(ngaycap2CnBL){
                        try{
                            tempBlackLítCN.ngaycap2CnBL = ngaycap2CnBL.getDateCellValue()
                        }catch (e){
                            flash.error = "Dòng "+(row+1)+" cột Ngày cấp thứ hai lỗi dữ liệu"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        tempBlackLítCN.ngaycap2CnBL = null
                    }
                    if(noicap2CnBl && getCellValue(noicap2CnBl)){
                        tempBlackLítCN.noicap2CnBl = getCellValue(noicap2CnBl)
                    }else{
                        tempBlackLítCN.noicap2CnBl = ''
                    }
                    if(diachiCnBL && getCellValue(diachiCnBL)){
                        tempBlackLítCN.diachiCnBL = getCellValue(diachiCnBL)
                    }else{
                        tempBlackLítCN.diachiCnBL = ''
                    }
                    if(sdtCnBl && getCellValue(sdtCnBl)){
                        tempBlackLítCN.sdtCnBl = getCellValue(sdtCnBl)
                    }else{
                        tempBlackLítCN.sdtCnBl = ''
                    }
                    if(danhsachCnBL && getCellValue(danhsachCnBL)){
                        if(BlacklistCategory.findByName(getCellValue(danhsachCnBL))){
                            tempBlackLítCN.danhsachCnBL = BlacklistCategory.findByName(getCellValue(danhsachCnBL))
                        }else{
                            flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách dữ liệu không tồn tại trong danh sách lý do"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách lỗi dữ liệu"
                        redirect(action: "showImportCN")
                        return
                    }
                    if(lydochitietCnBL && getCellValue(lydochitietCnBL)){
                        tempBlackLítCN.lydochitietCnBL = getCellValue(lydochitietCnBL)
                    }else{
                        tempBlackLítCN.lydochitietCnBL = ''
                    }
                    if(doituongCnBL && getCellValue(doituongCnBL)){
                        if(BlacklistObject.findByName(getCellValue(doituongCnBL))){
                            tempBlackLítCN.doituongCnBL = BlacklistObject.findByName(getCellValue(doituongCnBL))
                        }else{
                            flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng dữ liệu không tồn tại trong danh sách phân loại"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng lỗi dữ liệu"
                        redirect(action: "showImportCN")
                        return
                    }
                    if(thoihanCnBL){
                        try{
                            tempBlackLítCN.thoihanCnBL = thoihanCnBL.getDateCellValue()
                        }catch (e){
                            flash.error = "Dòng "+(row+1)+" cột Thời hạn lỗi dữ liệu"
                            redirect(action: "showImportCN")
                            return
                        }
                    }else{
                        Calendar cal = Calendar.getInstance();
                        cal.add(Calendar.YEAR, 10);
                        Date next10Year = cal.getTime();
                        tempBlackLítCN.thoihanCnBL = next10Year
                    }
                    if(dulieuCnBl && getCellValue(dulieuCnBl)){
                        tempBlackLítCN.dulieuCnBl = getCellValue(dulieuCnBl)
                    }else{
                        tempBlackLítCN.dulieuCnBl = ''
                    }
                    if(tochucCnBL && getCellValue(tochucCnBL)){
                        tempBlackLítCN.tochucCnBL = getCellValue(tochucCnBL)
                    }else{
                        tempBlackLítCN.tochucCnBL = ''
                    }
                    if(masothueCnBL && getCellValue(masothueCnBL)){
                        tempBlackLítCN.masothueCnBL = getCellValue(masothueCnBL)
                    }else{
                        tempBlackLítCN.masothueCnBL = ''
                    }
                    if(lydoCnBl && getCellValue(lydoCnBl)){
                        tempBlackLítCN.lydoCnBl = getCellValue(lydoCnBl)
                    }else{
                        tempBlackLítCN.lydoCnBl = ''
                    }
                    if(ghichuCnBL && getCellValue(ghichuCnBL)){
                        tempBlackLítCN.ghichuCnBL = getCellValue(ghichuCnBL)
                    }else{
                        tempBlackLítCN.ghichuCnBL = ''
                    }
                    tempBlackLítCN.donvi_1 = UnitDepart.get(currentUser.tenDonVi1)
                    tempBlackLítCN.donvi_2 = UnitDepart.get(currentUser.tenDonVi2)
                    tempBlackLítCN.donvi_3 = UnitDepart.get(currentUser.tenDonVi3)
                    tempBlackLítCN.ngaynhapCnBL = new Date()
                    tempBlackLítCN.usernhapCnBL = currentUser.userEmail
                    tempBlackLítCN.phongbanCnBl = UnitDepart.get(currentUser.tenDonVi3).name
                    tempBlackLítCN.nguoisua = currentUser.userEmail
                    tempBlackLítCN.ngaysua = new Date()
                    tempBlackLítCN.status = 'PENDING'
                    listimportCN << tempBlackLítCN
                }
            }catch (e){
                flash.error = "Lỗi template đề nghị kiểm tra lại"
                redirect(action: "showImportCN")
                return
            }
            int countSave = 0
            if(listimportCN.size()>0){
                listimportCN.each {BlackListCNImport varBlackCN ->
                    countSave++
                    try {
                        varBlackCN.save(flush:true)
                    }catch (e){
                        flash.error = "Dòng "+countSave+"lỗi dữ liệu khi lưu vào bảng tạm"
                        redirect(action: "showImportCN")
                        return
                    }
                }
            }
            flash.message = "Import dữ liệu vào bảng tạm thành công"
        }
        redirect (action:'showImportCN')
    }
    def transferImportCN = {
        def importCN = BlackListCNImport.findAllByUsernhapCnBLAndStatus(springSecurityService.principal.username,'PENDING')
        try{
            importCN.each {BlackListCNImport varBlackCN ->
                def checkBlackListCN = BlackIndividual.findByCmndCnBLAndStatus(varBlackCN.cmndCnBL,0)
                if(checkBlackListCN){
                    varBlackCN.status = 0
                    varBlackCN.usernhapCnBL = checkBlackListCN.usernhapCnBL
                    varBlackCN.ngaynhapCnBL = checkBlackListCN.ngaynhapCnBL
                    checkBlackListCN.properties = varBlackCN.properties
                    checkBlackListCN.save()
                    varBlackCN.status = 'COMPLETED'
                    varBlackCN.save()
                }else{
                    varBlackCN.status = 0
                    def newBlackListCN = new BlackIndividual(varBlackCN.properties)
                    newBlackListCN.save()
                    varBlackCN.status = 'COMPLETED'
                    varBlackCN.save()
                }
            }
        }catch (e){
            flash.error = "Lỗi dữ liệu khi import từ bảng tạm vào hệ thống"
            redirect(action: "showImportCN")
            return
        }
        flash.message = "Import dữ liệu từ bảng tạm vào hệ thống thành công"
        redirect (action:'showImportCN')
    }
    def deleteImportCN = {
        def importCN = BlackListCNImport.findAllByUsernhapCnBLAndStatus(springSecurityService.principal.username,'PENDING')
        try{
            importCN.each {BlackListCNImport varBlackCN ->
                varBlackCN.status = 'DELETED'
                varBlackCN.save()
            }
        }catch (e){
            flash.error = "Xóa bảng tạm không thành công"
            redirect(action: "showImportCN")
            return
        }
        flash.message = "Xóa dữ liệu bảng tạm thành công"
        redirect (action:'showImportCN')
    }
    def showImportCop = {
        ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
        def importCop = BlackListCopImport.findAllByUsernhapPnBLAndStatus(springSecurityService.principal.username,'PENDING')
        render (view:'/blacklist/importExcelCop',model: [importCop:importCop])
    }
    
	def doUploadCop = {
		ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def uploadFile = request.getFile('uploadField')
		XSSFWorkbook workbook = new XSSFWorkbook(uploadFile.getInputStream())
		Sheet sheet = workbook.getSheetAt(0);
		def listimportCop = []
		def tempBlackListCop

		// skip first row (row 0) by starting from 1

		if(sheet.getPhysicalNumberOfRows()<=1){
			flash.error = "File excel không có dữ liệu"
		}
        else if(sheet.getPhysicalNumberOfRows()>5001){
            flash.error = "File excel có quá 5000 dòng dữ liệu , đề nghị anh/chị chia nhỏ file"
        }
        else{
			try{
				for (int row = 1; row < sheet.getPhysicalNumberOfRows(); row++) {
					Cell tenPnBL = sheet.getRow(row).getCell(0)
					Cell giayphepPnBL = sheet.getRow(row).getCell(1)
					Cell ngaycapPnBL = sheet.getRow(row).getCell(2)
					Cell noicapPnBL = sheet.getRow(row).getCell(3)
					Cell diachiPnBL = sheet.getRow(row).getCell(4)
					Cell masothuePnBL = sheet.getRow(row).getCell(5)
					Cell phapluatPnBL = sheet.getRow(row).getCell(6)
					Cell cmndPnBL = sheet.getRow(row).getCell(7)
					Cell danhsachPnBL = sheet.getRow(row).getCell(8)
					Cell lydoPnBL = sheet.getRow(row).getCell(9)
					Cell doituongPnBL = sheet.getRow(row).getCell(10)
					Cell thoihanPnBL = sheet.getRow(row).getCell(11)
					Cell dulieuPnBL = sheet.getRow(row).getCell(12)
					Cell tochucPnBL = sheet.getRow(row).getCell(13)
					Cell hochieuPnBL = sheet.getRow(row).getCell(14)
					Cell lydoLqPnBL = sheet.getRow(row).getCell(15)
					Cell ghichuPnBL = sheet.getRow(row).getCell(16)

					println('ket thuc doc cell')
					tempBlackListCop = new BlackListCopImport()
					if(tenPnBL && getCellValue(tenPnBL)){
						tempBlackListCop.tenPnBL = getCellValue(tenPnBL)
					}else{
						flash.error = "Dòng "+(row+1)+" cột Tên doanh nghiệp lỗi dữ liệu"
						redirect(action: "showImportCop")
						return
					}
					if(giayphepPnBL && getCellValue(giayphepPnBL)){
						tempBlackListCop.giayphepPnBL = getCellValue(giayphepPnBL)
					}else{
						flash.error = "Dòng "+(row+1)+" cột Số ĐKKD/Giấy phép đầu tư lỗi dữ liệu"
						redirect(action: "showImportCop")
						return
					}
					if(ngaycapPnBL){
						try{
							tempBlackListCop.ngaycapPnBL = ngaycapPnBL.getDateCellValue()
						}catch (e){
							flash.error = "Dòng "+(row+1)+" cột Ngày cấp ĐKKD lỗi dữ liệu"
							redirect(action: "showImportCop")
							return
						}
					}else{
						tempBlackListCop.ngaycapPnBL = null
					}
					if(noicapPnBL && getCellValue(noicapPnBL)){
						tempBlackListCop.noicapPnBL = getCellValue(noicapPnBL)
					}else{
						tempBlackListCop.noicapPnBL = ''
					}
					if(diachiPnBL && getCellValue(diachiPnBL)){
						tempBlackListCop.diachiPnBL = getCellValue(diachiPnBL)
					}else{
						tempBlackListCop.diachiPnBL = ''
					}
					if(masothuePnBL && getCellValue(masothuePnBL)){
						tempBlackListCop.masothuePnBL = getCellValue(masothuePnBL)
					}else{
						tempBlackListCop.masothuePnBL = ''
					}
					if(phapluatPnBL && getCellValue(phapluatPnBL)){
						tempBlackListCop.phapluatPnBL = getCellValue(phapluatPnBL)
					}else{
						tempBlackListCop.phapluatPnBL = ''
					}
					if(cmndPnBL && getCellValue(cmndPnBL)){
						tempBlackListCop.cmndPnBL = getCellValue(cmndPnBL)
					}else{
						tempBlackListCop.cmndPnBL = ''
					}
					if(danhsachPnBL && getCellValue(danhsachPnBL)){
						if(BlacklistCategory.findByName(getCellValue(danhsachPnBL))){
							tempBlackListCop.danhsachPnBL = BlacklistCategory.findByName(getCellValue(danhsachPnBL))
						}else{
							flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách dữ liệu không tồn tại trong danh sách lý do"
							redirect(action: "showImportCop")
							return
						}
					}else{
						flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách lỗi dữ liệu"
						redirect(action: "showImportCop")
						return
					}
					if(lydoPnBL && getCellValue(lydoPnBL)){
						tempBlackListCop.lydoPnBL = getCellValue(lydoPnBL)
					}else{
						tempBlackListCop.lydoPnBL = ''
					}
					if(doituongPnBL && getCellValue(doituongPnBL)){
						if(BlacklistObject.findByName(getCellValue(doituongPnBL))){
							tempBlackListCop.doituongPnBL = BlacklistObject.findByName(getCellValue(doituongPnBL))
						}else{
							flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng dữ liệu không tồn tại trong danh sách phân loại"
							redirect(action: "showImportCop")
							return
						}
					}else{
						flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng lỗi dữ liệu"
						redirect(action: "showImportCop")
						return
					}
					if(thoihanPnBL){
						try{
							tempBlackListCop.thoihanPnBL = thoihanPnBL.getDateCellValue()
						}catch (e){
							flash.error = "Dòng "+(row+1)+" cột Thời hạn lỗi dữ liệu"
							redirect(action: "showImportCop")
							return
						}
					}else{
						Calendar cal = Calendar.getInstance();
						cal.add(Calendar.YEAR, 10);
						Date next10Year = cal.getTime();
						tempBlackListCop.thoihanPnBL = next10Year
					}
					if(dulieuPnBL && getCellValue(dulieuPnBL)){
						tempBlackListCop.dulieuPnBL = getCellValue(dulieuPnBL)
					}else{
						tempBlackListCop.dulieuPnBL = ''
					}
					if(tochucPnBL && getCellValue(tochucPnBL)){
						tempBlackListCop.tochucPnBL = getCellValue(tochucPnBL)
					}else{
						tempBlackListCop.tochucPnBL = ''
					}
					if(hochieuPnBL && getCellValue(hochieuPnBL)){
						tempBlackListCop.hochieuPnBL = getCellValue(hochieuPnBL)
					}else{
						tempBlackListCop.hochieuPnBL = ''
					}
					if(lydoLqPnBL && getCellValue(lydoLqPnBL)){
						tempBlackListCop.lydoLqPnBL = getCellValue(lydoLqPnBL)
					}else{
						tempBlackListCop.lydoLqPnBL = ''
					}
					if(ghichuPnBL && getCellValue(ghichuPnBL)){
						tempBlackListCop.ghichuPnBL = getCellValue(ghichuPnBL)
					}else{
						tempBlackListCop.ghichuPnBL = ''
					}
					tempBlackListCop.donvi_1 = UnitDepart.get(currentUser.tenDonVi1)
					tempBlackListCop.donvi_2 = UnitDepart.get(currentUser.tenDonVi2)
					tempBlackListCop.donvi_3 = UnitDepart.get(currentUser.tenDonVi3)
					tempBlackListCop.ngaynhapPnBL = new Date()
					tempBlackListCop.usernhapPnBL = currentUser.userEmail
					tempBlackListCop.phongbanPnBL = UnitDepart.get(currentUser.tenDonVi3).name
					tempBlackListCop.nguoisua = currentUser.userEmail
					tempBlackListCop.ngaysua = new Date()
					tempBlackListCop.status = 'PENDING'
					listimportCop << tempBlackListCop
				}
			}catch (e){
				flash.error = "Lỗi template đề nghị kiểm tra lại"
				redirect(action: "showImportCop")
				return
			}
			int countSave = 0
			if(listimportCop.size()>0){
				listimportCop.each {BlackListCopImport varBlackCop ->
					countSave++
					try {
						varBlackCop.save(flush:true)
					}catch (e){
						flash.error = "Dòng "+countSave+"lỗi dữ liệu khi lưu vào bảng tạm"
						redirect(action: "showImportCop")
						return
					}
				}
			}
			flash.message = "Import dữ liệu vào bảng tạm thành công"
		}
		redirect (action:'showImportCop')
	}
    def transferImportCop = {
        def importCop = BlackListCopImport.findAllByUsernhapPnBLAndStatus(springSecurityService.principal.username,'PENDING')
        try{
            importCop.each {BlackListCopImport varBlackCop ->
                def checkBlackListCop = BlacklistCorporation.findByGiayphepPnBLAndStatus(varBlackCop.giayphepPnBL,0)
                if(checkBlackListCop){
                    varBlackCop.status = 0
                    varBlackCop.usernhapPnBL = checkBlackListCop.usernhapPnBL
                    varBlackCop.ngaynhapPnBL = checkBlackListCop.ngaynhapPnBL
                    checkBlackListCop.properties = varBlackCop.properties
                    checkBlackListCop.save()
                    varBlackCop.status = 'COMPLETED'           
					varBlackCop.save()						
                }else{
                    varBlackCop.status = 0
                    def newBlackListCop = new BlacklistCorporation(varBlackCop.properties)
                    newBlackListCop.save()
                    varBlackCop.status = 'COMPLETED'
					varBlackCop.save()
                }
            }
        }catch (e){
            flash.error = "Lỗi dữ liệu khi import từ bảng tạm vào hệ thống"
            redirect(action: "showImportCN")
            return
        }
        flash.message = "Import dữ liệu từ bảng tạm vào hệ thống thành công"
        redirect (action:'showImportCop')
    }
    def deleteImportCop = {
        def importCop = BlackListCopImport.findAllByUsernhapPnBLAndStatus(springSecurityService.principal.username,'PENDING')
        try{
            importCop.each {BlackListCopImport varBlackCop ->
                varBlackCop.status = 'DELETED'
                varBlackCop.save()
            }
        }catch (e){
            flash.error = "Xóa bảng tạm không thành công"
            redirect(action: "showImportCop")
            return
        }
        flash.message = "Xóa dữ liệu bảng tạm thành công"
        redirect (action:'showImportCop')
    }
  
	def showImportTsbd = {
		ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def importTsbd = BlacklistTsbdImport.findAllByUsernhapTsBLAndStatus(springSecurityService.principal.username,'PENDING')
		render (view:'/blacklist/importExcelTsbd',model: [importTsbd:importTsbd])
	}	
	def doUploadTsbd = {
		ErrorMasterUserCreate currentUser = ErrorMasterUserCreate.findByUserEmail(springSecurityService.principal.username)
		def uploadFile = request.getFile('uploadField')
		XSSFWorkbook workbook = new XSSFWorkbook(uploadFile.getInputStream())
		Sheet sheet = workbook.getSheetAt(0);
		def listimportTsbd = []
		def tempBlackListTsbd

		// skip first row (row 0) by starting from 1

		if(sheet.getPhysicalNumberOfRows()<=1){
			flash.error = "File excel không có dữ liệu"
		}
        else if(sheet.getPhysicalNumberOfRows()>5001){
            flash.error = "File excel có quá 5000 dòng dữ liệu , đề nghị anh/chị chia nhỏ file"
        }
        else{
			try{
				for (int row = 1; row < sheet.getPhysicalNumberOfRows(); row++) {
					Cell loaiTsBL = sheet.getRow(row).getCell(0)
					Cell thongtinTsBL = sheet.getRow(row).getCell(1)
					Cell motaTsBL = sheet.getRow(row).getCell(2)
					Cell sohuuTsBL = sheet.getRow(row).getCell(3)
					Cell cmtcshTsBL = sheet.getRow(row).getCell(4)
					Cell masothueTsBL = sheet.getRow(row).getCell(5)
					Cell canhanTsBL = sheet.getRow(row).getCell(6)
					Cell cmtlqTsBL = sheet.getRow(row).getCell(7)
					Cell lydoTsBL = sheet.getRow(row).getCell(8)
					Cell giatriTsBL = sheet.getRow(row).getCell(9)
					Cell lichsuGdTsBL = sheet.getRow(row).getCell(10)
					Cell riskTsdbTsBL = sheet.getRow(row).getCell(11)
					Cell lydoCtTsBL = sheet.getRow(row).getCell(12)
					Cell doituongTsBL = sheet.getRow(row).getCell(13)
					Cell thoihanTsBL = sheet.getRow(row).getCell(14)
					Cell dulieuTsBL = sheet.getRow(row).getCell(15)
					Cell ghichuTsBL = sheet.getRow(row).getCell(16)

					println('ket thuc doc cell')
					tempBlackListTsbd = new BlacklistTsbdImport()		
					if(loaiTsBL && getCellValue(loaiTsBL)){
						if(BlacklistTaiSan.findByName(getCellValue(loaiTsBL))){
							tempBlackListTsbd.loaiTsBL = BlacklistTaiSan.findByName(getCellValue(loaiTsBL))
						}else{
							flash.error = "Dòng "+(row+1)+" cột Loại tài sản dữ liệu không tồn tại trong danh sách"
							redirect(action: "showImportTsbd")
							return
						}
					}else{
						flash.error = "Dòng "+(row+1)+" cột Loại tài sản lỗi dữ liệu"
						redirect(action: "showImportTsbd")
						return
					}
					if(thongtinTsBL && getCellValue(thongtinTsBL)){
						tempBlackListTsbd.thongtinTsBL = getCellValue(thongtinTsBL)
					}else{
						flash.error = "Dòng "+(row+1)+" cột Thông tin nhận diện tài sản"
						redirect(action: "showImportTsbd")
						return
					}
					if(motaTsBL && getCellValue(motaTsBL)){
						tempBlackListTsbd.motaTsBL = getCellValue(motaTsBL)
					}else{
						tempBlackListTsbd.motaTsBL = ''
					}
					if(sohuuTsBL && getCellValue(sohuuTsBL)){
						tempBlackListTsbd.sohuuTsBL = getCellValue(sohuuTsBL)
					}else{
						tempBlackListTsbd.sohuuTsBL = ''
					}
					if(cmtcshTsBL && getCellValue(cmtcshTsBL)){
						tempBlackListTsbd.cmtcshTsBL = getCellValue(cmtcshTsBL)
					}else{
						tempBlackListTsbd.cmtcshTsBL = ''
					}
					if(masothueTsBL && getCellValue(masothueTsBL)){
						tempBlackListTsbd.masothueTsBL = getCellValue(masothueTsBL)
					}else{
						tempBlackListTsbd.masothueTsBL = ''
					}
					if(canhanTsBL && getCellValue(canhanTsBL)){
						tempBlackListTsbd.canhanTsBL = getCellValue(canhanTsBL)
					}else{
						tempBlackListTsbd.canhanTsBL = ''
					}
					if(cmtlqTsBL && getCellValue(cmtlqTsBL)){
						tempBlackListTsbd.cmtlqTsBL = getCellValue(cmtlqTsBL)
					}else{
						tempBlackListTsbd.cmtlqTsBL = ''
					}
					if(lydoTsBL && getCellValue(lydoTsBL)){
						tempBlackListTsbd.lydoTsBL = getCellValue(lydoTsBL)
					}else{
						tempBlackListTsbd.lydoTsBL = ''
					}
					if(giatriTsBL && getCellValue(giatriTsBL)){
						tempBlackListTsbd.giatriTsBL = getCellValue(giatriTsBL)
					}else{
						tempBlackListTsbd.giatriTsBL = ''
					}
					if(lichsuGdTsBL && getCellValue(lichsuGdTsBL)){
						tempBlackListTsbd.lichsuGdTsBL = getCellValue(lichsuGdTsBL)
					}else{
						tempBlackListTsbd.lichsuGdTsBL = ''
					}
					if(riskTsdbTsBL && getCellValue(riskTsdbTsBL)){
						if(BlacklistRiskTSBD.findByName(getCellValue(riskTsdbTsBL))){
							tempBlackListTsbd.riskTsdbTsBL = BlacklistRiskTSBD.findByName(getCellValue(riskTsdbTsBL))
						}else{
							flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách dữ liệu không tồn tại trong danh sách lý do"
							redirect(action: "showImportTsbd")
							return
						}
					}else{
						flash.error = "Dòng "+(row+1)+" cột Lý do thuộc danh sách lỗi dữ liệu"
						redirect(action: "showImportTsbd")
						return
					}
					if(lydoCtTsBL && getCellValue(lydoCtTsBL)){
						tempBlackListTsbd.lydoCtTsBL = getCellValue(lydoCtTsBL)
					}else{
						tempBlackListTsbd.lydoCtTsBL = ''
					}
					if(doituongTsBL && getCellValue(doituongTsBL)){
						if(BlacklistObject.findByName(getCellValue(doituongTsBL))){
							tempBlackListTsbd.doituongTsBL = BlacklistObject.findByName(getCellValue(doituongTsBL))
						}else{
							flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng dữ liệu không tồn tại trong danh sách phân loại"
							redirect(action: "showImportTsbd")
							return
						}
					}else{
						flash.error = "Dòng "+(row+1)+" cột Phân loại đối tượng lỗi dữ liệu"
						redirect(action: "showImportTsbd")
						return
					}
					if(lydoCtTsBL && getCellValue(lydoCtTsBL)){
						tempBlackListTsbd.lydoCtTsBL = getCellValue(lydoCtTsBL)
					}else{
						tempBlackListTsbd.lydoCtTsBL = ''
					}
					if(thoihanTsBL){
						try{
							tempBlackListTsbd.thoihanTsBL = thoihanTsBL.getDateCellValue()
						}catch (e){
							flash.error = "Dòng "+(row+1)+" cột Thời hạn lỗi dữ liệu"
							redirect(action: "showImportTsbd")
							return
						}
					}else{
						Calendar cal = Calendar.getInstance();
						cal.add(Calendar.YEAR, 10);
						Date next10Year = cal.getTime();
						tempBlackListTsbd.thoihanTsBL = next10Year
					}
					if(dulieuTsBL && getCellValue(dulieuTsBL)){
						tempBlackListTsbd.dulieuTsBL = getCellValue(dulieuTsBL)
					}else{
						tempBlackListTsbd.dulieuTsBL = ''
					}
					if(ghichuTsBL && getCellValue(ghichuTsBL)){
						tempBlackListTsbd.ghichuTsBL = getCellValue(ghichuTsBL)
					}else{
						tempBlackListTsbd.ghichuTsBL = ''
					}
					tempBlackListTsbd.donvi_1 = UnitDepart.get(currentUser.tenDonVi1)
					tempBlackListTsbd.donvi_2 = UnitDepart.get(currentUser.tenDonVi2)
					tempBlackListTsbd.donvi_3 = UnitDepart.get(currentUser.tenDonVi3)
					tempBlackListTsbd.ngaynhapTsBL = new Date()
					tempBlackListTsbd.usernhapTsBL = currentUser.userEmail
					tempBlackListTsbd.phongbanTsBl = UnitDepart.get(currentUser.tenDonVi3).name
					tempBlackListTsbd.nguoisua = currentUser.userEmail
					tempBlackListTsbd.ngaysua = new Date()
					tempBlackListTsbd.status = 'PENDING'
					listimportTsbd << tempBlackListTsbd
				}
			}catch (e){
				flash.error = "Lỗi template đề nghị kiểm tra lại"
				redirect(action: "showImportTsbd")
				return
			}
			int countSave = 0
			if(listimportTsbd.size()>0){
				listimportTsbd.each {BlacklistTsbdImport varBlackTsbd ->
					countSave++
					try {
						varBlackTsbd.save(flush:true)
					}catch (e){
						flash.error = "Dòng "+countSave+"lỗi dữ liệu khi lưu vào bảng tạm"
						redirect(action: "showImportTsbd")
						return
					}
				}
			}
			flash.message = "Import dữ liệu vào bảng tạm thành công"
		}
		redirect (action:'showImportTsbd')
	}
	
	def transferImportTsbd = {
		def importTsbd = BlacklistTsbdImport.findAllByUsernhapTsBLAndStatus(springSecurityService.principal.username,'PENDING')
		try{
			importTsbd.each {BlacklistTsbdImport varBlackTsbd ->
				def checkBlackListTsbd = BlacklistTSBD.findByThongtinTsBLAndStatus(varBlackTsbd.thongtinTsBL,0)
				if(checkBlackListTsbd){
					varBlackTsbd.status = 0
					varBlackTsbd.usernhapTsBL = checkBlackListTsbd.usernhapTsBL
					varBlackTsbd.ngaynhapTsBL = checkBlackListTsbd.ngaynhapTsBL
					checkBlackListTsbd.properties = varBlackTsbd.properties
					checkBlackListTsbd.save()
					varBlackTsbd.status = 'COMPLETED'	
					varBlackTsbd.save(flush:true)											
				}else{
					varBlackTsbd.status = 0
					def newBlackListCop = new BlacklistCorporation(varBlackTsbd.properties)
					newBlackListCop.save()
					varBlackTsbd.status = 'COMPLETED'
					varBlackTsbd.save()						
				}
			}
		}catch (e){
			flash.error = "Lỗi dữ liệu khi import từ bảng tạm vào hệ thống"
			redirect(action: "showImportTsbd")
			return
		}
		flash.message = "Import dữ liệu từ bảng tạm vào hệ thống thành công"
		redirect (action:'showImportTsbd')
	}
	
	def deleteImportTsbd = {
		def importTsbd = BlacklistTsbdImport.findAllByUsernhapTsBLAndStatus(springSecurityService.principal.username,'PENDING')
		try{
			importTsbd.each {BlacklistTsbdImport varBlackTsbd ->
				varBlackTsbd.status = 'DELETED'
				varBlackTsbd.save()
			}
		}catch (e){
			flash.error = "Xóa bảng tạm không thành công"
			redirect(action: "showImportTsbd")
			return
		}
		flash.message = "Xóa dữ liệu bảng tạm thành công"
		redirect (action:'showImportTsbd')
	}
	
	def getCellValue(def cell){
        switch(cell.getCellType()) {
            case Cell.CELL_TYPE_BOOLEAN:
                return cell.getBooleanCellValue();
                break;
            case Cell.CELL_TYPE_NUMERIC:
                return formatNumber(number: cell.getNumericCellValue(), format: '###',locale: Locale.US).toString().trim();
                break;
            case Cell.CELL_TYPE_STRING:
                return cell.getStringCellValue().trim();
                break;
        }
    }
}
