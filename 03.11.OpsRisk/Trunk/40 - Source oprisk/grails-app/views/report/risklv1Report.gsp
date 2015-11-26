<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo đánh giá rủi ro hoạt động theo rủi ro cấp 1</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'risklv1Report',action:'report'),title:'Báo cáo đánh giá rủi ro hoạt động theo rủi ro cấp 1',label:'Báo cáo đánh giá rủi ro hoạt động theo rủi ro cấp 1']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="../admin/mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="risklv1Report">
          <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
                    <th width="5%" class ="center">Mã</th>
	            <th width="45%" class ="center">Rủi ro level 1</th>

	            <th width="10%" class ="center" >A</th>
	            <th width="10%" class ="center" >B</th>
                    <th width="10%" class ="center" >C</th>
                    <th width="10%" class ="center" >D</th>
                    <th width="10%" class ="center" >A+B</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${result}" var="r" status="i">
	        <tr>
                  <td class="center">${r.risk.id}</td>
	          <td >${r.risk.name}</td>
                  <td id ="scoreA" class ="center">${r.scores.A}</td>
                  <td id ="scoreB" class ="center">${r.scores.B}</td>
                  <td class ="center">${r.scores.C}</td>
                  <td class ="center">${r.scores.D}</td>
                  <td id ="scoreAB" class ="center">${r.scores.A+ r.scores.B}</td>
                  

	        </tr>
                </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){

          $("#report-risklv1").closest('li').addClass('active');
        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
