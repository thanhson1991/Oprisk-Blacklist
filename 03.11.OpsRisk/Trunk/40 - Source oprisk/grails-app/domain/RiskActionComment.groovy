import msb.platto.fingerprint.*
class RiskActionComment implements Comparable {
	User createdBy
	String content
	static belongsTo = [riskAction:RiskAction]
	Date dateCreated	

	static constraints = {
		createdBy nullable:true		
		content nullable:true;
	}
	static mapping = {
		content type: 'text'
		sort id:"desc"
	}
	int compareTo(o) {
		if(!id) return 1
		return o.id.compareTo(this.id)
	}
}
