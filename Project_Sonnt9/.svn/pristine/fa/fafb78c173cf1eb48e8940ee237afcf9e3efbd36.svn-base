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
						[href:createLink(controller:'opError',action:'report'),title:'Báo cáo theo đơn vị',label:'Báo cáo theo đơn vị']]
					]}"/>
           </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                    
                  
					  	<g:render template="errorsidebar"/>
					
                    
		</div>
    <div id="m-melanin-main-content">
     <g:form name="reportForm" di="reportForm" class="form" action="reportErrorUserCreate">
     	
     	
     	<g:hiddenField   id="typeReport" name="typeReport" value="1"/>
     	
        <g:render template="errorSReport"/>
        <g:hiddenField id="actionbutton" name="exportExcel"/>
      </g:form>

    <table class="datatablesExport sortDatatablesExport">
	        <thead>
	          <tr>
	            <th class ="center">Mã</th>	            
	            <th class ="center" >Họ và tên</th>
	            <th class ="center" >Mức độ TB</th>
	            <th class ="center" >Số lượng lỗi</th>
	            <th class ="center" >Số lượng giao dịch</th>
	            <th class ="center" >KPI</th>

             </tr>
	        </thead>
	        <tbody>
		<% def numberCount = 0
		def mucDoTB = 0
		def soLuongLoi = 0
		def totalGd = 0								
					 %>
	     <g:each in="${result}" var="e" status="i">
			<%--<%numberCount = numberCount + 1 
			mucDoTB = mucDoTB + e.rs.MucDoTB
			soLuongLoi = soLuongLoi + e.rs.soluongLoi
			totalGd = totalGd + e.rs.TotalGD
							%>
	        --%><tr>
	         
	            <td class ="center">${i+1 } </td>
	           
	         <td class ="">${e.ErrorUserCreate[3]}</td>
	         <td class ="center">${e.ErrorUserCreate[4]?e.ErrorUserCreate[4].toDouble()/e.ErrorUserCreate[1]:0}</td>
	         <td class ="center">${e.ErrorUserCreate[1]}</td>	          
	         <td class ="center">${e.rs}</td>
	         <td></td>
               

	        </tr>
	        </g:each>
	        <g:if test = "${result.size()>0 }">
			<%--<tr>
			<td>Tổng</td>
			<td  class ="center">${numberCount }</td>
			
			<td   class ="center">${mucDoTB/numberCount }</td>
			<td  class ="center">${soLuongLoi }</td>
			<td  class ="center">${totalGd }</td>
			<td></td>
			
			</tr>--%>
			</g:if>
	      </tbody>
	    </table>
      		<button class="btn primary" id="exportExcel" name="exportExcel">Xuất ra excel</button> 
      		<br>
      		<br>
      <br>
      </div>
      
      

    <script type="text/javascript">
    $(document).ready(function(){
       $("#error-reportUnit").closest('li').addClass('active');
     		 set_side_bar(true);
        });
	$("#exportExcel").click(function(){
			$("#actionbutton").val("ExportExcel");
			$("#reportForm").submit();
			$("#actionbutton").val("");	
		});
    
        TableToolsInit.sTitle = "BaoCaoTheoDonVi";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    
  </body>
</html>
