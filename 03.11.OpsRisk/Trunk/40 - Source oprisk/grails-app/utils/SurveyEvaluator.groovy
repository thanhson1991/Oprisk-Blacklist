/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



/**
 *
 * @author longtd
 */
class SurveyEvaluator {
	static def evaluate(Answer answer, Question question = null){
            def q = question?:answer.question
            def result = 0;
            // ignore Title question
            if(!SurveyRenderer.Q_TITLE_TYPE.equalsIgnoreCase(q.answerType)
                && !SurveyRenderer.Q_AUTO_TYPE.equalsIgnoreCase(q.answerType)
            	&& ((q.evaluation) ||
                    (q.survey?.defaultQuestionEvaluation))){
                // determine the evaluation formula in the question or the
                // survey
                def evaluation = q.evaluation?:q.survey.defaultQuestionEvaluation

                def a = answer.answer
                if(a==null) return 0
                if(a.isInteger()){
                    a = a.toInteger()
                }else if(a.isDouble()){
                	a = a.toDouble()
                }
                // should be able to pass in other bindings
                def binding = new Binding()
                binding.setVariable("answer", a)
                q.getProperties().each{key,value ->
                    binding.setVariable(key,value )
                }
                answer.surveyInstance?.answers?.each{
                    binding.setVariable(it.question.reference,it.answer )
                }


                def gs = new GroovyShell(binding)
                result = gs.evaluate(evaluation)?.toDouble();

            }else if(SurveyRenderer.Q_AUTO_TYPE.equalsIgnoreCase(q.answerType)){
                // should be able to pass in other bindings
                def binding = new Binding()
                binding.setVariable("survey", answer.surveyInstance)
                answer.surveyInstance?.answers?.each{
                    binding.setVariable(it.question.reference,it.answer )
                }
                def gs = new GroovyShell(binding)
                return gs.evaluate(q.evaluation)?.toDouble()
			}else{
                result = answer.answer
            }

            return  result?result.toDouble():0;
        }
        public static double evaluate(SurveyInstance surveyInstance, extraAnswers = null){
            def binding = new Binding()
            binding.setVariable("answers", surveyInstance.answers)
            if(extraAnswers){
            	binding.setVariable("extraAnswers", extraAnswers)
            }
            def gs = new GroovyShell(binding)
            return gs.evaluate(String.valueOf(surveyInstance.survey.evaluation))?.toDouble();
        }
        public static double evaluate(String answer, String script){
            def binding = new Binding()
            binding.setVariable("answer", answer)
            def gs = new GroovyShell(binding)
            return gs.evaluate(String.valueOf(script)).toDouble();
        }
        public static Object runScript(String script){
            def gs = new GroovyShell()
            return gs.evaluate(script)
        }
}

