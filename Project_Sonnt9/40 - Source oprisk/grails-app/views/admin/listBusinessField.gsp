<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Quản lý lĩnh vực kinh doanh</title>
  </head>
  <body>
     <div id="m-melanin-tab-header">
     	<div id="m-melanin-tab-header-inner">
	 		<div id="m-melanin-tab-actions">
             <button class="btn small primary m-melanin-toggle-side-bar" name="m-test-button-3" value="Toggle sidebar">Toggle sidebar</button>
            
       	
             
           </div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
			model="${[
						items:[[href:createLink(controller:'opError',action:'reportList'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Quản lý lĩnh vực kinh doanh',label:'Quản lý lĩnh vực kinh doanh']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar">
             <g:render template="/admin/sidebar"/>
            </div>
		</div>
     <div id="m-melanin-main-content">
      <g:form name="businessFieldForm" class="form" action="detailBusinessField" style="margin-bottom:-15px">  		 		 
		 <button  name="addComment" class="btn primary float-right">Nhập thông tin</button>
	   </g:form>			
		<br>
		<Br>
     <g:form name="reportForm" class="form" action="getErrorDisplay" style="">
     <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
      </g:if>
      
    <g:if test="${messageCode != null}">
    <div class ="message">
      <g:message code="errorMessage${messageCode}" />
    </div>
  	</g:if>
     </g:form>
  		
	      <table class="sortDataTBL">
	        <thead>
	          <tr>
<%--	          <th class="center">ID</th>	            --%>
	            <th class ="center" >Mã lĩnh vực kinh doanh</th>
	            <th class ="center">Tên lĩnh vực kinh doanh</th> 
<%--	            <th class ="center" >Trạng thái</th>--%>
	            <th class ="center" >Thao tác</th>	            
	        
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${allFields}" var="i" >

	      	<tr>	          	
<%--                <td >${e.id}</td>--%>
                <td >${i.code}</td>
                <td >${i.name}</td>
                
<%--                <td >${e.status}</td>              --%>
				<td class ="center"><a href="${createLink(controller:'admin',action:'detailBusinessField',params:[businessFieldId:i.id])}" >Xem chi tiết</a></td>				                                    
	        </tr>
	        </g:each>
	      </tbody>
	    </table>

			
					
				
      </div>

 
    <script type="text/javascript">
       $(document).ready(function(){
   	  
        set_active_tab('management');
       $("#admin-businessField").closest('li').addClass('active');
        set_side_bar(true);
       });

 
       
   

        
    </script>
 
  </body>
</html>
