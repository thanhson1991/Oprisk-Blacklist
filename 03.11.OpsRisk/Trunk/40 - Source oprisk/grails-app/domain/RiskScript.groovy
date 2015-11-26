import msb.platto.fingerprint.*
class RiskScript {
	//String businessField
	BusinessField businessField
	String description
	Event event
	Possibility possibility
	String financialLoss
	String actionPlan
	ErrorStatus actionStatus
	User createdBy
	Date dateCreated
	Date lastUpdated
	int status = 0
    static constraints = {	
		description(maxSize:10000)
		actionPlan(maxSize:10000)
		
    }
}
