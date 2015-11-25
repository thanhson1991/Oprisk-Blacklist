
class QuizSurvey {
    int reference
    String title
    String descriptions = ''
    String evaluation = ''
    int status = 0
    String defaultQuestionEvaluation = ''
    static hasMany = [questions:QuizQuestion]
    SortedSet questions
    Department department
	int minutes = 10

    static constraints = {		
        reference(unique:true)
        evaluation(maxSize:10000)
        defaultQuestionEvaluation(maxSize:10000)
    }
}
