// Place your Spring DSL code here
import org.apache.commons.dbcp.BasicDataSource
beans = {
	sqlserverDataSource(BasicDataSource) {
						 
		driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
		

		
		url = "jdbc:sqlserver://10.2.1.158\\sql2008;databaseName=bclkgd_new"
		

		username = "m1t_reader"
		password = "123456"

	}
}
