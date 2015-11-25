import msb.platto.fingerprint.*

class QuizProcess{    
    QuizSurveyInstance surveyInstance
    User employee
	String timeLeft
    int status=0
    Date dateCreated
    String comments
	String branchName

    static constraints = {
        comments maxSize:10000, nullable: true        
        surveyInstance   nullable:true
        employee nullable:true
		branchName nullable:true
		timeLeft nullable:true
    }

    static mapping = {
     sort "dateCreated"
    }


}