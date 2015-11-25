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
                model="${[items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
                        [href:createLink(controller:'admin',action:'viewDepartment'),title:'Quản lý rủi ro tại chi nhánh',label:'Quản lý rủi ro tại chi nhánh']]
                        ]}"/>

      <div class="clear"></div>
    </div>
    <div id="m-melanin-main-content">
	<g:form action="addRiskAction">
	    <table  class="datatablesExport">
	      <thead>
	        <tr>
	          <th>Rủi ro</th>
	          <th>Mức rủi ro</th>
	          <th>Đề xuất các biện pháp giảm rủi ro</th>
	          <th>Người chịu trách nhiệm</th>
	          <th>Tình trạng</th>
	          <th>Thời hạn</th>
	      </tr>
	      </thead>
	      <tbody>
	      <g:each in="${risks}" var ="i" status="k">
	        <tr>
	         <td class="risk${i.id}" >${i.risk.name} </td>
	        <td class="score${i.id}" > ${i.score} </td>
	        <td class="description${i.id}"><g:textArea name="description" value="${i.action?.description}"/></td>
	        <td class="executor${i.id}">
					<g:textField name="executor" value="${i.action?.executor}"/></td>
	        <td class="status${i.id}"><g:select style="width: 120px" name="status" from="${['Đang thực hiện','Bị chậm','Hoàn thành']}" value="${i.action?.status}"/></td>
	        <td class="deadline${i.id}">
				<g:textField class="m-melanin-datepicker" name="deadline" value="${g.formatDate(format:'dd/MM/yyyy',date:i.action.deadline)}"/></td>
	        </tr>
	      </g:each>
	      </tbody>
	    </table>
		<div class="clearfix"></div>
		<a class="btn" href="${createLink(action:'viewEvaluationProcess')}">&laquo; Quay lại</a>
	    <input type="button" class="btn primary" value="Lưu và gửi đi &raquo;" name="send"/>
	</g:form>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){
         $("input.datetime").datepicker({
            dateFormat: 'dd/mm/yy',
            changeMonth: true,
            changeYear: true
        });
        $("input.datetime").attr("readOnly", true);
        $("#actionForm").hide();
          $(".set-edit").click(function(){
            var actionId = $(this).attr('tid');
            $("#risk").html($(".risk"+actionId).html());
            $("#score").html($(".score"+actionId).html());
            //CKEDITOR.instances['description'].setData($(".description"+actionId).html());
            $("#executor").val($(".executor"+actionId).html());
            $("#status").val($(".status"+actionId).html());
            $("#deadline").val($(".deadline"+actionId).html());
            $("#actionId").val(actionId);
            $("#actionForm").show();
          });

          JQUERY4U.UTIL.smoothAnchor('anchorLink');

		set_active_tab('self-management');
      })
    </script>
  </body>
</html>
