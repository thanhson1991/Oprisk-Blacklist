<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Danh sách báo cáo</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Danh sách báo cáo rủi ro',label:'Danh sách báo cáo rủi ro']]
					]}"/>

			<div class="clear"></div>
		</div>

        <div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="baroReport" href="${createLink(controller:'opRisk',action:'getReport')}" class="m-melanin-vertical-navigation-link">Báo cáo rủi ro</a>
              </li>
                <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="selfReport" href="${createLink(controller:'opRisk',action:'getSelfReport')}" class="m-melanin-vertical-navigation-link">Báo cáo tự đánh giá</a>
              </li>
      </ul>
        </div>
          
          <div id="m-melanin-main-content">
            <h3>Danh sách báo cáo rủi ro</h3>
	      <table class="datatables">
	        <thead>
	          <tr>
	            <th class ="center" >Đơn vị</th>
	            <th class ="center" >Ngày tạo</th>
	            <th class ="center" >Người tạo</th>
                    <th class ="center" >Trạng thái</th>
	            <th class ="center" >Thao tác</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${process}" var="p" status="i">

	        <tr>
	          <td class ="center">${p.employee.prop2}</td>
	          <td class ="center"><g:formatDate format="dd-MM-yyyy" date="${p.dateCreated}"/></td>
                  <td class ="center">${p.employee.fullname}</td>
                  <td class ="center"><g:message code="status${p.status}"/></td>
                  <td class ="center"><a href="${createLink(controller:'opRisk',action:'create',params:[id:p.id])}" >Xem chi tiết</a></td>

	        </tr>
	        </g:each>
	      </tbody>
	    </table>
      </div>


    <script type="text/javascript">
      $(document).ready(function(){
        set_active_tab('created-reports');
        $("#baroReport").closest('li').addClass('active');
        set_side_bar(true);

      });


    </script>
    
  </body>
</html>
