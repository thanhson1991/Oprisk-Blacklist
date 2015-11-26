import org.grails.plugins.excelimport.*;

class RiskImporter extends AbstractExcelImporter {
	static Map COLUMN_MAP = [
		sheet:'Sheet1',
		startRow:0,
		columnMap:[
			'B':'lv1',
			'C':'lv2',
			'D':'lv3'
		]
	]

	public RiskImporter(filename){
		super(filename)
	}

	List<Map> getRisk(){
		List risk = ExcelImportUtils.convertColumnMapConfigManyRows(workbook, COLUMN_MAP)
	}
}
