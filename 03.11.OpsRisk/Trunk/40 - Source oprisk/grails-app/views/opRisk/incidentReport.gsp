<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="comboboxList" %>
<html>
  <head>
  <meta name="layout" content="m-melanin-layout" />
    <title>Báo cáo</title>
      <style type="text/css">
      .dataTables_scroll
      {
          overflow:auto;
      }
      </style>

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
						[href:createLink(controller:'opRisk',action:'incidentReport'),title:'Tổng hợp các sự cố rủi ro hoạt động',label:'Tổng hợp các sự cố rủi ro hoạt động']]
					]}"/>
          </div>
			<div class="clear"></div>
		</div>
                    <div id="m-melanin-left-sidebar">
                      <g:render template="../report/risksidebar"/>
		</div>
    <div id="m-melanin-main-content">
        <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
                        </g:if>
    <g:form name="incidentReportForm" id="incidentReportForm" class="form" action="incidentReport">
       <g:render template="searchReport"/>
      </g:form>
      <br>

    <table class="datatablesExport">
	        <thead>
	          <tr>
                    <th class ="center" >ID</th>
	          		<th class ="center" >Tên sự kiện</th>
                    <th class ="center" >Tên</th>
	            	<th class ="center">Đơn vị</th>
                    <th class ="center">Ngày xảy ra sự vụ</th>
                    <th class ="center" style="display: none">Ngày báo cáo</th>
                    <th class ="center" style="display: none">Lĩnh vực kinh doanh</th>
                    <th class ="center">Mô tả</th>
                    <th class ="center">Nguyên nhân</th>
                    <th class ="center">Giải pháp</th>
                    <th class ="center" style="display: none">Kế hoạch hành động</th>
                    <th class ="center">Loại nguyên nhân</th>
                    <th class ="center">Loại sự kiện</th>
                    <th class ="center">Loại sự kiện tổn thất</th>
                    <th class ="center">Thiệt hại tài chính (VND)</th>
                    <th class ="center">Đã thu hồi (VND)</th>
                    <th class ="center" style="display: none">Trạng thái của tổn thất</th>
                    <th class ="center">Thiệt hại phi tài chính</th>
                    <th class ="center" style="display: none">Thu hồi từ bảo hiểm</th>
                    <th class ="center" style="display: none">Loại tiền</th>
                    <th class ="center" style="display: none">Thu hồi từ nguồn khác</th>
                    <th class ="center" style="display: none">Loại tiền</th>
                    <th class ="center" style="display: none">Bút toán trên GL</th>
                    <th class ="center" style="display: none">Ngày hạch toán kế toán</th>
                    <th class ="center" style="display: none">Loại nguồn dữ liệu</th>
                    <th class ="center" style="display: none">Cờ đánh dấu</th>
                    <th class ="center" style="display: none">Ghi chú</th>
                    <th class ="center">Hồ sơ đính kèm</th>
	            <th class ="center">Sửa</th>
                    <th class ="center">Xóa</th>
	          </tr>
	        </thead>
	        <tbody>

                  <g:each in="${incidents}" var="i" status="k">
	        <tr>
                <td  class="eventID${i?.id}">${i?.id}</td>
	        	<td  class="eventName${i?.id}">${i?.eventName}</td>
                  <g:if test="${i.createdBy != null}">
                  	
                    <td  class="name${i.id}">${i.createdBy.fullname}</td>
                    <td  class="branch${i.id}">${i.createdBy.prop2}</td>
                  </g:if>
                  <g:elseif test="${i.opRiskProcess != null}">
                    <td  class="name${i.id}">${i.opRiskProcess.employee.fullname}</td>
                    <td  class="branch${i.id}">${i.opRiskProcess.employee.prop2}</td>
                  </g:elseif>
                  <g:else>
                    <td  class="name${i.id}">${i.name}</td>
                    <td  class="branch${i.id}">${i.branch}</td>
                  </g:else>
                  <td class="dateIncident${i.id}"><g:formatDate format="dd/MM/yyyy" date="${i.dateIncident}"/></td>
                  <td class="dateReport${i.id}" style="display: none"><g:formatDate format="dd/MM/yyyy" date="${i.dateReport}"/></td>
                <td class="basel2${i.id}" style="display: none">${i.basel2?.name}</td>
                  <td class="description${i.id}">${i.description}</td>
                  <td class="cause${i.id}">${i.cause}</td>
                  <td class="solution${i.id}">${i.solution}</td>
                <td class="actionPlan${i.id}" style="display: none">${i.actionPlan}</td>
                  <td tid="${i.reason?.id}" class="reason${i.id}" >${i.reason?.name}</td>
                  <td tid="${i.event?.id}" class="event${i.id}" >${i.event?.name}</td>
                  <td tid="${i.incidentType}" class="incidentType${i.id}" >${i.incidentType?g.message(code:'incidentType'+i.incidentType):''}</td>
                  <td class="price financialLoss${i.id}"><g:formatNumber number="${i.financialLoss}" format="#,###" /></td>
                  <td class="price retrieval${i.id}"><g:formatNumber number="${i.retrieval}" format="#,###" /></td>
                <td class="incidentStatus${i.id}" style="display: none">${i.incidentStatus}</td>
                <td class="nonFinancialLoss${i.id}">${i.nonFinancialLoss}</td>
                <td class="price fromInsurance${i.id}" style="display: none"><g:formatNumber number="${i.fromInsurance}" format="#,###" /></td>
                <td class="moneyTypeI${i.id}" style="display: none">${i.moneyTypeI}</td>
                <td class="price fromAnother${i.id}" style="display: none"><g:formatNumber number="${i.fromAnother}" format="#,###" /></td>
                <td class="moneyTypeA${i.id}" style="display: none">${i.moneyTypeA}</td>
                <td class="gl_cal${i.id}" style="display: none">${i.gl_cal}</td>
                <td class="dateFnCal${i.id}" style="display: none"><g:formatDate format="dd/MM/yyyy" date="${i.dateFnCal}"/></td>
                <td class="sourceType${i.id}" style="display: none">${i.sourceType}</td>
                <td class="stickFlg${i.id}" style="display: none">${i.stickFlg}</td>
                <td class="noteRR${i.id}" style="display: none">${i.noteRR}</td>
                  <td class="fileName${i.id}"><a  href="${resource(dir:'incidentFiles',file:i.fileName)}" >${i.fileName }</a></td>
                  <td class="center"><a class="anchorLink" tid="${i.id}" href="#saveIncidentForm"><span  id ="${i.id}" class="ss_sprite ss_page_edit  set-edit" title="Sửa"></span></a></td>
                  <td class="center"><span tid="${i.id}" class="ss_sprite ss_cancel set-delete delete_incident" title="Xóa"></span>
	        </tr>
                 </g:each>

	      </tbody>
	    </table>
      <br>
      <br>
      <br>
      <g:form name="saveIncidentForm" controller="opRisk" action="incidentReport" enctype="multipart/form-data">
      <button type="button" class="float-left" id ="createIncident" name="createIncident" value="Thêm">Thêm sự kiện</button>
   <div class="" id="panel">
