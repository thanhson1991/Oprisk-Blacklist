<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Sự kiện tổn thất</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">
      <div id="m-melanin-tab-header-inner">         

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opRisk',action:'incidentReport'),title:'Báo cáo tổn thất',label:'Báo cáo tổn thất']]
					]}"/>
          </div>
			<div class="clear"></div>
		</div>

    <div id="m-melanin-main-content">
      <g:if test="${messageCode != null && messageCode!=0 && messageCode!=3}">
        <div class ="message">
          <g:message code="message${messageCode}" />
        </div>
      </g:if>
      <fieldset class="info">
        <legend>Hướng dẫn</legend>        
        <p><i>- Anh/chị hãy nhớ lại tình hình hoạt động tại trung tâm trong 30 ngày vừa qua và tường thuật lại các sự cố hoạt động (có thể đã gây ra thất thoát hoặc chưa).</i></p>
        <p><i>Có sự cố RRHD nào xảy ra trong trung tâm của anh/chị trong tháng qua không?</i></p>
        <p><i>Hoặc anh/chị có thấy RRHD tiềm ẩn nào trong hoạt động của trung tâm trong tháng qua không?</i></p>

      </fieldset>
       
      <div style="margin-left:20px;width:97%">
    <table class="datatablesExport">
	        <thead>
	          <tr>
	          		<th class ="center" >Tên sự kiện</th>
                    <th class ="center">Ngày xảy ra sự vụ</th>
                    <th class ="center">Mô tả</th>
                    <th class ="center">Nguyên nhân</th>
                    <th class ="center">Giải pháp</th>
                    <th class ="center">Loại sự kiện tổn thất</th>
                    <th class ="center">Tổn thất tài chính (VND)</th>
                    <th class ="center">Đã thu hồi (VND)</th>
                    <th class ="center">Thiệt hại phi tài chính</th>
                    <th class ="center">Hồ sơ đính kèm</th>
	          </tr>
	        </thead>
	        <tbody>

                  <g:each in="${incidents}" var="i" status="k">
	        <tr>
				  <td  class="eventName${i?.id}">${i?.eventName}</td>
                  <td class="center dateIncident${i.id}"><g:formatDate format="dd/MM/yyyy" date="${i.dateIncident}"/></td>
                  <td class="description${i.id}">${i.description}</td>
                  <td class="cause${i.id}">${i.cause}</td>
                  <td class="solution${i.id}">${i.solution}</td>
                  <td tid="${i.incidentType}" class="incidentType${i.id}" >${i.incidentType?g.message(code:'incidentType'+i.incidentType):''}</td>
                  <td class="price financialLoss${i.id}"><g:formatNumber number="${i.financialLoss}" format="#,###" /></td>
                  <td class="price retrieval${i.id}"><g:formatNumber number="${i.retrieval}" format="#,###" /></td>
                  <td class="nonFinancialLoss${i.id}">${i.nonFinancialLoss}</td>
                  <td class="fileName${i.id}"><a  href="${resource(dir:'incidentFiles',file:i.fileName)}" >${i.fileName }</a></td>
	        </tr>
                 </g:each>

	      </tbody>
	    </table>
        </div>

<g:form method="post" name="saveIncidentForm" controller="opRisk" action="listIncident" enctype="multipart/form-data">
  
   <fieldset class="info">
     <legend>Thêm sự kiện rủi ro hoạt động</legend>
 
  <ol class="form form-clear" id="incidentField">

    <li>
      <label for="dateIncident" class="incident_label "><font color="red">*</font> Ngày xảy ra sự cố (dd/mm/yy):</label>
      <input type="text" name ="dateIncident"readonly="true" id="dateIncident" class="validate[required] text-input datetime incident-field-number">
    </li>
 	<li>
      <label class="label-left"><font color="red">*</font> Tên sự kiện:</label>
      <input type="text" style="margin-left:70px" class="e-xxxl validate[required]" name ="eventName" id="eventName" />
    </li>
    <li>
      <label for="description" class="incident_label"><font color="red">*</font> Mô tả (liên quan đến những ai, xảy ra như thế nào, gây tổn thất gì):</label>
    </li>
    <li>
      <g:textArea name="description"  cols="140" rows="3" class="incident-field validate[required]" id="description"/>
    </li>
    <li>
      <label class="label-left" for="cause"><font color="red">*</font> Nguyên nhân:</label>

    </li>
    <li><g:textArea name="cause"  rows="3" cols="140" class="incident-field validate[required]" id="cause"/></li>
    <li>
      <label for="solution"><font color="red">*</font> Giải pháp tức thời:</label>
    </li>
    <li><g:textArea name="solution"  rows="3" cols="140" class="validate[required] incident-field" id="solution"/></li>
    <li>
      <label class="label-left e-l" ><font color="red">*</font> Loại sự kiện tổn thất:</label>      
      <input id="incidentType1" class="validate[required]" type="radio" name="incidentType" value="1" /> <label for="incidentType1">Đã xảy ra tổn thất </label>
      <input id="incidentType2" class="validate[required]" type="radio" name="incidentType" value="2" /> <label class="e-l" for="incidentType2">Có thể xảy ra tổn thất </label>
      <input id="incidentType3" class="validate[required]" type="radio" name="incidentType" value="3" /> <label class="e-xxxl" for="incidentType3">Đã xảy ra tổn thất nhưng thu hồi được trong ngày</label>
    </li>

    <li>
      <label class="label-left e-l" for ="financialLoss"><font color="red">*</font> Tổn thất tài chính:</label>
      <input class="validate[required] incident-field-number price" name="financialLoss" id="financialLoss"/> (VND)
    </li>
     <li>
      <label class="label-left e-l" for ="retrieval"><font color="red">*</font> Đã thu hồi:</label>
      <input class="validate[required] incident-field-number price" name="retrieval" id="retrieval"/> (VND)
    </li>

    <li>
      <label class="incident_label" for ="nonFinancialLoss"><font color="red">*</font> Tổn thất phi tài chính:</label>
    </li>
    <li>
      <g:textArea name="nonFinancialLoss"  rows="3" cols="140" class="validate[required] incident-field" id="nonFinancialLoss"/>
    </li>
     <li>
      <label class="label-left e-l" for ="file">Hồ sơ đính kèm:</label>    
      <input type="file" class="incident-field-number " name="file" id="file"/> 
    </li>

    <input type="hidden" id="incidentID" name="incidentID"value=""/>
    <li>
      <button class="float-left" id ="submit_incident" name="saveincident" value="Lưu">Lưu sự kiện</button>
      <g:hiddenField name="saveincident"/>
    </li>
    

  </ol>
</fieldset>
    
  </g:form>
       </div>


    <script type="text/javascript">
    $(document).ready(function(){
     set_active_tab('incident');
      $("#saveIncidentForm").validationEngine();
       $("button[name=saveincident]").click(function(){

          jquery_confirm("Thêm sự kiện","Anh/chị đồng ý thêm sự kiện này?",
                      function(){
                            $("#saveIncidentForm input[name=saveincident]").val('Processing');
                            $("#saveIncidentForm").submit();
                });

          return false;
      });
        });
        TableToolsInit.sTitle = "Bao cao su co rui ro hoat dong";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>  


  </body>
</html>
