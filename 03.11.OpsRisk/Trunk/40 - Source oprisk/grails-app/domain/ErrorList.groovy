
class ErrorList implements Comparable{
    String name
    int status = 0
    int ord = 0
	String code
   // static belongsTo = [parent:ErrorList]
    //static hasMany = [children:ErrorList]
	ErrorList parent
    SortedSet children


    static mapping = {
        sort 'id'
    }

    int compareTo(o) {
        if(!id) return 1
        return this.id.compareTo(o.id)
    }

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