<fieldset >
   
  <ol class="form form-clear" id="">

    <li>
      <label for="dateIncident" class="label-left"><font color="red">*</font> Ngày xảy ra</label>
      <input type="text" name ="dateIncident"readonly="true" id="dateIncident" class="validate[required] text-input datetime e-m">
    </li>
    <li>
          <label for="dateIncident" class="label-left"><font color="red">*</font> Ngày báo cáo</label>
          <input type="text" name ="dateReport"readonly="true" id="dateReport" class="validate[required] text-input datetime e-m">
    </li>
 	<li>
      <label class="label-left"><font color="red">*</font> Tên sự kiện</label>
      <input type="text" class="e-xxxl validate[required]" name ="eventName" id="eventName" />
    </li>
      <li>
          <label class="label-left"><font color="red"></font> Lĩnh vực kinh doanh</label>
          <g:select name ="basel2" id="basel2" from="${BusinessField.executeQuery('from BusinessField e where e.status=0')}"
                    optionKey="id" optionValue="name" noSelection="${['':'']}" style="width: 310px;"/>
          %{--<input type="text" class="e-xxxl" name ="basel2" id="basel2" />--}%
      </li>
     <li>
      <label class="label-left"><font color="red">*</font> Họ và tên</label>
      <input type="text" class="e-xxxl validate[required]" name ="name" id="name" name ="name"/>
    </li>
    
    <li>
      <label class="label-left"><font color="red">*</font> Tên đơn vị</label>
      <input type="text" class="e-xxxl validate[required]" name ="branch" id="branch" name ="branch"/>
    </li>

    <li>
      <label for="description" class="incident_label"><font color="red">*</font> Mô tả (liên quan đến những ai, xảy ra như thế nào,gây tổn thất gì)</label>
    </li>
    <li>
      <g:textArea name="description"  cols="140" rows="3" class="small-incident-field validate[required]" id="description"/>
    </li>
    <li>
      <label class="incident_label" for="cause"><font color="red">*</font> Nguyên nhân chính</label>

    </li>
    <li><g:textArea name="cause" rows="3" cols="140" class="small-incident-field validate[required]" id="cause"/></li>
    <li>
      <label class="incident_label" for="solution"><font color="red">*</font> Giải pháp tức thời</label>
    </li>
    <li><g:textArea name="solution"  rows="3" cols="140" class="small-incident-field validate[required]" id="solution"/></li>
      <li><label class="label-left e-l"><font color="red"> </font> Kế hoạch hành động</label></li>
      <li>
          <g:textArea name="actionPlan"  rows="3" cols="140" class="small-incident-field" id="actionPlan"/>
      </li>
    <li>
      <label class="label-left e-l" for="reason"><font color="red">*</font> Loại nguyên nhân</label>
        <select id="reason" name="reason" class="e-xxxl validate[required]">
		<option value="">--- Vui lòng chọn ---</option>
	                <g:each in="${causes}" var="r">
	                  <optgroup label="${r.name}">
	                    <g:each in="${r.children}" var="t">
	                    <option value="${t.id}">${t.name}</option>
	                    </g:each>
	                  </optgroup>
	                </g:each>
	</select>

    </li>
    <li>
      <label class="label-left e-l" for="event"><font color="red">*</font> Loại sự kiện</label>
      <select id="event" name="event" class="e-xxxl validate[required]">
		<option value="">--- Vui lòng chọn ---</option>
	                <g:each in="${events}" var="r">
	                  <optgroup label="${r.name}">
	                    <g:each in="${r.children}" var="t">
	                    <option value="${t.id}">${t.name}</option>
	                    </g:each>
	                  </optgroup>
	                </g:each>
	</select>
    </li>
    <li>
      <label class="label-left e-l" ><font color="red">*</font> Loại sự kiện tổn thất</label>      
      <input id="incidentType1" class="validate[required]" type="radio" name="incidentType" value="1" /> <label for="incidentType1">Đã xảy ra tổn thất </label>
      <input id="incidentType2" class="validate[required]" type="radio" name="incidentType" value="2" /> <label class="e-l" for="incidentType2">Có thể xảy ra tổn thất </label>
      <input id="incidentType3" class="validate[required]" type="radio" name="incidentType" value="3" /> <label class="e-xxxl" for="incidentType3">Đã xảy ra tổn thất nhưng thu hồi được trong ngày</label>
    </li>

    <li>
      <label class="label-left e-l" for ="financialLoss"><font color="red">*</font> Tổn thất tài chính</label>
      <input class="validate[required] incident-field-number price" name="financialLoss" id="financialLoss"/> (VND)
    </li>
     <li>
      <label class="label-left e-l" for ="retrieval"><font color="red">*</font> Đã thu hồi</label>
      <input class="validate[required] incident-field-number price" name="retrieval" id="retrieval"/> (VND)
    </li>
      <li>
          <label class="label-left e-l"><font color="red"></font> Thu hồi từ bảo hiểm</label>
          <input type="text" class="incident-field-number price" name ="fromInsurance" id="fromInsurance"/> (VND)
      </li>
