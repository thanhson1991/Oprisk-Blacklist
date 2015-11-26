

class ErrorType implements Comparable{

	String name
	
	
	
	static constraints = {
	}
	
	int compareTo(o) {
		if(!id) return 1
		return this.id.compareTo(o.id)
	}
	
}
