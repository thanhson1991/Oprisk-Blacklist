<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Báo cáo theo dõi tự đánh giá rủi ro hoạt động</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Báo cáo theo dõi tự đánh giá rủi ro hoạt động',label:'Báo cáo theo dõi tự đánh giá rủi ro hoạt động']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                     <g:render template="../admin/mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="instancesReport">
          <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
                   <th width="10%" class ="center">Mã kết quả</th>
                   <th width="10%" class ="center">Mã đánh giá</th>
	            <th width="20%" class ="center">Tên rủi ro</th>

	            <th width="10%" class ="center" >Ảnh hưởng</th>
	            <th width="10%" class ="center" >Tần suất</th>
                    <th width="10%" class ="center" >Hiệu quả kiểm soát</th>
                    <th width="10%" class ="center" >Tổng thể</th>
                    <th width="10%" class ="center" >Người tạo</th>
                     <th width="10%" class ="center" >Đơn vị</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${instances}" var="r" status="i">
	        <tr>
                  <td class="center">${r.selfEvaluationProcess.id}</td>
	          <td class ="center">${r.id}</td>
                  <td >${r.risk?.name}</td>
                  <td class ="center">${r.impact?.score}</td>
                  <td class ="center">${r.possibility?.score}</td>
                  <td class ="center">${r.controlEffect?.score}</td>
                   <td class ="center">${r.score}</td>
                  <td class ="center">${r.selfEvaluationProcess.createdBy.username}</td>                  
                  <td >${r.selfEvaluationProcess.department.name}</td>
                 

	        </tr>
                 </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
         $("#report-instances").closest('li').addClass('active');
          set_active_tab('self-evaluation-management');
        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
