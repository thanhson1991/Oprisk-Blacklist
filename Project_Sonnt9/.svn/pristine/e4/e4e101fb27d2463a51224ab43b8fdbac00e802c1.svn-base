
class QuizSurveyInstance {
    QuizSurvey survey
    static hasMany = [answers:QuizAnswer]
    SortedSet answers
    Date lastUpdated
    int status = 0
    double score = 0.0

    static constraints = {
    }

    static QuizSurveyInstance createSurveyInstance(QuizSurvey s){
        QuizSurveyInstance instance = new QuizSurveyInstance(survey:s);

        s.questions.each{
            instance.addToAnswers(question:it,ord:it.ord,answer:"")
        }
        instance.save();
    }


    def evaluate(extraAnswers = null) {
        answers.each{
            it.evaluate();
        }
        this.score = SurveyEvaluator.evaluate(this,extraAnswers);
    }
}
