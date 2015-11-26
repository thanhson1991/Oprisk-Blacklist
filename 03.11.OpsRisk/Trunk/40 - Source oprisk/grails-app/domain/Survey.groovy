
class Survey {
    int reference
    String title
    String descriptions = ''
    String evaluation = ''
    int status = 0
    String defaultQuestionEvaluation = ''
    static hasMany = [questions:Question]
    SortedSet questions
    Department department

    static constraints = {
        reference(unique:true)
        evaluation(maxSize:10000)
        defaultQuestionEvaluation(maxSize:10000)
    }
}
