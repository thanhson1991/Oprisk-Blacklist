<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý loại tài sản đảm bảo blacklist</title>
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
						[href:createLink(controller:'admin',action:'getErrorDisplay'),title:'Quản lý đối tượng blacklist',label:'Quản lý đối tượng blacklist']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
                     <g:render template="/admin/sidebar"/>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="saveTaiSanBlacklist" controller="admin" action="saveTaiSanBlacklist" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý loại tài sản đảm bảo blacklist</legend>
 
 		<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
        </g:if>
  
  		<ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="ChangeCategoryName" class="lableCenter ">Tên loại tài sản <font color="red">*</font> </label>
   	      <br>
   	       <input type="text" value="${taisanBlacklist?.name}"  name ="name" id="name"   class=" validate[required] text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="ChangeCategoryCode" class="lableCenter ">Mã loại tài sản <font color="red">*</font> </label>
   	      <br>
   	      <input type="text" value="${taisanBlacklist?.code}"  name ="code" id="code"   class=" validate[required] text-input largeControlCenter">
   </li>       
   
   <li>  
		<button class="btn primary" name="save" id ="save" type="button" value="save">${taisanBlacklist?'Sửa':'Thêm mới'}</button>
		<g:if test="${taisanBlacklist }">
			<button class="btn primary"  id="delete" type="button" value="delete">Xóa</button>
		</g:if>
		<g:hiddenField name="blId" value="${taisanBlacklist?.id }"/>
		<g:hiddenField name="deletebl" id="deletebl" />
		<g:hiddenField name="savebl" id="savebl" />
		
   </li>
 </ol>
  		
  
  
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-blacklistTaiSanDB").closest('li').addClass('active');
    set_side_bar(true);
	   $("#saveTaiSanBlacklist").validationEngine();
	   $("#save").click(function(){
		   $("#savebl").val("save");			 		  
           $("#saveTaiSanBlacklist").submit();
	   });
	   
	   $("#delete").click(function(){
			 jquery_confirm("Xóa","Anh/chị đồng ý xóa ?",
					 function(){
			 	$("#deletebl").val("Xoa");			 		  
	            $("#saveTaiSanBlacklist").submit();
			 });
			 return false;
		});
	</script>

  </body>
  
  
  
</html>


