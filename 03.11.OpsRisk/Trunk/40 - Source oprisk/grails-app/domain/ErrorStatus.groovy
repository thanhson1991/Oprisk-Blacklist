

class ErrorStatus implements Comparable{

	String nameStatus
	String code
	int status
	
	
    static constraints = {
    	code nullable:true
	}
	
	
	int compareTo(o) {
		if(!id) return 1
		return this.id.compareTo(o.id)
	}
	
}
