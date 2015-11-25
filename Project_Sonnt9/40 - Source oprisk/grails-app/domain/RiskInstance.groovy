
class RiskInstance implements Comparable {
    Date dateCreated
    static belongsTo = [selfEvaluationProcess:SelfEvaluationProcess]
    Action riskAction
    int status=0
    Risk risk
    Impact impact
    Possibility possibility
    ControlEffect controlEffect
    String control
    String score
    String description
    static mapping = {
        sort 'id'
        control type: 'text'
    }

    static constraints = {
        impact nullable:true
        controlEffect nullable:true
        possibility nullable:true
        score nullable:true
        control nullable:true
		risk nullable:true
		riskAction nullable:true
        description nullable:true
    }


     int compareTo(o) {
        if(!id) return 1
        return this.id.compareTo(o.id)
    }
}