%{--      <li>
          <label class="label-left e-l" for="event"><font color="red"></font> Loại tiền</label>
          <g:select id="moneyTypeI" name="moneyTypeI" class="e-xxxl" from="${comboboxList.listMoneyType()}" optionKey="value"/>
      </li>--}%
      <li>
          <label class="label-left e-l"><font color="red"></font> Thu hồi từ nguồn khác</label>
          <input type="text" class="incident-field-number price" name ="fromAnother" id="fromAnother"/> (VND)
      </li>
%{--      <li>
          <label class="label-left e-l" for="event"><font color="red"></font> Loại tiền</label>
          <g:select id="moneyTypeA" name="moneyTypeA" class="e-xxxl" from="${comboboxList.listMoneyType()}" optionKey="value"/>
      </li>--}%
      <li>
          <label class="label-left e-l"><font color="red"></font> Bút toán trên GL</label>
          <input type="text" name ="gl_cal" id="gl_cal" style="width: 210px;"/>
      </li>
      <li>
          <label for="dateFnCal" class="label-left e-l"><font color="red"></font> Ngày hạch toán kế toán </label>
          <input type="text" name ="dateFnCal" readonly="true" id="dateFnCal" class="text-input datetime e-m">
      </li>
      <li>
          <label class="label-left e-l" for="event"><font color="red"></font> Trạng thái của tổn thất</label>
          <g:select id="incidentStatus" name="incidentStatus" class="e-xxxl" from="${comboboxList.listIncidentStatus()}" optionKey="value"/>
      </li>
    <li>
      <label class="incident_label" for ="nonFinancialLoss"><font color="red">*</font> Tổn thất phi tài chính</label>
    </li>
    <li>
      <g:textArea name="nonFinancialLoss"  rows="3" cols="140" class="validate[required] small-incident-field" id="nonFinancialLoss"/>
    </li>

      <li>
          <label class="label-left e-l" for="event"><font color="red">*</font> Loại nguồn dữ liệu</label>
          <g:select id="sourceType" name="sourceType" class="e-xxxl" from="${comboboxList.listSourceType()}" optionKey="value"/>
      </li>
      <li>
          <label class="label-left e-l" ><font color="red">*</font> Cờ đánh dấu</label>
          <input id="stickFlg1" class="validate[required]" type="radio" name="stickFlg" value="${comboboxList.RRHD.value}" /> <label for="stickFlg1">${comboboxList.RRHD.value}</label>
          <input id="stickFlg2" class="validate[required]" type="radio" name="stickFlg" value="${comboboxList.RRTD.value}" /> <label class="e-l" for="stickFlg2">${comboboxList.RRTD.value}</label>
          <input id="stickFlg3" class="validate[required]" type="radio" name="stickFlg" value="${comboboxList.RRTT.value}" /> <label class="e-l" for="stickFlg3">${comboboxList.RRTT.value}</label>
          <input id="stickFlg4" class="validate[required]" type="radio" name="stickFlg" value="${comboboxList.KH.value}" /> <label for="stickFlg4">${comboboxList.KH.value}</label>
      </li>
      <li>
          <label class="incident_label" for ="noteRR"><font color="red"></font> Ghi chú</label>
      </li>
      <li>
          <g:textArea name="noteRR"  rows="3" cols="140" class="small-incident-field" id="noteRR"/>
      </li>
	 <li>
      <label class="label-left e-l" for ="uploadFile">Hồ sơ đính kèm</label>
      <span id ="uploadFile" class="incident-field-number"></span>
    </li>
    <li>
      <label class="label-left e-l" for ="file">Upload lại hồ sơ</label>
      <input type="file" class="incident-field-number " name="file" id="file"/> 
    </li>
    <input type="hidden" id="incidentID" name="incidentID"value=""/>
    <li >
       <button class="float-left" type="submit" id ="submit_incident" name="saveincident" value="Lưu">Lưu sự kiện</button>
       <button style="margin-left:10px" class="float-left" type="button" id ="deleteFile" name="deleteFile" value="Xóa">Xóa hồ sơ đính kèm</button>
      <button class="float-left" id ="addIncident" name="addIncident" value="Thêm">Thêm sự kiện</button>
      
      <g:hiddenField name="saveEditIncident"  id="saveEditIncident" value=""/>
      <g:hiddenField name="deleteFileEditIncident"  id="deleteFileEditIncident" value=""/>
    </li>

  </ol>
