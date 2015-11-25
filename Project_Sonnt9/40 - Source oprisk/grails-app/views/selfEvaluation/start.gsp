<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tự đánh giá rủi ro</title>
  </head>
  <body>
    <div id="m-melanin-tab-header">
      <g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
                model="${[items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'OpRisk',label:'OpRisk'],
                        [href:createLink(controller:'admin',action:'viewDepartment'),title:'Tự đánh giá rủi ro',label:'Tự đánh giá rủi ro']]
                        ]}"/>

      <div class="clear"></div>
    </div>
	<div id="m-melanin-main-content">
            <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
	<div id="help-info">
		<h3>Hướng dẫn tự đánh giá rủi ro</h3>
                <div class="progress-train">
					<div class="step active">
						Bước 1: Xác định rủi ro </div>
						<div class="step">
						Bước 2: Đánh giá rủi ro </div>
						<div class="step">
						Bước 3: Đề xuất biện pháp giảm rủi ro</div>
                </div>
		<p>- Anh/chị cần chọn <strong><u>ít nhất 01</u></strong> rủi ro tại trung tâm của bạn trong danh sách dưới đây.</p>
		<p>- Nếu không tìm thấy rủi ro ở danh sách dưới, anh/chị có thế nhấn vào nút "<b>Thêm rủi ro</b>" để thêm vào danh sách.</p>
		<p>&nbsp;</p>
              <g:form name="risksForm" action="createEvaluationProcess">
                <table>
                  <thead>
                    <tr>
                      <th>STT</th>
                      <th>Phân loại</th>
                      <th>Hiện tượng rủi ro hoạt động</th>
                    </tr>
                  </thead>
                   <tbody>
                    <g:each in="${risks}" var ="r" status="k">
                        <tr>
                          <td class="center">${k+1}</td>
                       <td style="${r.ord==2?'border-top:0px solid transparent !important;border-bottom:0px solid transparent !important':''}">${r.ord == 0 ? r.name :''}</td>
                       <td><g:if test="${r.ord==2}">
								<g:checkBox name="risk" id="risk-select-${r.id}" class="validate[minCheckbox[5]]" value="${r.id}" checked="${false}"/>
							</g:if>
						<label for="risk-select-${r.id}">${r.ord == 2 ? r.name :''}</label></td>
                      </tr>

                    </g:each>


                    </tbody>
                </table>
                <br>
                <input type="button" name="addRisk" id="addRisk" class="btn" value="Thêm rủi ro"/>
                <input type="submit" name="continue" id="continue" class="btn primary" value="Tiếp tục &raquo;"/>

              </g:form>
	</div>
	<div id="add-risk-dialog" title="Thêm định nghĩa rủi ro" class="hide">
      <g:form name="addRiskForm" id="addRiskForm" action="start" params="${['addRisk':'true']}">
        <div class="form-stacked">
			<div class="clearfix">
	      		<label>Rủi ro cấp 1:</label>
				<g:select from="${riskL1}" name="riskL1Id" optionKey="id" optionValue="name"/>
			</div>
			<div class="clearfix">
		      	<label><font color="red">*</font> Định nghĩa rủi ro:</label>
				<g:textField name="name" class="validate[required]" style="width: 400px;"/>
			</div>
		</div>
    	</g:form>
    </div>
    </div>
	<script type = "text/javascript" charset="utf-8">
	$(document).ready(function(){

                set_active_tab('self-management');
		$("#add-risk-dialog").dialog({width: '470px', autoOpen:false,modal:true,
			buttons: { 
				"Lưu": function()  {
                                        $("#addRiskForm").validationEngine();
					$("#addRiskForm").submit();
//					$(this).dialog('close');
//					jquery_open_load_spinner();
				},
				"Đóng": function() { 
					$(this).dialog("close")},
				}
			});
		$("#addRisk").click(function(){
			$("#add-risk-dialog").dialog('open');
			return false;
		});
		$("#continue").click(function(){
			var s = $("input[name=risk]").filter(":checked").length;
			if(s<1){
				jquery_alert('Thông báo','Anh/chị cần phải chọn ít nhất 01 rủi ro. Anh/chị chỉ đã chọn '+s+' rủi ro.');
				return false;
			}else{
				return true;
			}
		});
	});
	</script>
</body>
</html>