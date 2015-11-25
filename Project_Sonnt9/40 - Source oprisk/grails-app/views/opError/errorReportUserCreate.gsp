<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Báo cáo</title>
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
						[href:createLink(controller:'opError',action:'reportErrorUserCreate'),title:'Báo cáo người gây lỗi',label:'Báo cáo người gây lỗi']]
					]}"/>
           </div>
			<div class="clear"></div>
		</div>
                    
                    <div id="m-melanin-left-sidebar">
                    
                    <sec:ifAnyGranted roles="ROLE_GDTT">
			      		  <g:render template="errorsidebarLevel1"/>
					</sec:ifAnyGranted>
					<sec:ifAnyGranted roles="ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">
						  <g:render template="errorsidebarLevel2"/> 
					</sec:ifAnyGranted>
					<sec:ifNotGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,,ROLE_GDTT_LEVEL4">
					  <g:render template="errorsidebar"/>
					</sec:ifNotGranted>
                    
		</div>
    <div id="m-melanin-main-content">
     <g:form name="reportForm" id="reportForm" class="form" action="reportErrorUserCreate1">     	                          
<%--					<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4">--%>
<%--			      		  <g:render template="errorUserSReport"/>--%>
			      		  
<%--					</sec:ifAnyGranted>--%>
					
 
					  <g:render template="errorSReportUser1"/>
 
					
					<g:hiddenField name="CheckDate" id="checkExportExcel" value="data"/>
					
					<g:hiddenField id="actionbutton" name="exportExcel"/>
					
      </g:form>
<%--      <g:form name="reportFormEportExcel" id="reportForm" class="form" action="reportErrorUserCreate1">--%>
<%--	  		<g:hiddenField id="actionbutton" name="exportExcel"/>--%>
<%--	  </g:form>--%>
	<g:if test="${search}">
    <table class="datatablesExport sortDatatablesExport">
	        <thead>
	          <tr>
	            <th class ="center">Mã</th>
	            <th class ="center" >UserName</th>
	            <th class ="center" >Họ và Tên</th>
	            <th class ="center" >Chức danh</th>
	            <th class ="center" >NHCD/Khối lỗi</th>
	            <th class ="center" >Chi nhánh/Trung tâm lỗi</th>
	            <th class ="center" >PGD/Tổ/Nhóm lỗi</th>
	            <th class ="center" >ID nhân sự</th>
	            <th class ="center" >User BDS</th>	 
				<th class ="center" >Số Lượng Lỗi 0</th>
				<th class ="center" >Số lượng lỗi</th>	
				<th class ="center" >Tổng lỗi quy đổi</th>                   
	            <th class ="center" >Cấp độ lỗi TB</th>
	            
	            <th class ="center" >Số lượng giao dịch</th>
			</tr>
	        </thead>
	       
	        <tbody>	     
	        <g:each in ="${masterUserCreate}" var="e">
	        	<tr>	     		         
		         <td class ="center">${e.ErrorUser.id}</td>
		         <td class =" ">${e.ErrorUser.username}</td>
		         <td class =" ">${e.ErrorUser.fullname}</td>	
		         <td class =" ">${e.ErrorUser.title}</td>
		         <td class =" ">${UnitDepart.get(e?.ErrorUser.dvLoi1)?.code+'-'+UnitDepart.get(e?.ErrorUser.dvLoi1)?.name}</td> 	        
		         <td class =" ">${UnitDepart.get(e?.ErrorUser.dvLoi2)?.code+'-'+UnitDepart.get(e?.ErrorUser.dvLoi2)?.name}</td>
		         <td class =" ">${UnitDepart.get(e?.ErrorUser.dvLoi3)?.code+'-'+UnitDepart.get(e?.ErrorUser.dvLoi3)?.name}</td>	  
		         <td class ="center">${e.ErrorUser.idemployee}</td>
		         <td class ="center">${e.ErrorUser.userbds}</td>         
		         <td class ="center">${e.ErrorUser.slLoi0}</td>
		         <td class ="center">${e.ErrorUser.slLoi1?e.ErrorUser.slLoi1:'0'}</td>
		         <td class ="center">${e.ErrorUser.TLQD?e.ErrorUser.TLQD:'0.0'}</td>
		         <td class ="center">${e.ErrorUser.CDLTB?e.ErrorUser.CDLTB:'0.0'}</td>	          
		         <td class ="center">${e.rs }</td>
				</tr>
	        </g:each>
	        	    
	      </tbody>
	    </table>

      	<br>
      	<button class="btn primary" id="exportExcel" name="exportExcel">Xuất ra excel</button> 
      	<br><br>
      	</g:if>
      	<g:else>
      		<font color="red"><g:message code="errorMessage10"/></font>
      	</g:else>
      </div>
             
    <script type="text/javascript">
    $(document).ready(function(){
       $("#error-reportUserCreate").closest('li').addClass('active');
      	set_side_bar(true);
        });
    $("#exportExcel").click(function(){ 
<%--    	alert('${CheckDate}');--%>
        var check = '${CheckDate}';     
		$("#actionbutton").val("ExportExcel");
		if(!check){
			$("#checkExportExcel").val("");
		}
		$("#reportForm").submit();
		$("#actionbutton").val("");
		$("#checkExportExcel").val("data");
        });
        TableToolsInit.sTitle = "BaoCaoNguoiGayLoi";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    
  </body>
</html>
