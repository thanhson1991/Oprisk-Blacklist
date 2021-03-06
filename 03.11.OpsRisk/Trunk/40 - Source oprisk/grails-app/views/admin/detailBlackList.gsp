<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý danh sách blacklist</title>
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
						[href:createLink(controller:'admin',action:'getErrorDisplay'),title:'Quản lý blacklist',label:'Quản lý blacklist']]
					]}"/>
          </div>
         
			<div class="clear"></div>
			 
		</div>
		<div id="m-melanin-left-sidebar">
                     <g:render template="/admin/sidebar"/>
		</div>
	<div id="m-melanin-main-content">
	<g:form method="post" name="saveBlackList" controller="admin" action="saveBlackList" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý danh sách Blacklist</legend>
 
 		<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
        </g:if>
  
  		<ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="ChangeCategoryName" class="lableCenter ">Tên blacklist <font color="red">*</font> </label>
   	      <br>
   	       <input type="text" value="${blackList?.name}"  name ="name" id="name"   class=" validate[required] text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="ChangeCategoryCode" class="lableCenter ">Mã blacklist <font color="red">*</font> </label>
   	      <br>
   	      <input type="text" value="${blackList?.code}"  name ="code" id="code"   class=" validate[required] text-input largeControlCenter">
   </li>       
   
   <li>  
		<button class="btn primary" name="save" id ="save" type="button" value="save">${blackList?'Sửa':'Thêm mới'}</button>
		<g:if test="${blackList }">
			<button class="btn primary"  id="delete" type="button" value="delete">Xóa</button>
		</g:if>
		<g:hiddenField name="blId" value="${blackList?.id }"/>
		<g:hiddenField name="deletebl" id="deletebl" />
		<g:hiddenField name="savebl" id="savebl" />
		
   </li>
 </ol>
  		
  
  
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-blacklistCategory").closest('li').addClass('active');
    set_side_bar(true);
	   $("#saveBlackList").validationEngine();
	   $("#save").click(function(){
		   $("#savebl").val("save");			 		  
           $("#saveBlackList").submit();
	   });
	   
	   $("#delete").click(function(){
			 jquery_confirm("Xóa","Anh/chị đồng ý xóa ?",
					 function(){
			 	$("#deletebl").val("Xoa");			 		  
	            $("#saveBlackList").submit();
			 });
			 return false;
		});
	</script>

  </body>
  
  
  
</html>


