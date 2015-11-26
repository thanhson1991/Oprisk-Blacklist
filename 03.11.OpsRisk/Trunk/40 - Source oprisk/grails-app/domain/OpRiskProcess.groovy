import msb.platto.fingerprint.*

class OpRiskProcess{
    static hasMany = [incidents:Incident]
    SortedSet incidents
    SurveyInstance surveyInstance
    User employee

    int status=0
    Date dateCreated
    String comments
	String branchName

    static constraints = {
        comments maxSize:10000, nullable: true
        incidents nullable:true
        surveyInstance   nullable:true
        employee nullable:true
		branchName nullable:true
    }

    static mapping = {
     sort "dateCreated"
    }


}