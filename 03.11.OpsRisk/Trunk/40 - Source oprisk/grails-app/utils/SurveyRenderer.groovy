/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



/**
 *
 * @author longtd
 */
class SurveyRenderer {
    public static final String Q_LIST_TYPE='List';
    public static final String Q_YES_NO_TYPE='YesNo';
    public static final String Q_VALUE_TYPE='Value';
    public static final String Q_TITLE_TYPE='Title';
    public static final String Q_AUTO_TYPE='Auto';
    public static final String Q_YES_NO_CHOICE="['No','Yes']"

	public static String renderQuestion(Question question, String prefix = '', String classes='',
            boolean admin = false, String showComments = ''){
            String refID = createRefId(prefix,question?.reference)

            String result = '<div id="q_'+ refID +'" ><label class="q_'+question?.answerType+' question_title" for="'+ refID +'">' +
                (Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType)?'':'<span class="question_ref">'+question?.reference+'.</span> ')+
                question?.title + '</label></div>' +"\n"
            result+='<div class="answer_wrapper">' +"\n"

            // check answer type
            // display List type
            if(Q_LIST_TYPE.equalsIgnoreCase(question?.answerType)){
                def validation = question?.validation

                def html = '\'<span class="a_'+question?.answerType+'" ><label class="a_'+question?.answerType+'" for="'+refID+'_\'+i+\'">\'+q_' + refID + '[i-1]+\'</label>'+
                    '<span class="question_add_att display_none"><input disabled="disabled" type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'_ref1" id="'+refID+'\'+i+\'_ref1"/></span>'+
                    '<span class="question_add_att display_none"><input disabled="disabled" type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'_ref2" id="'+refID+'\'+i+\'_ref2"/></span>'+
                    '<span class="question_add_att"><input type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'" id="'+refID+'_\'+i+\'"/></span>'+
                    '</span>\''+"\n"

                result += '<span id="' + refID +'"></span>'+HTMLUtils.JQUERY_OPEN +
                'var q_' + refID + ' = ' + validation +';'+ "\n" +
                'for(i=1;i<=q_'+refID+'.length;i++){' + "\n" +
                '$("#'+refID+'").html($("#'+refID+'").html() + '+html+');'+"\n" +
                '}' + "\n" +
                    HTMLUtils.JQUERY_CLOSE


            // display YesNo type
            }else if(Q_YES_NO_TYPE.equalsIgnoreCase(question?.answerType) ){

                def validation = Q_YES_NO_CHOICE

                def html = '\'<input type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'" id="'+refID+'_\'+i+\'"/>'+"" +
                '<label class="a_'+question?.answerType+'" for="'+refID+'_\'+i+\'">\'+q_' + refID + '[i]+\'</label>\''

                result +='<input class="question_add_att q_'+question?.answerType+' display_none float-left" disabled="disabled" type="text" name="'+ refID +'_ref1" ' +
                ' id="'+refID +'_ref1"/>'+"\n"
                result += '<input class="question_add_att q_'+question?.answerType+' display_none float-left" disabled="disabled" type="text" name="'+ refID +'_ref2" ' +
                ' id="'+refID +'_ref2"/>'+"\n"


                result += '<span class="a_'+question?.answerType+'" id="' + refID +'"></span>'+HTMLUtils.JQUERY_OPEN +"\n"+
                'var q_' + refID + ' = ' + validation +';'+ "\n" +
                'for(i=0;i<q_'+refID+'.length;i++){' + "\n" +
                '$("#'+refID+'").html($("#'+refID+'").html() + '+html+');'+"\n" +
                '}' + "\n" +
                    HTMLUtils.JQUERY_CLOSE

            }else if(Q_VALUE_TYPE.equalsIgnoreCase(question?.answerType) || Q_AUTO_TYPE.equalsIgnoreCase(question?.answerType)){
                result += '<span class="a_'+question?.answerType+'">'+"\n"
                //result += '<label class="a_'+question.answerType+'">&nbsp;</label>'
                result +='<input class="question_add_att q_'+question?.answerType+' display_none" disabled="disabled" type="text" name="'+ refID +'_ref1" ' +
                ' id="'+refID +'_ref1"/>'+"\n"
                result += '<input class="question_add_att q_'+question?.answerType+' display_none" disabled="disabled" type="text" name="'+ refID +'_ref2" ' +
                ' id="'+refID +'_ref2"/>'+"\n"
                result += '<input class="q_'+question?.answerType+' ' +classes+' " type="text" name="'+ refID +'" ' +
                ' id="'+refID +'"/></span>'+"\n"
            }

