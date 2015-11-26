
class BlacklistRiskTSBD {
	String name
	String code
	int status=0
	
	static constraints = {
		status nullable : true
	}
}
