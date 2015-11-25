import org.grails.plugins.excelimport.*;

class ErrorImporter extends AbstractExcelImporter {
	static Map COLUMN_MAP = [
		sheet:'Sheet1',
		startRow:2,
		columnMap:[
			'A':'TenNH',
			'B':'TenDonVi',
			'C':'NgayXayRa',
			'D':'LoaiLoiCap1',
			'E':'LoaiLoiCap2',
			'F':'MoTaChiTietLoi',
			'G':'MaGiaoDich',
			'H':'GiaTriGiaoDich',
			'I':'SoCif',
			'J':'TenKH',
			'K':'SoVaTenHoSo',
			'L':'NguoiGayLoi1',
			'M':'MucDoLoi1',
			'N':'HoVaTen1',
			'O':'ChucDanh1',
			'P':'UserBDS1',
			'Q':'NguoiGayLoi2',
			'R':'MucDoLoi2',
			'S':'HoVaTen2',
			'T':'ChucDanh2',
			'U':'UserBDS2',
			'V':'NguoiGayLoi3',
			'W':'MucDoLoi3',
			'X':'HoVaTen3',
			'Y':'ChucDanh3',
			'Z':'UserBDS3',
			'AA':'NguoiGayLoi4',
			'AB':'MucDoLoi4',
			'AC':'HoVaTen4',
			'AD':'ChucDanh4',
			'AE':'UserBDS4',
			'AF':'BienPhapKhacPhuc',
			'AG':'ThoiGianKhacPhuc',
			'AH':'NguoiNhap',
			'AI':'ThoiGianNhap',
			'AJ':'TrangThai',
			'AK':'YKienVoiLoiNay',
						
						
			
		]
	]

	public ErrorImporter(filename){
		super(filename)
	}

	List<Map> getError(){
		List error = ExcelImportUtils.convertColumnMapConfigManyRows(workbook, COLUMN_MAP)
	}

}
