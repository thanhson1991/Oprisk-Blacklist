
class DisplayQuestionTagLib {
    static namespace = 'survey'
    def displayQuestion = { attrs ->
        out << SurveyRenderer.renderQuestion(attrs.question,
            attrs.prefix,attrs.classes,attrs.admin);

    }
    def displayAnswer = { attrs ->
        out << SurveyRenderer.renderAnswer(attrs.answer,
            attrs.showScore?:false,attrs.classes,attrs.showComments?:'',attrs.ref1,attrs.ref2);

    }
	def displayQuizQuestion = { attrs ->
		out << SurveyRenderer.renderQuizQuestion(attrs.question,
			attrs.prefix,attrs.classes,attrs.admin);

	}
	def displayQuizAnswer = { attrs ->
		out << SurveyRenderer.renderQuizAnswer(attrs.answer,
			attrs.showScore?:false,attrs.classes,attrs.showComments?:'',attrs.ref1,attrs.ref2);

	}

}
