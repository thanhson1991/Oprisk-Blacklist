<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Tổng hợp đánh giá</title>
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
						[href:createLink(controller:'hierarchy',action:'index'),title:'Tổng hợp đánh giá',label:'Tổng hợp đánh giá']]
					]}"/>
                    </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
      <%def user%>
       <g:form name="reportForm" class="form" action="overallReport">
        <g:render template="searchReport"/>
      </g:form>
      
    <table class="datatablesExport">
        <thead>
	          <tr>
                    <th >Mã kết quả</th>
	            <th >Mã đánh giá</th>
                    <th >Đơn vị</th>
	            <th >Rủi ro level 1</th>
                    <th >Rủi ro level 2</th>
                    <th >Rủi ro level 3</th>
                    <th >Ảnh hưởng</th>
                    <th >Tần suất</th>
                    <th >Hiệu quả kiểm soát</th>
                    <th >Mô tả kiểm soát tại đơn vị</th>
                    <th >Mức độ rủi ro</th>
                    <th >Biện pháp giảm rủi ro</th>
                    <th >Người chịu trách nhiệm</th>
                    <th >Thời hạn</th>
                    <th >User nhập</th>
                    <th >Trạng thái</th>
                    <th >Ngày báo cáo</th>
	          </tr>
	        </thead>
	        <tbody>
                <g:each in="${instances}" var="p" status="i">
	        <tr>
                  <%user = p.selfEvaluationProcess.createdBy %>
                  <td class="center">${p.id}</td>
                  <td class="center">${p.selfEvaluationProcess.id}</td>
                  <td>${p.selfEvaluationProcess.branchName}</td>
	          <td >${p.risk?.parent?.parent?.name}</td>
                  <td >${p.risk?.parent?.name}</td>
                  <td >${p.risk?.name}</td>
                  <td class ="center">${p.impact?.score}</td>
                  <td class ="center">${p.possibility?.score}</td>
                  <td class ="center">${p.controlEffect?.score}</td>
                  <td class ="center">${p.control}</td>
                  <td class ="center">${p.score}</td>
                  <td >${p.riskAction?.description}</td>
                  <td >${p.riskAction?.executor}</td>
                  <td ><g:formatDate format="dd-MM-yyyy" date="${p.riskAction?.deadline}"/></td>
                  <td >${user.username}</td>
                  <td ><g:message code="action${p.riskAction?.status}"/></td>
                  <td ><g:formatDate format="dd-MM-yyyy" date="${p.dateCreated}"/></td>


	        </tr>
                 </g:each>
	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){        
        $("#admin-overall").closest('li').addClass('active');
        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
