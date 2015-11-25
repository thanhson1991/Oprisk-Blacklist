<%@page import="msb.platto.dna.*"%>


<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý hình thức kiểm tra</title>
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
						[href:createLink(controller:'opError',action:'getErrorDisplay'),title:'Quản lý lỗi',label:'Quản lý lỗi']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
                     <g:render template="/admin/sidebar"/>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="insertErrorCheck" controller="admin" action="saveCheck" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý hình thức kiểm tra</legend>
 
 <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                      </g:if>
                        
  <ol class="form form-clear olCenter" id="incidentField">
   <li>
   	      <label for="checkName" class="lableCenter ">Tên kiểm tra </label>
   	      <br>
   	       <input type="text" value=""  name ="checkName" id="checkName"   class="  text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="checkCode" class="lableCenter ">Mã kiểm tra  </label>
   	      <br>
   	      <input type="text" value=""  name ="checkCode" id="checkCode"   class="  text-input largeControlCenter">
   </li>       
    
   <li> 
   	<button class="btn primary" type="submit" value="saveCheck">Tạo mới</button>
   </li>
   
   <li>
 </ol>
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-errorCheck").closest('li').addClass('active');
    set_side_bar(true);
	   $("#insertErrorCheck").validationEngine();
	   
	$("input[name=userOutlook]").focusout(function() {
		
		var un=$("#userOutlook").val();
		
		if(un!="")
		{
		
		$.getJSON('${createLink(controller:'masterUserCreate',action:'getDisplayName')}?username='+un,function(fullNameOutlook){

			
			if(fullNameOutlook==",")
				alert("Không tồn tại:"+un)
			
						
			$("#fullName").val(fullNameOutlook[0]);
			$("#title").val(fullNameOutlook[1]);
			
		});
		}
		else
			{
			$("#fullName").val("");
			$("#title").val("");
			}

			
		
	});
	</script>

  </body>
  
  
  
</html>


