

class UnitDepart {

	String name
	int status=0
	//static hasMany = [errorManagement:ErrorManagement]
	SortedSet errorManagement
	String code=''	
	UnitDepart parent
	int ord

	static constraints = {
		parent	nullable:true
		code nullable:true
	}
	
	def beforeInsert() {
		updateOrd()
	}

	def beforeUpdate() {
		updateOrd()
	}

	protected void updateOrd() {
		if (this.parent){
			this.ord = parent.ord + 1
		} else {
			ord = 0
		}
	}
	
}
