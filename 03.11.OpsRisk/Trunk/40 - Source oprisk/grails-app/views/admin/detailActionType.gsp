<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý nghiệp vụ</title>
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
						[href:createLink(controller:'admin',action:'getErrorDisplay'),title:'Quản lý loại hành động',label:'Quản lý lĩnh vực kinh doanh']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
                     <g:render template="/admin/sidebar"/>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="saveActionType" controller="admin" action="saveActionType" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý Loại hành động</legend>
 
 		<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
        </g:if>
  
  		<ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="ChangeCategoryName" class="lableCenter ">Tên loại hành động <font color="red">*</font> </label>
   	      <br>
   	       <input type="text" value="${actionType?.name}"  name ="name" id="name"   class=" validate[required] text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="ChangeCategoryCode" class="lableCenter ">Mã loại hành động <font color="red">*</font> </label>
   	      <br>
   	      <input type="text" value="${actionType?.code}"  name ="code" id="code"   class=" validate[required] text-input largeControlCenter">
   </li>       
   
   <li>  
		<button class="btn primary" name="save" id ="save" type="button" value="save">${actionType?'Sửa':'Thêm mới'}</button>
		<g:if test="${actionType }">
			<button class="btn primary"  id="delete" type="button" value="delete">Xóa</button>
		</g:if>
		<g:hiddenField name="actionTypeId" value="${actionType?.id }"/>
		<g:hiddenField name="deleteField" id="deleteField" />
		<g:hiddenField name="saveField" id="saveField" />
		
   </li>
 </ol>
  		
  
  
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-actionType").closest('li').addClass('active');
    set_side_bar(true);
	   $("#saveActionType").validationEngine();
	   $("#save").click(function(){
		   $("#saveField").val("save");			 		  
           $("#saveActionType").submit();
	   });
	   
	   $("#delete").click(function(){
			 jquery_confirm("Xóa","Anh/chị đồng ý xóa ?",
					 function(){
			 	$("#deleteField").val("Xoa");			 		  
	            $("#saveActionType").submit();
			 });
			 return false;
		});
	</script>

  </body>
  
  
  
</html>


