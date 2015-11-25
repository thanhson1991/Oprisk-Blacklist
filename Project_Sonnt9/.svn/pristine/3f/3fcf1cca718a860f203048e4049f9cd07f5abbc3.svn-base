import msb.platto.fingerprint.*
class RiskAction {
	ActionType actionType
	String riskName
	String description
	String riskLevel
	Date actionDueDate
	String actionStatus
	String fileName
	static hasMany = [responsibleUsers: ErrorMasterUserCreate, supervisors: ErrorMasterUserCreate,actionComments:RiskActionComment]	
	SortedSet actionComments,responsibleUsers,supervisors	
	Date lastUpdated
	Date dateCreated
	User createdBy
	int status = 0
    static constraints = {
		fileName nullable:true
		description(maxSize:10000)
    }
	
	static mapping = {		
		actionComments cascade:'all-delete-orphan'
	}
}