</fieldset>
     </div>
  </g:form>
       </div>


    <script type="text/javascript">
    $(".delete_incident").click(function(){
        var deleteId = $(this).attr('tid');
        jquery_confirm("Xóa sự kiện","Anh/chị đồng ý xóa bỏ sự kiện này?",
                      function(){
                            document.location = "${createLink(controller:'opRisk',action:'incidentReport',params:[deleteIncident:'a'])}&deleteId="+deleteId;

                });

          return false;

      });

  //edit incident
    $(".set-edit").click(function(){

        var id = $(this).attr("id");
		
        $("#dateIncident").attr("value",$(".dateIncident"+id).html());
        $("#dateReport").attr("value",$(".dateReport"+id).html());
        /*$("#basel2").attr("value",$(".basel2"+id).html());*/
        $("#basel2 option").filter(function() {
            //may want to use $.trim in here
            return $(this).text() == $(".basel2"+id).html();
        }).attr('selected', true);
        $("#eventName").attr("value",$(".eventName"+id).html()); 
        $("#name").attr("value",$(".name"+id).html());
        $("#branch").attr("value",$(".branch"+id).html());
        $("#description").attr("value",$(".description"+id).html());
       $("#cause").attr("value",$(".cause"+id).html());
        $("#solution").attr("value",$(".solution"+id).html());
        $("#actionPlan").attr("value",$(".actionPlan"+id).html());
        $("#financialLoss").attr("value",$(".financialLoss"+id).html());
         $("#retrieval").attr("value",$(".retrieval"+id).html());
        $("#incidentStatus").attr("value",$(".incidentStatus"+id).html());
        $("#nonFinancialLoss").attr("value",$(".nonFinancialLoss"+id).html());

        $("#fromInsurance").attr("value",$(".fromInsurance"+id).html());
        $("#fromAnother").attr("value",$(".fromAnother"+id).html());
        $("#moneyTypeI").attr("value",$(".moneyTypeI"+id).html());
        $("#moneyTypeA").attr("value",$(".moneyTypeA"+id).html());
        $("#gl_cal").attr("value",$(".gl_cal"+id).html());
        $("#dateFnCal").attr("value",$(".dateFnCal"+id).html());
        $("#sourceType").attr("value",$(".sourceType"+id).html());
     //   $("input[name=stickFlg][value=" + $(".stickFlg"+id).html().trim() + "]").attr('checked', 'checked');
     //   alert($(".stickFlg"+id).html());
        $("input[name=stickFlg]").val([$(".stickFlg"+id).html()]);

        $("#noteRR").attr("value",$(".noteRR"+id).html());

        $("#uploadFile").html($(".fileName"+id).html());        
        $("#reason").val($(".reason"+id).attr('tid'));
        $("#event").val($(".event"+id).attr('tid'));
        $("#incidentType"+$(".incidentType"+id).attr('tid')).attr('checked','checked');
        $("#incidentID").attr("value",id);
        $("#saveEditIncident").attr("value",id);         
        $("button[name=addIncident]").hide();
        $("button[name=createIncident]").hide();
        $("button[name=saveincident]").show();
        $("button[name=deleteFile]").show();
        $("#panel").slideDown("slow");
     });

    $(document).ready(function(){
       $("#baro-incidentReport").closest('li').addClass('active');
      set_side_bar(true);
       $("#saveIncidentForm").validationEngine();
    //   jQuery('.datatablesExport').wrap('<div class="dataTables_scroll" />');
        $("table.datatablesExport").dataTable({
            "bSort": false,
            "bLengthChange": false,
            "bPaginate":true,
            "bFilter": true,
            "bInfo": true,
            'sPaginationType': 'full_numbers',
            "iDisplayLength": 20,
            "bDestroy":true,
            "sDom": 'lftipr<"break">T',
            "bAutoWidth": false,
           /* "aoColumnDefs": [{ "bVisible": false, "aTargets": [4,5,9,15,17,18,19,20,21,22,23,24,25] }],*/
            "oLanguage": {
                "oPaginate":
                {
                    "sNext": '&gt',
                    "sLast": '&raquo',
                    "sFirst": '&laquo',
                    "sPrevious": '&lt'
                },

                "sInfo": "Hiển thị từ _START_ đến _END_. Tổng cộng: _TOTAL_ hàng",
                "sZeroRecords": "Không có kết quả nào được tìm thấy",
                "sInfoEmpty": "Hiển thị từ 0 đến 0. Tổng cộng: 0 hàng"
            },
        });

    	

      $("button[name=createIncident]").click(function(){
        $("button[name=createIncident]").hide();
        $("button[name=saveincident]").hide();
        $("button[name=deleteFile]").hide();
        $("#panel").slideDown("slow");
      });

      $("#deleteFile").click(function(){    
    	  var deleteId = $(this).attr('tid');      
          jquery_confirm("Xóa hồ sơ","Anh/chị đồng ý xóa bỏ hồ sơ đính kèm sự kiện này?",
                        function(){
        	  $("#saveIncidentForm input[name=deleteFileEditIncident]").val('Processing');
              $("#saveIncidentForm").submit();

                  });

            return false;

        });


      //delete incident
//      $(".delete_button").click(function(){
//        var id =   $(this).attr("id");
//       jquery_confirm("Xoá","Bạn đồng ý xóa sự vụ này?",function(){
//          var Incidentno= $("#incidentNo"+id).attr("value");
//          alert(Incidentno);
//         $.post('${createLink(controller:'opRisk',action:'deleteIncident',params:[incidentno:Incidentno])}',("#listOfIncident").serialize(),function(data){
//
//         $(".survey").html(data);
//            });
//              //jquery_open_load_spinner();
//              return false;
//          });
//      });
      JQUERY4U.UTIL.smoothAnchor('anchorLink');
      set_active_tab('report');

        });
        TableToolsInit.sTitle = "Bao cao su co rui ro hoat dong";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>
    <br>
    <br>
    <br>

   
  </body>
</html>
