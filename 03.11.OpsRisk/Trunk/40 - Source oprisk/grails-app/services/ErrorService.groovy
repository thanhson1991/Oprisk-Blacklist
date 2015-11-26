import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.Sheet
import org.apache.poi.ss.usermodel.Row
import org.apache.poi.xssf.usermodel.XSSFWorkbook
import jxl.*
import jxl.write.*

class ErrorService {

    static transactional = true
	
    /*def exportExcel(def title,List<Expando> data ) {*/
		def exportExcel(ArrayList<String> title ) {
		
		
		def rowCount = 0
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("new sheet")
		Row row1 = sheet.createRow((short)0);
		def _count=0;
		def _rowCount=0;		
		title.each {
			
			_count=it.size()						
			Row row = sheet.createRow(_rowCount)
			row.setHeightInPoints(50);
			for(int i=0;i<_count;i++)
			{
				row.createCell( i).setCellValue(it[i])	
							
			}
			_rowCount++
		}		
		
		return wb
		
    }

}
