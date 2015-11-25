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
						[href:createLink(controller:'opError',action:'report'),title:'Báo cáo loại lỗi',label:'Báo cáo loại lỗi']]
					]}"/>
           </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="errorsidebar"/>
		</div>
    <div id="m-melanin-main-content">
     <g:form name="reportForm" class="form" action="reportErrorLevel">
     	
        <g:render template="errorSReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
	            <th class ="center" >Mã</th>
	            <th class ="center" >Loại lỗi cấp 1</th>
	            <th class ="center" >Loại lỗi cấp 2</th>
	            <th class ="center" >Loại lỗi cấp 3</th>
	            <th class ="center" >Số lượng lỗi</th>
	            

             </tr>
	        </thead>
	        <tbody>
	<%def errorCount = 0 %>
	     <g:each in="${errorManagement}" var="e" status="i">
	     	<%errorCount = errorCount+1 %>
			<%--<g:if test="${ErrorList.get(e[0])}">
			<%errorCount = errorCount+1 %>
	        <tr>
	         <td class="center" style="width:100px">${errorCount } </td>
	          <td class ="">${ErrorList.get(e[0])?.name}</td>
	          <td class ="">${ErrorList.get(e[1])?ErrorList.get(e[1]).name:''}</td>

	          <td class ="center">${e[2]}</td>
	        </tr>
	        </g:if>
	        
	        
	        --%>
	        <tr>
	         <td class="center" style="width:100px">${errorCount} </td>
	          <td class ="">${ErrorList.get(e[0])?.name}</td>
	          <td class ="">${ErrorList.get(e[1])?ErrorList.get(e[1]).name:''}</td>
	          <td class ="">${ErrorList.get(e[2])?ErrorList.get(e[2]).name:''}</td>
	          <td class ="center">${e[3]}</td>
	        </tr>
	        
	        </g:each>

	      </tbody>
	    </table>
      <br>
      </div>
      
      

    <script type="text/javascript">
    $(document).ready(function(){
       $("#error-reportLevel").closest('li').addClass('active');
      set_side_bar(true);
        });
        TableToolsInit.sTitle = "BaoCaoLoaiLoi";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    
  </body>
</html>
