<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />

    <title>Danh sách báo cáo tự đánh giá rủi ro từ chi nhánh</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Danh sách báo cáo gửi lên từ chi nhánh',label:'Danh sách báo cáo gửi lên từ chi nhánh']]
					]}"/>

			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="mntsidebar"/>
		</div>
    <div id="m-melanin-main-content">
       <g:form name="reportForm" class="form" action="evaluationManagement">
        <g:render template="searchReport"/>
      </g:form>

    <table class="datatablesExport">
	        <thead>
	          <tr>
                    <th class="center">Mã</th>
	            <th class="center">Đơn vị</th>

	            <th class ="center" >Ngày tạo</th>
	            <th class ="center" >Người tạo</th>
                    <th class ="center" >User login</th>
                    <th class ="center" >Trạng thái</th>
                    <th class ="center" >Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${process}" var="p" status="i">
	        <tr>
                  <td class="center">${p.id}</td>
	          <td >${p?.branchName}</td>
                  <td class="center"><g:formatDate format="dd-MM-yyyy HH:mm:ss" date="${p.dateCreated}"/></td>
                  <td >${p.createdBy.fullname}</td>
                  <td class ="center">${p.createdBy.username}</td>
                  <td class ="center"><g:message code="process${p.status}"/></td>
                  <td class ="center"><a href="${createLink(controller:'admin',action:'processDetail',params:[id:p.id])}" >Xem chi tiết</a></td>
                  
	        </tr>
                </g:each>

	      </tbody>
	    </table>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
       
         $("#admin-report").closest('li').addClass('active');
        set_side_bar(true);
				//add_tab('#','Cơ cấu tổ chức','hierarchy');
				//set_active_tab('hierarchy');

      })
        TableToolsInit.sTitle = "Bao cao quan ly rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
