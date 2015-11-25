<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Hồ sơ đính kèm</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
             
             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opError',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Nhập lỗi từ file excel',label:'Nhập lỗi từ file excel']]
					]}"/>

			<div class="clear"></div>
		</div>
		
                    <div id="m-melanin-left-sidebar">
                     <g:render template="errorsidebar"/>
		</div>
		</div>
     <div id="m-melanin-main-content">
     <g:form name="uploadErrorExcel" class="form" action="viewErrorImportExcel"  enctype="multipart/form-data">
       <g:if test="${flash.message}">
			<li>
				<div class="${flash.messageType}">${flash.message}</div>
			</li>
		</g:if>
		<br>
	
       	  <label for="file" class="uploadFIle_lable ">File nhập dữ liệu:</label>
   	      <input type="file" id="file" name="file"></input>
   	      
   	      
   	      	<g:submitButton name="addComment" class="searchButtons btn primary" value="upload" style="margin-left:10px">Upload</g:submitButton>
	</g:form>		
			
      </div>

 
    <script type="text/javascript">
       $(document).ready(function(){
    	   $('#dataTableUserCreate').dataTable( {
       	    
       	  } );
        set_active_tab('error-uploadExcel');
        $("#error-uploadExcel").closest('li').addClass('active');
        set_side_bar(true);
       });

    
       
   

        
    </script>
 
  </body>
</html>
