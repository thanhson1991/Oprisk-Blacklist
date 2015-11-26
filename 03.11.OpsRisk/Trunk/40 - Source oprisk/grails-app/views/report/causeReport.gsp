<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo đánh giá sự kiện tổn thất theo nguyên nhân</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Báo cáo đánh giá sự kiện tổn thất theo nguyên nhân',label:'Báo cáo đánh giá sự kiện tổn thất theo nguyên nhân']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="risksidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="causeReport">
             <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
      <%def totalCount =0
        def totalLoss = 0
        def totalRetrieval = 0
      %>
	        <thead>
	          <tr>
                    <th width="10%" class ="center">STT</th>
                    <th width="40%" class ="center">Loại nguyên nhân</th>
	            <th width="10%" class ="center">Số vụ việc</th>
	            <th width="20%" class ="center" >Tổn thất (VND)</th>
	            <th width="20%" class ="center" >Thu hồi (VND)</th>

	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${result}" var="r" status="i">
	        <tr>
	          <td class ="center">${i+1}</td>
                  <td >${r.cause.name}</td>
                  <td class ="center">${r.count}</td>
                  <td class ="price"><g:formatNumber number="${r.loss}" format="#,###" /></td>
                  <td class ="price"><g:formatNumber number="${r.retrieval}" format="#,###" /></td>

	        </tr>
                <%totalCount = totalCount + r.count
                  totalLoss = totalLoss + r.loss
                  totalRetrieval = totalRetrieval + r.retrieval%>
                </g:each>
                <tr>
                  <td><b>Tổng cộng</b></td>
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
         $("#report-causes").closest('li').addClass('active');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
