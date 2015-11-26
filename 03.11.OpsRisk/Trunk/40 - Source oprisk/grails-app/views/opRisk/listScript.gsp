<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta name="layout" content="m-melanin-layout" />
    <title>Danh sách kịch bản</title>
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
						[href:createLink(controller:'opRisk',action:'listScript'),title:'Danh sách kịch bản',label:'Danh sách kịch bản']]
					]}"/>

			<div class="clear"></div>
		</div>
		
            <div id="m-melanin-left-sidebar"><g:render template="scriptSidebar"/></div>
		</div>     
                
     <div id="m-melanin-main-content">
     <g:form name="scriptForm" class="form" action="listScript">
     <g:hiddenField id="actionbutton" name="exportExcel"/>
     <g:if test="${flash.message}">
				<div id="flash-message" class="message info">${flash.message}</div>
      	</g:if>
      	<br>
      <ol class="form form-clear">
         <li>
            <%def today = new Date();
            today.setMonth(today.month-1);
            %>
            <label class="label-left e-m" for="fromDate" style="width:107px !important">Từ ngày:</label>            
            <label class="label-left e-m" style="float:none" for="toDate">Đến ngày:</label>            
            <label for="businessField" style="float:none" class="label-left se-xl">Tên lĩnh vực kinh doanh:</label>  
            <label for="event" style="float:none" class="label-left">Tên loại sự kiện:</label>
          </li>
          <li>
            <input name="fromDate" id="fromDate" class="e-m datetime" value="${params.fromDate?params.fromDate:DateUtil.formatDate(today)}" readonly="readonly"/>
            <input name="toDate" id="toDate" class="e-m datetime" value="${params.toDate?params.toDate:DateUtil.formatDate(new Date())}" readonly="readonly"/>
            <g:select class="se-xl" name="businessField" id="businessField" from="${BusinessField.executeQuery(' from BusinessField t where t.status>=0 order by t.code+0')}" optionKey="id" optionValue="${{it.code+'-'+it.name}}" value="${params.businessField}" noSelection="${['':'Tất cả']}"/>
            <g:select class="se-xl" name="event" id="event" from="${events}" optionKey="id" optionValue="name" value="${params.event}" noSelection="${['':'Tất cả']}"/>
            
          </li>
 		  
 		  <li>
 		  	<label class="label-left " style="width:217px" for="possibility">Đánh giá khả năng xảy ra:</label>
 		  	<label class="label-left se-xl" style="float:none" for="financialLoss">Tổn thất nếu xảy ra:</label>
 		  	<label class="label-left se-xl" style="float:none" for="actionStatus">Trạng thái:</label>
 		  </li>
 		  <li> 		  
				<ul class="mega-menu" rel="possibility" style="margin-left: 0px;width:195px">
					<li><a href="#" class="drop" id="possibility.description">${params.possibility?Possibility.get(params.possibility).description:'Chọn khả năng xảy ra...' }</a><!-- Begin 4 columns Item -->
					        <div id="possibility-list" class="dropdown_4columns ">
						        <h2>Xin chọn 1 trong các khả năng xảy ra sau<a class="close-mega-menu " rel="-1">Đóng</a></h2>
								<div class="col_4">
					                <ul>
										<g:each in="${possibilities}" var="possibility">
					                    	<li><a href="#" rel="${possibility.id}">${possibility.description}</a></li>
					                    </g:each>
					                </ul>
					            </div>
          			        </div>
						</li>
				</ul>
			<input type="hidden" name ="possibility" id="possibility"/>
				
 		  	<%--<g:select style="width:224px" name="possibility" id="possibility" from="${possibilities}" optionKey="description" optionValue="description" value="${possibilityId}" />
 		  	--%><input name="financialLoss" id="financialLoss" class="e-xl price" value="${params.financialLoss}"/>
            <g:select class="se-xl" name="actionStatus" id="actionStatus" from="${actionStatus}" optionKey="id" optionValue="nameStatus" value="${params.actionStatus}" noSelection="${['':'Tất cả']}" />
            <g:submitButton style="margin-left:0px" class="searchButtons btn primary" name="search" value="Lọc thông tin" />
            </li>
 		  
       </ol>
      </g:form>
      <button class="btn primary float-right" type="button" onclick="javascript:document.location='${createLink(controller:'opRisk',action:'detailScript')}'">Thêm mới kịch bản</button>
	      <table class="sortDatatablesExport">
	        <thead>
	          <tr>
	            <th class ="center" >Mã kịch bản</th>
	            <th class ="center" >Tên lĩnh vực kinh doanh</th>
	            <th class ="center" >Tên loại sự kiện</th>
                    <th class ="center" >Đánh giá khả năng xảy ra</th>
                    <th class ="center" >Tổn thất nếu xảy ra</th>
                    <th class ="center" >Kế hoạch hành động</th>
                    <th class ="center" >Trạng thái</th>
                    <th class ="center" >Chi tiết</th>
	          </tr>
	        </thead>
	        <tbody>

	        <g:each in="${allScripts}" var="s" status="i">

	        <tr>
	          <td class="center">${s.id}</td>
                  <td >${s.businessField.name}</td>
                  <td >${s.event.name}</td>
                  <td >${s.possibility.description}</td>
                  <td ><span class="float-right">${s.financialLoss}</span></td>
                  <td >${s.actionPlan}</td>
                  <td >${s.actionStatus.nameStatus}</td>
                  <td ><a href="${createLink(controller:'opRisk',action:'detailScript',params:[scriptId:s.id])}" >Xem chi tiết</a></td>

	        </tr>
	        </g:each>
	      </tbody>
	    </table>
	    <button class="btn primary" id="exportExcel" name="exportExcel"> Xuất ra excel </button>
      <div class="clear"></div>

      </div>


    <script type="text/javascript">
       $(document).ready(function(){
       $(".price").priceFormat({prefix:'',centsLimit:0,centsSeparator: '',clearOnEmpty: true});
       set_active_tab('riskScript');
       $("#script-management").closest('li').addClass('active');//leftMenu
       set_side_bar(true);
       });

       $("ul.mega-menu ul li a").click(function(){
    	   $("ul.mega-menu > li").removeClass('hover');
    	   $(this).closest('.mega-menu').find('li').removeClass('selected');
           $(this).closest('li').addClass('selected');
           $(this).closest('.mega-menu').find('.drop').first().html($(this).html());
           $("#possibility").val($(this).attr('rel'));
           //$("#possibility").val($(this).html());
           return false;
   });

       $("ul.mega-menu > li").click(function(event){
               $("ul.mega-menu > li").removeClass('hover');
               $(this).addClass('hover')
               return false;
       });
       $("ul.mega-menu .close-mega-menu").click(function(){

               $("ul.mega-menu > li").removeClass('hover');
               return false;
       });
       $("#exportExcel").click(function(){
			$("#actionbutton").val("ExportExcel");
			$("#scriptForm").submit();	
			$("#actionbutton").val("");
		});
       
       TableToolsInit.sTitle = "Danhsachkichban";
        TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
    </script>

  </body>
</html>
