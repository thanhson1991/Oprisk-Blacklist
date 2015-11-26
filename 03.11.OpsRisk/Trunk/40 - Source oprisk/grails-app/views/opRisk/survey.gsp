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
    <title>Báo cáo rủi ro</title>
  </head>

  <body>
   <br>
    <br>
   <div id="m-melanin-main-content" style="width:960px;margin:auto">


   <g:if test="${process.status == 100 && SpringSecurityUtils.ifAnyGranted('ROLE_GDTT')}">
    <div class ="message">
      <g:message code="note" />
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
        <p><i>- Anh/chị hãy tick vào lựa chọn phù hợp nhất với tình hình hoạt động ở Trung tâm mình.</i></p>       
        <p>Các anh chị nên sử dụng khoảng <b>30 phút</b> để hoàn thành bản Báo cáo này</p>
      </fieldset>
    </div>
  </g:if>
  <br>


  <g:form method="post" name="saveForm" controller="opRisk" action="create" id="${params.id}">
    <g:hiddenField name="surveyInstanceId" value="${process.surveyInstance.id}"/>
    <g:hiddenField name="proceed"/>
    <g:hiddenField name="approve"/>
    <g:hiddenField name="deny"/>
    <g:hiddenField name="delete"/>
    <g:hiddenField name="saveComments"/>
    <g:hiddenField name="save"/>
    <div class="center"><h2>Báo Cáo Rủi Ro Hoạt Động Hàng Tháng</h2></div>
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
                                <button class="btn" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'reportList')}'">Quay lại trang trước</button>
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
        
      
       
     

      <g:if test="${process.status != 200 || SpringSecurityUtils.ifNotGranted('ROLE_GDTT')}">
		
        <fieldset class="survey">         

          <p><i>Hãy trả lời những câu hỏi sau đây theo hiểu biết của anh/chị về hoạt động của trung tâm. Hãy dựa vào kết quả Checklist RRHĐ để trả lời câu hỏi.</i></p>
          <ul>

            <g:each status="i" in="${instance?.answers}" var="answer">
                  <li class="question_full">
	              	<survey:displayAnswer answer="${answer}"/>

	              </li>
	              <br>
    
            </g:each>
          </ul>
        </fieldset>    
		
   
    </g:if>
 


<g:if test="${SpringSecurityUtils.ifAnyGranted('ROLE_GDTT') || process.status == 0}">
  <center><button class="btn primary" id="proceed" name="proceed" value="proceed"/>Gửi báo cáo đến phòng QLRR</button></center>
</g:if>

</g:form>


<script type="text/javascript">
    //TableToolsInit.sTitle = "Sự cố rủi ro hoạt động";
    //TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";

    $(document).ready(function(){
      set_active_tab('baro');
       $("#incidentField").hide();
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
    
      $("#saveForm").validationEngine();
      $("input.a_List").addClass("validate[required]");

      if(${process.status > 0 || SpringSecurityUtils.ifAnyGranted('ROLE_CVQLRR')}){
        $("input.a_List").attr("disabled",true);
      }

      $("input.a_List[name *=_ref]").removeClass("validate[required]");

      $(".delete_incident").click(function(){
        var deleteId = $(this).attr('tid');        
        jquery_confirm("Xóa sự kiện","Anh/chị đồng ý xóa bỏ sự kiện này?",
                      function(){
                            document.location = "${createLink(controller:'opRisk',action:'create',params:[deleteIncident:'a',processId:process.id])}&deleteId="+deleteId;

                });

          return false;

      });

       $("button[name=saveincident]").click(function(){
          
          jquery_confirm("Thêm sự kiện","Anh/chị đồng ý thêm sự kiện này?",
                      function(){
                            $("#saveForm input[name=saveincident]").val('Processing');
                            $("#saveForm").submit();
                            
                });
         
          return false;
      });

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

	 //edit incident
//      $(".edit_button").click(function(){
//         var id = $(this).attr("id");
//         $("#datepicker").attr("value",$(".datepicker"+id).html());
//         $("#description").attr("value",$(".description"+id).html());
//         $("#cause").attr("value",$(".cause"+id).html());
//         $("#solution").attr("value",$(".solution"+id).html());
//         $("#financialLoss").attr("value",$(".financialLoss"+id).html());
//         $("#nonFinancialLoss").attr("value",$(".nonFinancialLoss"+id).html());
//         $("#incidentID").attr("value",id);
//
//         $("#panel").slideDown("slow");
//      });
      //
      //delete incident
//      $(".delete_button").click(function(){
//        var id =   $(this).attr("id");
//       jquery_confirm("Xoá","Bạn đồng ý xóa sự vụ này?",function(){
//          var Incidentno= $("#incidentNo"+id).attr("value");
//          alert(Incidentno);
//         $.post('${createLink(controller:'opRisk',action:'deleteIncident',params:[incidentno:Incidentno])}',("#listOfIncident").serialize(),function(data){
//
//         $(".survey").html(data);
//            });
//              //jquery_open_load_spinner();
//              return false;
//          });
//      });

      $("#addnew").click(function(){
        $(".incident-field").addClass("validate[required]");
        $(".incident-field-number").addClass("validate[required]");
        $(this).addClass("hidden");
        $("#incidentField").slideDown("slow");
        if($("#saveForm").validationEngine({returnIsValid:true})){

//		$(this).toggleClass("active");
                return false;
        }

      });

      $("#saveForm").validationEngine();
//      $("#incidentForm button[name=saveincident]").click(function(){
//        if($("#incidentForm").validationEngine({returnIsValid:true})){
//
//        // ajax
//         $.post('${createLink(controller:'opRisk',action:'saveincident',params:[prosID:process.id])}',$("#incidentForm").serialize(),function(data){
//         $(".survey").html(data);
//         });
//         $("#datepicker").attr("value","");
//         $("#description").attr("value","");
//         $("#cause").attr("value","");
//         $("#solution").attr("value","");
//         $("#financialLoss").attr("value","");
//         $("#nonFinancialLoss").attr("value","");
//         $("#addnew").removeClass("hidden");
//         $("#panel").slideUp("slow");
//		 var id=$("#incidentID").attr("value","");
//            return false;
//         }
//      });
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
TableToolsInit.sTitle = "Su co rui ro hoat dong";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
</script>

</div>
</body>

</html>
