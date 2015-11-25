<%@page  import ="RiskService" %>
<%
    def RiskService = grailsApplication.classLoader.loadClass('RiskService').newInstance()
	def i = 0
%>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Tự đánh giá rủi ro</title>
<style type="text/css" media="screen">
	ul#controlEffect-dropdown ul{
		left: -300px;
	}
	ul#possibility-dropdown ul{
		left: -100px;
	}
</style>
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
      <form method ="POST" controller="selfEvaluation"  action ="saveEvaluateForm" name="selfEvaluateForm" id="selfEvaluateForm">
      <table width="100%">
        <thead>
          <tr>
            <th >STT</th>
            <th width="380">Rủi ro</th>
            <th class="step1">Ảnh hưởng</th>
            <th class="step1">Khả năng xảy ra</th>
            <th class="step1">Hiệu quả kiểm soát</th>
          </tr>

        </thead>
        <tbody>

        <g:while test="${(count<5)?i<5:i<count}">
          <g:hiddenField name="chosenRiskId" id="chosen-risk-${i}" value="${chosenRisks.id[i]}"/>
          <tr>
            <td width="">${i+1}</td>
            <td>
				<div class="clearfix">
	              <select id="riskSelect" name="risk" class="riskSelect span5" rel="${i}">
					<option value="">--- Vui lòng chọn ---</option>
	                <g:each in="${risklv1}" var="r">
	                  <optgroup label="${r.name}">
	                    <g:each in="${RiskService.getRisklv3(r,process.id.toInteger())}" var="t">
	                    <option con="${t.control}" value="${t.id}" ${(chosenRisks.risk.id[i]==t.id)?'selected="selected"':''}>${t.name}</option>
	                    </g:each>
	                  </optgroup>
	                </g:each>
	              </select>
            	<span class="add_risk_icon ss_sprite ss_add">&nbsp;</span>
				</div>
				<div id="riskControl-section-${i}" class="hide form-stacked" style="padding-left: 0px;">
					<div class="clearfix">
						<label>Các kiểm soát hiện tại:</label>
				   		<g:textArea class="span6" readonly="true" rows="4" cols="50" name="riskControl-${i}" value="${chosenRisks.risk.control[i]}"/>
					</div>
					<div>
						<label>Các kiểm soát khác tại đơn vị:</label>
						<g:textArea class="span6" rows="4" cols="50" name="control" value="${chosenRisks.control[i]}" id="control-${i}" />
					</div>
				</div>

            </td>
            <td class="step1">
              <g:hiddenField name="impact" id="impact-hidden-${i}" value="${chosenRisks.impact.id[i]}"/>
              <span id="impact-label-${i}">${chosenRisks.impact.description[i]}</span>
              <ul class="sexy-dropdown" id="impact-dropdown">
                <li>
                  <span class="fake-link">Đánh giá ảnh hưởng...</span>
                  <ul>
                    <li class="arrow">arrow</li>
                    <g:each in="${impacts}" var="impact">
                      <li ${chosenRisks.impact.id[i]==impact.id?'class="selected"':''} rel="${impact.id}" title="${i}">${impact.description}</li>
                    </g:each>
                  </ul
                </li>
              </ul>
            </td>
            <td class="step1">
              <g:hiddenField name="possibility" id="possibility-hidden-${i}" value="${chosenRisks.possibility.id[i]}"/>
              <span id="possibility-label-${i}">${chosenRisks.possibility.description[i]}</span>
              <ul class="sexy-dropdown" id="possibility-dropdown">
                <li>
                  <span class="fake-link">Đánh giá khả năng xảy ra...</span>
                  <ul>
                    <li class="arrow">arrow</li>
                    <g:each in="${possibilities}" var="possibility">
                      <li ${chosenRisks.possibility.id[i]==possibility.id?'class="selected"':''} rel="${possibility.id}" title="${i}">${possibility.description}</li>
                    </g:each>
                  </ul
                </li>
              </ul>
            </td>
             <td class="step1">
              <g:hiddenField name="controlEffect" id="controlEffect-hidden-${i}" value="${chosenRisks.controlEffect.id[i]}"/>
              <span id="controlEffect-label-${i}">${chosenRisks.controlEffect.description[i]}</span>
              <ul class="sexy-dropdown" id="controlEffect-dropdown">
                <li>
                  <span class="fake-link">Đánh giá hiệu quả kiểm soát...</span>
                  <ul>
                    <li class="arrow">arrow</li>
                    <g:each in="${controlEffects}" var="controlEffect">
                      <li ${chosenRisks.controlEffect.id[i]==controlEffect.id?'class="selected"':''} rel="${controlEffect.id}" title="${i}">${controlEffect.description}</li>
                    </g:each>
                  </ul
                </li>
              </ul>


             </td>

          </tr>
          <%i++%>
        </g:while>
        </tbody>

      </table>
	<div class="clearfix"></div>
    	<button class="btn" type="submit" name="addRisk">Thêm rủi ro</button>

      <button class="btn primary" type="submit" name="save">Nhập biện pháp giảm rủi ro &raquo;</button>
      <g:hiddenField name="processId" id="processId" value="${process.id}"/>
      <g:hiddenField name="add" id="add"/>
      <g:hiddenField name="save" id="save"/>
      </form>
    </div>
    
    <div id="add-risk-dialog" title="Thêm định nghĩa rủi ro" class="hide">
		<div class="form-stacked">
			<div class="clearfix">
	      		<label>Rủi ro cấp 1:</label>
				<g:select from="${risklv1}" name="newRiskLevel1" optionKey="id" optionValue="name"/>
			</div>
			<div class="clearfix">
		      	<label>Định nghĩa rủi ro:</label>
				<g:textField name="newRisk" style="width: 400px;"/>
			</div>
		</div>
    </div>
    <script type="text/javascript">
      $(function(){
        $("button[name=addRisk]").click(function(){
          $("input#add").val('true');
        });
        $("button[name=save]").click(function(){
          $("input#save").val('true');
        });
       
     
       
      $(".riskSelect").change(function(){
		var $select = $(this);
		if($select.val() !=''){
	        $.get('${createLink(controller:'selfEvaluation',action:'getControl')}/' + $(this).val(),function(data){
	          	$("#riskControl-"+$select.attr('rel')).val(data);
				$("#riskControl-section-"+$select.attr('rel')).slideDown();
	        });
		}
      });
      $(".riskSelect").trigger('change');

      $("#add-risk-dialog").dialog({width: '470px', autoOpen:false,modal:true,
			 buttons: { "Ok": function() { $(this).dialog("close")}},
			});
      $(".impact_help").tooltip({
	   offset: [20, 40],
	   effect: 'slide',
           position: 'bottom center',
           tip: "#impact-tip"
	});

      $(".add_risk_icon").click(function(){
        $("#add-risk-dialog").dialog('open');
          
      });

	$('ul.sexy-dropdown li ul').hide();
	$('ul.sexy-dropdown li').click(
		function(){
			$('.sexy-dropdown li').not($('ul', this)).stop();
                        $('ul.sexy-dropdown ul').not($('ul', this)).slideUp();
                	$('ul', this).slideDown();
                        
		}
               
	);
        $('ul#impact-dropdown li li').click(function(event){
            $(this).closest('ul').slideUp();            
            var impactId = $(this).attr('rel');
            var orderId = $(this).attr('title');
            $('span#impact-label-'+orderId).html($(this).html());
            $('input#impact-hidden-'+orderId).val(impactId);
            
            $('ul#impact-dropdown li li').removeClass('selected');
            $(this).addClass('selected');
            event.stopPropagation();
        });
         $('ul#possibility-dropdown li li').click(function(event){
            $(this).closest('ul').slideUp();            
            var possibilityId = $(this).attr('rel');
            var orderId = $(this).attr('title');
            $('span#possibility-label-'+orderId).html($(this).html());
            $('input#possibility-hidden-'+orderId).val(possibilityId);
            $('ul#possibility-dropdown li li').removeClass('selected');
            $(this).addClass('selected');
            event.stopPropagation();
        });
        $('ul#controlEffect-dropdown li li').click(function(event){
            $(this).closest('ul').slideUp();           
            var controlEffectId = $(this).attr('rel');
            var orderId = $(this).attr('title');
            $('span#controlEffect-label-'+orderId).html($(this).html());
            $('input#controlEffect-hidden-'+orderId).val(controlEffectId);
            $('ul#controlEffect-dropdown li li').removeClass('selected');
            $(this).addClass('selected');
            event.stopPropagation();
        });        
		set_active_tab('self-management');
    });
    </script>

  </body>
</html>