<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="m-melanin-layout" />
<title>Quản lý danh sách rủi ro TSBĐ Blacklist</title>
</head>
<body>
	<div id="m-melanin-tab-header">
		<div id="m-melanin-tab-header-inner">
			<div id="m-melanin-tab-actions">
				<button class="btn small primary m-melanin-toggle-side-bar"
					name="m-test-button-3" value="Toggle sidebar">Toggle
					sidebar</button>


			</div>

			<g:render plugin="melanin" template="/templates/m-melanin-breadcrum"
				model="${[
						items:[[href:createLink(controller:'opRisk',action:'dashboard'),title:'home',label:'Home'],
						[href:createLink(controller:'opError',action:'reportList'),title:'Danh sách blacklist TSBD',label:'Danh sách blacklist TSBD']]
					]}" />

			<div class="clear"></div>
		</div>

		<div id="m-melanin-left-sidebar">
				<g:render template="/blacklist/blacklistSidebar" />
		</div>
	</div>
	<div id="m-melanin-main-content">
	<%def today = new Date();%>
		<g:form name="dialogTruyVanTSBD" id="dialogTruyVanTSBD" class="form float-left"
			action="detailQLTaiSan">
			<g:if test="${flash.message}">
				<div id="flash-message" class="message info">
					${flash.message}
				</div>
			</g:if>
			<g:if test="${flash.error}">
       				 <div id="flash-error" class="alert-message error">${flash.error}</div>
   			 </g:if>
			<g:render template="../blacklist/dialogTruyVanTSBD" />
			<g:hiddenField name="search" value="search"/>
			<g:hiddenField id="actionbutton" name="exportExcel"/>
		</g:form>
		 <sec:ifAnyGranted roles="ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
            <button type="button" name="uploadExcelTsbd" class=" btn primary" id="uploadExcelTsbd"
                    style="position: relative; float: right; margin-top: 15px;margin-left: 5px">Upload Excel</button>
        </sec:ifAnyGranted>
		<g:form name="blacklist" class="form float-right"
			action="addTsbdBlacklist">
			<sec:ifAnyGranted roles="ROLE_GDTT,ROLE_GDTT_LEVEL2,ROLE_GDTT_LEVEL3,ROLE_GDTT_LEVEL4,ROLE_CVQLRR">
			<button name="addComment" class=" btn primary"
				style="position: relative; float: right; margin-top: 15px">Nhập
				thông tin</button>
				</sec:ifAnyGranted>
		</g:form>
		<table class="sortDatatablesExport">
			<thead>
				<tr>
					<th class="center">ID</th>
					<th class="center">Loại tài sản</th>
					<th class="center">Thông tin nhận diện</th>
					<th class="center">Mô tả tài sản</th>
					<th class="center">Chủ sở hữu</th>
					<th class="center">CMT/HC chủ sở hữu (Cá nhân)</th>
					<th class="center">ĐKKD/mã số thuế chủ sỡ hữu (Tổ chức)</th>
					<th class="center">Người vay bằng TSBD bên thứ 3</th>
					<th class="center">CMT/HC/ĐKKD người vay</th>		
					<th class="center">Giá trị tài sản</th>
					<th class="center">Lịch sử giao dịch của TSĐB</th>
					<th class="center">Lý do thuộc danh sách</th>
					<th class="center">Lý do chi tiết (nếu có)</th>
					<th class="center">Phân loại đối tượng</th>
					<th class="center">Thời hạn</th>
					<th class="center">Nguồn dữ liệu</th>
					<th class="center">Ghi chú</th>
					<th class="center">Ngày nhập</th>
					<th class="center">User nhập</th>
					<th class="center">Phòng/Ban nhập</th>
					<th class="center">Người cập nhật</th>
					<th class="center">Thời gian cập nhật</th>
					<th class="center">Xem</th>
				</tr>

			</thead>



			<tbody>
			 <g:each in="${blacklistTsbd}" var="p" status="i">
	        <tr>	
	        	  <td >${p.id}</td>
		      	  <td >${p.loaiTsBL?.name}</td>
	              <td >${p.thongtinTsBL}</td> 
	              <td >${p.motaTsBL}</td>   
	              <td >${p.sohuuTsBL}</td>
	              <td >${p.cmtcshTsBL}</td>
	              <td >${p.masothueTsBL}</td>
	              <td >${p.canhanTsBL}</td>
	              <td >${p.cmtlqTsBL}</td>
	              <td >${p.lydoTsBL}</td>
	              <td >${p.giatriTsBL}</td>
	              <td >${p.lichsuGdTsBL}</td>
	              <td >${p.riskTsdbTsBL?.name}</td>
	              <td >${p.lydoCtTsBL}</td>
	              <td >${p.doituongTsBL?.name}</td>
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${p.thoihanTsBL}" /></td> 
	              <td >${p.dulieuTsBL}</td>                    
	              <td >${p.ghichuTsBL}</td>                  
	              <td class =""><g:formatDate format="dd-MM-yyyy" date="${p.ngaynhapTsBL}" /></td>
	              <td>${p.usernhapTsBL}</td>
	           	  <td>${p.phongbanTsBl }</td>
	           	  <td>${p.nguoisua }</td>
	           	  <td><g:formatDate format="dd-MM-yyyy hh:mm:ss" date="${p.ngaysua}" /></td>           		 
	              <td class ="center"><a href="${createLink(controller:'blackList',action:'viewBlacklistTSBD',params:[blacklistId:p.id])}" >Xem </a></td>						
	        </tr>
	        </g:each>
			</tbody>
		</table>

	
		<button class="btn primary" id="exportExcel" name="exportExcel">
			Xuất ra excel</button>
		
		<br> <br>
	</div>

	<script class="jsbin"
		src="http://datatables.net/download/build/jquery.dataTables.nightly.js"></script>
	<script type="text/javascript">
       $(document).ready(function(){
	        set_active_tab('blacklist-management');//top
	        $("#blacklist-taisan-management").closest('li').addClass('active');//leftMenu
	        set_side_bar(true);
       });
		$("#exportExcel").click(function(){
				$("#actionbutton").val("ExportExcel");
				$("#dialogTruyVanTSBD").submit();	
				$("#actionbutton").val("");
			});
		$("#uploadExcelTsbd").live('click',function(e){
	           document.location = "${createLink(controller:'importExcel',action:'showImportTsbd')}";
	       });
       TableToolsInit.sTitle = "DanhSachLoiRutGon";
       TableToolsInit.sSwfPath = "${resource(dir:'js',file:'ZeroClipboard.swf')}";
	</script>

</body>
</html>
