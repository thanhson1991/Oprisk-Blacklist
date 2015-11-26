<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Phân tích kịch bản</title>
  </head>
  <body>
  	<div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
             
             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'detailScript'),title:'Phân tích kịch bản',label:'Phân tích kịch bản']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar"><g:render template="scriptSidebar"/></div>
		</div>
     <div id="m-melanin-main-content">
       <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
          <g:form method="post" id="saveForm" name="saveForm" controller="opRisk" action="saveScript">
            <g:hiddenField name="scriptId" value="${script?.id}"/>
            <fieldset>
              <legend>Phân tích kịch bản</legend>
              <ol class="olCenter form form-clear">
              	<li>                  
                  <label class="e-xl label-left" style="width:207px !important" for="scriptCode">Mã kịch bản <font color="red">*</font></label>
                                    
                  
                </li>
                <li>                  
                  <input class="e-xl validate[required]" name="scriptCode" id="scriptCode" readonly="readonly" value="${script?script.id:RiskScript.findAll().size() +1 }"/>                  
                  
                </li>
                <li>
                  <label class="e-xl label-left" for="description" style="width:207px !important">Mô tả kịch bản <font color="red">*</font></label>
                </li>
                <li>
                   <textarea style="width:413px" class="validate[required]" name="description" id="description" value="${script?.description}">${script?.description}</textarea>
                </li>
                <li>                  
				  <label class="e-xl label-left" for="businessField">Tên lĩnh vực kinh doanh <font color="red">*</font></label>	                                    
                  <label class="e-xl label-left" for="event">Tên loại sự kiện <font color="red">*</font></label>
                </li>
                <li>
                  <g:select class="se-xl validate[required]" name="businessField" id="businessField" from="${businessFields}" optionKey="id" optionValue="name" value="${script?.businessField}"/>                  
                  <g:select class="se-xl validate[required]" name="event" id="event" from="${events}" optionKey="id" optionValue="name" value="${script?.event}"/>
                </li>
                <li>       
                <label style="float:left" class="e-xl label-left" for="financialLoss">Đánh giá khả năng xảy ra <font color="red">*</font></label>           
                  <ul class="mega-menu" rel="possibility" style="margin-left: 0px;float:left">                  
					<li><a href="#" class="drop basePossibility" rel="${script?script.possibility.id:null }" id="possibility.description">${script?script.possibility.description:'Chọn khả năng xảy ra...' }</a><!-- Begin 4 columns Item -->
					        <div id="possibility-list" class="dropdown_4columns ">
						        <h2>Xin chọn 1 trong các khả năng xảy ra sau<a class="close-mega-menu " rel="-1">Đóng</a></h2>
								<div class="col_4">
					                <ul>
										<g:each in="${possibilities}" var="possibility">
					                    	<li><a href="#" rel="${possibility.id}">${possibility.description}</a></li>
					                    </g:each>
					                </ul>
					            </div>
          			        </div>
						</li>
				</ul>
				<input type="hidden" name ="possibility" id="possibility"/>
                </li>
                <li>
                	<label class="e-xl label-left" style="width:207px !important" for="financialLoss">Tổn thất xảy ra (nếu có) <font color="red">*</font></label>
                </li>
                
                <li>
                	<input class="e-xl validate[required] incident-field-number price" name="financialLoss" id="financialLoss" value="${script?.financialLoss}"/> VND
                </li>
                <li>
                  
                  <label class="e-xl label-left" for="actionPlan">Kế hoạch hành động <font color="red">*</font></label>
                </li>
                <li>                  
                                     
                   <textarea style="width:413px" class=" validate[required]" name="actionPlan" id="actionPlan" >${script?.actionPlan}</textarea>
                </li>
                <li>                  
                  <label class="e-xl label-left" for="actionStatus">Trạng thái hành động <font color="red">*</font></label>                  
                  
                </li>
                <li><g:select class="se-xl validate[required]" name="actionStatus" id="actionStatus" from="${actionStatus}" optionKey="id" optionValue="nameStatus" value="${script?script.actionStatus:'Chưa khắc phục'}"/>
                                
                </li>
                 <br>
                <li>
                <button class="btn primary" type="button" id="saveScript" name="saveScript" value="saveScript">${script?'Cập nhật':'Lưu'}</button>
                  <g:if test ="${script }">
                  <button class="btn primary" type="button" id="newScript" name="newScript">Lưu mới</button>
                  <button class="btn primary" type="button" id="deleteScript" name="deleteScript">Xóa</button>
                  </g:if>           
                  <button class="btn primary" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'listScript')}'">Quay lại</button>
                
                </li>
               
                <li class="">
                	    
                  
                </li>
                
              </ol>
            </fieldset>
            <g:hiddenField id = "clone" name = "clone"/>
			<g:hiddenField id = "delete" name = "delete"/>
			<g:hiddenField id = "save" name = "save"/>			
           
          </g:form>
      </div>


    <script type="text/javascript">
       $(document).ready(function(){
          $("#saveForm").validationEngine();
          set_active_tab('riskScript');
          $("#script-add-management").closest('li').addClass('active');//leftMenu
          set_side_bar(true);

          $("ul.mega-menu ul li a").click(function(){
       	   $("ul.mega-menu > li").removeClass('hover');
       	   $(this).closest('.mega-menu').find('li').removeClass('selected');
              $(this).closest('li').addClass('selected');
              $(this).closest('.mega-menu').find('.drop').first().html($(this).html());              
              //$("#possibility").val($(this).html());              
              $("#possibility").val($(this).attr('rel'));
              $(".basePossibility").attr('rel',$(this).attr('rel'));
              return false;
      });
          //$("ul.mega-menu ul li a").click();
          if ($("ul.mega-menu li a").html()!='Chọn khả năng xảy ra...') {            
          	$("#possibility").val($("ul.mega-menu ul li a").attr('rel'));
          }
          $("ul.mega-menu > li").click(function(event){
                  $("ul.mega-menu > li").removeClass('hover');
                  $(this).addClass('hover')
                  return false;
          });
          $("ul.mega-menu .close-mega-menu").click(function(){

                  $("ul.mega-menu > li").removeClass('hover');
                  return false;
          });
          
          $("button[name=saveScript]").click(function(){
          	   $("#save").val("true");
          	   if($("#possibility").val()==''){
              	   alert('Bạn chưa chọn khả năng xảy ra');
              	   return false;
              }	
       	   $("#saveForm").submit();

           });
           
           $("button[name=newScript]").click(function(){
          	   $("#clone").val("true");	
          	 $("#possibility").val($("ul.mega-menu li a").attr('rel'));          	 
          	 if($("#possibility").val()==''){
            	   alert('Bạn chưa chọn khả năng xảy ra');
            }	
       	   $("#saveForm").submit();

           });
         

            $("#deleteScript").click(function(){
            jquery_confirm("Xóa bản tin","Anh/chị đồng ý xóa kịch bản này?",
                          function(){
            	 			$("#delete").val("true");	
             	   			$("#saveForm").submit();
                    });
              return false;

          });
           

    
       });
       TableToolsInit.sTitle = "Quan ly ban tin";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>

  </body>
</html>
