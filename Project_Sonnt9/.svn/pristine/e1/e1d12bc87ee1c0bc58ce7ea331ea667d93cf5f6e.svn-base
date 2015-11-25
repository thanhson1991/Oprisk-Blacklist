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
	<g:form method="post" name="insertErrorStatus" controller="admin" action="saveStatus" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Quản lý Nghiệp vụ</legend>
 
 		<g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
        </g:if>
  <g:if test="${check==1 }">
  		<ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="ChangeCategoryName" class="lableCenter ">Tên trạng thái  </label>
   	      <br>
   	       <input type="text" value="${status.nameStatus}"  name ="ChangeNameStatus" id="ChangeNameStatus"   class="  text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="ChangeCategoryCode" class="lableCenter ">Mã trạng thái  </label>
   	      <br>
   	      <input type="text" value="${status.code}"  name ="ChangeCodeStatus" id="ChangeCodeStatus"   class=" text-input largeControlCenter">
   </li>       
   
   <li>  
		<button class="btn primary" name="buttonEdit" type="submit">Sửa</button>
		<button class="btn primary" name="" id="delete" type="submit" value="">Xóa</button>
		<g:hiddenField name="idStatus" value="${status.id }"/>
		<g:hiddenField id="DeleteStatus" name="deleleStatus" value=""/>
		
   </li>
 </ol>
  		
  </g:if>
  <g:else>                      
  <ol class="form form-clear olCenter" id="incidentField">
  
   <li>
   	      <label for="StatusName" class="lableCenter ">Tên trạng thái  </label>
   	      <br>
   	       <input type="text" value=""  name ="StatusName" id="StatusName"   class="  text-input largeControlCenter">
   </li>
   
    <li>
   	     <label for="StatusCode" class="lableCenter ">Mã trạng thái </label>
   	      <br>
   	      <input type="text" value=""  name ="StatusCode" id="StatusCode"   class="  text-input largeControlCenter">
   </li>       
   
   <li>  
<%--    	<g:if test="${change=='1' }">--%>
    		<button class="btn primary" name="buttonNew" type="submit" value="SaveStatus">Tạo mới</button>
<%--		</g:if>--%>
<%--		<g:else>--%>
<%--			--%>
<%--		</g:else>--%>
   </li>
   
   <li>
 </ol>
 </g:else>
</fieldset>    
  </g:form>
	
</div>
 
	<script type="text/javascript">
	$("#admin-errorStatus").closest('li').addClass('active');
    set_side_bar(true);
	   $("#insertErrorStatus").validationEngine();
	   
	$("#delete").click(function(){
		 jquery_confirm("Xóa","Anh/chị đồng ý xóa ?",
				 function(){
		 	$("#DeleteStatus").val("Xoa");
		 		  // $("#actionButton").val("errorDelete");
            $("#insertErrorStatus").submit();
		 });
		 return false;
	});
	   
	
	</script>

  </body>
  
  
  
</html>


