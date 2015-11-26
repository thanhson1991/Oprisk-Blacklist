import grails.converters.JSON

class SurveyAdminController {

    def index = {		
        Survey survey = null
        def departments = Department.findAllByStatusGreaterThanEquals('0')
        // saving the survey        
        if(params.save){
            if(params.id)
                survey = Survey.get(params.id)
            else
                survey = new Survey()

            survey.properties = params
            survey.department = Department.get(params.departmentId)
            if (!survey.hasErrors() && survey.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), survey.id])}"
            }
        }else{

            if(params.create)
                survey = new Survey()
            else if(params.id)
                survey = Survey.get(params.id)
        }
        
        render(view:'/admin/surveyAdmin',model:[departments:departments,surveys:Survey.list(),
            s:survey])
    }

    // test question
    def testQuestion = {
        try{
            // create the models
            Question q = new Question(params)
            q.survey = Survey.get(params.survey.id)

            Answer a = new Answer(question:q)

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
        render Question.get(params.id) as JSON
    }
	
	def deleteQuestion = {
//		// println "id>>"+ params.id
			def question =  Question.get(params.id)
			def id_Answer = Answer.executeQuery("from Answer e where e.question ="+params.id)
			def id = question.survey.id
		try{
			id_Answer.each{
				it.delete(flush:true)
			}
			question.delete(flush:true)
		 
		}catch (Exception e){
			flash.message =  "Xóa cầu hỏi không thành công. Đã có báo cáo rủi ro gắn với câu hỏi này"
		}
		redirect (action:'index',params:[id:id])
		
	}
	 
	
    // function to save/add question
    def saveQuestion = {		
        params.ord=params.ord?:0
        params.status=params.status?:0
        params.weight=params.weight?:0
        params.param1=params.param1?:0
        params.param2=params.param2?:0
        params.param3=params.param3?:0
        params.param4=params.param4?:0
        params.param5=params.param5?:0

        Question question = new Question(params)
        // detect old question saving
        if( params.id ){
            question = Question.get(params.id)
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
        def questionTable = Question.createCriteria().list{
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
