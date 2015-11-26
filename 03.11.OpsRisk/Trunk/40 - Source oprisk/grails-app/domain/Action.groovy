import msb.platto.fingerprint.*

class Action {
    RiskInstance riskInstance
    int status = 0
    String description
    Date deadline
    String executor
    Date dateCreated
    User createdBy

    static constraints = {        
        description nullable:true
        deadline nullable:true
        executor nullable:true
    }

    static mapping = {
        description type: 'text'
    }
    
}
