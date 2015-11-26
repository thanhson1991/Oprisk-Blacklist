<%@page import ="org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
   
    <style type="text/css" media="screen">
      fieldset{
        margin-left:0px !important;
        margin-right:0px !important;
      }
    </style>
    <ckeditor:resources />
    <title>Kiểm tra kiến thức</title>
  </head>

  <body>
   <br>
    <br>
   <div id="m-melanin-main-content" style="width:960px;margin:auto">


   <g:if test="${process.status == 100 && SpringSecurityUtils.ifAnyGranted('ROLE_GDTT')}">
    <div class ="message">
      <g:message code="quizNote" />
    </div>
  </g:if>

  <g:if test="${messageCode != null && messageCode!=0 && messageCode!=3}">
    <div class ="message">
      <g:message code="message${messageCode}" />
    </div>
  </g:if>

  <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_GDTT') && process.status==0}">
    
    <div>
      <fieldset class="info">
        <legend>Hướng dẫn</legend>
        
        <p><i>- Anh/chị hãy tick vào đáp án đúng nhất với mỗi câu hỏi.</i></p>      
        
        <p><span style="float:left"><b>Thời gian còn lại:</b></span> <span class="countdown" id="defaultCountdown"></span></p>
      </fieldset>
    </div>
  </g:if>
  <br>
 
<br clear="both">

  <g:form method="post" name="saveForm" controller="opRisk" action="createQuiz" id="${params.id}">
    <g:hiddenField name="surveyInstanceId" value="${process.surveyInstance.id}"/>
    <g:hiddenField name="proceed"/>
    <g:hiddenField name="approve"/>
    <g:hiddenField name="deny"/>
    <g:hiddenField name="delete"/>
    <g:hiddenField name="saveComments"/>
    <g:hiddenField name="save"/>
    <g:hiddenField name="minutes"/>
    <g:hiddenField name="seconds"/>
     <g:if test="${process.status !=100 || SpringSecurityUtils.ifNotGranted('ROLE_GDTT')}">
    <div class="center"><h2>Kiểm tra kiến thức</h2></div>
    </g:if>
    <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}">
    <fieldset class="info">
      <ul class="form form-wide">

        
        <li><label class="e-xxxxl label-left" for="empName">Tên giám đốc TT (Ví dụ: Nguyễn Văn A):</label><br>
          <input class="e-xxxxl validate[required]" ${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')?'':"readonly='readonly'"} id="empName" name ="empName" type="text" value="${process.employee.fullname}"/>
        </li>
        <br>
        <li><label class="e-xxxxl label-left" for="branch">Tên Đơn vị (Ví dụ: TT KHCN Láng Hạ):</label><br>   
          <input class="e-xxxxl validate[required]" ${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')?'':"readonly='readonly'"} id="branch" name ="branch" type="text" value="${process.branchName}"/>
        </li>
        
        <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}">
          <br>
          <li class="">
				<button id="saveDetails" class="primary btn" name="saveDetails" value="saveDetails"/>Lưu thông tin</button>
                                <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR') &&(process.status == 100)}">
                                  <button class="btn" id="deny" name="deny" value="deny">Gửi trả báo cáo lại cho đơn vị</button>
                                </g:if>
                                <button class="btn" id="delete" name="delete" value="delete">Xoá bỏ báo cáo</button>
                                <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'quizReportList')}'">Quay lại trang trước</button>
			</li>
        </g:if>
      </ul>
    </fieldset>
    </g:if>
<!--    <g:if test="${process.status == 200 || SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}">
      <fieldset class="survey">
    	  <p><b>Phản hồi của phòng QLRR:</b></p>
          <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}">
            <div class="commentsEditor">
            <ckeditor:editor height="400"  width="950" name="comments" id="comments" toolbar="Full"> ${process.comments}</ckeditor:editor>
            </div>
            <div class="commentsReview hidden">
            ${process.comments }
            </div>
             <br clear=both>
          </g:if>
          <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_GDTT')}">
            <p>${process.comments}</p>
          </g:if>

            <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR') &&(process.status == 100 || process.status == 0)}">
           <button class="btn primary" id="approve" name="approve" value="approve">Gửi phản hồi cho đơn vị</button>
          <button class="btn" id="deny" name="deny" value="deny">Gửi trả báo cáo lại cho đơn vị</button>
          <button class="btn" id="delete" name="delete" value="delete">Xoá bỏ báo cáo</button>
         


          </g:if>
          <g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}">
             <button class="btn" type="button" id="saveComments" name="saveComments" value="saveComments">Lưu phản hồi</button>
             <button class="btn" type="button" id="reviewComments" name="reviewComments" value="reviewComments">Xem trước phản hồi</button>
             <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'reportList')}'">Quay lại trang trước</button>

             <button class="btn hidden" id="backToComments" name="backToComments" value="backToComments">Quay trở lại</button>
          </g:if>

   	  </fieldset>
	</g:if>-->
        
      
       
     

      <g:if test="${process.status !=100 || SpringSecurityUtils.ifNotGranted('ROLE_GDTT')}">
		
        <fieldset class="survey">         

          <p><i>Anh/chị hãy trả lời các câu hỏi dưới đây:</i></p>
          <ul>

            <g:each status="i" in="${instance.answers}" var="answer">
              <li class="question_full">
              <survey:displayQuizAnswer answer="${answer}"/>
              </li>
              <br>
            </g:each>
          </ul>
        </fieldset>    
		
   
    </g:if>
 


