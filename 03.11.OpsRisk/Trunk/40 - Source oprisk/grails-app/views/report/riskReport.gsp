<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo đánh giá rủi ro tại các đơn vị</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'report',action:'riskReport'),title:'Báo cáo đánh giá rủi ro tại các đơn vị',label:'Báo cáo đánh giá rủi ro tại các đơn vị']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="../admin/mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="riskReport">
          <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
                    <th width="5%" class ="center">Mã</th>
	            <th width="50%" class ="center">Tên Đơn vị</th>
	           
	            <th width="10%" class ="center" >A</th>
	            <th width="10%" class ="center" >B</th>
                    <th width="10%" class ="center" >C</th>
                    <th width="10%" class ="center" >D</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${result}" var="r" status="i">
	        <tr>
                  <td class="center">${r.user.id}</td>
	          <td >${r.user.prop2}</td>
                  <td class ="center">${r.scores.A?r.scores.A:0}</td>
                  <td class ="center">${r.scores.B?r.scores.B:0}</td>
                  <td class ="center">${r.scores.C?r.scores.C:0}</td>
                  <td class ="center">${r.scores.D?r.scores.D:0}</td>
              
                  
	        </tr>
                </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
        set_side_bar(true);
	   $("#report-department").closest('li').addClass('active');              
      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