        // render admin function
            if(admin){

                if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType)){
                    result += '<span class="question_admin_info">'+
                    'Thứ tự: '+question?.ord+', Hướng dẫn: ' + question?.help +
                    '</span>';
                }
                result += '<a href="#" qid="'+question?.id+'" class="edit_question">Sửa</a> <a href="#" qid="'+question?.id+'" class="delete_question">Xóa</a>'			
            }else {
                if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType) && question?.help){
                    result += '<span class="help">'+
                        'Hướng dẫn: ' + question?.help +
                        '</span>';
                }
            }

            //render comments box
            if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType) && showComments){
            	result += '<div class="q_comments display_none" name="'+ refID +'_comments_ref1" id="' + refID +'_comments_ref1">' +
            		'<label for="' + refID +'_comments" class="comments_label">Ý kiến RM: </label>' +"\n"+
                    '<textarea cols="80" name="'+ refID +'_comments_ref1" rows="3" readonly="readonly" ></textarea></div>'+"\n"

                result += '<div class="q_comments" >' +'<label for="' + refID +'_comments"  class="comments_label">Ý kiến: </label>' +"\n"+
                    '<textarea cols="80" rows="3" name="'+ refID +'_comments" id="' + refID +'_comments"></textarea></div>'+"\n"

            }
            result += '</div>' +"\n";

            return result;
        }
			
			public static String renderQuizQuestion(QuizQuestion question, String prefix = '', String classes='',
				boolean admin = false, String showComments = ''){
				String refID = createRefId(prefix,question?.reference)
	
				String result = '<div id="q_'+ refID +'" ><label class="q_'+question?.answerType+' question_title" for="'+ refID +'">' +
					(Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType)?'':'<span class="question_ref">'+question?.reference+'.</span> ')+
					question?.title + '</label></div>' +"\n"
				result+='<div class="answer_wrapper">' +"\n"
	
				// check answer type
				// display List type
				if(Q_LIST_TYPE.equalsIgnoreCase(question?.answerType)){
					def validation = question?.validation
	
					def html = '\'<span class="a_'+question?.answerType+'" ><label class="a_'+question?.answerType+'" for="'+refID+'_\'+i+\'">\'+q_' + refID + '[i-1]+\'</label>'+
						'<span class="question_add_att display_none"><input disabled="disabled" type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'_ref1" id="'+refID+'\'+i+\'_ref1"/></span>'+
						'<span class="question_add_att display_none"><input disabled="disabled" type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'_ref2" id="'+refID+'\'+i+\'_ref2"/></span>'+
						'<span class="question_add_att"><input type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'" id="'+refID+'_\'+i+\'"/></span>'+
						'</span>\''+"\n"
	
					result += '<span id="' + refID +'"></span>'+HTMLUtils.JQUERY_OPEN +
					'var q_' + refID + ' = ' + validation +';'+ "\n" +
					'for(i=1;i<=q_'+refID+'.length;i++){' + "\n" +
					'$("#'+refID+'").html($("#'+refID+'").html() + '+html+');'+"\n" +
					'}' + "\n" +
						HTMLUtils.JQUERY_CLOSE
	
	
				// display YesNo type
				}else if(Q_YES_NO_TYPE.equalsIgnoreCase(question?.answerType) ){
	
					def validation = Q_YES_NO_CHOICE
	
					def html = '\'<input type="radio" class="a_'+question?.answerType+'" value="\'+i+\'" name="'+refID+'" id="'+refID+'_\'+i+\'"/>'+"" +
					'<label class="a_'+question?.answerType+'" for="'+refID+'_\'+i+\'">\'+q_' + refID + '[i]+\'</label>\''
	
					result +='<input class="question_add_att q_'+question?.answerType+' display_none float-left" disabled="disabled" type="text" name="'+ refID +'_ref1" ' +
					' id="'+refID +'_ref1"/>'+"\n"
					result += '<input class="question_add_att q_'+question?.answerType+' display_none float-left" disabled="disabled" type="text" name="'+ refID +'_ref2" ' +
					' id="'+refID +'_ref2"/>'+"\n"
	
	
					result += '<span class="a_'+question?.answerType+'" id="' + refID +'"></span>'+HTMLUtils.JQUERY_OPEN +"\n"+
					'var q_' + refID + ' = ' + validation +';'+ "\n" +
					'for(i=0;i<q_'+refID+'.length;i++){' + "\n" +
					'$("#'+refID+'").html($("#'+refID+'").html() + '+html+');'+"\n" +
					'}' + "\n" +
						HTMLUtils.JQUERY_CLOSE
	
				}else if(Q_VALUE_TYPE.equalsIgnoreCase(question?.answerType) || Q_AUTO_TYPE.equalsIgnoreCase(question?.answerType)){
					result += '<span class="a_'+question?.answerType+'">'+"\n"
					//result += '<label class="a_'+question.answerType+'">&nbsp;</label>'
					result +='<input class="question_add_att q_'+question?.answerType+' display_none" disabled="disabled" type="text" name="'+ refID +'_ref1" ' +
					' id="'+refID +'_ref1"/>'+"\n"
					result += '<input class="question_add_att q_'+question?.answerType+' display_none" disabled="disabled" type="text" name="'+ refID +'_ref2" ' +
					' id="'+refID +'_ref2"/>'+"\n"
					result += '<input class="q_'+question?.answerType+' ' +classes+' " type="text" name="'+ refID +'" ' +
					' id="'+refID +'"/></span>'+"\n"
				}
	
			// render admin function
				if(admin){
	
					if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType)){
						result += '<span class="question_admin_info">'+
						'Thứ tự: '+question?.ord+', Hướng dẫn: ' + question?.help +
						'</span>';
					}
					result += '<a href="#" qid="'+question?.id+'" class="edit_question">Sửa</a> <a href="#" qid="'+question?.id+'" class="delete_question">Xóa</a>'
				}else {
					if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType) && question?.help){
						result += '<span class="help">'+
							'Hướng dẫn: ' + question?.help +
							'</span>';
					}
				}
	
				//render comments box
				if(!Q_TITLE_TYPE.equalsIgnoreCase(question?.answerType) && showComments){
					result += '<div class="q_comments display_none" name="'+ refID +'_comments_ref1" id="' + refID +'_comments_ref1">' +
						'<label for="' + refID +'_comments" class="comments_label">Ý kiến RM: </label>' +"\n"+
						'<textarea cols="80" name="'+ refID +'_comments_ref1" rows="3" readonly="readonly" ></textarea></div>'+"\n"
	
					result += '<div class="q_comments" >' +'<label for="' + refID +'_comments"  class="comments_label">Ý kiến: </label>' +"\n"+
						'<textarea cols="80" rows="3" name="'+ refID +'_comments" id="' + refID +'_comments"></textarea></div>'+"\n"
	
				}
				result += '</div>' +"\n";
	
				return result;
			}

        public static String renderQuizAnswer(QuizAnswer answer, boolean showScore=false, String classes='',
                String showComments = '', Answer ref1, Answer ref2){

            String result = renderQuizQuestion(answer?.question,String.valueOf(answer?.id),classes,false,
                showComments);
            String refID = "_" + answer?.id + "_" + answer?.question?.reference

            if(showScore) result += '<div class="answer_score">Score: ' + answer?.score +'</div>'
			answer?.answer = cleanHTMLString(answer?.answer)
            // setting the value using jQuery - Magic, cleaner codes and I am
            // good, too good, :D
            result += HTMLUtils.JQUERY_OPEN;
			if(ref1?.answer  && ref2?.answer &&
				(ref1?.answer?.toFloat() == ref2?.answer?.toFloat()) &&
				(answer?.answer == null || answer?.answer == '') ){
            	answer?.answer = ref1.answer
			}

            if(Q_VALUE_TYPE.equalsIgnoreCase(answer?.question?.answerType) || Q_AUTO_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
                result += '$("#'+refID+'").val("'+(answer?.answer == null?'':answer?.answer)+'");'
            }else if(Q_YES_NO_TYPE.equalsIgnoreCase(answer?.question?.answerType) ||
                Q_LIST_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
                result += '$("input:radio[name='+refID+']").filter("[value='+answer?.answer+']").attr("checked", true);'

            }
            result += "\n";
            // rendering comparison quite complex
            if(!Q_TITLE_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
                if(ref1){
                    result += getCompareAnswerString(refID+'_ref1',ref1.answer,answer?.question?.answerType)
                }
                if(ref2){
                    result += getCompareAnswerString(refID+'_ref2',ref2.answer,answer?.question?.answerType)
                }
                //result += '$("#q_' + refID +'").append("<label class=\'question_add_att\'>Trả lời</label>");';

            }
            result += "\n";


            // set comment value
            if(showComments){
				answer?.comments=cleanHTMLString(answer?.comments)
                result += '$("#' + refID +'_comments").val("' + cleanHTMLString(answer?.comments?answer?.comments:'')+'");'+"\n"
                result += '$("textarea[name=' + refID +'_comments_ref1]").val("' + cleanHTMLString(ref1?.comments?ref1.comments:'')+'");'+"\n"
                if(ref1)
                	result +='$("#' + refID +'_comments_ref1").show();'
                if(ref1?.answer?.equals(ref2?.answer) && answer?.comments == null){
					ref1.comments=cleanHTMLString(answer?.comments)
					result +='$("#' + refID +'_comments").val("'+ref1.comments+'");'
				}
            }
            result += HTMLUtils.JQUERY_CLOSE;

            return result;
        }
				
				public static String renderAnswer(Answer answer, boolean showScore=false, String classes='',
					String showComments = '', Answer ref1, Answer ref2){
					println "1"
	
				String result = renderQuestion(answer?.question,String.valueOf(answer?.id),classes,false,
					showComments);
				String refID = "_" + answer?.id + "_" + answer?.question?.reference
	
				if(showScore) result += '<div class="answer_score">Score: ' + answer?.score +'</div>'
				answer?.answer = cleanHTMLString(answer?.answer)
				// setting the value using jQuery - Magic, cleaner codes and I am
				// good, too good, :D
				result += HTMLUtils.JQUERY_OPEN;
				if(ref1?.answer  && ref2?.answer &&
					(ref1?.answer?.toFloat() == ref2?.answer?.toFloat()) &&
					(answer?.answer == null || answer?.answer == '') ){
					answer?.answer = ref1.answer
				}
	
				if(Q_VALUE_TYPE.equalsIgnoreCase(answer?.question?.answerType) || Q_AUTO_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
					result += '$("#'+refID+'").val("'+(answer?.answer == null?'':answer?.answer)+'");'
				}else if(Q_YES_NO_TYPE.equalsIgnoreCase(answer?.question?.answerType) ||
					Q_LIST_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
					result += '$("input:radio[name='+refID+']").filter("[value='+answer?.answer+']").attr("checked", true);'
	
				}
				result += "\n";
				// rendering comparison quite complex
				if(!Q_TITLE_TYPE.equalsIgnoreCase(answer?.question?.answerType)){
					if(ref1){
						result += getCompareAnswerString(refID+'_ref1',ref1.answer,answer?.question?.answerType)
					}
					if(ref2){
						result += getCompareAnswerString(refID+'_ref2',ref2.answer,answer?.question?.answerType)
					}
					//result += '$("#q_' + refID +'").append("<label class=\'question_add_att\'>Trả lời</label>");';
	
				}
				result += "\n";
	
	
				// set comment value
				if(showComments){
					answer?.comments=cleanHTMLString(answer?.comments)
					result += '$("#' + refID +'_comments").val("' + cleanHTMLString(answer?.comments?answer?.comments:'')+'");'+"\n"
					result += '$("textarea[name=' + refID +'_comments_ref1]").val("' + cleanHTMLString(ref1?.comments?ref1.comments:'')+'");'+"\n"
					if(ref1)
						result +='$("#' + refID +'_comments_ref1").show();'
					if(ref1?.answer?.equals(ref2?.answer) && answer?.comments == null){
						ref1.comments=cleanHTMLString(answer?.comments)
						result +='$("#' + refID +'_comments").val("'+ref1.comments+'");'
					}
				}
				result += HTMLUtils.JQUERY_CLOSE;
	
				return result;
			}

        private static getCompareAnswerString(String refID, String answer,String answertType){
            def result = '$("input[name='+refID+']").parent().show();'+"\n"
            result += '$("input[name='+refID+']").show();'+"\n"
            if(!Q_LIST_TYPE.equalsIgnoreCase(answertType)){
                result += '$("input[name='+refID+']").val("'+
                (Q_YES_NO_TYPE.equalsIgnoreCase(answertType)?(answer && answer!= '0'?'Yes':'No'):(answer?:''))+'");'+"\n"
            }
            result += '$("input:radio[name='+refID+']").filter("[value='+answer+']").attr("checked", true);'+"\n"
            return result
        }

        public static String getAnswerId(Answer answer){
            return createRefId(answer?.id,answer?.question?.reference)
        }
		
		public static String getQuizAnswerId(QuizAnswer answer){
			return createRefId(answer?.id,answer?.question?.reference)
		}

        private static String createRefId(Object prefix, String id){
            String refID = "_" + (prefix?:prefix.toString()) + "_" + id
        }

		private static String cleanHTMLString(String s){
			if(s == null) return ""
			def r = "\"+\"\\\\n\"+\""
			s = s.replaceAll('"',"'")
			s = s.replaceAll("\r",r )
			s = s.replaceAll("\n",r )
			s = s.replaceAll("\r\n",r )
			return s
		}
		
		

}

