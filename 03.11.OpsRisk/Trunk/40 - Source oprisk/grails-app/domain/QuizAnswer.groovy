class QuizAnswer implements Comparable{

    static belongsTo = [surveyInstance:QuizSurveyInstance]
    String comments
    QuizQuestion question
    String answer = ""
    double score
    int ord=0

    static constraints = {
        comments maxSize:10000, nullable: true
        answer maxSize:4000, nullable: true
    }

    int compareTo(o) {
        if(this?.ord > o?.ord) return 1
        else if(this?.ord < o?.ord) return -1
        return 0
    }
}