<g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_GDTT') && process.status == 0}">
  <center><button class="btn primary" id="proceed" name="proceed" value="proceed"/>Gửi báo cáo đến phòng QLRR</button></center>
</g:if>

</g:form>


<script type="text/javascript">
    //TableToolsInit.sTitle = "Sự cố rủi ro hoạt động";
    //TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";

    $(document).ready(function(){
    	var shortly = new Date(); 
    	shortly.setMinutes(shortly.getMinutes() + ${minutes});
    	shortly.setSeconds(shortly.getSeconds() + ${seconds});
    	$('#defaultCountdown').countdown({until: shortly,onExpiry: submitQuiz,onTick: watchCountdown,format: 'MS'}); 
    	var newYear = new Date(); 
    	//newYear = new Date(newYear.getFullYear() + 1, 1 - 1, 1); 
    	//alert(newYear);
    	//$('#defaultCountdown').countdown({until: newYear}); 
    	 
    	

    	function watchCountdown(periods) { 
    		   // save quiz with AJAX
    		$("#saveForm input[name=save]").val('Processing');
    		$("#saveForm input[name=minutes]").val(periods[5]);
    		$("#saveForm input[name=seconds]").val(periods[6]);
            $.post('${createLink(controller:'opRisk',action:'saveQuiz')}',
            $("#saveForm").serialize(),function(){
              
            });
    	}

    	function submitQuiz(){
        	alert('Hết thời gian. Bài kiểm tra của anh/chị đã được gửi đến phòng QLRR');
    		$("#saveForm input[name=proceed]").val('Processing');
            $("#saveForm").submit();

        }
        
      set_active_tab('quiz');      
       $("#reviewComments").click(function(){
			$("button[name=saveComments]").hide();
			var body = CKEDITOR.instances['comments'].getData();
			$(".commentsReview").html(body);
			/*alert( body);*/
			$("#reviewComments").addClass("hidden");
			$(".commentsEditor").addClass("hidden");
			$("#backToComments").removeClass("hidden");
			$(".commentsReview").removeClass("hidden");
       });
       $("#backToComments").click(function(){
         $("button[name=saveComments]").show();
    	   $("#backToComments").addClass("hidden");
           $(".commentsReview").addClass("hidden");
    	   $(".commentsEditor").removeClass("hidden");
    	   $("#reviewComments").removeClass("hidden");
       });


      $("#datepicker").datepicker();
    
      //$("#saveForm").validationEngine();
      $("input.a_List").addClass("validate[required]");

      if(${process.status > 0 || SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}){
        $("input.a_List").attr("disabled",true);
      }

      $("input.a_List[name *=_ref]").removeClass("validate[required]");

   


      $("button[name=save]").click(function(){
          jquery_confirm("Lưu","Anh/chị đồng ý lưu báo cáo này?",
                      function(){
                            $("#saveForm input[name=save]").val('Processing');
                            $("#saveForm").submit();
                           
                });
         
          return false;
      });

      $("button[name=approve]").click(function(){
         
          jquery_confirm("Phản hồi","Anh/chị đồng ý gửi phản hồi đến đơn vị?",
                      function(){
                            $("#saveForm input[name=approve]").val('Processing');
                            $("#saveForm").submit();
                          
                });
         
          return false;
      });

      $("button[name=proceed]").click(function(){
         
          jquery_confirm("Gửi","Anh/chị đồng ý gửi báo cáo này đến phòng QLRR?",
                      function(){
                            $("input[name=proceed]").val('Processing');
                            $("#saveForm").submit();
                           
                });        
          return false;
      });

      $("button[name=deny]").click(function(){
          $("#comments").removeClass('validate[required]');         
          jquery_confirm("Từ chối","Anh/chị đồng ý gửi lại báo cáo này về đơn vị để sửa đổi?",
                      function(){
                            $("#saveForm input[name=deny]").val('Processing');
                            $("#saveForm").submit();
                           
                });
          
          return false;
      });

        $("button[name=delete]").click(function(){
          $("#comments").removeClass('validate[required]');        
          jquery_confirm("Xóa","Anh/chị đồng xóa bỏ báo cáo này?",
                      function(){
                            $("#saveForm input[name=delete]").val('Processing');
                            $("#saveForm").submit();
                         
                });         
          return false;
      });

       $("button[name=saveComments]").click(function(){
          
          jquery_confirm("Lưu phản hồi","Anh/chị đồng ý lưu phản hồi này?",
                      function(){
                            $("#saveForm input[name=saveComments]").val('Processing');
                            $("#saveForm").submit();
                            
                });
         
          return false;
      });  

     

        $(".survey input[type=radio]").change(function(){
          var selected = $(this)
          $(".survey input[name="+selected.attr('name')+"]").each(function(index){
              if($(this).attr('id') != selected.attr('id')){
                $("label[for="+$(this).attr('id')+"]").removeClass('selected_a_list');
              }else{
			$("label[for="+$(this).attr('id')+"]").addClass('selected_a_list');
			
			}
		});
	});
	$(".a_List").attr('title','Nhấn để chọn câu trả lời này.');

	

    
});
   

</script>

</div>
</body>

</html>
