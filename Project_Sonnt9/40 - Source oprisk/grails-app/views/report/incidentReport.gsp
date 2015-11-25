<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo thống kê sự kiện tổn thất theo đơn vị</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Báo cáo thống kê sự kiện tổn thất theo đơn vị',label:'Báo cáo thống kê sự kiện tổn thất theo đơn vị']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="risksidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="incidentReport">
       <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
      <%def totalCount =0
        def totalLoss = 0
        def totalRetrieval = 0
      %>
	        <thead>
	          <tr>
                    <th width="30%" class ="center">Tên đơn vị</th>
                    <th width="20%" class ="center">Tên giám đốc</th>
                    <th width="20%" class ="center">Username</th>
	            <th width="10%" class ="center">Số vụ việc</th>
	            <th width="10%" class ="center" >Tổn thất (VND)</th>
	            <th width="10%" class ="center" >Thu hồi (VND)</th>
                    
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${result}" var="r" status="i">
	        <tr>                  
	          <td >${r.user.prop2}</td>
                  <td >${r.user.fullname}</td>
                  <td >${r.user.username}</td>
                  <td class ="center">${r.count}</td>
                  <td class ="price"><g:formatNumber number="${r.loss}" format="#,###" /></td>
                  <td class ="price"><g:formatNumber number="${r.retrieval}" format="#,###" /></td>
                 
	        </tr>
                <%totalCount = totalCount + r.count
                  totalLoss = totalLoss + r.loss
                  totalRetrieval = totalRetrieval + r.retrieval%>
                </g:each>
                <tr>
                  <td ><b>Tổng cộng</b></td>
                  <td></td>
                  <td></td>
                  <td class ="center">${totalCount}</td>
                  <td class ="price"><g:formatNumber number="${totalLoss}" format="#,###" /></td>
                  <td class ="price"><g:formatNumber number="${totalRetrieval}" format="#,###" /></td>
                </tr>

	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
        set_side_bar(true);
        
         $("#report-incidents").closest('li').addClass('active');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
