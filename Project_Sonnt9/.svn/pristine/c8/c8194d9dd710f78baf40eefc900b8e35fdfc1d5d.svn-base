import grails.converters.JSON

class QuizAdminController {

    def index = {
		// println params
        QuizSurvey survey = null
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        // saving the survey        
        if(params.save){
            if(params.id)
                survey = QuizSurvey.get(params.id)
            else
                survey = new QuizSurvey()

            survey.properties = params
            survey.department = Department.get(params.departmentId)
            if (!survey.hasErrors() && survey.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])}"
            }
        }else{

            if(params.create)
                survey = new QuizSurvey()
            else if(params.id)
                survey = QuizSurvey.get(params.id)
        }
        // println departments
        render(view:'/admin/quizSurveyAdmin',model:[departments:departments,surveys:QuizSurvey.list(),
            s:survey])
    }

    // test question
    def testQuestion = {
        try{
            // create the models
            QuizQuestion q = new QuizQuestion(params)
            q.survey = QuizSurvey.get(params.survey.id)

            QuizAnswer a = new QuizAnswer(question:q)

            // now generate the answers from inputs
            def script = 'def r = ' + params.testAnswer + '; return r;'
            def answers = SurveyEvaluator.runScript(script)

            List results = new ArrayList()

            if(answers.class == String.class){
                a.answer = answers
                results.add(['answer':answers,'score':a.evaluate()])
            }else{
                // not string, go through each answer.
                answers.each{
                    a.answer = it
                    results.add(['answer':it,'score':a.evaluate()])
                }
            }

            render results as JSON
        }catch(e){
            e.printStackTrace()
            def r  = ['error':e.toString()]
            render r as JSON
        }

    }

    // function to get question by id and display as JSON
    def getQuestion = {
        render QuizQuestion.get(params.id) as JSON
    }
	
	def deleteQuestion = {
		
		def question =  QuizQuestion.get(params.id)
		def id = question.survey.id
		question.delete(flush:true)
		redirect (action:'index',params:[id:id])
		
	}
	
	
    // function to save/add question
    def saveQuestion = {
		// println params
        params.ord=params.ord?:0
        params.status=params.status?:0
        params.weight=params.weight?:0
        params.param1=params.param1?:0
        params.param2=params.param2?:0
        params.param3=params.param3?:0
        params.param4=params.param4?:0
        params.param5=params.param5?:0

        QuizQuestion question = new QuizQuestion(params)
        // detect old question saving
        if( params.id ){
            question = QuizQuestion.get(params.id)
            question.properties = params
        }
        // check for error
        if(!question.hasErrors() && params.survey.id && question.save(flush:true))
        {
            //Survey survey = Survey.get(params.survey.id)
            //survey.addToQuestions(question)
            //if(survey.save(flush:true))
                render '1'
            //else
            //    render 'Lỗi database'
        }else{
            render question.errors as JSON
        }
    }

    def setQuestionTable = {
        def questionTable = QuizQuestion.createCriteria().list{
                or{
                    like("reference","Q%")
                    and {
                        like("reference","CIC%")
                        gt("weight",0.toDouble())
                    }
                }
            }
            int i=0;
            if (params.save){
                questionTable.each{
                    if (!it.reference.contains('QT')){
                        it.weight = params.weight[i].toDouble()
                        it.param1 = params.param1[i].toDouble()
                        it.param2 = params.param2[i].toDouble()
                        it.save(flush:true)
                        i++;
                    }
                }
            }

//        if (params.id != 'cic'){
//            questionTable= Question.createCriteria().list{
//                like("reference","Q%")
//            }
//            int i=0;
//
//            if (params.save){
//                questionTable.each{
//                    if (!it.reference.contains('QT')){
//                        it.weight = params.weight[i].toDouble()
//                        it.param1 = params.param1[i].toDouble()
//                        it.param2 = params.param2[i].toDouble()
//                        it.save(flush:true)
//                        i++;
//                    }
//                }
//                //questionTable.save(flush:true)
//            }else{
//
//            }
//        }else{
//            questionTable= Question.createCriteria().list{
//                like("reference","CIC%")
//                gt("weight",0)
//            }
//            int i=0;
//
//            if (params.save){
//                questionTable.each{
//                        it.weight = params.weight[i].toDouble()
//                        it.param1 = params.param1[i].toDouble()
//                        it.param2 = params.param2[i].toDouble()
//                        it.save(flush:true)
//                        i++;
//                }
//            }
//        }


        render view:"/admin/tableQuestion",model:[questionTable:questionTable],params:params
    }

    def setQuestionTableCIC = {


        render view:"/admin/tableQuestion",model:[questionTable:questionTable]
    }

}
