
class SurveyInstance {
    Survey survey
    static hasMany = [answers:Answer]
    SortedSet answers
    Date lastUpdated
    int status = 0
    double score = 0.0

    static constraints = {
    }

    static SurveyInstance createSurveyInstance(Survey s){
        SurveyInstance instance = new SurveyInstance(survey:s);

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
