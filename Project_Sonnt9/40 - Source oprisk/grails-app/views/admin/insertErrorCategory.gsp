<%@page import="msb.platto.dna.*"%>


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
						[href:createLink(controller:'opError',action:'getErrorDisplay'),title:'Quản lý lỗi',label:'Quản lý lỗi']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
                     <g:render template="/admin/sidebar"/>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="insertErrorCategory" controller="admin" action="saveCategory" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý Nghiệp vụ</legend>
 
 		<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
        </g:if>
  <g:if test="${check==1 }">
  		<ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="ChangeCategoryName" class="lableCenter ">Tên nghiệp vụ  </label>
   	      <br>
   	       <input type="text" value="${errorCate.name}"  name ="ChangeCategoryName" id="CategoryName"   class="  text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="ChangeCategoryCode" class="lableCenter ">Mã nghiệp vụ  </label>
   	      <br>
   	      <input type="text" value="${errorCate.code}"  name ="ChangeCategoryCode" id="CategoryCode"   class="  text-input largeControlCenter">
   </li>       
   
   <li>  
		<button class="btn primary" name="buttonEdit" type="submit" value="EditCategory">Sửa</button>
		<button class="btn primary"  id="delete" type="submit">Xóa</button>
		<g:hiddenField name="idCategory" value="${errorCate.id }"/>
		<g:hiddenField name="deleteCategory" id="DeleteCategory" />
		
   </li>
 </ol>
  		
  </g:if>
  <g:else>                      
  <ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="CategoryName" class="lableCenter ">Tên nghiệp vụ  </label>
   	      <br>
   	       <input type="text" value=""  name ="CategoryName" id="CategoryName"   class="  text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="CategoryCode" class="lableCenter ">Mã nghiệp vụ </label>
   	      <br>
   	      <input type="text" value=""  name ="CategoryCode" id="CategoryCode"   class="  text-input largeControlCenter">
   </li>       
   
   <li>  
    	<button class="btn primary" name="buttonNew" type="submit" value="saveCategory">Tạo mới</button>
   </li>
   
   <li>
 </ol>
 </g:else>
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-errorCategory").closest('li').addClass('active');
    set_side_bar(true);
	   $("#insertErrorStatus").validationEngine();
	   
	   $("#delete").click(function(){
			 jquery_confirm("Xóa","Anh/chị đồng ý xóa ?",
					 function(){
			 	$("#DeleteCategory").val("Xoa");
			 		  // $("#actionButton").val("errorDelete");
	            $("#insertErrorCategory").submit();
			 });
			 return false;
		});
	</script>

  </body>
  
  
  
</html>


