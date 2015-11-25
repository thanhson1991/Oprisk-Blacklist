<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>

    <meta name="layout" content="m-melanin-layout" />
    <ckeditor:resources />
    <title>Biện pháp giảm rủi ro</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">


			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
						[href:createLink(controller:'hierarchy',action:'index'),title:'Danh sách biện pháp giảm rủi ro',label:'Danh sách biện pháp giảm rủi ro']]
					]}"/>

			<div class="clear"></div>
		</div>
  
        <div id="m-melanin-left-sidebar">
      <ul class="m-melanin-vertical-navigation">
              <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="actionManagement" href="${createLink(controller:'selfEvaluation',action:'actionManagement')}" class="m-melanin-vertical-navigation-link">Cập nhật biện pháp giảm rủi ro</a>
              </li>
                <li>
                      <span class="ss_sprite ss_application_view_list">&nbsp;</span>
                      <a id="listActions" href="${createLink(controller:'selfEvaluation',action:'listActions')}" class="m-melanin-vertical-navigation-link">Danh sách các biện pháp giảm rủi ro</a>
              </li>
      </ul>
        </div>




    <div id="m-melanin-main-content">
    
      <h3>Danh sách các hành động giảm rủi ro</h3><br>   
    <table  class="datatablesExport">
      <thead>
        <tr>
          <th>Rủi ro</th>
          <th>Mức rủi ro</th>
          <th>Đề xuất các biện pháp giảm rủi ro</th>
          <th>Người chịu trách nhiệm</th>
          <th>Thời hạn</th>
          <th>Tình trạng</th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${actions}" var ="i" status="k">       
        
        <tr>
         <td class="">${i.riskInstance.risk.name} </td>
        <td class="center"> ${i.riskInstance.score} </td>
        <td class="">${i.description}</td>
        <td class="">${i.executor}</td>
        <td class=""><g:formatDate format="dd/MM/yyyy" date="${i.deadline}"/></td>
         <td class=""><g:message code="action${i.status}"/></td>
        </tr>
      </g:each>
      </tbody>
    </table>
   
    </div>
    <script type="text/javascript">
      $(document).ready(function(){         
       
         $("#listActions").closest('li').addClass('active');
        set_side_bar(true);
        set_active_tab('action-management');
      });
      TableToolsInit.sTitle = "Danh sach bien phap giam rui ro";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
  </body>
</html>
