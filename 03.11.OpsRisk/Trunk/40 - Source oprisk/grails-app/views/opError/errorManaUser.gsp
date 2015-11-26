<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý lỗi</title>
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
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách lỗi',label:'Danh sách lỗi']]
					]}"/>

			<div class="clear"></div>
		</div>
		
                    <div id="m-melanin-left-sidebar">
                     <g:render template="errorsidebar"/>
		</div>
		</div>
     <div id="m-melanin-main-content">
     <g:form name="reportForm" class="form" action="serchErrorUser">
        
      </g:form>	

	      <table  class="datatablesExport">
	        <thead>
	          <tr>
	            <th class ="center" width="180px" >STT</th>
	            <th class ="center" width="200px">Outlook</th>
	            <th class ="center" width="80px">Họ và tên</th>	            
	            <th class ="center" >Chức danh</th>
	            
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${userErrorCreate}" var="e" status="i">

	        <tr>
	         <td class ="">${i+1}  </td>
	          <td class ="">${e.userEmail}  </td>
	          <td class ="">${e.fullName}</td>
	          <td class ="">${e.title}</td>
	          
	        </tr>
	        </g:each>
	      </tbody>
	    </table>
	    	
					
				
			
      </div>

 
    <script type="text/javascript">
       $(document).ready(function(){
    	 
        set_active_tab('error-reportUserList');
        $("#error-reportUserList").closest('li').addClass('active');
        set_side_bar(true);
       });

       TableToolsInit.sTitle = "Quản lý danh sách người gây lỗi";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
       
   

        
    </script>
 
  </body>
</html>
