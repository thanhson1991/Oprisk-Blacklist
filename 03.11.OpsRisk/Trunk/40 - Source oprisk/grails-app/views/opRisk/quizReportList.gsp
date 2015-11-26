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


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'reportList'),title:'Danh sách báo cáo kiểm tra RRHD',label:'Danh sách báo cáo kiểm tra RRHD']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                     <g:render template="quizsidebar"/>
		</div>
     <div id="m-melanin-main-content">
     <g:form name="reportForm" class="form" action="quizReportList">
         <g:render template="searchReport"/>
      </g:form>

	      <table class="datatablesExport">
	        <thead>
	          <tr>
	            <th class ="center" >Đơn vị</th>
	            <th class ="center" width="15%" >Ngày tạo</th>
	            <th class ="center" width="20%" >Người tạo</th>
                    <th class ="center" >User login</th>
                    <th class ="center" width="10%">Trạng thái</th>
                     <th class ="center" width="10%">Thời gian còn lại</th>
	            <th class ="center" width="10%">Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${process}" var="p" status="i">

	        <tr>
	          <td class ="">${p.branchName}</td>
	          <td class ="center"><g:formatDate format="dd-MM-yyyy HH:mm:ss" date="${p.dateCreated}"/></td>
                  <td class ="">${p.employee.fullname}</td>
                  <td class ="">${p.employee.username}</td>
                  <td class ="center"><g:message code="status${p.status}"/></td>
                   <td class ="">${p.timeLeft}</td>
                  <td class ="center"><a href="${createLink(controller:'opRisk',action:'createQuiz',params:[id:p.id])}" >Xem chi tiết</a></td>

	        </tr>
	        </g:each>
	      </tbody>
	    </table>

      </div>


    <script type="text/javascript">
       $(document).ready(function(){
      set_side_bar(true);
      $("#quiz-reportList").closest('li').addClass('active');
       set_active_tab('quiz-management');
        
       });
       TableToolsInit.sTitle = "Bao cao kiem tra RRHD";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
 
  </body>
</html>
