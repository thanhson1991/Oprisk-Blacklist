<html>
    <head>
         <meta name="layout" content="m-melanin-layout" />
          <ckeditor:resources />
        <title>Quản trị Survey</title>
    </head>
    <body>
        <div id="m-melanin-tab-header">


			

        <g:form action="${actionName}" class="float-right" style="margin-right: 20px" >
          
          <g:select name="id" from="${surveys}"
            optionKey="id" optionValue="title" onchange="this.form.submit()"
            value="${s?.id}"/>
          <g:submitButton name="show" class="btn create small " value="Xem" />
          <g:submitButton name="create" class="create btn small" value="Thêm Survey" />
           
        </g:form>

        <g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Quản trị survey',label:'Quản trị survey']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                         <div id="m-melanin-left-sidebar">
                      <g:render template="../opRisk/barosidebar"/>
		</div>
     
		</div>
        <div id="m-melanin-main-content">
            <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${s}">
              <div class="errors">
                <g:renderErrors bean="${s}" as="list" />
              </div>
            </g:hasErrors>


        <!-- DISPLAY SURVEY -->
        <g:if test="${s}">
          <g:form name="surveyForm" class="break">

            <fieldset class="form float-left" style="width: 460px">
              <legend>${s.id ? (s.reference + ' - ' + s.title) : 'Thêm' }</legend>
            
              <ol>
                <li><label for="reference"><g:message code="survey.reference.label" default="Reference" /></label>
                <g:textField name="reference" class="e-m" value="${s?.reference}" />
                </li>
                <li><label for="departmentId">Loại nghiệp vụ</label>
                 <g:select name="departmentId" from="${departments}" value="${s?.department?.id}" optionValue ="name" optionKey="id"/>
                </li>
                <li><label for="title"><g:message code="survey.title.label" default="Title" /></label>
                <g:textField name="title" class="e-xxl" value="${s?.title}" />
                </li>
                <li><label for="descriptions"><g:message code="survey.descriptions.label" default="Descriptions" /></label>
                <g:textField name="descriptions" class="e-xxl" value="${s?.descriptions}" />
                </li>
                <li><label for="defaultQuestionEvaluation"><g:message code="survey.defaultQuestionEvaluation.label"
                                                                      default="Default Question Formula" /></label>
                </li>
                <li>
                <g:textArea name="defaultQuestionEvaluation" value="${s?.defaultQuestionEvaluation}"
                            rows="2" cols="60"/>
                </li>
              </ol>
            </fieldset>
            <div class="float-left">
              <fieldset class="form float-left" style="width: 460px">
                <legend>Công thức</legend>
                <ol>

                  <li><label for="evaluation"><g:message code="survey.evaluation.label" default="Evaluation Formula" /></label>
                  </li>
                  <li>
                  <g:textArea name="evaluation" value="${s?.evaluation}"
                                rows="7" cols="60"/>
                  </li>
                </ol>
              </fieldset>
              <div class="buttons break">
              <input type="hidden" value="${s?.id}" name="id"/>
              <input type="hidden" value="${s?.version}" name="version"/>
                <span class="button"><g:submitButton name="save" class="save" value="Cập nhật" /></span>
            </div>
            </div>
            
          </g:form>
          <!-- DISPLAY QUESTIONS -->
          <g:if test="${s.id}">
            <fieldset class="survey break survey_admin">
              <legend>Danh sách câu hỏi - <input type="button" id="addQuestionButton" value="Thêm câu hỏi" /></legend>
              <ul>
                <g:each in="${s.questions}" var="q">
                  <li><survey:displayQuestion question="${q}" admin="${true}"/>
                  </li>
                </g:each>
              </ul>
            </fieldset>

          <!-- QUESTION DIALOG -->
          <div id="questionDetailsDialog" title="Chi tiết câu hỏi - ${s.reference + ' - ' + s.title}">
            <g:render template="/admin/questionDetails"/>
          </div>
          <script type="text/javascript">
            $(document).ready(function(){    
            	 
              // click on the question
              $(".delete_question").unbind('click');

              $(".delete_question").click(function(){
            	  var qid = $(this).attr('qid');
            	  jquery_confirm("Lưu phản hồi","Anh/chị đồng ý xóa câu hỏi này?",
                          function(){
            		  		document.location="${createLink(controller:'surveyAdmin',action:'deleteQuestion')}/"+qid;
            	  		
                    });
             
              return false;
              });
              
              $(".edit_question").unbind('click');

              $(".edit_question").click(function(){
                  var qid = $(this).attr('qid');
                  var question = $.getJSON('${createLink(controller:'surveyAdmin',action:'getQuestion')}/'+qid,
                    // Now displayin data in the popup :)
                    function(data){
                      if(data){
                        $('#q_survey_id').val($("#id").val());
                        $('#q_id').val(data.id);
                        $('#q_answerType').val(data.answerType);
                        $('#q_reference').val(data.reference);
						$('#q_cssClass').val(data.cssClass);
						$('#q_wrapperClass').val(data.wrapperClass);
                        $('#q_evaluation').val(data.evaluation);
                        $('#q_validation').val(data.validation);
                        $('#q_answerWeight').val(data.answerWeight);
                        $('#q_title').val(data.title);
						$('#q_indent').val(data.indent);
						$('#q_answerFirst').attr('checked',data.answerFirst);
                        $('#q_ord').val(data.ord);
                        $('#q_descriptions').val(data.descriptions);
                        $('#q_help').val(data.help);
                        $('#q_status').val(data.status);
                        $('#q_weight').val(data.weight);
                        $('#q_param1').val(data.param1);
                        $('#q_param2').val(data.param2);
                        $('#q_param3').val(data.param3);
                        $('#q_param4').val(data.param4);
                        $('#q_param5').val(data.param5);
                        // open the dialog
                        $('#questionDetailsDialog').dialog('open');

                      }
                    }
                  )
              });

              // create the dialog
              $("#questionDetailsDialog").dialog({
                  autoOpen: false,
                  height: 530,
                  width: 1020,
                  modal: true,
                  buttons:{
                    'Đóng': function() {
                        $(this).dialog('close');
						document.location="${createLink(controller:'surveyAdmin',action:'index')}/" +
                            $("#id").val();
                          // reload page here
                    },
                    'Lưu': function() {
                        // validation
                        if($("#questionDetailsForm").validationEngine({returnIsValid:true,
                                scroll:false})){

                          // check for the list validity
                          if($("#q_answerType").val() == 'List'){
                            try{
                              eval('var ltIsTooCool = ' + $("#q_validation").val() + ";");
                            }catch(err){
                              alert("Có lỗi về giá trị các câu trả lời.\n" +
                                "Xin vui lòng sử dụng các cấu trúc sau:\n\n" +
                                "['Có','Không','Không rõ'] hoặc \n" +
                                "['Nam','Nữ','Không rõ'] hoặc \n" +
                                "[1,2,3,4,5,6,7]"
                              );
                              return ;
                            }
							
                            if(/^[0-9,]+$/.test($("#q_answerWeight").val())== false && $("#q_answerWeight").val() != ''){
								alert('Có lỗi về cấu trúc trọng số các câu trả lời.')
								return;
                                };
                                
                          }


                          // post the value with AJAX
                          $.post('${createLink(controller:'surveyAdmin',action:'saveQuestion')}',
                          $("#questionDetailsForm").serialize(),function(data){
                            if(data == '1'){
                              alert('Cập nhật thành công')
                              //$(this).dialog('close');
                            }else{
                              alert(getErrors(data));
                            }
                          });
                        }
                    }
                    

                  },
                  beforeclose: function(event,ui){
                      //$.validationEngine.closePrompt(".formError",true);
                  }
              });
              // clean the dialog
              $('#addQuestionButton').click(function() {
                  $('#q_survey_id').val($("#id").val());
                  $('#q_id').val('');
                  $('#q_reference').val('');
                  $('#q_cssClass').val('');
					$('#q_wrapperClass').val('');
                  $('#q_validation').val('');
                  $('#q_answerWeight').val('');
                  $('#q_title').val('');
                  $('#q_ord').val(${s?s.questions?.size():'0'});
				  $('#q_answerFirst').attr('checked',false);
	              $('#q_indent').val('0');
                  $('#q_descriptions').val('');
                  $('#q_help').val('');
                  // open the dialog
                  $('#questionDetailsDialog').dialog('open');

              });

            });
          </script>
          </g:if>
        </g:if>

        <script type="text/javascript">
            $(document).ready(function(){
                set_side_bar(true);
               $("#survey-management").closest('li').addClass('active');
              set_active_tab('baro-management');
            });
        </script>
      </div>
        <br>
    <br>
    <br>
    
    </body>
</html>
