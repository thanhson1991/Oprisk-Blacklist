import msb.platto.fingerprint.*
class SelfEvaluationProcess {
    int status = 0
    Date dateCreated
    String comment
    User createdBy
    static hasMany = [riskInstances:RiskInstance]
    SortedSet riskInstances
    Department department
	String branchName

    static constraints = {
        comment nullable: true
		branchName nullable: true
    }

    static mapping = {
        riskInstances cascade:'all-delete-orphan'
    }
}
