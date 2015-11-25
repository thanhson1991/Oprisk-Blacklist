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
						[href:createLink(controller:'hierarchy',action:'index'),title:'Tự đánh giá rủi ro',label:'Tự đánh giá rủi ro']]
					]}"/>

			<div class="clear"></div>
		</div>
     

    <div id="m-melanin-main-content">
      <h3>Hướng dẫn tự đánh giá rủi ro</h3>
                <div class="progress-train">
					<div class="step ">
						Bước 1: Xác định rủi ro </div>
						<div class="step">
						Bước 2: Đánh giá rủi ro </div>
						<div class="step active">
						Bước 3: Đề xuất biện pháp giảm rủi ro</div>
                </div>

       <form method ="POST" controller="selfEvaluation" action="finishProcess" id="finishForm" name="finishForm" >
          <g:hiddenField name="processId" value="${process.id}"/>
             <g:if test="${process.status==100}">
            <div class ="message">
              <g:message code="message21" />
            </div>
          </g:if>
      <table>
        <thead>
          <tr>
            <th>Rủi ro</th>
            <th>Mức rủi ro</th>
            <th>Đề xuất các biện pháp giảm rủi ro <font color="red">*</font></th>
            <th>Người chịu trách nhiệm <font color="red">*</font></th>
            <th>Thời hạn <font color="red">*</font></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${pastRisks}" var ="i" status="k">
           <g:hiddenField name="actionId" value="${i.riskAction.id}"/>
          <tr>
           <td class="" >${i.risk?.name} </td>
          <td class="center" > ${i.score} </td>
          <td><g:textArea class="risk-input validate[required]" id="description${k}" name="description" value="${i.riskAction?.description}"/></td>
          <td>
             <input class="risk-input validate[required]" id="executor${k}" name="executor" value="${i.riskAction?.executor}"/></td>
          <td>
             <input class="e-m datetime validate[required]" id="deadline${k}" name="deadline" value="${g.formatDate(format:'dd/MM/yyyy',date:i.riskAction?.deadline)}"/></td>
          </tr>
       
         
        </g:each>
        </tbody>
      </table>   
        <center>
          <g:if test="${process.status !=100}">
          <input type="submit" class="btn primary" id="finish" name="finish" value="Lưu và gửi báo cáo đến phòng QLRR &raquo;"/>
          </g:if>
                <input type="button" class="btn" onclick="javascript:document.location='${createLink(controller:"selfEvaluation", action:"viewEvaluationProcess",params:[id:process.id])}'"  value="Quay lại"/>
        </center>
        
      </form>
    </div>
    <script type="text/javascript">
      $(document).ready(function(){

        if(${process.status ==100}){         
          $(".risk-input").attr('readonly','readonly');
          $(".datetime").attr('disabled','disabled');
        };

        set_active_tab('self-management');
        $("#finishForm").validationEngine();
      
      })
    </script>
  </body>
</html>
