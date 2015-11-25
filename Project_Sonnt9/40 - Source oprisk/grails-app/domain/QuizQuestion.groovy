
class QuizQuestion implements Comparable {
    String reference
    String title
    String descriptions = ''
    String evaluation = ''
    String answerType = SurveyRenderer.Q_YES_NO_TYPE
    String validation = ''
	String answerWeight = ''
    int status = 0
    double weight = 0
    int ord = 0
    static belongsTo = [survey:QuizSurvey]
    int indent = 0
    String help
    String wrapperClass
    String cssClass
    boolean answerFirst = false

    static constraints = {
        survey nullable:false

        answerType(inList:[SurveyRenderer.Q_YES_NO_TYPE,
                SurveyRenderer.Q_VALUE_TYPE,
                SurveyRenderer.Q_LIST_TYPE,
                SurveyRenderer.Q_TITLE_TYPE,
                SurveyRenderer.Q_AUTO_TYPE])
        reference(unique:'survey')

        title(maxSize:4000)
        validation(maxSize:5000)

        evaluation(maxSize:10000)

        descriptions(maxSize:4000)
	descriptions	nullable: true
	validation	nullable: true
        wrapperClass  	nullable: true
        help			nullable: true
        cssClass		nullable: true
		answerWeight nullable: true
    }

    int compareTo(o) {
		if(o == null) return 1
        if(this?.ord > o?.ord) return 1
        else if(this?.ord < o?.ord) return -1
        return this.id?.compareTo(o.id)
    }
}
