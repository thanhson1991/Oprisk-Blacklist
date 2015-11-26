
class BlacklistCategory {
	String name
	String code
	String type
	int status=0
	
	static constraints = {
		code nullable:true
	}
}
