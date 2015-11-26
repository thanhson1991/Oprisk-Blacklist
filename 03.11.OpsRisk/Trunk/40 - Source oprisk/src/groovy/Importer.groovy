import org.grails.plugins.excelimport.*;

class Importer extends AbstractExcelImporter {
	static Map COLUMN_MAP = [
		sheet:'Sheet1',
		startRow:0,
		columnMap:[
			'B':'lv1',
			'C':'lv2',
		]
	]

	public Importer(filename){
		super(filename)
	}

	List<Map> getData(){
		List risk = ExcelImportUtils.convertColumnMapConfigManyRows(workbook, COLUMN_MAP)
	}
}
