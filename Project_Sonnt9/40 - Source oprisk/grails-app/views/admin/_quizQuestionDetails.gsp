<g:form method="post" name="questionDetailsForm" action="saveQuestion" >
    <g:hiddenField id="q_id" name="id" value="${questionInstance?.id}"/>
    <g:hiddenField id="q_survey_id" name="survey.id" value="${questionInstance?.survey?.id}"/>

    <div class="dialog">
      <fieldset class="form form-narrow float-left" style="width: 450px">
        <legend>Chi tiết câu hỏi</legend>
        <ol>
          <li>
                <label for="q_answerType"><g:message code="question.answerType.label" default="Answer Type" /></label>
                  <g:select id="q_answerType" name="answerType" value="${questionInstance?.answerType}" from="${Question.constraints.answerType.inList}" valueMessagePrefix="question.answerType"  />
          </li>
          <li>
                <label for="q_reference"><g:message code="question.reference.label" default="Reference" /></label>
                  <g:textField id="q_reference" class="validate[required]" name="reference" value="${questionInstance?.reference}" />
          </li>
          <li>
                <label for="q_title"><g:message code="question.title.label" default="Title" /></label>
                  <g:textArea id="q_title" name="title" class="validate[required]" cols="40" rows="3" value="${questionInstance?.title}" />
                </li>                
          <li>
                <label for="q_validation"><g:message code="question.validation.label" default="Possible Answers" /></label>
               
<%--                <ckeditor:editor height="150"  width="200" name="validation" id="q_validation" toolbar="Basic"> ${questionInstance?.validation}</ckeditor:editor>--%>
                 <g:textArea id="q_validation" name="validation" cols="40" rows="5" value="${questionInstance?.validation}" /> 
                </li>
			<li>
			<li>
	                <label for="q_answerWeight">Answer weight</label>
	                  <g:textField id="q_answerWeight" class="e-xl" name="answerWeight" value="${questionInstance?.answerWeight}" />
	                </li>
	                 <li>             
              <span class="help">VD: 1,4,2,5</span>
              </li>
              <br>
	          <li>
				<label for="q_answerFirst">Disp. ans. left</label>
				<g:checkBox id="q_answerFirst" name="answerFirst" value="${questionInstance?.answerFirst}"/>
			</li>
			<li>
	                <label for="q_wrapperClass">Wrapper Class</label>
	                  <g:textField id="q_wrapperClass" class="e-xl" name="wrapperClass" value="${questionInstance?.wrapperClass}" />
	                </li>
	          <li>
		 <li>
                <label for="q_cssClass"><g:message code="question.reference.label" default="CSS Class" /></label>
                  <g:textField id="q_cssClass" class="e-xl" name="cssClass" value="${questionInstance?.cssClass}" />
                </li>
          <li>
			<li>
				<label for="q_indent">Left margin:</label>
				<g:textField id="q_indent" name="indent" value="${questionInstance?.indent}"/>
			</li>
          <li>
	
                <label for="q_ord"><g:message code="question.ord.label" default="Ord" /></label>
                  <g:textField id="q_ord" name="ord" class="validate[optional,onlyNumber]" class="e-s" value="${fieldValue(bean: questionInstance, field: 'ord')}" />
                </li>
          <li  style="display:none">
                <label for="q_weight"><g:message code="question.weight.label" default="Weight" /></label>
                  <g:textField id="q_weight" name="weight" />
                </li>
          <li  style="display:none">
                <label for="q_param1"><g:message code="question.param1.label" default="Param1" /></label>
                  <g:textField id="q_param1" name="param1"/>
                </li>
          <li  style="display:none">
                <label for="q_param2"><g:message code="question.param2.label" default="Param2" /></label>
                  <g:textField id="q_param2" name="param2" />
                </li>
        </ol>
      </fieldset>
      <fieldset class="form form-narrow form-clear float-left" style="width: 430px">
        <legend>Thông tin khác</legend>
        <ol>
          <li>
                <label for="q_evaluation"><g:message code="question.evaluation.label" default="Evaluation" /></label>
                  <g:textArea id="q_evaluation" name="evaluation" cols="35" rows="2" value="${questionInstance?.evaluation}" />
                </li>
          <li>
                <label for="q_descriptions"><g:message code="question.descriptions.label" default="Descriptions" /></label>
                  <g:textField id="q_descriptions" name="descriptions" class="e-xxl" value="${questionInstance?.descriptions}" />
                </li>
          <li>
                <label for="q_help"><g:message code="question.help.label" default="Help" /></label>
                  <g:textField id="q_help" name="help" class="e-xxl" value="${questionInstance?.help}" />
                </li>
          <li>
                <label for="q_status"><g:message code="question.status.label" default="Status" /></label>
                  <g:textField id="q_status" name="status" class="e-s" value="${fieldValue(bean: questionInstance, field: 'status')}" />
                </li>
          <li>
                <label for="q_param3"><g:message code="question.param3.label" default="Param3" /></label>
                  <g:textField id="q_param3" name="param3"  />
                </li>
          <li>
                <label for="q_param4"><g:message code="question.param4.label" default="Param4" /></label>
                  <g:textField id="q_param4" name="param4" />
                </li>
          <li>
                <label for="q_param5"><g:message code="question.param5.label" default="Param5" /></label>
                  <g:textField id="q_param5" name="param5" />
                </li>
        </ol>
    </fieldset>
      <fieldset class="form form-narrow float-left" style="width: 430px">
        <legend>Thử nghiệm</legend>
        <ol>
          <li>
              <label for="testAnswer">Trả lời</label>
                <g:textField name="testAnswer" class="e-xxxl" /> 
              </li>
          <li>
              <label>&nbsp;</label>
              <span class="help">VD: 3 hoặc [1,5,7] hoặc 2..12 hoặc "AAA" (cả ngoặc kép)</span>
              </li>
        </ol>
        <input class="float-right" type="button" id="testQuestionButton" value="Chạy thử" />
      </fieldset>

    </div>
</g:form>

<script type="text/javascript">
  $(document).ready(function(){	  
    $("#testQuestionButton").unbind('click');
    $("#testQuestionButton").click(function(){
      // check input size
      if($("#testAnswer").val().length > 0){
      $.post('${createLink(controller:'quizAdmin',action:'testQuestion')}',
        $("#questionDetailsForm").serialize(),function(data){
            // is there error?
              if(data.error){
                alert("Lỗi: \n\n" + data.error);
              }else{
                var r = "Kết quả: \n";
                var i = 0;
                for(i = 0;i<data.length;i++){
                  r += data[i].answer + ": " + data[i].score + "\n";
                 
                }
                alert(r);
              }

          },'json');
      }else{
          alert('Xin nhập dữ liệu đầu vào');
      }
    });

    $("#questionDetailsForm").validationEngine();
  });
</script>

