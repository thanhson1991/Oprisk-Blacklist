import msb.platto.fingerprint.*
class Incident implements Comparable {
    static belongsTo = [opRiskProcess:OpRiskProcess]
	String eventName
    String description
    String cause
    String solution
    String financialLoss
    String nonFinancialLoss
    Date   dateIncident
    String name
    String branch
    Cause reason
    Event event
    String retrieval
    User createdBy
    String incidentType
	String fileName

    Date dateReport
    BusinessField basel2
    String actionPlan
    String incidentStatus
    String fromInsurance
    String fromAnother
    String moneyTypeI
    String moneyTypeA
    String gl_cal
    Date dateFnCal
    String sourceType
    String stickFlg
    String noteRR

    static mapping = {
        sort 'id'
    }
    static constraints = {
        description maxSize:10000,nullable:true
        cause maxSize:10000,nullable :true
        solution maxSize:10000,nullable :true
        financialLoss maxSize:10000,nullable :true
        nonFinancialLoss maxSize:10000,nullable :true
        dateIncident nullable:true
        name nullable:true
        branch nullable:true
        opRiskProcess nullable:true
        reason nullable:true
        event nullable:true
        retrieval nullable:true
        incidentType nullable:true
        createdBy nullable:true
		fileName nullable:true
		eventName nullable:true

        dateReport nullable:true
        basel2 nullable:true
        actionPlan nullable:true
        incidentStatus nullable:true
        fromInsurance nullable:true
        fromAnother nullable:true
        moneyTypeI nullable:true
        moneyTypeA nullable:true
        gl_cal nullable:true
        dateFnCal nullable:true
        sourceType nullable:true
        stickFlg nullable:true
        noteRR nullable:true
    }

    int compareTo(o) {
        if(!id) return 1
        return this.id.compareTo(o.id)
    }
}
