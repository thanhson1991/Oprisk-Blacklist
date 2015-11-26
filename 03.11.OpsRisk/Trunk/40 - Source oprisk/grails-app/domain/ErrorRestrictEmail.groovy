

class ErrorRestrictEmail implements Comparable{

	String userEmail
	
	//String unitDepartError
    static constraints = {
		userEmail nullable:true	
		
		//unitDepartError nullable:true
    }
	
	int compareTo(o) {
		if(!id) return 1
		return this.id.compareTo(o.id)
	}
	
}
