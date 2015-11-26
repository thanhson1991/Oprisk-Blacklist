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
						[href:createLink(controller:'hierarchy',action:'index'),title:'Biện pháp giảm rủi ro',label:'Biện pháp giảm rủi ro']]
					]}"/>

			<div class="clear"></div>
		</div>
  <g:if test="${management}">
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
  

  </g:if>

    <div id="m-melanin-main-content">
      <g:if test="${flash.message}">
					<div id="flash-message" class="message">${flash.message}</div>
				</g:if>
        <g:if test="${actions}">
      <h3>Cập nhật trạng thái hành động giảm rủi ro kỳ trước</h3><br>
    <form method="post" controller="admin" action="updateIncompleteAction" id="actionForm" name="actionForm" >
    
    <table  class="">
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
         <g:hiddenField name="actionId" value="${i.id}"/>
         <g:if test="${management}">
           <g:hiddenField name="management" value="1"/>
         </g:if>
        <tr>
         <td class="">${i.riskInstance.risk.name} </td>
        <td class="center"> ${i.riskInstance.score} </td>
        <td class="">${i.description}</td>
        <td class="">${i.executor}</td>       
        <td class=""><g:formatDate format="dd/MM/yyyy" date="${i.deadline}"/></td>       
         <td class="status${i.id}"><select  id="status" name="status">
            <option ${i.status==10?'selected="selected"':''} value="10">Đang thực hiện</option>
            <option ${i.status==20?'selected="selected"':''} value="20">Bị chậm</option>
            <option ${i.status==100?'selected="selected"':''} value="100">Hoàn thành</option>
          </select></td>
        </tr>
      </g:each>
      </tbody>
    </table>
      <center> <button class="btn primary" type="submit" name="saveBtn">Lưu</button>
        <g:if test="${!management}">
      <button class="btn primary" type="submit" name="proceedBtn">Tiếp tục</button></center>
      </g:if>
      <g:hiddenField name="proceed" id="proceed"/>
      <g:hiddenField name="save" id="save"/>     
    </form>
       </g:if>
      <g:else>
        <div class ="message">
                <g:message code="noAction" />
            </div>
      </g:else>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
        $("button[name=proceedBtn]").click(function(){
          $("input#proceed").val('true');
        });
        $("button[name=saveBtn]").click(function(){
          $("input#save").val('true');
        });
      })
      <g:if test="${management}">
        set_active_tab('action-management');
         $("#actionManagement").closest('li').addClass('active');
        set_side_bar(true);
    </g:if>
    <g:else>
      set_active_tab('self-management');
      
    </g:else>
    </script>
  </body>
</html>
